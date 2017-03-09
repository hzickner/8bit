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