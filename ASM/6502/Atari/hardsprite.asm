; defines
DMA_OFF		equ 0
DMA_PM		equ 34

PL_ON		equ 2

WHITE		equ 15

;memory locations
SDMCTL		equ	$22F
SDLSTL		equ	$230
SDLSTH		equ	$231
PCOLR0		equ	$2C0

HPOSP0		equ	$D000
SIZEP0		equ	$D008
GRACTL		equ	$D01D

RANDOM		equ	$D20A
PMBASE		equ	$D407
VCOUNT		equ	$D40B

; zero page
plx	equ	$80
ply	equ	$81
ptr1	equ	$82


	org $2000

.proc main
	jsr init_player
	jsr init_display
	
loop
	inc plx
	inc ply
	jsr set_pl0pos
	jsr WaitVBL
	jmp loop	
	rts
.endp

.proc init_player
	lda #>PMDATA
	sta PMBASE
	lda #<PL0
	sta ptr1
	lda #>PL0
	sta ptr1+1
	lda #0
	sta plx
	sta ply
	sta SIZEP0
	tay
	
l1:	sta (ptr1),Y
	dey
	bne l1
	
	jsr set_pl0pos
	
	lda #WHITE
	sta PCOLR0
	
	lda #PL_ON
	sta GRACTL
		
	rts
.endp

.proc set_pl0pos
/*
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

	lda #0
	ldy #8
	sta (ptr1),Y
	dec ptr1
	tay
	sta (ptr1),Y
*/	
	lda plx
	sta HPOSP0
	
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
l1	lda VCOUNT
	beq l1
l2	lda VCOUNT
	bne l2
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

pldata	.byte	%11111111
	.byte	%10000001
	.byte	%10000001
	.byte	%10000001
	.byte	%10000001
	.byte	%10000001
	.byte	%10000001
	.byte	%11111111

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