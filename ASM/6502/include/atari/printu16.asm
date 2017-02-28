; print 16bit unsigned value in A,X
.proc printu16
	sta FR0
	stx FR0+1
	jsr IFP	
	jmp printfr0
.endp	