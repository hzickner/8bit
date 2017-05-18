// defines
scr_mem		equ	$4000
DMA_OFF		equ	$0
DMA_ON		equ	$22

TEXTGR		equ	0
GRMODE		equ	1

SCREENWIDTH	equ	64

BLACK		equ	0	; use color0 for black

/*
=======================
=
= VW_Startup
=
=======================
*/
//void	VW_Startup (void)
.proc VW_Startup
//TODO
/*
{

	asm	cld;

	EGAWRITEMODE(0);

	cursorvisible = 0;
}
*/
	rts
.endp
	
/*
=======================
=
= VW_Shutdown
=
=======================
*/
// void	VW_Shutdown (void)
.proc VW_Shutdown
	lda #TEXTGR
	jsr VW_SetScreenMode

	lda #80
	jsr VW_SetLineWidth

	rts
.endp

/*
========================
=
= VW_SetScreenMode
= Call BIOS to set TEXT / CGAgr / EGAgr / VGAgr
=
========================
*/
//void VW_SetScreenMode (int grmode)
.proc VW_SetScreenMode
//TODO
	cmp #TEXTGR
	bne grm
	ldx #<TEXTDL
	ldy #>TEXTDL
		
	jmp out		
grm
	ldx #<GRDL
	ldy #>GRDL

out
	stx B3		; temp store for X
	lda #DMA_OFF
	sta SDMCTL	; DMA off
	ldx #1
	jsr VW_WaitVBL	; wait 1 VSYNC
	ldx B3		; restore X
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
	
	lda #SCREENWIDTH
	jsr VW_SetLineWidth

	rts
	
B3	= $82	
.endp	

/*
====================
=
= VW_SetLineWidth
=
= Must be an even number of bytes
=
====================
*/
//void VW_SetLineWidth (int width)
.proc VW_SetLineWidth
//TODO
/*
{
  int i,offset;

#if GRMODE == EGAGR
//
// set wide virtual screen
//
asm	mov	dx,CRTC_INDEX
asm	mov	al,CRTC_OFFSET
asm mov	ah,[BYTE PTR width]
asm	shr	ah,1
asm	out	dx,ax
#endif

//
// set up lookup tables
//
  linewidth = width;

  offset = 0;

  for (i=0;i<VIRTUALHEIGHT;i++)
  {
	ylookup[i]=offset;
	offset += width;
  }
}
*/
	rts
.endp	

/*
====================
=
= VW_ClearVideo
= clear screen in graphics mode
====================
*/
//void	VW_ClearVideo (int color)
.proc VW_ClearVideo
//TODO
	lda #<scr_mem
	sta PTR1
	lda #>scr_mem
	sta PTR1+1
	
	ldy #<scr_size
	ldx #>scr_size
	lda #0
	jsr memset16

	rts
scr_size	= 3840
PTR1		= $80
.endp

;========
;
; VW_WaitVBL (int number)
; args - X number
;========
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