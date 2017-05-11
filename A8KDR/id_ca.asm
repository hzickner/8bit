/*
======================
=
= CA_Startup
=
= Open all files and load in headers
=
======================
*/
//void CA_Startup (void)
.proc CA_Startup
//TODO
/*
{
#ifdef PROFILE
	unlink ("PROFILE.TXT");
	profilehandle = open("PROFILE.TXT", O_CREAT | O_WRONLY | O_TEXT);
#endif

	CAL_SetupMapFile ();
	CAL_SetupGrFile ();
	CAL_SetupAudioFile ();

	mapon = -1;
	ca_levelbit = 1;
	ca_levelnum = 0;
}
*/
	rts
.endp
	
/*
======================
=
= CA_Shutdown
=
= Closes all files
=
======================
*/
/*
void CA_Shutdown (void)
{
#ifdef PROFILE
	close (profilehandle);
#endif

	close (maphandle);
	close (grhandle);
}
*/
.proc CA_Shutdown
//TODO
	rts
.endp

/*
======================
=
= CA_ClearMarks
=
= Clears out all the marks at the current level
=
======================
*/
//void CA_ClearMarks (void)
.proc CA_ClearMarks
//TODO
/*
{
	int i;

	for (i=0;i<NUMCHUNKS;i++)
		grneeded[i]&=~ca_levelbit;
}
*/
	rts
.endp	
