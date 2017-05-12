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
	ldx <TEXTDL
	ldy >TEXTDL
		
	jmp out		
grm
	ldx <GRDL
	ldy >GRDL

out

	lda #DMA_OFF
	sta SDMCTL	; DMA off
	lda #1
	jsr VW_WaitVBL	; wait 1 VSYNC
	sei		; disable interrupts
	stx SDLSTL	
	sty SDLSTH	; set DLIST
	cli		; enable interrupts
	lda #1		
	jsr VW_WaitVBL	; wait 1 VSYNC
	lda #DMA_ON
	sta SDMCTL	; DMA on
	
	lda #SCREENWIDTH
	jsr VW_SetLineWidth

	rts
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
/*
{
#if GRMODE == EGAGR
	EGAWRITEMODE(2);
	EGAMAPMASK(15);
#endif

asm	mov	es,[screenseg]
asm	xor	di,di
asm	mov	cx,0xffff
asm	mov	al,[BYTE PTR color]
asm	rep	stosb
asm	stosb

#if GRMODE == EGAGR
	EGAWRITEMODE(0);
#endif
}
*/
	rts
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