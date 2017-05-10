; clear screen (text mode)
.proc clrscr
	lda #CLS
	jmp putc
.endp