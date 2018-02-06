; defines
DMA_OFF		equ 0
DMA_STD		equ 34

; memory locations
SDMCTL		equ	$22F
SDLSTL		equ	$230
SDLSTH		equ	$231
ICPTL  		equ	$0346
ICPTH  		equ	$0347

PAL		equ	$D014	; NTSC if bits 1-3 set
COLBK		equ	$D01A
WSYNC		equ	$D40A
VCOUNT		equ	$D40B

SETVBV		equ	$E45C
XITVBV		equ	$E462

; zero page

hz_l		equ $80
hz_h		equ $81
u16_hz		equ $80
ntsc_vid	equ $82
vb_count	equ $83


	org $2000	;Start of code block
	
.proc main

	jsr engInit
	
	jsr engLoop
	
	rts
.endp

; clear screen RAM
;
.proc displayClear
	
	rts
.endp

; initialize display
;
.proc displayInit
	jsr displayClear
	jsr displaySetMode
	
	ldy #5
	lda #"9"
@	sta counter,Y
	dey
	bne @-
		
	rts
.endp

; activate display list
;
.proc displaySetMode
	ldx #<DL
	ldy #>DL
	lda #DMA_OFF
	sta SDMCTL	; DMA off
	jsr sysWaitVBL	; wait 1 VSYNC
	sei		; disable interrupts
	stx SDLSTL	
	sty SDLSTH	; set DLIST
	cli		; enable interrupts

	lda #DMA_STD
	sta SDMCTL
	jsr sysWaitVBL	; wait 1 VSYNC

	rts
.endp

.proc engInit
	; init variables
	lda #0
	sta hz_l
	sta hz_h
	sta vb_count

	; detect video standard
	lda PAL
	and #14
	beq s1
	lda #1
s1:
	sta ntsc_vid
		
	jsr displayInit
	jsr init_VB
		
	rts
.endp

.proc engLoop
l1:	

	jmp l1

.endp

.proc init_VB
	lda ntsc_vid
	bne s1
	ldy <vb_proc_pal
	ldx >vb_proc_pal
	jmp s2
s1:
	ldy <vb_proc_ntsc
	ldx >vb_proc_ntsc
s2:		
	lda #07			; 7 for deferred vector
	jmp SETVBV
	;rts
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

; VBI interrupt routine
.proc vb_proc_pal
	jsr vb_p0
	jsr vb_p1
	jsr vb_p2
	jsr vb_p3
	jsr vb_p4
	jsr vb_p5
	lda #0
	sta COLBK
	jmp XITVBV
.endp

.proc vb_proc_ntsc
	ldx vb_count
	inx
	cpx #6
	bne s0
	ldx #0
s0:	
	stx vb_count
	beq s1
	jsr vb_p0
	lda vb_count
	cmp #1
	beq s2

s1:	jsr vb_p1
	lda vb_count
	cmp #2
	beq s3

s2:	jsr vb_p2
	lda vb_count
	cmp #3
	beq s4

s3:	jsr vb_p3
	lda vb_count
	cmp #4
	beq s5

s4:	jsr vb_p4
	lda vb_count
	cmp #5
	beq s6

s5:	jsr vb_p5

s6:	
	lda #0
	sta COLBK
	jmp XITVBV
.endp

.proc vb_p0
	lda #7
	sta COLBK

	inc hz_l
	bne s1
	inc hz_h	; 16bit inc 13cy	
s1:	

:367	nop	
	rts
.endp
.proc vb_p1
	lda #23
	sta COLBK
:380	nop	
	rts
.endp
.proc vb_p2
	lda #39
	sta COLBK
:380	nop	
	rts
.endp
.proc vb_p3
	lda #45
	sta COLBK
:380	nop	
	rts
.endp
.proc vb_p4
	lda #61
	sta COLBK
:380	nop	
	rts
.endp
.proc vb_p5
	lda #77
	sta COLBK
	
	lda hz_h
	sta scr_mem
	lda hz_l
	sta scr_mem+1	; copy 2 zeropage bytes to screen 14cy

	ldy #5		; 2
	inc counter+5	; 6	pre increment first digit to count 100th of a second
l1:	clc		;  2
	lda counter,Y	;  4
	adc #1		;  2
	cmp #"9"+1	;  2
	bmi s1		;  2
	lda #"0"	;  2
	sta counter,Y	;  5
	dey		;  2
	bne l1		;  3
	iny		; 2
s1:	sta counter,Y	; 5 	inc 5-digit counter onscreen 135cy worst case
	
:300	nop	
	rts
.endp

; display list
.align $400
DL:
	.DB $70,$70,$70			; 3 x 8 blank scanlines
	.DB $42				; text mode ptr follows
	.DW scr_mem	
	.DB $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
	.DB $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02	; 23 lines of text mode
	
	.DB $41				; wait vbl and jump to start
	.DW DL

; reserve screen memory
scr_memsize	equ 40*24
scr_adr	=	((* + (scr_memsize)+$FFF)&$F000)-(scr_memsize)
	org scr_adr
;.align $1000
scr_mem		.DS	scr_memsize
counter equ scr_mem+10
	
	run main
	