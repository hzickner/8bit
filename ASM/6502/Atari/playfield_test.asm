; defines
DMA_OFF		equ 0
DMA_PM		equ 62

; memory locations
SDMCTL		equ	$22F
SDLSTL		equ	$230
SDLSTH		equ	$231
CHBAS		equ	$2F4	; shadow for CHBASE, even page number

CHBASE		equ	$D409
VCOUNT		equ	$D40B

; zero page

; tmps
PTR1		equ $80
B3		equ $82

; start of code
	org $2000
	
	ICL "../include/memset.asm"
	
.proc main

	jsr engInit
	
	jsr engLoop
	
	jsr engExit
	
	rts
.endp

; clear screen RAM
;
.proc displayClear
	lda #<scr_mem
	sta PTR1
	lda #>scr_mem
	sta PTR1+1
	ldy #<scr_memsize
	ldx #>scr_memsize
	lda #0
	jsr memset
	
	rts
.endp

; initialize display
;
.proc displayInit
	jsr displayClear
	jsr displaySetMode
	jsr displaySetFont
	rts
.endp

; load custom font
;
.proc displaySetFont
	lda #>font1
	sta CHBAS
	rts
.endp

; activate display list
;
.proc displaySetMode
	ldx #<GRDL
	ldy #>GRDL
	lda #DMA_OFF
	sta SDMCTL	; DMA off
	jsr sysWaitVBL	; wait 1 VSYNC
	sei		; disable interrupts
	stx SDLSTL	
	sty SDLSTH	; set DLIST
	cli		; enable interrupts
	lda #DMA_PM
	sta SDMCTL
	jsr sysWaitVBL	; wait 1 VSYNC

	rts
.endp

.proc engInit
	jsr mapInit
	jsr displayInit
	rts
.endp

.proc engLoop
l1:
	jmp l1
	rts
.endp

; exit with cold boot
;
.proc engExit
	rts
.endp

mapDimX	equ 1000
mapDimY equ 1000
mapX	.DS 2
mapY	.DS 2
.proc mapInit
	lda #0
	sta mapX
	sta mapX+1
	sta mapY
	sta mapY+1
	rts
.endp

.proc sysWaitVBL
l1:	lda VCOUNT
	cmp #16
	bcc l1
l2:	lda VCOUNT
	cmp #16
	bcs l2
	rts
.endp

; custom font
.align $400
font1:
	INS "bin/test.fnt"

; display list
.align $400
GRDL:
	.DB $70,$70,$70			; 3 x 8 blank scanlines
	.DB $44				; antic mode 4 screen ptr follows 40x24 4/5 colors text mode 40 bytes per line
	.DW scr_mem	
	.DB $04,$04,$04,$04,$04
	.DB $04,$04,$04,$04,$04,$04
	.DB $04,$04,$04,$04,$04,$04
	.DB $04,$04,$04,$04,$04,$04	; 23 more lines mode 4
	.DB $41				; wait vbl and jump to start
	.DW GRDL

; reserve screen memory
.align $1000
scr_memsize	equ 40*24
scr_mem	.DS	scr_memsize
	
	run main		