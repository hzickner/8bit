// defines
NumCodes	equ	64

sc_None		equ	255
/*
#define	sc_Bad			0xff
sc_Return	equ	12
sc_Escape	equ	28
sc_Space	equ	33
#define	sc_BackSpace	0x0e
sc_Tab		equ	44
#define	sc_Alt			0x38
#define	sc_Control		0x1d
#define	sc_CapsLock		0x3a
#define	sc_LShift		0x2a
#define	sc_RShift		0x36
#define	sc_UpArrow		0x48
#define	sc_DownArrow	0x50
#define	sc_LeftArrow	0x4b
#define	sc_RightArrow	0x4d
#define	sc_Insert		0x52
#define	sc_Delete		0x53
#define	sc_Home			0x47
#define	sc_End			0x4f
#define	sc_PgUp			0x49
#define	sc_PgDn			0x51
#define	sc_F1			0x3b
#define	sc_F2			0x3c
#define	sc_F3			0x3d
#define	sc_F4			0x3e
#define	sc_F5			0x3f
#define	sc_F6			0x40
#define	sc_F7			0x41
#define	sc_F8			0x42
#define	sc_F9			0x43
#define	sc_F10			0x44
#define	sc_F11			0x57
#define	sc_F12			0x59

#define	sc_A			0x1e
sc_B		equ	21
sc_C		equ	18
#define	sc_D			0x20
sc_E		equ	42
#define	sc_F			0x21
#define	sc_G			0x22
#define	sc_H			0x23
sc_I		equ	13
sc_J		equ	1
sc_K		equ	5
sc_L		equ	0
sc_M		equ	37
sc_N		equ	35
sc_O		equ	8
sc_P		equ	10
#define	sc_Q			0x10
sc_R		equ	40
#define	sc_S			0x1f
#define	sc_T			0x14
sc_U		equ	11
sc_V		equ	16
#define	sc_W			0x11
sc_X		equ	22
#define	sc_Y			0x15
sc_Z		equ	23
*/
key_None	equ	0
/*
#define	key_None		0
#define	key_Return		0x0d
#define	key_Escape		0x1b
#define	key_Space		0x20
#define	key_BackSpace	0x08
#define	key_Tab			0x09
#define	key_Delete		0x7f
*/
// 	Global variables
//TODO move to rwdata

//boolean		Keyboard[NumCodes]
Keyboard	.DS	NumCodes
//char		LastASCII;
LastASCII	.DS	1
LastScan	.DS	1

//	Makros
//#define	IN_ClearKey(code)	{Keyboard[code] = false;\
//							if (code == LastScan) LastScan = sc_None;}
; args - X code
.proc IN_ClearKey
	lda #0
	sta Keyboard,X
	cpx LastScan
	bne skip
	lda #sc_None
	sta LastScan
skip	rts
.endp
		
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
	boolean	checkjoys;
	word	i;

	checkjoys = true;

	INL_StartKbd();

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

///////////////////////////////////////////////////////////////////////////
//
//	IN_ClearKeysDown() - Clears the keyboard array
//
///////////////////////////////////////////////////////////////////////////
//void IN_ClearKeysDown(void)
.proc IN_ClearKeysDown
//	LastScan = sc_None;
	lda #sc_None
	sta LastScan

//	LastASCII = key_None;
	lda #key_None
	sta LastASCII

//	for (i = 0;i < NumCodes;i++)
//		Keyboard[i] = false;
	ldy #NumCodes
	lda <Keyboard
	sta PTR1
	lda >Keyboard
	sta PTR1+1
	lda #0
	jsr memset8
	
	rts
	
PTR1	equ $80	
.endp	

///////////////////////////////////////////////////////////////////////////
//
//	IN_AckBack() - Waits for either an ASCII keypress or a button press
//
///////////////////////////////////////////////////////////////////////////
//void IN_AckBack(void)
.proc IN_AckBack
//TODO
/*
{
	word	i;

	while (!LastScan)
	{
		for (i = 0;i < MaxJoys;i++)
		{
			if (JoysPresent[i])
			{
				if (IN_GetJoyButtonsDB(i))
				{
					while (IN_GetJoyButtonsDB(i))
						;
					return;
				}
			}
		}
	}
*/
	ldx LastScan
	jsr IN_ClearKey
//	LastScan = sc_None;	already done by ClearKey

	rts
.endp	

///////////////////////////////////////////////////////////////////////////
//
//	IN_Ack() - Clears user input & then calls IN_AckBack()
//
///////////////////////////////////////////////////////////////////////////
//void IN_Ack(void)
.proc IN_Ack
//TODO
	ldx LastScan
	jsr IN_ClearKey
//	LastScan = sc_None;	already done by ClearKey

/*
	for (i = 0;i < MaxJoys;i++)
		if (JoysPresent[i])
			while (IN_GetJoyButtonsDB(i))
				;
*/
	jsr IN_AckBack

	rts
.endp	