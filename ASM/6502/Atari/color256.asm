; 06/23/2017	332 bytes of code

; defines
DMA_OFF		equ 0
DMA_STD		equ 34
DMA_WIDE	equ 35
DMA_PM		equ 62

; memory locations
VDSLST		equ	$200
SDMCTL		equ	$22F
SDLSTL		equ	$230
SDLSTH		equ	$231
GPRIOR		equ	$26F	; shadow for $D01B
COLOR4		equ	$2C8	; shadow for COLBK
CHBAS		equ	$2F4	; shadow for CHBASE, even page number

COLBK		equ	$D01A
CHBASE		equ	$D409
WSYNC		equ	$D40A
VCOUNT		equ	$D40B
NMIEN		equ	$D40E

SETVBV		equ	$E45C
XITVBV		equ	$E462

; zero page

; tmps
PTR1		equ $80
B3		equ $82
B4		equ $83
B5		equ $84
B6		equ $85
B7		equ $86
B8		equ $87
B9		equ $88

col		equ $A0


; start of code
	org $2000
	
	ICL "../include/memset.asm"
	
.proc main

	jsr engInit
	
	jsr engLoop
	
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
	jsr displayFill
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
	lda #64		; GR. 9
	sta GPRIOR
	lda #DMA_WIDE
	sta SDMCTL
	jsr sysWaitVBL	; wait 1 VSYNC

	rts
.endp

.proc displayFill
	ldy #0
l1:	jsr displayFillLine
	iny
	cpy #12
	bne l1
	rts
.endp

.proc displayFillLine
	ldx #0
l1:	txa
	jsr div5
	and #$0F
	stx B7
	sty B8
	jsr displayPlot
	ldx B7
	ldy B8
	inx
	cpx #80
	bne l1
	
	lda #$0F
	jsr displayPlot
	ldy B8
	
	lda #$0F
	ldx #81
	jsr displayPlot
	ldy B8
		
	rts
.endp

.proc displayPlot
	sta B3
	lda #0
	sta B6
	txa
	lsr
	tax
	rol B6		; which nibble
	bne s1
	lda B3
	asl
	asl
	asl
	asl
	sta B3
s1:	
	txa
	clc
	adc #<scr_mem
	sta PTR1
	lda #0
	adc #>scr_mem
	sta PTR1+1
	lda #4
	adc PTR1
	sta PTR1
	bcc s11
	inc PTR1+1
s11:	
	
	tya
	jsr mul48
	clc
	adc PTR1
	sta PTR1
	txa
	adc PTR1+1
	sta PTR1+1
	ldy #0
	lda (PTR1),Y
	ldx B6
	bne s2
	and #$0F
	jmp s3	
s2:	and #$F0
s3:	ora B3
	sta (PTR1),Y 
	
	rts
.endp

.proc engInit
	jsr displayInit
	jsr init_VB
	jsr init_DLI
	rts
.endp

.proc engLoop
l1:
	jmp l1
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

; multiply A by 40
; result in AX
.proc mul40
	ldx #0
	stx B4
	sta B5
	asl
	rol B4		; x2
	asl
	rol B4		; x4
	adc B5
	bcc s1
	inc B4		; x5
s1:	asl
	rol B4		; x10
	asl
	rol B4		; x20
	asl
	rol B4		; x40
	ldx B4
	rts		
.endp

; multiply A by 48
; result in AX
.proc mul48
	ldx #0
	stx B4
	sta B5
	asl
	rol B4		; x2
	adc B5
	bcc s1
	inc B4		; x3
s1:	asl
	rol B4		; x6
	asl
	rol B4		; x12
	asl
	rol B4		; x24
	asl
	rol B4		; x48
	ldx B4
	rts
.endp

;Divide by 5
.proc div5
  	sta B5
	lsr
 	adc #13
	adc B5
	ror
	lsr
	lsr
	adc B5
	ror
	adc B5
	ror
	lsr
	lsr

 	rts
.endp  

.proc init_VB
	ldy <vb_proc
	ldx >vb_proc
	lda #07			; 7 for deferred vector
	jmp SETVBV
	rts
.endp

.proc vb_proc
	lda #0
	sta col
	jmp XITVBV
.endp

.proc init_DLI
	lda #<dli
	sta VDSLST
	lda #>dli
	sta VDSLST+1
	lda NMIEN
	ora %10000000
	sta NMIEN
	rts
.endp
	  
.proc dli
	pha

	lda col
	
	sta WSYNC
		
	sta COLBK
	adc #16
	sta col
	
	pla
	rti
.endp

; display list
.align $400
GRDL:
	.DB $70,$70,$F0			; 3 x 8 blank scanlines
	.DB $4F				; antic mode 7 screen ptr follows high res gr 40 bytes per line
	.DW scr_mem	
	.DB $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$8F
	.DB $4F
	.DW scr_mem	
	.DB $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$8F
	.DB $4F
	.DW scr_mem	
	.DB $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$8F
	.DB $4F
	.DW scr_mem	
	.DB $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$8F
	.DB $4F
	.DW scr_mem	
	.DB $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$8F
	.DB $4F
	.DW scr_mem	
	.DB $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$8F
	.DB $4F
	.DW scr_mem	
	.DB $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$8F
	.DB $4F
	.DW scr_mem	
	.DB $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$8F

	.DB $4F
	.DW scr_mem	
	.DB $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$8F
	.DB $4F
	.DW scr_mem	
	.DB $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$8F
	.DB $4F
	.DW scr_mem	
	.DB $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$8F
	.DB $4F
	.DW scr_mem	
	.DB $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$8F
	.DB $4F
	.DW scr_mem	
	.DB $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$8F
	.DB $4F
	.DW scr_mem	
	.DB $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$8F
	.DB $4F
	.DW scr_mem	
	.DB $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$8F
	.DB $4F
	.DW scr_mem	
	.DB $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$8F
			
	
	.DB $41				; wait vbl and jump to start
	.DW GRDL

; reserve screen memory
scr_memsize	equ 48*13
scr_adr	=	((* + (scr_memsize)+$FFF)&$F000)-(scr_memsize)
	org scr_adr
;.align $1000
scr_mem		.DS	scr_memsize
;scr_mem2	.DS	scr_memsize/2
	
	run main		