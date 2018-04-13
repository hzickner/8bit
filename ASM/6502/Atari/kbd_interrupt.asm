CR		equ	$9B

VKEYBD		equ	$0208

ICPTL		equ	$0346
ICPTH		equ	$0347

KBCODE		equ	$D209
SKSTAT		equ	$D20F

	org $2000

	ICL "../include/atari/printu16.asm"
	ICL "../include/atari/printbcd20.asm"
	ICL "../include/atari/putc.asm"
	ICL "../include/u16_2bcd.asm"
	ICL "../include/u16_2bcd16.asm"
	
.proc kbd
	PHA
	TXA
	PHA		;save X
	TYA
	PHA		;save Y

	ldx #0
	lda KBCODE
	sta lastkey
	jsr printu16
	lda #' '
	jsr putc
	ldx #0
	lda SKSTAT
	jsr printu16
	lda #CR
	jsr putc
	
	PLA		;saved Y
	TAY		;restore Y
	PLA		;saved X
	TAX		;restore X
	PLA		;restore A
	RTI		;return	rti
.endp

.proc setKBint
	lda VKEYBD
	sta SYSKEYBD
	lda VKEYBD+1
	sta SYSKEYBD+1		; save orig. interrupt vector

	sei
	lda <kbd
	sta VKEYBD
	lda >kbd
	sta VKEYBD+1
	cli			; set new vector
	
	rts
.endp

.proc resKBint
	sei
	lda SYSKEYBD
	sta VKEYBD
	lda SYSKEYBD+1
	sta VKEYBD+1
	cli			; restore orig interrupt vector
	
	rts
.endp
	
.proc main

	jsr setKBint

	sei
	lda #0
	sta 20
	sta 19
	sta 18			; reset RTC
l2	ldx #0
	jsr printu16
	lda 19
	cmp #02
	bne l2			; wait 512 ticks
	
 	cli
		
l1	lda lastkey
	cmp #18
	bne l1			; until lastkey=='c'
	
	jsr resKBint
		
	rts
.endp

lastkey		.byte 	0
SYSKEYBD	.ds	2

W1	equ	$80
B5	equ	$84
B6	equ	$85
B7	equ	$86

	run	main
