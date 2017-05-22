random	equ $d20a
screen	equ $1000
plx	equ $f0			; byte position of player
ply	equ $f1			; line of player position
shifted	equ $f2			; position of player inside "byte"
dx	equ $f3
dy	equ $f4
tmp	equ $2020		; area for background storing


	org $600

	lda <dlist
        sta $230		; gr. mod 160x100,4 colors
        lda >dlist
        sta $231

	lda <screen
        sta $fe			; fill screen with random data
        lda >screen
        sta $ff
	ldx #16
fill2	ldy #0
fill	lda random
	sta ($fe),y
	iny
	bne fill
	inc $ff
	dex
	bne fill2

	lda #0
	sta plx
	sta ply
	sta shifted
	sta dx
	sta dy

loop	jsr draw_sprite
	jsr wait
	jsr restore
	lda #$88                ; some bacground color changes too measure time for erasing (white) and drwaing (blue) sprite
	sta $d01a
	ldx shifted
	cpx #3
	bne *+6
	inc plx
	ldx #$ff
	inx
	stx shifted
	ldx plx
	cpx #40
	bne *+6
	ldx #0
	stx plx
	ldx ply
	lda dy
	bne *+4
	inx
	inx
	dex
	bne *+4
	dec dy
	cpx #88
	bne *+4
	inc dy
	stx ply
	jmp loop

wait
	lda $d40b
	sta $ef
    	lda #0
    	sta $d01a
    	ldx #1
wloop	lda $d40b
	cmp #4
	bne wloop
wloop1	lda $d40b
	cmp #4
	beq wloop1
        dex
	bne wloop
	lda #$0f
	sta $d01a
	rts

draw_sprite
        ldx ply
        clc
	lda tabley_lo,x
	adc plx
	sta $fe
	lda tabley_hi,x
	adc #0
	sta $ff
	ldx shifted
	lda sprite_data_lo,x
	sta $fc
	lda sprite_data_hi,x
	sta $fd
	lda mask_data_lo,x
	sta $fa
	lda mask_data_hi,x
	sta $fb
	lda <tmp
	sta $f8
	lda >tmp
	sta $f9
	ldy #0
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	ldy #40
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	ldy #80
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	ldy #120
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	ldy #160
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	ldy #200
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y

	clc
	lda $fa
	adc #240
	sta $fa
	bcc *+4
	inc $fb
	clc
	lda $fc
	adc #240
	sta $fc
	bcc *+4
	inc $fd
	clc
	lda $fe
	adc #240
	sta $fe
	bcc *+4
	inc $ff
	clc
	lda $f8
	adc #240
	sta $f8
	bcc *+4
	inc $f9

        ldy #0
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	ldy #40
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	ldy #80
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	ldy #120
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	ldy #160
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	ldy #200
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
        sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	iny
	lda ($fe),y
	sta ($f8),y
	and ($fa),y
	ora ($fc),y
	sta ($fe),y
	rts

restore
	ldx ply
        clc
	lda tabley_lo,x
	adc plx
	sta $fe
	lda tabley_hi,x
	adc #0
	sta $ff
	lda <tmp
	sta $f8
        lda >tmp
	sta $f9
	ldy #0
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	ldy #40
        lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	ldy #80
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	ldy #120
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	ldy #160
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	ldy #200
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	clc
	lda $fe
	adc #240
	sta $fe
	bcc *+4
	inc $ff
	clc
	lda $f8
	adc #240
	sta $f8
	bcc *+4
	inc $f9
	ldy #0
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	ldy #40
        lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	ldy #80
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	ldy #120
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	ldy #160
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	ldy #200
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	iny
	lda ($f8),y
	sta ($fe),y
	rts


	org $f00
dlist
:2	dta $70
	dta $40
	dta $4d,a(screen)
:99	dta $d
	dta $41,a(dlist)

	org $e00
