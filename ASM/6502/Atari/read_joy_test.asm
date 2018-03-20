CR		equ	$9B

RTCLOK		equ	$12
VKEYBD		equ	$0208

ICPTL		equ	$0346
ICPTH		equ	$0347

TRIG0		equ	$D010
TRIG1		equ	$D011
GRACTL		equ	$D01D
CONSOL		equ	$D01F
KBCODE		equ	$D209
SKSTAT		equ	$D20F
PORTA		equ	$D300

	org $2000

	ICL "../include/atari/printu16.asm"
	ICL "../include/atari/printbcd20.asm"
	ICL "../include/atari/putc.asm"
	ICL "../include/u16_2bcd.asm"
	ICL "../include/u16_2bcd16.asm"
	
	
.proc main

loop:
	jsr read_joy
	
	lda JOY1_RAW
	ldx #0
	
	jsr printu16
	
	lda #' '
	jsr putc

	lda JOY2_RAW
	ldx #0
	
	jsr printu16
	
	lda #CR
	jsr putc	
	jmp loop
		
	rts
.endp

.proc read_joy
	lda #0
	sta JOY1_RAW
	sta JOY2_RAW
	
	lda TRIG0
	eor #$FF
	lsr
	ror JOY1_RAW
			
	lda TRIG1
	eor #$FF
	lsr
	ror JOY2_RAW

	lda CONSOL
	eor #$FF
	lsr
	ror JOY1_RAW
	lsr
	ror JOY1_RAW
	lsr
	ror JOY1_RAW

	clc
	ror JOY2_RAW
	ror JOY2_RAW
	ror JOY2_RAW

	lda PORTA
	eor #$FF
	tay
	and #$0F
	ora JOY1_RAW
	sta JOY1_RAW
	
	tya
	lsr
	lsr
	lsr
	lsr
	ora JOY2_RAW
	sta JOY2_RAW
	
	rts
.endp

JOY1_RAW	.DS	1
JOY2_RAW	.DS	1

W1	equ	$80
B5	equ	$84
B6	equ	$85
B7	equ	$86

	run	main
