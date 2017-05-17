; A - value
; X - size H
; Y - size L
; PTR1 - dest
.proc memset16
	
	sty B3		; temp storage for low byte of size
	
	cpx #0		
	beq l1		; less than one page

	ldy #0
l2	sta (PTR1),Y
	dey
	bne l2		; fill one page

	inc PTR1+1
	dex
	bne l2		; advance to next page
		
l1	ldy B3
	beq l3
l4	dey
	sta (PTR1),Y
	bne l4		; remaining bytes
l3	
	rts
	
PTR1	equ	$80
B3	equ	$82	
.endp

