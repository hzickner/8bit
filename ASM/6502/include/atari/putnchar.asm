; write n chars to console
; 	args A - n
;	PTR1 - pointer to message
.proc putnchar
	ldx #0

	sta ICBLL	; output size low
	lda #11
	sta ICCOM	; output characters
	lda PTR1
	sta ICBAL	; output buffer low
	lda PTR1+1
	sta ICBAH	; output buffer high
	stx ICBLH	; output size high
	
	;jsr CIOV
	;rts
	jmp CIOV
.endp