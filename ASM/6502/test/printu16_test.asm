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
W1	= $82
u16_i	= $84

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
	sta W1
	stx W1+1
	lda #STRBUF1&$FF
	sta PTR1
	lda #STRBUF1/256
	sta PTR1+1
	ldy #6			; u16 max 5 chars + CR + 1 reserve
	lda #CR
	sta (PTR1),Y		; set last char to CR
next		
	lda W1
	ldx W1+1
	jsr u16_mod10		; get next char
	clc
	adc #'0'
	dey
	sta (PTR1),Y
	
	lda W1
	ldx W1+1
	jsr u16_div10
	sta W1
	stx W1+1		; value /= 10
	
	ora W1+1
	bne next		; until value==0
	
	rts
.endp

.proc u16_mod10
	rts
.endp

.proc u16_div10
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