///////////////////////////////////////////////////////////////////////////
//
//	US_Shutdown() - Shuts down the User Mgr
//
///////////////////////////////////////////////////////////////////////////
/* 
void
US_Shutdown(void)
{
	if (!abortprogram)
		USL_WriteConfig();
}
*/
.proc US_Shutdown
//TODO
	rts
.endp

///////////////////////////////////////////////////////////////////////////
//
//	US_TextScreen() - Puts up the startup text screen
//	Note: These are the only User Manager functions that can be safely called
//		before the User Mgr has been started up
//
///////////////////////////////////////////////////////////////////////////
//void US_TextScreen(void)
.proc US_TextScreen
//TODO
/*
{
	word sx,sy;

	USL_ClearTextScreen();

#define	scr_rowcol(y,x)	{sx = (x) - 1;sy = (y) - 1;}
#define	scr_aputs(s,a)	USL_ScreenDraw(sx,sy,(s),(a))
scr_rowcol(19,33)      scr_aputs("Please standby...",0x4E);
#undef	scr_rowcol
#undef	scr_aputs

}
*/
	rts
.endp	