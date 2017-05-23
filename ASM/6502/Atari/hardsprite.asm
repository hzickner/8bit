; defines
DMA_OFF		equ 0
DMA_PM		equ 62

xmin		equ 48
xmax		equ 200
ymin		equ 32
ymax		equ 216

PL_ON		equ 2

BLACK		equ 0
WHITE		equ 15
RED		equ 64
BLUE		equ 128
ORANGE		equ 246

;memory locations
SDMCTL		equ	$22F
SDLSTL		equ	$230
SDLSTH		equ	$231
GPRIOR		equ	$26F
PCOLR0		equ	$2C0
PCOLR1		equ	$2C1
PCOLR2		equ	$2C2
PCOLR3		equ	$2C3

HPOSP0		equ	$D000
HPOSP1		equ	$D001
HPOSP2		equ	$D002
HPOSP3		equ	$D003
COLBK		equ	$D01A
SIZEP0		equ	$D008
SIZEP1		equ	$D009
SIZEP2		equ	$D00A
SIZEP3		equ	$D00B
P1PL		equ	$D00D
P2PL		equ	$D00E
GRACTL		equ	$D01D
HITCLR		equ	$D01E

RANDOM		equ	$D20A
PMBASE		equ	$D407
VCOUNT		equ	$D40B

SETVBV		equ	$E45C
XITVBV		equ	$E462

; zero page
plx	equ	$80
ply	equ	$81
oply	equ	$82
plx1	equ	$83
ply1	equ	$84
oply1	equ	$85
pl1dx	equ	$86
pl1dy	equ	$87
plx2	equ	$88
ply2	equ	$89
oply2	equ	$8A
pl2dx	equ	$8B
pl2dy	equ	$8C
pl2cy	equ	$8D
plx3	equ	$8E
ply3	equ	$8F
oply3	equ	$90
pl3dx	equ	$91
pl3dy	equ	$92
pl3cy	equ	$93
ptr1	equ	$94
ptr2	equ	$96
frc	equ	$98


	org $2000

.proc main
	jsr init_players
	jsr init_display
	
	lda #xmin
	sta plx
	sta plx1
	sta plx2
	lda #xmax
	sta plx3
	lda #ymin
	sta ply
	sta ply1
	lda #ymax
	sta ply2
	sta ply3
	
	jsr init_VB
	
	lda #0
	sta frc
loop
	lda #BLUE
	sta COLBK
	
	inc frc
	lda frc
	cmp #6
	bne s1
	lda #0
	sta frc	
s1:
	
	lda frc
	beq s2	

	jsr move_pl0
	jsr move_pl1
	jsr move_pl2
	jsr move_pl3		
s2:				
	lda #WHITE
	sta COLBK
		
	jsr WaitVBL
	jmp loop	
	rts
.endp

.proc init_VB
	ldy <vb_proc
	ldx >vb_proc
	lda #07			; 7 for deferred vector
	jsr SETVBV
	rts
.endp

.proc vb_proc
	lda #RED
	sta COLBK
	
	jsr set_pl0pos
	jsr set_pl1pos
	jsr set_pl2pos
	jsr set_pl3pos

	jsr handle_pl2col
	
	ldx #$2A
l1:	jsr rndScreenByte
	dex
	bne l1
	
	lda #BLACK
	sta COLBK
		
	jmp XITVBV		; exit from interrupt handling routine
.endp

.proc move_pl0
	ldx plx
	inx
	cpx #xmax+1
	bne s1
	ldx #xmin
s1	stx plx	
	
	ldx ply
	stx oply
	inx
	cpx #ymax+1
	bne s2
	ldx #ymin
s2	stx ply
	rts
.endp

.proc move_pl1
	ldx plx1
	cpx #xmin
	bne s1
	lda #1
	sta pl1dx
s1:	cpx #xmax-8
	bne s2
	lda #-1
	sta pl1dx
s2:	clc
	lda plx1
	adc pl1dx
	sta plx1		

	ldx ply1
	cpx #ymin
	bne s3
	lda #1
	sta pl1dy
s3:	cpx #ymax
	bne s4
	lda #-1
	sta pl1dy
s4:	clc
	lda ply1
	sta oply1
	adc pl1dy
	sta ply1		
	rts
.endp

.proc move_pl2
	lda pl2cy
	clc
	adc #1
	and #$0F
	sta pl2cy
	
	ldx plx2
	cpx #xmin
	bne s1
	lda #1
	sta pl2dx
s1:	cpx #xmax
	bne s2
	lda #-1
	sta pl2dx
s2:	clc
	lda plx2
	adc pl2dx
	sta plx2		

	ldx ply2
	cpx #ymin
	bne s3
	lda #1
	sta pl2dy
s3:	cpx #ymax
	bne s4
	lda #-1
	sta pl2dy
s4:	clc
	lda ply2
	sta oply2
	adc pl2dy
	sta ply2		
	rts
.endp

