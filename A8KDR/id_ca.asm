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
	rts
.endp	