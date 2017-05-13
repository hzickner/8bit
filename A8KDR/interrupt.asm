.proc INT_Setup
	ldy <kd_int
	ldx >kd_int
	lda #07			; 7 for deferred vector
	jsr SETVBV
	rts
.endp

.proc kd_int
	pha
	txa
	pha
	tya
	pha			; save registers
	
	pla
	tay
	pla
	tax
	pla			; restore registers
	rti			; return from interrupt
.endp