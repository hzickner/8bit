; print 20bit BCD number in B5 B6 B7
;
.proc printbcd20

	lda B7
	bne c4
	lda B6
	cmp #$10
	bcs c3
	cmp #$01
	bcs c2
	lda B5
	cmp #$10
	bcs c1
	bcc c0		; jump to first char != 0
			
c4:	and #$0F
	ora #'0'
	jsr putc

	lda B6
c3:	and #$F0
	lsr
	lsr
	lsr
	lsr
	ora #'0'
	jsr putc

	lda B6
c2:	and #$0F
	ora #'0'
	jsr putc

	lda B5
c1:	and #$F0
	lsr
	lsr
	lsr
	lsr
	ora #'0'
	jsr putc
	
	lda B5		; always print last char
c0:	and #$0F
	ora #'0'
	jmp putc	
.endp