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
/*
void	VW_Shutdown (void)
{
	VW_SetScreenMode (TEXTGR);
#if GRMODE == EGAGR
	VW_SetLineWidth (80);
#endif
}
*/
.proc VW_Shutdown
	rts
.endp

