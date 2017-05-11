 
	org $2000
	
	ICL "include/A8equ.inc"
	ICL "include/puts.asm"
	ICL "include/putc.asm"
	ICL "include/exit.asm"
	ICL "include/clrscr.asm"
	ICL "id_ca.asm"
	ICL "id_in.asm"
	ICL "id_mm.asm"
	ICL "id_rf.asm"
	ICL "id_sd.asm"
	ICL "id_us.asm"
	ICL "id_vw.asm"
	ICL "kd_demo.asm"

/*
==========================
=
= ShutdownId
=
= Shuts down all ID_?? managers
=
==========================
*/
//void ShutdownId (void)
.proc ShutdownId
	jsr US_Shutdown
	jsr SD_Shutdown
	jsr IN_Shutdown
	jsr VW_Shutdown
	jsr CA_Shutdown
	jsr MM_Shutdown
	rts
.endp

/*
==========================
=
= Quit
= args: PTR1 - pointer to error string
==========================
*/
//void Quit (char *error)
.proc Quit
	jsr ShutdownId
	jsr clrscr
	
	lda PTR1
	ora PTR1+1
	beq l1		; if (PTR1)
	jsr puts
	jmp exit	; print	error and exit
l1			; else
	lda <qstr
	sta PTR1
	lda >qstr
	sta PTR1+1
	jsr puts
	jmp exit	; print qstr and exit
	
PTR1	equ $80
// TODO move to rodata segment
qstr	.byte 'Good bye.',0	
.endp

/*
==========================
=
= InitGame
=
= Load a few things right away
=
==========================
*/

//void InitGame (void)
.proc InitGame
// TODO

	jsr MM_Startup
/*
	if (mminfo.mainmem < 335l*1024)
	{

		textbackground(0);
		clrscr();			// we can't include CONIO because of a name conflict

		Quit ("not enough memory");
	}
*/

	jsr US_TextScreen
	jsr VW_Startup
	jsr RF_Startup
	jsr IN_Startup
	jsr SD_Startup
	jsr US_Startup
	jsr CA_Startup
	jsr US_Setup

//
// load in and lock down some basic chunks
//

	jsr CA_ClearMarks
/*
	CA_MarkGrChunk(STARTFONT);
	CA_MarkGrChunk(STARTFONTM);
	CA_MarkGrChunk(STARTTILE8);
	CA_MarkGrChunk(STARTTILE8M);
	for (i=KEEN_LUMP_START;i<=KEEN_LUMP_END;i++)
		CA_MarkGrChunk(i);

	CA_CacheMarks (NULL, 0);

	MM_SetLock (&grsegs[STARTFONT],true);
	MM_SetLock (&grsegs[STARTFONTM],true);
	MM_SetLock (&grsegs[STARTTILE8],true);
	MM_SetLock (&grsegs[STARTTILE8M],true);
	for (i=KEEN_LUMP_START;i<=KEEN_LUMP_END;i++)
		MM_SetLock (&grsegs[i],true);

	CA_LoadAllSounds ();

	fontcolor = WHITE;

	US_FinishTextScreen();

	VW_SetScreenMode (GRMODE);
	VW_ClearVideo (BLACK);
}
*/

	rts
.endp

/*
==========================
=
= main
=
==========================
*/
.proc main
	jsr InitGame
	jsr DemoLoop

	lda <qstr
	sta PTR1
	lda >qstr
	sta PTR1+1
	jmp Quit

// TODO move to rodata segment	
qstr	.byte 'Demo loop exited???',0

PTR1	equ $80	
.endp

	run main