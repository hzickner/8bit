	org $2000

PTR1	= $80
PTR2	= $82
B3	= $82
B5	= $84
B6	= $85

; A - value
; X - size H
; Y - size L
; PTR1 - dest
.align $0100
.proc memset
	
	sty B3		; 3  2 ; temp storage for low byte of size
	
	cpx #0		; 2  2
	beq remain	; 2+ 2 ; less than one page

	ldy #0		; 2  2								; 9
loop1	sta (PTR1),Y	; 6  2							
	dey		; 2  1
	bne loop1	; 2+ 2 ; fill one page			; inner loop 11*256*X = 2816*X

	inc PTR1+1  	; 5  2
	dex		; 2  1
	bne loop1	; 2+ 2 ; advance to next page		; outer loop 10*X
		
remain	ldy B3		; 3  2
	beq out		; 2+ 2					; 6
loop2	dey		; 2  1
	sta (PTR1),Y	; 6  2
	bne loop2	; 2+ 2 ; remaining bytes		; loop 11*Y
out	
	rts		; 6  1					; 6
.endp								; total 11*N + X*10 (per page overhead) + 21 (const overhead); 28 bytes

; A - value
; X - size H
; Y - size L
; PTR1 - dest
.align $0100
.proc memset2
	
	sty B3		; 3  2 ; temp storage for low byte of size
	
	cpx #0		; 2  2
	beq remain	; 2+ 2 ; less than one page

	ldy #0		; 2  2					; 9
loop1	sta (PTR1),Y	; 6  2							
	dey		; 2  1
	sta (PTR1),Y	; 6  2							
	dey		; 2  1
	bne loop1	; 2+ 2 ; fill one page			; inner loop 19*128*X 9.5 per byte

	inc PTR1+1  	; 5  2
	dex		; 2  1
	bne loop1	; 2+ 2 ; advance to next page		; outer loop 10*X
		
remain	ldy B3		; 3  2
	beq out		; 2+ 2					; 6
loop2	dey		; 2  1
	sta (PTR1),Y	; 6  2
	bne loop2	; 2+ 2 ; remaining bytes		; loop 11*Y
out	
	rts		; 6	 1				; 6
.endp								; total 9.5*X*256 + 11*Y + X*10 (per page overhead) + 21 (const overhead); 31 bytes

; A - value
; X - size H
; Y - size L
; PTR1 - dest
.align $0100
.proc memset3
	
	sty B5		; 3  2 ; temp storage for low byte of size
	
	cpx #0		; 2  2
	beq l1		; 2+ 2 ; less than one page

	stx B6		; 3  2
	lsr B6		; 5  2
	bcc two		; 2+ 2
	ldy #0		; 2  2								; 9

l2	sta (PTR1),Y; 6  2								; fill one page if odd number of pages							
	dey			; 2  1
	sta (PTR1),Y; 6  2							
	dey			; 2  1
	bne l2		; 2+ 2 ; fill one page				; inner loop 19 per 2 byte 9.5 per byte

two
	cpx #0		; 2  2
	beq l1		; 2+ 2								; only one page

	tax			; 2  1
	lda PTR1+1	; 3  2
	clc			; 2  1
	adc B6		; 3  2
	sta PTR2+1	; 3  2
	lda PTR1	; 3  2
	sta PTR2	; 3  2
	txa			; 2  1
	ldx B6		; 3  2								; set up two fill pointers

l5	sta (PTR1),Y; 6  2								; fill two pages simultaneously
	sta (PTR2),Y; 6  2							
	dey			; 2  1
	sta (PTR1),Y; 6  2
	sta (PTR2),Y; 6  2							
	dey			; 2  1
	bne l5		; 2+ 2 ; fill two pages				; inner loop 31 per 4 bytes = 7.75 per byte
		
	inc PTR1+1  ; 5  2
	inc PTR2+1  ; 5  2
	dex			; 2  1
	bne l5		; 2+ 2 ; advance to next doublepage	; outer loop 13 * X/2
		
l1	ldy B5		; 3  2
	beq out		; 2+ 2								; 6
l4	dey			; 2  1
	sta (PTR1),Y; 6  2
	bne l4		; 2+ 2 ; remaining bytes			; loop 11*Y
out	
	rts			; 6	 1								; 6
.endp												; 70 bytes total

.proc main
	rts
.endp

	run main	 						