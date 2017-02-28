; print value in FR0 to console
; modifies PTR1
.proc printfr0
	jsr FASC
	jsr fasc2str
	lda INBUFF	; set argument for putline
	sta PTR1
	lda INBUFF+1
	sta PTR1+1
	tya
	
	jmp putnchar
.endp	