/*
============================
=
= GameLoop
=
= A game has just started (after the cinematic or load game)
=
============================
*/
//void GameLoop (void)
.proc GameLoop
/*
{
	unsigned	cities,i;
	long	orgx,orgy;

	gamestate.difficulty = restartgame;
	restartgame = gd_Continue;

	do
	{
startlevel:
		if (loadedgame)
		{
			loadedgame = false;
			//
			// start the initial view position to center the player
			//
			orgx = (long)player->x - (150<<G_P_SHIFT);
			orgy = (long)player->y-(84<<G_P_SHIFT);
			if (orgx<0)
				orgx=0;
			if (orgy<0)
				orgy=0;

			VW_FadeOut ();
			fadecount = 0;
			RF_SetRefreshHook (&FadeAndUnhook);
			RF_NewPosition (orgx,orgy);
			CalcInactivate ();
		}
		else
		{
			VW_FixRefreshBuffer ();
			US_CenterWindow (20,8);
			US_CPrint ("Loading");
			VW_UpdateScreen ();
			gamestate.bombsthislevel = 0;
			SetupGameLevel (true);
		}


		PlayLoop ();

		if (loadedgame)
			goto startlevel;

		switch (playstate)
		{
		case warptolevel:
			goto startlevel;

		case died:
			HandleDeath ();
			break;

		case levelcomplete:
			if (mapon)
				SD_PlaySound (LEVELDONESND);
			gamestate.leveldone[mapon] = true;	// finished the level
			if (mapon != 0)
				gamestate.mapon = 0;
			break;

		case resetgame:
			return;

		case victorious:
			goto done;
		}


	} while (gamestate.lives>-1 && playstate!=victorious);

	GameOver ();

done:
	cities = 0;
	for (i= 1; i<=16; i++)
		if (gamestate.leveldone[i])
			cities++;
	US_CheckHighScore (gamestate.score,cities);
	VW_ClearVideo (FIRSTCOLOR);
}
*/
	rts
.endp	
