/*
=====================
=
= RF_Startup
=
=====================
*/
//static	char *ParmStrings[] = {"comp",""};
//void RF_Startup (void)
.proc RF_Startup
/*
{
	int i,x,y;
	unsigned	*blockstart;

	for (i = 1;i < _argc;i++)
		if (US_CheckParm(_argv[i],ParmStrings) == 0)
		{
			compatability = true;
			break;
		}

	for (i=0;i<PORTTILESHIGH;i++)
		uwidthtable[i] = UPDATEWIDE*i;

	originxmin = originymin = MAPBORDER*TILEGLOBAL;

	eraselistptr[0] = &eraselist[0][0];
	eraselistptr[1] = &eraselist[1][0];

	SX_T_SHIFT = 1;

	baseupdatestart[0] = &update[0][UPDATESPARESIZE];
	baseupdatestart[1] = &update[1][UPDATESPARESIZE];

	screenpage = 0;
	otherpage = 1;
	displayofs = screenstart[screenpage];
	bufferofs = screenstart[otherpage];
	masterofs = screenstart[2];

	updateptr = baseupdatestart[otherpage];

	blockstart = &blockstarts[0];
	for (y=0;y<UPDATEHIGH;y++)
		for (x=0;x<UPDATEWIDE;x++)
			*blockstart++ = SCREENWIDTH*16*y+x*TILEWIDTH;

	xpanmask = 6;	// dont pan to odd pixels

}
*/
	rts
.endp	
