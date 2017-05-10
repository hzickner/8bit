; write string to console
;	PTR1 - pointer to message
.proc puts

	ldy #0
	sty B3
loop	lda (PTR1),Y
	beq out
	jsr putc
	inc B3
	ldy B3
	bne loop
out	rts

PTR1	equ $80
B3	equ $82
.endp