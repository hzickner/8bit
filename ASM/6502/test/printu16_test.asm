; test program for printu16 functions
; printu16 using FP routines from OS ROM
; 03/13/2017	573 ticks
; 03/13/2017	571 ticks
; printu16_2 using div10 and mod10
; 03/13/2017	482 ticks
; 03/13/2017-2	470 ticks
; 03/13/2017-2	469 ticks
; 03/13/2017-2	468 ticks
; printu16_3 using divmod10
; 03/13/2017	452 ticks
; 03/13/2017	451 ticks
; 03/13/2017	450 ticks
; printu16_4 using putstring (putc loop)
; 03/13/2017	394 ticks
; 03/13/2017	392 ticks
; 03/13/2017	391 ticks
; printu16_5 using BCD
; 03/14/2017	393 ticks
; 03/14/2017	392 ticks
; 03/15/2017	381 ticks

 
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
;N	= 531		; benchmark
N	= 531
N1	= 0

; variables
; zero page
PTR1	= $80

W1	= $80
W2	= $82
W3	= $84
W4	= $86
W5	= $88

B5	= $84
B6	= $85
B7	= $86
B8	= $87
B11	= $90
B12	= $91

u16_i	= $92

	org $2000

; variables
; RAM
u16_tm1 .DS 2
STRBUF1	.DS 7		; string buffer for u16 variables, must not cross 256byte page boundary	
	
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
	
	lda #STRBUF1&$FF+6
	sec
	sbc PTR1

	jmp putnchar
.endp

; print 16bit unsigned value in A,X
.proc printu16_3
	jsr u16_2str_2
	
	lda #STRBUF1&$FF+6
	sec
	sbc PTR1
	
	jmp putnchar
.endp

; print 16bit unsigned value in A,X
.proc printu16_4
	jsr u16_2str_2

	jmp putstring
.endp

; print 16bit unsigned value in A,X
.proc printu16_6
	jsr u16_2str_3

	jmp putstring_2
.endp

; print 16bit unsigned value in A,X
; using BCD
.proc printu16_5
	jsr u16_2bcd

	jmp printbcd20
.endp

; convert u16 binary to string base10
; A,X value
; STRBUF1 string buffer min legth=7
.proc u16_2str
	sta W2
	stx W2+1
	lda #STRBUF1&$FF
	clc
	adc #6
	sta PTR1
	lda #STRBUF1/256
	sta PTR1+1

	lda #0
	tay
	sta (PTR1),Y		; set last char to 0

next		
	lda W2

	jsr u16_mod10		; get next char

	ora #'0'
	dec PTR1
	ldy #0
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

; convert u16 binary to string base10
; use divmod
; A,X value
; STRBUF1 string buffer min legth=7
.proc u16_2str_2
	sta W2
	stx W2+1
	lda #STRBUF1&$FF
	clc
	adc #06
	sta PTR1
	lda #STRBUF1/256
	sta PTR1+1

	lda #0
	tay
	sta (PTR1),Y		; set last char to 0
	lda W2
next
	jsr u16_divmod10	; get next char and divide number by 10
	sta W2
	stx W2+1
	tya
	
	ora #'0'		; '0' == $30, ora == add
	ldy #0
	dec PTR1
	sta (PTR1),Y
	
	lda W2
	bne next
	ldy W2+1		; until value==0
	bne next
	
	rts
.endp

; convert u16 binary to string base10
; use divmod
; A,X value
; STRBUF1 string buffer min legth=7
.proc u16_2str_3
	sta W2
	stx W2+1

	ldx #6
	lda #0
	sta STRBUF1,X		; set last char to 0

next
	jsr u16_divmod10_2	; get next char and divide number by 10
	
	ora #'0'		; '0' == $30, ora == add

	dex

	sta STRBUF1,X
	
	lda W2
	bne next
	ldy W2+1		; until value==0
	bne next
	
	rts
.endp

; convert 16 bit binary to 20bit BCD number
; input binary in A,X
.proc u16_2bcd
	sta W1
	stx W1+1

	ldx #0
	stx B5
	stx B6
	stx B7

	lda W1+1
	beq u8_2bcd.u8bcd1
	
	ldx #17
	sed
	
skip:	asl W1
	rol W1+1
	dex
	bcc skip
		
