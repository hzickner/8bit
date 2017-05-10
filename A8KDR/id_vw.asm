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

