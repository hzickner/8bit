

	org $2000	;Start of code block

start	
	lda #0		;Disable screen DMA
	sta 559
	
loop
	lda $d40b	; load VCOUNT
	sta $d40a	; wait for HSYNC
	sta $d01a	; change background color
	jmp loop
        
	run start	; define run address