cnvbit:	
	lda B5		; BCD = 2*BCD + bit
	adc B5
	sta B5
	lda B6
	adc B6
	sta B6
	lda B7
	adc B7
	sta B7
	asl W1
	rol W1+1
	dex
	bne cnvbit
	
	cld
out:	rts
.endp

; convert 8 bit binary to 20bit BCD number
; input binary in W1
.proc u8_2bcd

	ldx #0
	stx B5
	stx B6

u8bcd1:	lda W1
	beq out
	
	ldx #9
	sed
	
skip:	asl W1
	dex
	bcc skip
		
cnvbit:	
	lda B5		; BCD = 2*BCD + bit
	adc B5
	sta B5
	lda B6
	adc B6
	sta B6
	asl W1
	dex
	bne cnvbit
	
	cld
out:	rts
.endp

; convert 16 bit binary to 20bit BCD number
; input binary in A,X
.proc u16_2bcd_2
	sta W1
	stx W1+1

	ldx #0
	stx B5
	stx B6
	stx B7

	ora W1+1
	beq out
	
	ldx #17
	sed
	
skip:	asl W1
	rol W1+1
	dex
	bcc skip
	cpx #6
	bcc cnvbit1_1
	cpx #13
	bcc cnvbit2_1

cnvbit3:		; 3 byte result	
	lda B5		; BCD = 2*BCD + bit
	adc B5
	sta B5
	lda B6
	adc B6
	sta B6
	lda B7
	adc B7
	sta B7
	asl W1
	rol W1+1
	dex
	bne cnvbit3
	beq out2

cnvbit2_1:
	sec		
cnvbit2:		; 2 byte result	
	lda B5		; BCD = 2*BCD + bit
	adc B5
	sta B5
	lda B6
	adc B6
	sta B6
	asl W1
	rol W1+1
	dex
	bne cnvbit2
	beq out2

cnvbit1_1:
	sec
	lda B5
cnvbit1:		; 1 byte result
			; BCD = 2*BCD + bit
	adc B5
	sta B5
	asl W1+1
	dex
	bne cnvbit1
					
out2:	cld
out:	rts
.endp

.proc printbcd20

	lda B7
	bne c4
	lda B6
	cmp #$10
	bcs c3
	cmp #$01
	bcs c2
	lda B5
	cmp #$10
	bcs c1
	bcc c0		; jump to first char != 0
			
c4:	and #$0F
	ora #'0'
	jsr putc

	lda B6
c3:	and #$F0
	lsr
	lsr
	lsr
	lsr
	ora #'0'
	jsr putc

	lda B6
c2:	and #$0F
	ora #'0'
	jsr putc

	lda B5
c1:	and #$F0
	lsr
	lsr
	lsr
	lsr
	ora #'0'
	jsr putc
	
	lda B5		; always print last char
c0:	and #$0F
	ora #'0'
	jmp putc	
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

  	lsr			;2  @12...82
  	sta B11			;3  @15
  	lsr			;2  @17
	adc B11			;3  @20
  	ror			;2  @22
  	lsr			;2  @24
  	lsr			;2  @26
  	adc B11			;3  @29
  	ror			;2  @31
  	adc B11			;3  @34
  	ror			;2  @36
  	and #$7C		;2  @38  AND'ing here...
  	sta B11			;3  @41  and saving result as highTen (times 4)
  	lsr			;2  @43
  	lsr			;2  @45...115
  
	iny			;2  @47
	bpl finishLowTen	;2³ @49...120

	tax			;2  @51

	adc B11			;3  @54   highTen (times 5)
	asl			;2  @56   highTen (times 10)
	sbc W3+1		;3  @59
	eor #$FF		;2  @61
	tay			;2  @63   mod 10 result!

	lda TensRemaining,Y	;4  @67   Fill the low byte with the tens it should
	sta W4			;3  @70   have at this point from the high byte divide.
	lda W3			;3  @73
	adc ModRemaing,Y	;4  @77
	bcc do8bitDiv		;2³ @79/80

overflowFound:
	cmp #4			;2  @81   We have overflowed, but we can apply a shortcut.
	lda #25			;2  @83   Divide by 10 will be at least 25, and the
				;         carry is set when higher for the next addition.
finishLowTen:
	adc W4			;3  @86...123

	rts			;6  @92...129	routine ends at either 95 or 132 cycles
; tables	
TensRemaining:
	.byte 0,25,51,76,102,128,153,179,204,230
