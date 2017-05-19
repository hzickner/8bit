GAMELEVELS	equ	17
/*
typedef	struct
{
	unsigned	worldx,worldy;
	boolean	leveldone[GAMELEVELS];
	long	score,nextextra;
	int		flowerpowers;
	int		boobusbombs,bombsthislevel;
	int		keys;
	int		mapon;
	int		lives;
	int		difficulty;
} gametype;
*/
//TODO shrink
.struct gametype
	worldx		.word
	worldy		.word 
	leveldone	:GAMELEVELS-1 .byte
	score		.long
	nextextra	.long
	flowerpowers	.word 
	boobusbombs	.word
	bombsthislevel	.word
	keys		.word
	mapon		.word
	lives		.byte
	difficulty	.byte
.ends

/*
=============================================================================

						 GLOBAL VARIABLES

=============================================================================
*/
//TODO move to rwdata
//exittype	playstate;
gamestate	gametype
.print "sizeof gametype:",.len gametype	
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
*/
	//gamestate.difficulty = restartgame;
	//restartgame = gd_Continue;
	lda restartgame
	sta gamestate.difficulty
	lda #gd_Continue
	sta restartgame

do1:
/*	

	do
	{
startlevel:
*/
	//	if (loadedgame)
	lda loadedgame
	beq el1		

			//loadedgame = false;
	lda #0
	sta loadedgame
/*	
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
*/		
el1:
/*		
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

*/
//	} while (gamestate.lives>-1 && playstate!=victorious);
	lda gamestate.lives	//victorious is tested before
	bpl do1


	jsr GameOver
/*
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
