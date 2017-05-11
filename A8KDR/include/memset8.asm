; A - value
; Y - size
; PTR1 - dest
.proc memset8
	
l1	dey
	sta (PTR1),Y
	bne l1
	rts
	
PTR1	equ $80
.endp

