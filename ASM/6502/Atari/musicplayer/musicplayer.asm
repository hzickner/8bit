; memory locations

PAL		equ	$D014	; NTSC if bits 1-3 set
COLBK		equ	$D01A

SETVBV		equ	$E45C
XITVBV		equ	$E462

; zero page

hz_l		equ $80
hz_h		equ $81
ntsc_vid	equ $82
vb_count	equ $83
; 203-219 $cb-$dc reserved for rmtplayer

STEREOMODE	equ 0		; 0 => compile RMTplayer for mono 4 tracks
PLAYER		equ $2400	; startaddress of player
SONG		equ $4000	; address of RMT song
	; memory usage $30e0 - $394e		
	icl "rmtplayr.a65"	; include RMT player routine


	;org $2000		; Start of code block	

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
	jsr rmtInit
	jsr init_VB
		
	rts
.endp

.proc engLoop
l1:
	jmp l1
	rts
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

.proc rmtInit
	ldx #<SONG		;low byte of RMT module to X reg
	ldy #>SONG		;hi byte of RMT module to Y reg
	lda #0			;starting song line 0-255 to A reg
	jsr RASTERMUSICTRACKER	;Init
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
:380	nop	
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
	lda #0
	sta COLBK
	jsr RASTERMUSICTRACKER+3	; play music
	lda #77
	sta COLBK
:380	nop	
	rts
	
	opt h-			;RMT module is standard Atari binary file already
	ins "blue_monday.rmt"		;include music RMT module
	opt h+	
	
.endp
	run main