.proc INT_Setup
	ldy <kd_int
	ldx >kd_int
	lda #07			; 7 for deferred vector
	jsr SETVBV
	rts
.endp

.proc kd_int

	
	jmp XITVBV		; exit from interrupt handling routine
.endp