ModRemaing:
	.byte 0,6,2,8,4,0,6,2,8,4	
.endp

; unsigned div by 10
; A,X unsigned value
.proc u16_mod10
	sta W5			;3 	save val low

	jsr u16_div10		;135 	calc value / 10
	sta W4			;3 	we need only low byte from here
	
	asl			;2 	x2
	sta W3			;3
	asl			;2
	asl			;2 	x8
	clc			;2
	adc W3			;3 	+= 2x

	eor #$FF		;2
	sec			;2
	adc W5			;2

	ldx #0			;2
	
	rts			;6  @179
.endp

; divides a 8 bit value by 10
; remainder is returned in A
.proc u8_divmod10_2

	lda W2
	beq out
		
	ldy #8	        ;2	8 bits
	clc
l1	rol W2
	dey
	bcc l1
	
	lda #0		;2
loop	rol		;2
	cmp #10		;2
	bcc skip	;2/3
	sbc #10		;2
skip	rol W2		;2
        dey		;2
        bpl loop	;2/3	max16 per it, 128max
out	rts		;6
.endp

; divides a 8 bit value by 10
; remainder is returned in Y
.proc u8_divmod10_3
	lda W2
	lsr
	sta  B11
 	lsr
	adc  B11
 	ror
 	lsr
 	lsr
 	adc  B11
 	ror
 	adc  B11
 	ror
	and #$7C		;2  @38  AND'ing here...
  	sta B11			;3  @41  and saving result as highTen (times 4) 	
 	lsr
 	lsr
 	sta W3			; div result
 	adc B11
 	asl
 	sbc W2
 	eor #$FF		; mod result
 	
 	ldy W3
 	sty W2
 	rts
.endp 	


; divides a 16 bit value by 10
; remainder is returned in A
.proc u16_divmod10_2
	
	lda W2+1
	beq u8_divmod10_3
	
	ldy #16         ;2	16 bits
	clc
l1	rol W2
	rol W2+1
	dey
	bcc l1

	lda #0		;2
loop	rol		;2
	cmp #10		;2
	bcc skip	;2/3
	sbc #10		;2
skip	rol W2		;2
	rol W2+1	;2
        dey		;2
        bpl loop	;2/3	max18 per it, 288max
        rts		;6
.endp
        
; unsigned div by 10
; A,X unsigned value
; Result AX = AX div 10; Y = AX mod 10
; source: http://atariage.com/forums/blog/563/entry-11044-16-bit-division-fast-divide-by-10/
.proc u16_divmod10
	sta W3			;3  @3
	stx W3+1		;3  @6
	ldy #-2			;2  @8   skips a branch the first time through
	txa		 	;2  @10
do8bitDiv:

  	lsr			;2  @12...82
  	sta B11			;3  @15
  	lsr			;2  @17
	adc B11			;3  @20
  	ror			;2  @22
  	lsr			;2  @24
  	lsr			;2  @26
  	adc B11			;3  @29
  	ror			;2  @31
  	adc B11			;3  @34
  	ror			;2  @36
  	and #$7C		;2  @38  AND'ing here...
  	sta B11			;3  @41  and saving result as highTen (times 4)
  	lsr			;2  @43
  	lsr			;2  @45...115
  
	iny			;2  @47
	bpl finishLowTen	;2³ @49...120

	tax			;2  @51

	adc B11			;3  @54   highTen (times 5)
	asl			;2  @56   highTen (times 10)
	sbc W3+1		;3  @59
	eor #$FF		;2  @61
	tay			;2  @63   mod 10 result!

	lda TensRemaining,Y	;4  @67   Fill the low byte with the tens it should
	sta W4			;3  @70   have at this point from the high byte divide.
	lda W3			;3  @73
	adc ModRemaing,Y	;4  @77
	bcc do8bitDiv		;2³ @79/80

overflowFound:
	cmp #4			;2  @81   We have overflowed, but we can apply a shortcut.
	lda #25			;2  @83   Divide by 10 will be at least 25, and the
				;         carry is set when higher for the next addition.
finishLowTen:
	adc W4			;3  @86...123
	sta W4
	
	asl			;2
	sta B11			;3
	asl			;2
	asl			;2
	clc			;2
	adc B11			;3
	
	eor #$FF		;2
	sec			;2
	adc W3			;3	-A+W3	
	
	tay			;2
	
	lda W4			;3

	rts			;6  @118...155	routine ends at either