.proc move_pl3
	lda pl3cy
	sec
	sbc #1
	and #$1F
	sta pl3cy
	
	ldx plx3
	cpx #xmin
	bne s1
	lda #1
	sta pl3dx
s1:	cpx #xmax
	bne s2
	lda #-1
	sta pl3dx
s2:	clc
	lda plx3
	adc pl3dx
	sta plx3		

	ldx ply3
	cpx #ymin
	bne s3
	lda #1
	sta pl3dy
s3:	cpx #ymax
	bne s4
	lda #-1
	sta pl3dy
s4:	clc
	lda ply3
	sta oply3
	adc pl3dy
	sta ply3		
	rts
.endp

.proc init_players
	lda #>PMDATA
	sta PMBASE
	lda #1
	sta GPRIOR

	jsr init_pl0
	jsr init_pl1
	jsr init_pl2
	jsr init_pl3
	
	lda #PL_ON
	sta GRACTL
		
	rts
.endp

.proc init_pl0
	lda #<PL0
	sta ptr1
	lda #>PL0
	sta ptr1+1
	
	lda #0
	sta SIZEP0
	sta plx
	sta ply
	sta oply
	tay

l1:	sta (ptr1),Y
	dey
	bne l1

	jsr set_pl0pos
	
	lda #RED
	sta PCOLR0
	
	rts
.endp

.proc init_pl1
	lda #<PL1
	sta ptr1
	lda #>PL1
	sta ptr1+1
	
	lda #0
	sta plx1
	sta ply1
	sta oply1
	tay

l1:	sta (ptr1),Y
	dey
	bne l1

	jsr set_pl1pos
	
	lda #1
	sta SIZEP1
	lda #BLUE
	sta PCOLR1
	
	rts
.endp

.proc init_pl2
	lda #<PL2
	sta ptr1
	lda #>PL2
	sta ptr1+1
	
	lda #0
	sta SIZEP2
	sta plx2
	sta ply2
	sta oply2
	sta pl2cy
	tay

l1:	sta (ptr1),Y
	dey
	bne l1

	jsr set_pl2pos
	
	lda #BLACK
	sta PCOLR2
	
	rts
.endp

.proc init_pl3
	lda #<PL3
	sta ptr1
	lda #>PL3
	sta ptr1+1
	
	lda #0
	sta SIZEP3
	sta plx3
	sta ply3
	sta oply3
	sta pl3cy
	tay

l1:	sta (ptr1),Y
	dey
	bne l1

	jsr set_pl3pos
	
	lda #BLACK
	sta PCOLR3
	
	rts
.endp

.proc set_pl0pos	; x $30..$C8;48..200;152 		y $20..$D8;32..216;184

	clc
	lda oply
	adc #<PL0
	sta ptr1
	lda #>PL0
	sta ptr1+1
	ldy #7
	lda #0
l2:	sta (ptr1),Y
	dey
	bpl l2	
	
	clc
	lda ply
	adc #<PL0
	sta ptr1
	lda #>PL0
	sta ptr1+1
	ldy #7
l1:	lda pldata,Y
	sta (ptr1),Y
	dey
	bpl l1
	
	lda plx
	sta HPOSP0
	
	rts
.endp

.proc set_pl1pos	; x $30..$C8;48..200;152 		y $20..$D8;32..216;184

	clc
	lda oply1
	adc #<PL1
	sta ptr1
	lda #>PL1
	sta ptr1+1
	ldy #7
	lda #0
l2:	sta (ptr1),Y
	dey
	bpl l2	
	
	clc
	lda ply1
	adc #<PL1
	sta ptr1
	lda #>PL1
	sta ptr1+1
	ldy #7
l1:	lda pldata,Y
	sta (ptr1),Y
	dey
	bpl l1
	
	lda plx1
	sta HPOSP1
	sta PCOLR1
	
	rts
.endp

.proc set_pl2pos	; x $30..$C8;48..200;152 		y $20..$D8;32..216;184

	clc
	lda oply2
	adc #<PL2
	sta ptr1
	lda #>PL2
	sta ptr1+1
	ldy #7
	lda #0
l2:	sta (ptr1),Y
	dey
	bpl l2	
	
	clc
	lda ply2
	adc #<PL2
	sta ptr1
	lda #>PL2
	sta ptr1+1
	ldy #7
	lda pl2cy
	lsr
	tax
	lda pla_l,x
	sta ptr2
	lda pla_h,x
	sta ptr2+1
	
l1:	lda (ptr2),Y
	sta (ptr1),Y
	dey
	bpl l1
	
	lda plx2
	sta HPOSP2
	
	rts
.endp

.proc set_pl3pos	; x $30..$C8;48..200;152 		y $20..$D8;32..216;184

	clc
	lda oply3
	adc #<PL3
	sta ptr1
	lda #>PL3
	sta ptr1+1
	ldy #7
	lda #0
