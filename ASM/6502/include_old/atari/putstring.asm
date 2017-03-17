; write CR terminated string to console
; PTR1 - pointer to output string
.proc putstring
	ldx #0

	lda #9
	sta ICCOM	; output characters
	lda PTR1
	sta ICBAL	; output buffer low
	lda PTR1+1
	sta ICBAH	; output buffer high
	lda #0
	sta ICBLH	; output size high
	lda #$FF
	sta ICBLL	; output size low

	jmp CIOV
.endp	