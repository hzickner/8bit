; convert 16 bit binary to 20bit BCD number
; input binary in A,X
.proc u16_2bcd16
	sta W1
	stx W1+1

	ldx #0
	stx B5
	stx B6

	;lda W1+1
	;beq u8_2bcd.u8bcd1
	ora W1+1
	beq out
	
u16_2bcd16_1
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
	asl W1
	rol W1+1
	dex
	bne cnvbit
	
	cld
out:	rts
.endp