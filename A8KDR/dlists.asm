; display lists

.align $400

TEXTDL:
	.DB $70,$70,$70			; 3 x 8 blank scanlines
	.DB $42				; antic mode 2 screen ptr follows 40x24 text mode
	.DW scr_mem	
	.DB $02,$02,$02,$02,$02
	.DB $02,$02,$02,$02,$02,$02
	.DB $02,$02,$02,$02,$02,$02
	.DB $02,$02,$02,$02,$02,$02	; 23 more lines of mode 2
	.DB $41				; wait vbl and jump to start
	.DW TEXTDL
	
GRDL:
	.DB $70,$70,$70			; 3 x 8 blank scanlines
	.DB $4D				; antic mode D screen ptr follows 160x96 4 colors
	.DW scr_mem	
	.DB $0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D
	.DB $0D,$0D,$0D,$0D,$0D,$0D	; 95 more lines of mode D
	.DB $41				; wait vbl and jump to start
	.DW GRDL	