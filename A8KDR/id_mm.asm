/*
===================
=
= MM_Startup
=
= Grabs all space from turbo with malloc/farmalloc
= Allocates bufferseg misc buffer
=
===================
*/
//void MM_Startup (void)
.proc MM_Startup
//TODO
/*
{
	int i;
	unsigned 	long length;
	void far 	*start;
	unsigned 	segstart,seglength,endfree;

	bombonerror = true;

//
// set up the linked list (everything in the free list;
//
	mmhead = NULL;
	mmfree = &mmblocks[0];
	for (i=0;i<MAXBLOCKS-1;i++)
		mmblocks[i].next = &mmblocks[i+1];
	mmblocks[i].next = NULL;

//
// get all available near conventional memory segments
//
	length=coreleft();
	start = (void far *)(nearheap = malloc(length));

	length -= 16-(FP_OFF(start)&15);
	length -= SAVENEARHEAP;
	seglength = length / 16;			// now in paragraphs
	segstart = FP_SEG(start)+(FP_OFF(start)+15)/16;
	mminfo.nearheap = length;

	// locked block of unusable low memory
	// from 0 to start of near heap
	GETNEWBLOCK;
	mmhead = mmnew;				// this will allways be the first node
	mmnew->start = 0;
	mmnew->length = segstart;
	mmnew->attributes = LOCKBIT;
	endfree = segstart+seglength;
	mmrover = mmhead;

//
// get all available far conventional memory segments
//
	length=farcoreleft();
	start = farheap = farmalloc(length);

	length -= 16-(FP_OFF(start)&15);
	length -= SAVEFARHEAP;
	seglength = length / 16;			// now in paragraphs
	segstart = FP_SEG(start)+(FP_OFF(start)+15)/16;
	mminfo.farheap = length;
	mminfo.mainmem = mminfo.nearheap + mminfo.farheap;

	// locked block of unusable near heap memory (usually just the stack)
	// from end of near heap to start of far heap
	GETNEWBLOCK;
	mmnew->start = endfree;
	mmnew->length = segstart-endfree;
	mmnew->attributes = LOCKBIT;
	mmrover->next = mmnew;
	endfree = segstart+seglength;
	mmrover = mmnew;

//
// cap off the list
//
	// locked block of high memory (video, rom, etc)
	// from end of far heap or EMS/XMS to 0xffff
	GETNEWBLOCK;
	mmnew->start = endfree;
	mmnew->length = 0xffff-endfree;
	mmnew->attributes = LOCKBIT;
	mmnew->next = NULL;
	mmrover->next = mmnew;

//
// allocate the misc buffer
//
	mmrover = mmhead;		// start looking for space after low block

	MM_GetPtr (&bufferseg,BUFFERSIZE);
}
*/
	rts
.endp	

/*
====================
=
= MM_Shutdown
=
= Frees all conventional, EMS, and XMS allocated
=
====================
*/
/*
void MM_Shutdown (void)
{

  farfree (farheap);
  free (nearheap);

}
*/
.proc MM_Shutdown
	rts
.endp	
