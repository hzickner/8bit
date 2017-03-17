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