tabley_lo
:100	dta l($1000+40*#)

tabley_hi
:100	dta h($1000+40*#)

	org $f80
sprite_data_lo
:4	dta l($2000+8*#)

sprite_data_hi
:4	dta h($2000+8*#)

mask_data_lo
:4	dta l($2004+8*#)

mask_data_hi
:4	dta h($2004+8*#)


	org $2000
sprite
     	dta $ff,$ff,$ff,0,0,0,0,$ff,$3f,$ff,$ff,$c0,$c0,0,0,$3f,$0f,$ff,$ff,$f0,$f0,0,0,$0f,$03,$ff,$ff,$fc,$fc,0,0,$03
        org $2000+40
     	dta $ff,$ff,$ff,0,0,0,0,$ff,$3f,$ff,$ff,$c0,$c0,0,0,$3f,$0f,$ff,$ff,$f0,$f0,0,0,$0f,$03,$ff,$ff,$fc,$fc,0,0,$03
        org $2000+80
     	dta $ff,$ff,$ff,0,0,0,0,$ff,$3f,$ff,$ff,$c0,$c0,0,0,$3f,$0f,$ff,$ff,$f0,$f0,0,0,$0f,$03,$ff,$ff,$fc,$fc,0,0,$03
	org $2000+120
        dta $ff,0,$ff,0,0,$ff,0,$ff,$3f,$c0,$3f,$c0,$c0,$3f,$c0,$3f,$0f,$f0,$0f,$f0,$f0,$0f,$f0,$0f,$03,$fc,$03,$fc,$fc,$03,$fc,$03
	org $2000+160
     	dta $ff,0,$ff,0,0,$ff,0,$ff,$3f,$c0,$3f,$c0,$c0,$3f,$c0,$3f,$0f,$f0,$0f,$f0,$f0,$0f,$f0,$0f,$03,$fc,$03,$fc,$fc,$03,$fc,$03
	org $2000+200
     	dta $ff,0,$ff,0,0,$ff,0,$ff,$3f,$c0,$3f,$c0,$c0,$3f,$c0,$3f,$0f,$f0,$0f,$f0,$f0,$0f,$f0,$0f,$03,$fc,$03,$fc,$fc,$03,$fc,$03
	org $2000+240
     	dta $ff,0,$ff,0,0,$ff,0,$ff,$3f,$c0,$3f,$c0,$c0,$3f,$c0,$3f,$0f,$f0,$0f,$f0,$f0,$0f,$f0,$0f,$03,$fc,$03,$fc,$fc,$03,$fc,$03
	org $2000+280
     	dta $ff,0,$ff,0,0,$ff,0,$ff,$3f,$c0,$3f,$c0,$c0,$3f,$c0,$3f,$0f,$f0,$0f,$f0,$f0,$0f,$f0,$0f,$03,$fc,$03,$fc,$fc,$03,$fc,$03
	org $2000+320
	dta $ff,0,$ff,0,0,$ff,0,$ff,$3f,$c0,$3f,$c0,$c0,$3f,$c0,$3f,$0f,$f0,$0f,$f0,$f0,$0f,$f0,$0f,$03,$fc,$03,$fc,$fc,$03,$fc,$03
	org $2000+360
     	dta $ff,$ff,$ff,0,0,0,0,$ff,$3f,$ff,$ff,$c0,$c0,0,0,$3f,$0f,$ff,$ff,$f0,$f0,0,0,$0f,$03,$ff,$ff,$fc,$fc,0,0,$03
	org $2000+400
     	dta $ff,$ff,$ff,0,0,0,0,$ff,$3f,$ff,$ff,$c0,$c0,0,0,$3f,$0f,$ff,$ff,$f0,$f0,0,0,$0f,$03,$ff,$ff,$fc,$fc,0,0,$03
	org $2000+440
     	dta $ff,$ff,$ff,0,0,0,0,$ff,$3f,$ff,$ff,$c0,$c0,0,0,$3f,$0f,$ff,$ff,$f0,$f0,0,0,$0f,$03,$ff,$ff,$fc,$fc,0,0,$03

