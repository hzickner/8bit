///////////////////////////////////////////////////////////////////////////
//
//	IN_Startup() - Starts up the Input Mgr
//
///////////////////////////////////////////////////////////////////////////
//void IN_Startup(void)
.proc IN_Startup
//TODO
/*
{
	boolean	checkjoys,checkmouse;
	word	i;

	checkjoys = true;
	checkmouse = true;
	for (i = 1;i < _argc;i++)
	{
		switch (US_CheckParm(_argv[i],ParmStrings))
		{
		case 0:
			checkjoys = false;
			break;
		case 1:
			checkmouse = false;
			break;
		}
	}

	INL_StartKbd();
	MousePresent = checkmouse? INL_StartMouse() : false;

	for (i = 0;i < MaxJoys;i++)
		JoysPresent[i] = checkjoys? INL_StartJoy(i) : false;

}
*/
	rts
.endp

///////////////////////////////////////////////////////////////////////////
//
//	INL_ShutKbd() - Restores keyboard control to the BIOS
//
///////////////////////////////////////////////////////////////////////////
/*
static void
INL_ShutKbd(void)
{
	poke(0x40,0x17,peek(0x40,0x17) & 0xfaf0);	// Clear ctrl/alt/shift flags

	setvect(KeyInt,OldKeyVect);
}
*/
.proc INL_ShutKbd
//TODO
	rts
.endp

///////////////////////////////////////////////////////////////////////////
//
//	IN_Shutdown() - Shuts down the Input Mgr
//
///////////////////////////////////////////////////////////////////////////
//void IN_Shutdown(void)
.proc IN_Shutdown
	jsr INL_ShutKbd
	rts
.endp