; equates
; floating point package
FR0		= $D4	; 6 byte FP register
INBUFF		= $F3	; 2 byte pointer to input buffer
FASC		= $D8E6	; floating point to ATASCII, LBUFF = (string)FR0, INBUFF = last char
IFP		= $D9AA ; 16bit integer in FR0 to floating point in FR0

; CIO equates for IOCB0
ICHID  =   $0340
ICDNO  =   $0341
ICCOM  =   $0342
ICSTA  =   $0343
ICBAL  =   $0344
ICBAH  =   $0345
ICPTL  =   $0346
ICPTH  =   $0347
ICBLL  =   $0348
ICBLH  =   $0349
ICAX1  =   $034A
ICAX2  =   $034B

; OS jump table
CIOV   =   $E456

CR	= $9B


; constants
N	= 1000

; variables
; zero page
PTR1	= $80
W2	= $82
W3	= $84
W4	= $86
B9	= $88
u16_i	= $90

	org $2000

; variables
; RAM
STRBUF1	.DS 7		; string buffer for u16 variables	
	
; print 16bit unsigned value in A,X
; using OS FP routines
.proc printu16
	sta FR0
	stx FR0+1
	jsr IFP	
	jmp printfr0
.endp

; print 16bit unsigned value in A,X
.proc printu16_2
	jsr u16_2str
	rts
.endp

; convert u16 binary to string base10
; A,X value
; STRBUF1 string buffer min legth=7
.proc u16_2str
	sta W2
	stx W2+1
	lda #STRBUF1&$FF
	sta PTR1
	lda #STRBUF1/256
	sta PTR1+1
	ldy #6			; u16 max 5 chars + CR + 1 reserve
	lda #CR
	sta (PTR1),Y		; set last char to CR
next		
	lda W2
	ldx W2+1
	jsr u16_mod10		; get next char
	clc
	adc #'0'
	dey
	sta (PTR1),Y
	
	lda W2
	ldx W2+1
	jsr u16_div10
	sta W2
	stx W2+1		; value /= 10
	
	ora W2+1
	bne next		; until value==0
	
	rts
.endp

; unsigned div by 10
; A,X unsigned value
; source: http://atariage.com/forums/blog/563/entry-11044-16-bit-division-fast-divide-by-10/
.proc u16_div10
	sta W3			;3  @3
	stx W3+1		;3  @6
	ldy #-2			;2  @8   skips a branch the first time through
	txa		 	;2  @10
do8bitDiv:
	sta B9			;3  @13...86
	lsr			;2  @15
	adc #13			;2  @17
	adc B9			;3  @20
	ror			;2  @22
	lsr			;2  @24
	lsr			;2  @26
	adc B9			;3  @29
	ror			;2  @31
	adc B9			;3  @34
	ror			;2  @36
	lsr			;2  @38
	and #$7C		;2  @40   AND'ing here...
	sta B9			;3  @43   and saving result as highTen (times 4)
	lsr			;2  @45
	lsr			;2  @47
	iny			;2  @49
	bpl finishLowTen	;2³ @51...125

	sta W4+1		;3  @54
	adc B9			;3  @57   highTen (times 5)
	asl			;2  @59   highTen (times 10)
	sbc W3+1		;3  @62
	eor #$FF		;2  @64
	tay			;2  @66   mod 10 result!

	lda TensRemaining,Y	;4  @70   Fill the low byte with the tens it should
	sta W4			;3  @73   have at this point from the high byte divide.
	lda W3			;3  @76
	adc ModRemaing,Y	;4  @80
	bcc do8bitDiv		;2³ @82/83

overflowFound:
	cmp #4			;2  @84   We have overflowed, but we can apply a shortcut.
	lda #25			;2  @86   Divide by 10 will be at least 25, and the
				;         carry is set when higher for the next addition.
finishLowTen:
	adc W4			;3  @89...128
	sta W4			;3  @92...131
	ldx W4+1		;3  @95...134

	rts			;6  @101...140	routine ends at either 101 or 140 cycles
; tables	
TensRemaining:
	.byte 0,25,51,76,102,128,153,179,204,230
ModRemaing:
	.byte 0,6,2,8,4,0,6,2,8,4	
.endp

.proc u16_mod10
	rts
.endp
	
; print value in FR0 to console
; modifies PTR1
.proc printfr0
	jsr FASC
	jsr fasc2str
	lda INBUFF	; set argument for putline
	sta PTR1
	lda INBUFF+1
	sta PTR1+1
	tya
	
	jmp putnchar
.endp

; convert FASC result to CR terminated string
.proc fasc2str
	ldy #$FF
fstr1	
	iny	
	lda (INBUFF),Y
	bpl fstr1
	and #$7F
	sta (INBUFF),Y
	iny
	lda #CR
	sta (INBUFF),Y
	rts
.endp

; write n chars to console
; 	args A - n
;	PTR1 - pointer to message
.proc putnchar
	ldx #0

	sta ICBLL	; output size low
	lda #11
	sta ICCOM	; output characters
	lda PTR1
	sta ICBAL	; output buffer low
	lda PTR1+1
	sta ICBAH	; output buffer high
	stx ICBLH	; output size high
	
	jmp CIOV
.endp

; put character on screen
;	args char in A
;	changes Y
.proc putc
	tay			; 2
	lda ICPTH		; 4
	pha			; 3
	lda ICPTL		; 4 push address of OS putchar on stack
	pha			; 3
	tya			; 2
	rts			; 6 call OS putchar via rts	24 total
.endp

.proc main

	
	lda #0
	sta u16_i
	sta u16_i+1			; i=0

while1					; while(i<=N2)
	lda #N&$FF
	cmp u16_i
	lda #N/256
	sbc u16_i+1
	bcc while1out			; i>st

	lda u16_i
	ldx u16_i+1
	jsr printu16
	lda #' '
	jsr putc
	
	inc u16_i
	bne while1
	inc u16_i+1			; i++
	bne while1			; end while1
while1out

l1	jmp l1
	rts
.endp

	run main	