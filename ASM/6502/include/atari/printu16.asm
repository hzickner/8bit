; print 16bit unsigned value in A,X
; using BCD
.proc printu16
	jsr u16_2bcd

	jmp printbcd20
.endp