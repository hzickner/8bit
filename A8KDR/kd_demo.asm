/*
=====================
=
= DemoLoop
=
=====================
*/
/*
void
DemoLoop (void)
{
	char		*s;
	word		move;
	longword	lasttime;
	struct Shape FileShape1;

	struct ffblk ffblk;
	WindowRec	mywin;
	int bufsave	= bufferofs;
	int dissave	= displayofs;

//
// demo loop
//
	US_SetLoadSaveHooks(LoadGame,SaveGame,ResetGame);
	restartgame = gd_Continue;

	if (findfirst("KDREAMS.CMP", &ffblk, 0) == -1)
		Quit("Couldn't find KDREAMS.CMP");

	while (true)
	{

		loadedgame = false;

		if (LoadLIBShape("KDREAMS.CMP", "TITLESCR.LBM", &FileShape1))
			Quit("Can't load TITLE SCREEN");

		while (!restartgame && !loadedgame)
		{

			VW_InitDoubleBuffer();
			IN_ClearKeysDown();

			while (true)
			{

				VW_SetScreen(0, 0);
				MoveGfxDst(0, 200);
				UnpackEGAShapeToScreen(&FileShape1, 0, 0);
				VW_ScreenToScreen (64*200,0,40,200);

				if (IN_UserInput(TickBase * 4, false))
					break;

				displayofs = 0;
				VWB_Bar(0,0,320,200,FIRSTCOLOR);
				US_DisplayHighScores(-1);

				if (IN_UserInput(TickBase * 4, false))
					break;

			}

			bufferofs = bufsave;
			displayofs = dissave;

			VW_FixRefreshBuffer();
			restartgame = gd_Easy;
//			US_ControlPanel ();
		}

		if (!loadedgame)
			NewGame();

		FreeShape(&FileShape1);

		GameLoop();
	}
}
*/
.proc DemoLoop
// TODO
	rts
.endp
