; put character on screen
;	args char in A
;	changes Y
.proc putc
	tay			; 2
	lda ICPTH	; 4
	pha			; 3
	lda ICPTL	; 4 push address of OS putchar on stack
	pha			; 3
	tya			; 2
	rts			; 6 call OS putchar via rts	24 total
.endp	