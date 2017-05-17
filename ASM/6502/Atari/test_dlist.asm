CR		equ	$9B

SAVMSC		equ	$58

VKEYBD		equ	$0208
SDMCTL		equ	$022F
SDLSTL		equ	$0230
SDLSTH		equ	$0231

ICPTL		equ	$0346
ICPTH		equ	$0347

KBCODE		equ	$D209
SKSTAT		equ	$D20F
VCOUNT		equ	$D40B

scr_mem		equ	$4000
DMA_OFF		equ	$0
DMA_ON		equ	$22

	org $2000

	ICL "../include/atari/putc.asm"

.proc VW_WaitVBL

l1
l2	lda VCOUNT
	beq l2
l3	lda VCOUNT
	bne l3	
	dex
	bne l1

	rts
.endp
	
.proc VW_SetScreenMode

	ldx <TEXTDL
	ldy >TEXTDL
		
	lda #DMA_OFF
	sta SDMCTL	; DMA off
	ldx #1
	jsr VW_WaitVBL	; wait 1 VSYNC
	sei		; disable interrupts
	stx SDLSTL	
	sty SDLSTH	; set DLIST
	cli		; enable interrupts
	ldx #1		
	jsr VW_WaitVBL	; wait 1 VSYNC

	lda #<scr_mem
	sta SAVMSC
	lda #>scr_mem
	sta SAVMSC+1	; update screen mem location for OS
	
	lda #DMA_ON
	sta SDMCTL	; DMA on
	
	rts
.endp

.proc main
	;jsr VW_SetScreenMode

	lda #'x'
	jsr putc
	
	lda SAVMSC
	clc
	adc #10
	sta PTR1
	lda SAVMSC+1
	adc #0
	sta PTR1+1
	
	lda #'y'
	ldy #0
	sta (PTR1),Y
	
l1	jmp l1
	rts
.endp

.align $400

TEXTDL:
	.DB $70,$70,$70			; 3 x 8 blank scanlines
	.DB $42				; antic mode 2 screen ptr follows 40x24 text mode
	.DW scr_mem	
	.DB $02,$02,$02,$02,$02
	.DB $02,$02,$02,$02,$02,$02
	.DB $02,$02,$02,$02,$02,$02
	.DB $02,$02,$02,$02,$02,$02	; 23 more lines of mode 2
	.DB $41				; wait vbl and jump to start
	.DW TEXTDL


	run	main

PTR1	= $80