; tables	
TensRemaining:
	.byte 0,25,51,76,102,128,153,179,204,230
ModRemaing:
	.byte 0,6,2,8,4,0,6,2,8,4	
.endp

; unsigned div by 10
; W2 unsigned value
; Result W2 = W2 div 10; Y = AX mod 10
; source: http://atariage.com/forums/blog/563/entry-11044-16-bit-division-fast-divide-by-10/
.proc u16_divmod10_3

	ldy #-2			;2  @2   skips a branch the first time through
	lda W2+1	 	;2  @4
do8bitDiv:

  	lsr			;2  @6...74
  	sta B11			;3  @9
  	lsr			;2  @11
	adc B11			;3  @14
  	ror			;2  @16
  	lsr			;2  @18
  	lsr			;2  @20
  	adc B11			;3  @23
  	ror			;2  @25
  	adc B11			;3  @28
  	ror			;2  @30
  	and #$7C		;2  @32  AND'ing here...
  	sta B11			;3  @35  and saving result as highTen (times 4)
  	lsr			;2  @37
  	lsr			;2  @39...107
  
	iny			;2  @41
	bpl finishLowTen	;2³ @43...112

	sta W3+1		;3  @46

	adc B11			;3  @49   highTen (times 5)
	asl			;2  @51   highTen (times 10)
	sbc W2+1		;3  @54
	eor #$FF		;2  @56
	tay			;2  @58   mod 10 result!

	lda TensRemaining,Y	;4  @62   Fill the low byte with the tens it should
	sta W3			;3  @65   have at this point from the high byte divide.
	lda W2			;3  @68
	adc ModRemaing,Y	;4  @72
	bcc do8bitDiv		;2³ @74/75

overflowFound:
	cmp #4			;2  @76   We have overflowed, but we can apply a shortcut.
	lda #25			;2  @78   Divide by 10 will be at least 25, and the
				;         carry is set when higher for the next addition.
finishLowTen:
	adc W3			;3  @81...115
	sta W3			;3
	
	asl			;2
	sta B11			;3
	asl			;2
	asl			;2
	clc			;2
	adc B11			;3
	
	eor #$FF		;2
	sec			;2
	adc W2			;3	-A+W3	
	
	ldy W3			;3
	sty W2			;3
	ldy W3+1		;3
	sty W2+1		;3
	rts			;6  @123...157	routine ends at either 
; tables	
TensRemaining:
	.byte 0,25,51,76,102,128,153,179,204,230
ModRemaing:
	.byte 0,6,2,8,4,0,6,2,8,4	
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

; write string to console
;	PTR1 - pointer to message
.proc putstring

loop	ldy #0
	lda (PTR1),Y
	beq out
	jsr putc
	inc PTR1
	bne loop
out	rts
.endp

; write string to console
;	PTR1 - pointer to message
.proc putstring_2
	stx B11
loop	ldx B11
	lda STRBUF1,X
	beq out	
	jsr putc
	inc B11
	bne loop
out	rts
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

	lda #1099&255
	ldx #1099/256
	jsr printu16_5
	lda #' '
	jsr putc
		
	lda #0
	sta 19
	sta 20				; set timer to 0
	
	lda #N1&$FF
	sta u16_i
	lda #N1/256
	sta u16_i+1			; i=0

while1					; while(i<=N2)
	lda #N&$FF
	cmp u16_i
	lda #N/256
	sbc u16_i+1
	bcc while1out			; i>st

	lda u16_i
	ldx u16_i+1
	jsr printu16_6
	lda #' '
	jsr putc
	
	lda u16_i
	ldx u16_i+1
	jsr u16_div10
	jsr printu16_6
	lda #' '
	jsr putc
	
	lda u16_i
	ldx u16_i+1
	jsr u16_mod10
	jsr printu16_6
	lda #' '
	jsr putc	
	
	inc u16_i
	bne while1
	inc u16_i+1			; i++
	bne while1			; end while1
while1out

	lda 20
	ldx 19				; read memset time
	sta u16_tm1
	stx u16_tm1+1

;
; print timings
	lda #CR
	jsr putc
	lda u16_tm1
	ldx u16_tm1+1
	jsr printu16	

l1	jmp l1
	rts
.endp

	run main	