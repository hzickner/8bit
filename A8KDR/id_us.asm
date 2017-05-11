///////////////////////////////////////////////////////////////////////////
//
//	US_Startup() - Starts the User Mgr
//
///////////////////////////////////////////////////////////////////////////
//void US_Startup(void)
.proc US_Startup
//TODO
/*
{
	harderr(USL_HardError);	// Install the fatal error handler

	US_InitRndT(true);		// not necessary on A8

	USL_ReadConfig();		// Read config file
}
*/
	rts
.endp

///////////////////////////////////////////////////////////////////////////
//
//	US_Setup() - Does the disk access part of the User Mgr's startup
//
///////////////////////////////////////////////////////////////////////////
//void US_Setup(void)
.proc US_Setup
//TODO
/*
{
	USL_CheckSavedGames();	// Check which saved games are present
}
*/
	rts
.endp	
	
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
//	USL_ClearTextScreen() - Makes sure the screen is in text mode, clears it,
//		and moves the cursor to the leftmost column of the bottom line
//
///////////////////////////////////////////////////////////////////////////
//static void USL_ClearTextScreen(void)
.proc USL_ClearTextScreen
//TODO
/*
{
	// Set to 80x25 color text mode
	_AL = 3;				// Mode 3
	_AH = 0x00;
	geninterrupt(0x10);

	// Use BIOS to move the cursor to the bottom of the screen
	_AH = 0x0f;
	geninterrupt(0x10);		// Get current video mode into _BH
	_DL = 0;				// Lefthand side of the screen
	_DH = 24;				// Bottom row
	_AH = 0x02;
	geninterrupt(0x10);
}
*/
	rts
.endp	

///////////////////////////////////////////////////////////////////////////
//
//	USL_ScreenDraw() - Draws a chunk of the text screen (called only by
//		US_TextScreen())
//
///////////////////////////////////////////////////////////////////////////
//static void USL_ScreenDraw(word x,word y,char *s,byte attr)
// args		A,X - y,x
//		PTR1 - s
.proc USL_ScreenDraw
	sta ROWCRS
	stx COLCRS
	jsr puts
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

	jsr USL_ClearTextScreen
/*
scr_rowcol(19,33)      scr_aputs("Please standby...",0x4E);
*/
	lda <str
	sta PTR1
	lda >str
	sta PTR1+1
	lda #12
	ldx #11
	jsr USL_ScreenDraw
	
	rts
// TODO move to rodata segment	
str	.byte 'Please standby...',0

PTR1	equ $80		
.endp

///////////////////////////////////////////////////////////////////////////
//
//	US_FinishTextScreen() - After the main program has finished its initial
//		loading, this routine waits for a keypress and then clears the screen
//
///////////////////////////////////////////////////////////////////////////
//void US_FinishTextScreen(void)
.proc US_FinishTextScreen

	// Change Loading... to Press a Key
	//USL_ScreenDraw(30, 18, "Ready - Press a Key",0xCE);
	lda <str
	sta PTR1
	lda >str
	sta PTR1+1
	lda #12
	ldx #10
	jsr USL_ScreenDraw

	jsr IN_ClearKeysDown
	jsr IN_Ack
	jsr IN_ClearKeysDown

	jsr USL_ClearTextScreen
	rts
// TODO move to rodata segment	
str	.byte 'Ready - Press a Key',0

PTR1	equ $80		
.endp	