l2:	sta (ptr1),Y
	dey
	bpl l2	
	
	clc
	lda ply3
	adc #<PL3
	sta ptr1
	lda #>PL3
	sta ptr1+1
	ldy #7
	lda pl3cy
	lsr
	lsr
	tax
	lda pla_l,x
	sta ptr2
	lda pla_h,x
	sta ptr2+1
	
l1:	lda (ptr2),Y
	sta (ptr1),Y
	dey
	bpl l1
	
	lda plx3
	sta HPOSP3
	
	rts
.endp

.proc handle_pl2col
	lda P2PL
	;and $02
	beq s1
	lda #BLACK
	jmp out
s1:	lda #WHITE	
out:	
	sta PCOLR2
	sta HITCLR
	rts
.endp
	
.proc init_display
	jsr set_grmode
	jsr fill_screen
	rts
.endp

.proc set_grmode
	ldx #<GRDL
	ldy #>GRDL
	lda #DMA_OFF
	sta SDMCTL	; DMA off
	jsr WaitVBL	; wait 1 VSYNC
	sei		; disable interrupts
	stx SDLSTL	
	sty SDLSTH	; set DLIST
	cli		; enable interrupts
	jsr WaitVBL	; wait 1 VSYNC
	lda #DMA_PM
	sta SDMCTL
	rts
.endp

.proc WaitVBL
l1:	lda VCOUNT
	cmp #17
	bcc l1
l2:	lda VCOUNT
	cmp #17
	bcs l2
	rts
.endp

.proc fill_screen

	lda #<scr_mem
	sta ptr1
	lda #>scr_mem
	sta ptr1+1
	ldx #15
l2:	ldy #0
l1:	lda RANDOM
	sta (ptr1),y
	dey
	bne l1
	inc ptr1+1
	dex
	bne l2
	
	rts
.endp

.proc rndScreenByte
l1:	lda RANDOM
	and #$0F
	cmp #$0F		; random page nr. 0..14 
	beq l1
	
	clc
	adc #>scr_mem
	sta ptr1+1
	lda #<scr_mem
	sta ptr1
	
	lda RANDOM
	tay
	
	lda RANDOM
	sta (ptr1),Y
	
	rts
.endp

pldata	.byte	%11111111
	.byte	%11111111
	.byte	%11000011
	.byte	%11000011
	.byte	%11000011
	.byte	%11000011
	.byte	%11111111
	.byte	%11111111
	
pla_0	.byte	%00011000
	.byte	%00011000
	.byte	%00011000
	.byte	%00011000
	.byte	%00011000
	.byte	%00011000
	.byte	%00011000
	.byte	%00011000

pla_1	.byte	%00000110
	.byte	%00001100
	.byte	%00001100
	.byte	%00011000
	.byte	%00011000
	.byte	%00110000
	.byte	%00110000
	.byte	%01100000
	
pla_2	.byte	%00000011
	.byte	%00000110
	.byte	%00001100
	.byte	%00011000
	.byte	%00011000
	.byte	%00110000
	.byte	%01100000
	.byte	%11000000

pla_3	.byte	%00000000
	.byte	%00000001
	.byte	%00000111
	.byte	%00011110
	.byte	%01111000
	.byte	%11100000
	.byte	%10000000
	.byte	%00000000
	
pla_4	.byte	%00000000
	.byte	%00000000
	.byte	%00000000
	.byte	%11111111
	.byte	%11111111
	.byte	%00000000
	.byte	%00000000
	.byte	%00000000

pla_5	.byte	%00000000	
	.byte	%10000000
	.byte	%11100000
	.byte	%01111000
	.byte	%00011110
	.byte	%00000111	
	.byte	%00000001
	.byte	%00000000
	
pla_6	.byte	%11000000
	.byte	%01100000
	.byte	%00110000
	.byte	%00011000
	.byte	%00011000
	.byte	%00001100
	.byte	%00000110
	.byte	%00000011
	
pla_7	.byte	%01100000
	.byte	%00110000
	.byte	%00110000
	.byte	%00011000
	.byte	%00011000
	.byte	%00001100
	.byte	%00001100
	.byte	%00000110	
	
pla_l	.byte	<pla_0, <pla_1, <pla_2, <pla_3, <pla_4, <pla_5, <pla_6, <pla_7
pla_h	.byte	>pla_0, >pla_1, >pla_2, >pla_3, >pla_4, >pla_5, >pla_6, >pla_7
			
.align $400
GRDL:
	.DB $70,$70,$70			; 3 x 8 blank scanlines
	.DB $4D				; antic mode D screen ptr follows 160x96 4 colors
	.DW scr_mem	
	.DB $0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D	; 95 more lines of mode D
	.DB $41				; wait vbl and jump to start
	.DW GRDL

.align $800
PMDATA:
		.DS	768
MISSILES:	.DS	256
PL0		.DS	256
PL1		.DS	256
PL2		.DS	256
PL3		.DS	256

	
.align $1000
scr_mem	.DS	40*96

	run main	