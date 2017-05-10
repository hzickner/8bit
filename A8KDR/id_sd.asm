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