///////////////////////////////////////////////////////////////////////////
//
//	SD_Startup() - starts up the Sound Mgr
//		Detects all additional sound hardware and installs my ISR
//
///////////////////////////////////////////////////////////////////////////
//void SD_Startup(void)
.proc SD_Startup
//TODO
/*
{
	int	i;

	ssNoCheck = false;
	ssIsTandy = false;
	alNoCheck = false;
	sbNoCheck = false;
	LeaveDriveOn = false;
#ifndef	_MUSE_
	for (i = 1;i < _argc;i++)
	{
		switch (US_CheckParm(_argv[i],ParmStrings))
		{
		case 0:						// No AdLib detection
			alNoCheck = true;
			break;
		case 1:						// No SoundBlaster detection
			sbNoCheck = true;
			break;
		case 2:
			LeaveDriveOn = true;	// No drive turnoff
			break;
		case 3:
			ssNoCheck = true;		// No Sound Source detection
			break;
		case 4:						// Tandy Sound Source handling
			ssIsTandy = true;
			break;
		case 5:						// Sound Source present at LPT1
			ssPort = 1;
			ssNoCheck = SoundSourcePresent = true;
			break;
		case 6:                     // Sound Source present at LPT2
			ssPort = 2;
			ssNoCheck = SoundSourcePresent = true;
			break;
		case 7:                     // Sound Source present at LPT3
			ssPort = 3;
			ssNoCheck = SoundSourcePresent = true;
			break;
		}
	}
#endif

	SoundUserHook = 0;

	t0OldService = getvect(8);	// Get old timer 0 ISR

	SDL_InitDelay();			// SDL_InitDelay() uses t0OldService

	setvect(8,SDL_t0Service);	// Set to my timer 0 ISR
	TimeCount = 0;

	SD_SetSoundMode(sdm_Off);
	SD_SetMusicMode(smm_Off);

	if (!ssNoCheck)
		SoundSourcePresent = SDL_DetectSoundSource();

	if (!alNoCheck)
	{
		AdLibPresent = SDL_DetectAdLib();
		if (AdLibPresent && !sbNoCheck)
			SoundBlasterPresent = SDL_DetectSoundBlaster(-1);
	}

	for (i = 0;i < 255;i++)
		pcSoundLookup[i] = i * 60;

}
*/
	rts
.endp
	
///////////////////////////////////////////////////////////////////////////
//
//	SD_Shutdown() - shuts down the Sound Mgr
//		Removes sound ISR and turns off whatever sound hardware was active
//
///////////////////////////////////////////////////////////////////////////
/*
void SD_Shutdown(void)
{
	SDL_ShutDevice();

	asm	pushf
	asm	cli

	SDL_SetTimer0(0);

	setvect(8,t0OldService);

	asm	popf
	// DEBUG - set the system clock
}
*/
.proc SD_Shutdown
	rts
.endp