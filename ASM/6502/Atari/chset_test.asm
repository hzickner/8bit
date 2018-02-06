; zero page
B1	equ $80

; memory locations
CHBAS		equ	$2F4	; shadow for CHBASE, even page number
ICPTL		equ	$0346
ICPTH		equ	$0347

; start of code
	org $2000
	
	ICL "../include/atari/putc.asm"
	
.proc main
	lda #0
	sta B1
l1:	jsr putc
	inc B1
	lda B1
	cmp #'Z'+1
	bne l1
	
	lda #>font1
	sta CHBAS
		
l2:	jmp l2	
	rts
.endp

; custom font
.align $200
font1:
	INS "bin/test.fnt"
	
	run main	