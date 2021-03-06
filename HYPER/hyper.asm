; 05/24/2017	9868 bytes


	ICL "system.equ"
;
; User equates
;

PTR_L00D9   = $00D9
PTR_L00D5   = $00D5
COLORIDX_L00CF= $00CF
PTR_L00C7   = $00C7
PTR_L00BA   = $00BA
PTR_L00B7   = $00B7
ZPVAR_L00B3 = $00B3
ZPVAR_L00B2 = $00B2
PTR_L0094   = $0094
PTR_L0092   = $0092
;
; Code equates
;
dis_VBLKD_L5178       = $0089	; disable VBLKD_L5178 if != 0
L008A       = $008A		; audio duration
varAUDF4       = $008B
waitLoopCount       = $008C
twopl1       = $008D	; bool flag for two/one player
joyIndex       = $008E	; index of active joystick
L008F       = $008F	; bool value to skip some code
L0090       = $0090	; some bool value, toggles skip of subroutine
L0096       = $0096	; some bool value, toggles skip of subroutine
L0097       = $0097
L0098       = $0098
twopl2       = $0099	; bool flag for two/one player
lifes       = $009A	; stores lifes+1 starts with 5 (4 lifes)
L009B       = $009B
L009C       = $009C	; difficulty
L009D       = $009D
L009E       = $009E
hits       = $009F	; hitpoints?
L00A0       = $00A0
update_highscore       = $00A6	; bool indicates if highscore needs update
L00A7       = $00A7
L00A8       = $00A8	; some bool value
L00A9       = $00A9
L00AA       = $00AA
L00AB       = $00AB
PTR_L00AC       = $00AC

L00AE       = $00AE
L00AF       = $00AF
L00B0       = $00B0
L00B1       = $00B1
L00B4       = $00B4
L00B5       = $00B5
L00B6       = $00B6
L00B9       = $00B9
PTR_L00BC       = $00BC

L00BE       = $00BE
L00BF       = $00BF
L00C0       = $00C0
firstStar       = $00C1
lastStar       = $00C2
PTR_L00C3       = $00C3

L00C5       = $00C5
L00C6       = $00C6
L00C9       = $00C9
u16_d0      = $00D0	; used to fill a table

L00D2       = $00D2	; flag for initialized? some kind of loop counter
L00D3       = $00D3
L00D4       = $00D4
PTR_L00D7       = $00D7

L00DB       = $00DB
L00DC       = $00DC
L00DD       = $00DD
L00DE       = $00DE
L00DF       = $00DF
L00E0       = $00E0
L00E1       = $00E1
L00E2       = $00E2
L00E3       = $00E3
mis0x       = $00E4
mis1x       = $00E5
mis2x       = $00E6
L00E7       = $00E7
L00E8       = $00E8
L00E9       = $00E9
L00EB       = $00EB
L00EC       = $00EC
L00ED       = $00ED
L00EE       = $00EE
L00EF       = $00EF
L00F0       = $00F0
L00F1       = $00F1
L00F2       = $00F2
L00F4       = $00F4
L00F5       = $00F5
L00F6       = $00F6
L00F7       = $00F7
L00F8       = $00F8
pl0x       = $00F9
pl2x       = $00FB
L00FC       = $00FC
L00FD       = $00FD
L00FE       = $00FE
L00FF       = $00FF


L30D8       = $30D8


L34E8       = $34E8
L3548       = $3548
L35A8       = $35A8
L3608       = $3608

; define some ram locations
	org $0F16
scrolldata	.DS 127
	
	org $100E
scrline1	.DS 22		; screen ram at $100E
scrline2	.DS 20
grscreen	.DS 101*40
grscreen2	.DS 101*40	; second gr part at $2000
grovl		.DS 112		; clr_grmem overwrites this

	org $3018
scrline3	.DS 40		; ends at $3039

	org $3238
RAM264_L3238	.DS 264	

	org $3388
star_column_values	.DS 256
	
	org $3488
DATA192_L3488	.DS 192

	org $3708
GRLINESH_L3708	.DS 214		; ..$37DD


	org $37E0
GRLINESL_L37E0	.DS 214	
test		.DS 1

	org $3800
pmdata		.DS 192
star_lines	.DS 60
star_columns	.DS 60
star_values	.DS 60
free		.DS 12
DATA6_L3980	.DS 6
free1		.DS 2
DATA6_L3988	.DS 6
free11		.DS 2
DATA48_L3990	.DS 48
free12		.DS 64
TABLE60_16bit_L3A00	.DS 120
free2		.DS 8
DATA6_L3A80	.DS 6
free21		.DS 2
DATA6_L3A88	.DS 6
free22		.DS 2
DATA6_L3A90	.DS 6
DATA6_L3A96	.DS 6
free23		.DS 8
playerdata_L3AA4: 
            .DS 13
playerdata_L3AB1            
            .DS 13
free3		.DS 2
DATA20_L3AC0	.DS 20
DATA44_L3AD4	.DS 44            
mis0		.DS 256
pl0		.DS 256
pl1		.DS 256
pl2		.DS 256
pl3		.DS 256	

;
; Start of code
;
            org $3FE0
;
CAS_LOADADR_L3FE0:
            .byte $00,$4C
            .word CAS_LOADADR_L3FE0,CAS_INIT_L3FF8
            lda #<main
            sta CASINI
            sta DOSVEC
            lda #>main
            sta CASINI+1
            sta DOSVEC+1
            lda #$02
            sta BOOT
            clc
            rts
CAS_INIT_L3FF8:
            rts

            ;org $3FF9
            
            .byte $00,$00,$00,$00,$00,$00,$00
L4000:      .byte $10
            .byte $00,$01,$00,$14,$C0,$C5,$00,$14
            .byte $33,$05,$00,$15,$2A,$15,$00,$05
            .byte $8C,$94,$00,$00,$BF,$80,$00,$00
            .byte $80,$80,$00,$00,$2A,$00,$00,$00
            .byte $C0,$C0,$00,$03,$C0,$F0,$00,$00
            .byte $00,$00,$00,$05,$03,$00,$00,$05
            .byte $40,$C0,$00,$01,$5A,$00,$00,$00
            .byte $22,$8C,$00,$00,$8F,$A3,$00,$0C
            .byte $A3,$20,$00,$0F,$28,$90,$00,$00
            .byte $0A,$14,$00,$00,$30,$15,$00,$00
            .byte $3C,$05,$00,$00,$00,$00,$00,$00
            .byte $00,$55,$00,$00,$01,$54,$00,$0C
            .byte $01,$40,$00,$0F,$2A,$0C,$00,$00
            .byte $8C,$B0,$00,$00,$8F,$80,$00,$00
            .byte $8C,$B0,$00,$0F,$2A,$0C,$00,$0C
            .byte $01,$40,$00,$00,$01,$54,$00,$00
            .byte $00,$55,$00,$00,$00,$00,$00,$14
            .byte $0F,$00,$00,$15,$03,$00,$00,$05
            .byte $28,$00,$00,$01,$8A,$3C,$00,$02
            .byte $32,$8C,$00,$32,$BC,$80,$00,$0C
            .byte $A2,$00,$00,$00,$29,$50,$00,$00
            .byte $C0,$54,$00,$00,$30,$14,$00,$05
            .byte $50,$00,$00,$01,$54,$00,$00,$00
            .byte $14,$03,$00,$03,$0A,$8F,$00,$00
            .byte $E3,$20,$00,$00,$2F,$20,$00,$00
            .byte $E3,$20,$00,$03,$0A,$8F,$00,$00
            .byte $14,$03,$00,$01,$54,$00,$00,$05
            .byte $50,$00,$00,$00,$04,$00,$00,$00
            .byte $04,$00,$00,$00,$04,$00,$00,$00
            .byte $3F,$00,$00,$00,$B3,$80,$00,$02
            .byte $3F,$20,$00,$00,$04,$00,$00,$00
            .byte $11,$00,$00,$00,$40,$40,$00,$01
            .byte $00,$10,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$04,$00,$00
            .byte $00,$10,$00,$00,$AF,$C0,$00,$00
            .byte $0C,$C0,$00,$00,$0F,$C0,$00,$05
            .byte $50,$80,$00,$00,$10,$80,$00,$00
            .byte $10,$00,$00,$00,$10,$00,$00,$00
            .byte $10,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$04,$08,$00,$00,$01
            .byte $02,$00,$00,$00,$4F,$00,$00,$00
            .byte $1C,$D4,$00,$00,$4F,$00,$00,$01
            .byte $02,$00,$00,$04,$08,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $01,$00,$00,$00,$01,$00,$00,$00
            .byte $01,$00,$00,$00,$81,$00,$00,$00
            .byte $81,$54,$00,$00,$FC,$00,$00,$00
            .byte $CC,$00,$00,$00,$FE,$80,$00,$01
            .byte $00,$00,$00,$04,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$08,$04,$00,$00
            .byte $20,$10,$00,$00,$FC,$40,$00,$05
            .byte $CD,$00,$00,$00,$FC,$40,$00,$00
            .byte $20,$10,$00,$00,$08,$04,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$04,$37,$04,$00,$01
            .byte $0C,$10,$00,$00,$AE,$80,$00,$0C
            .byte $19,$0C,$00,$03,$19,$30,$00,$00
            .byte $E6,$C0,$00,$03,$26,$30,$00,$0C
            .byte $11,$0C,$00,$00,$11,$00,$00,$01
            .byte $40,$50,$00,$00,$00,$00,$00,$00
            .byte $14,$C0,$00,$03,$08,$10,$00,$00
            .byte $CA,$CC,$00,$00,$16,$80,$00,$00
            .byte $29,$A4,$00,$11,$99,$04,$00,$04
            .byte $20,$C0,$00,$00,$10,$30,$00,$00
            .byte $40,$00,$00,$00,$10,$00,$00,$00
            .byte $00,$00,$00,$03,$03,$04,$00,$10
            .byte $CC,$10,$00,$10,$30,$80,$00,$05
            .byte $A5,$8C,$00,$00,$5A,$F4,$00,$05
            .byte $A5,$8C,$00,$10,$30,$80,$00,$10
            .byte $CC,$10,$00,$03,$03,$04,$00,$00
            .byte $00,$00,$00,$00,$01,$00,$00,$00
            .byte $00,$40,$00,$03,$01,$00,$00,$00
            .byte $C2,$04,$00,$04,$19,$91,$00,$06
            .byte $9A,$00,$00,$00,$A5,$00,$00,$0C
            .byte $E8,$C0,$00,$01,$08,$30,$00,$00
            .byte $C5,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$04,$30,$30,$00,$01
            .byte $0C,$C1,$00,$00,$83,$01,$00,$0C
            .byte $96,$94,$00,$07,$E9,$40,$00,$0C
            .byte $96,$94,$00,$00,$83,$01,$00,$01
            .byte $0C,$C1,$00,$04,$30,$30,$00,$00
            .byte $00,$00,$00,$00,$04,$00,$00,$00
            .byte $2D,$00,$00,$00,$6E,$40,$00,$00
            .byte $4C,$40,$00,$01,$2A,$10,$00,$01
            .byte $E2,$D0,$00,$01,$2A,$10,$00,$00
            .byte $4C,$40,$00,$00,$6E,$40,$00,$00
            .byte $2D,$00,$00,$00,$04,$00,$00,$00
            .byte $01,$54,$00,$00,$15,$B4,$00,$01
            .byte $50,$E4,$00,$01,$CB,$14,$00,$05
            .byte $22,$10,$00,$04,$88,$50,$00,$14
            .byte $E3,$40,$00,$1B,$05,$40,$00,$1E
            .byte $54,$00,$00,$15,$40,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$15,$00,$00,$01
            .byte $4C,$50,$00,$06,$2A,$24,$00,$1F
            .byte $22,$FD,$00,$06,$2A,$24,$00,$01
            .byte $4C,$50,$00,$00,$15,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $01,$54,$00,$00,$15,$B4,$00,$01
            .byte $50,$E4,$00,$01,$CB,$14,$00,$05
            .byte $22,$10,$00,$04,$88,$50,$00,$14
            .byte $E3,$40,$00,$1B,$05,$40,$00,$1E
            .byte $54,$00,$00,$15,$40,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$15,$00,$00,$01
            .byte $4C,$50,$00,$06,$2A,$24,$00,$1F
            .byte $22,$FD,$00,$06,$2A,$24,$00,$01
            .byte $4C,$50,$00,$00,$15,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $08,$00,$00,$01,$6A,$50,$00,$07
            .byte $59,$74,$00,$1C,$99,$8D,$00,$3F
            .byte $BB,$BF,$00,$0E,$BB,$AC,$00,$01
            .byte $C0,$D0,$00,$05,$7B,$54,$00,$01
            .byte $0C,$10,$00,$01,$0C,$10,$00,$14
            .byte $33,$05,$00,$00,$D5,$5A,$00,$00
            .byte $F1,$9A,$00,$00,$EE,$E5,$00,$01
            .byte $5B,$B9,$00,$11,$70,$E5,$00,$04
            .byte $38,$B1,$00,$00,$3F,$6D,$00,$00
            .byte $C1,$7F,$00,$0F,$01,$40,$00,$03
            .byte $04,$00,$00,$00,$01,$00,$00,$10
            .byte $03,$40,$00,$10,$4F,$D0,$00,$05
            .byte $5B,$34,$00,$00,$7A,$94,$00,$30
            .byte $CF,$58,$00,$0F,$8A,$AA,$00,$30
            .byte $CF,$58,$00,$00,$7A,$94,$00,$05
            .byte $5B,$34,$00,$10,$4F,$D0,$00,$10
            .byte $03,$40,$00,$00,$10,$00,$00,$00
            .byte $04,$30,$00,$00,$50,$3C,$00,$3F
            .byte $50,$C0,$00,$1E,$7F,$00,$00,$13
            .byte $8B,$04,$00,$16,$C3,$51,$00,$1B
            .byte $B9,$50,$00,$16,$EE,$C0,$00,$29
            .byte $93,$C0,$00,$29,$55,$C0,$00,$00
            .byte $70,$01,$00,$01,$FC,$41,$00,$07
            .byte $39,$54,$00,$05,$AB,$40,$00,$09
            .byte $7C,$C0,$00,$2A,$A8,$BC,$00,$09
            .byte $7C,$C0,$00,$05,$AB,$40,$00,$07
            .byte $39,$54,$00,$01,$FC,$41,$00,$00
            .byte $70,$01,$00,$00,$15,$00,$00,$00
            .byte $08,$00,$00,$03,$08,$30,$00,$00
            .byte $FF,$C0,$00,$10,$C8,$C1,$00,$1A
            .byte $EE,$E9,$00,$10,$C8,$C1,$00,$00
            .byte $FF,$C0,$00,$03,$08,$30,$00,$00
            .byte $08,$00,$00,$00,$15,$00,$00,$01
            .byte $00,$10,$00,$04,$00,$04,$00,$12
            .byte $0C,$21,$00,$00,$B3,$80,$00,$00
            .byte $E2,$C0,$00,$03,$0C,$30,$00,$00
            .byte $E2,$C0,$00,$00,$B3,$80,$00,$12
            .byte $0C,$21,$00,$04,$00,$04,$00,$01
            .byte $00,$10,$00,$00,$15,$00,$00,$00
            .byte $08,$00,$00,$03,$08,$30,$00,$00
            .byte $FF,$C0,$00,$10,$C8,$C1,$00,$1A
            .byte $EE,$E9,$00,$10,$C8,$C1,$00,$00
            .byte $FF,$C0,$00,$03,$08,$30,$00,$00
            .byte $08,$00,$00,$00,$15,$00,$00,$01
            .byte $00,$10,$00,$04,$00,$04,$00,$12
            .byte $0C,$21,$00,$00,$B3,$80,$00,$00
            .byte $E2,$C0,$00,$03,$0C,$30,$00,$00
            .byte $E2,$C0,$00,$00,$B3,$80,$00,$12
            .byte $0C,$21,$00,$04,$00,$04,$00,$01
            .byte $00,$10,$00,$00,$15,$00,$00,$00
            .byte $08,$00,$00,$03,$08,$30,$00,$00
            .byte $FF,$C0,$00,$10,$C8,$C1,$00,$1A
            .byte $EE,$E9,$00,$10,$C8,$C1,$00,$00
            .byte $FF,$C0,$00,$03,$08,$30,$00,$00
            .byte $08,$00,$00,$00,$15,$00,$00,$00
            .byte $00,$00,$00,$00,$05,$00,$00,$00
            .byte $1F,$40,$00,$00,$4A,$10,$00,$01
            .byte $BA,$E4,$00,$04,$2F,$81,$00,$05
            .byte $05,$05,$00,$00,$30,$C0,$00,$00
            .byte $C0,$30,$00,$03,$C0,$3C,$00,$00
            .byte $00,$00,$00,$00,$15,$55,$00,$00
            .byte $42,$3D,$00,$00,$13,$AD,$00,$0C
            .byte $03,$A1,$00,$03,$F5,$F9,$00,$00
            .byte $01,$01,$00,$00,$03,$11,$00,$00
            .byte $03,$04,$00,$00,$03,$00,$00,$00
            .byte $00,$C0,$00,$00,$00,$00,$00,$00
            .byte $14,$00,$00,$0C,$11,$00,$00,$0F
            .byte $02,$40,$00,$00,$CB,$10,$00,$00
            .byte $1E,$B4,$00,$00,$1E,$B4,$00,$00
            .byte $CB,$10,$00,$0F,$02,$40,$00,$0C
            .byte $11,$00,$00,$00,$14,$00,$00,$00
            .byte $00,$00,$00,$00,$30,$00,$00,$00
            .byte $0C,$00,$00,$01,$0C,$00,$00,$04
            .byte $4C,$00,$00,$04,$04,$00,$00,$06
            .byte $F5,$FC,$00,$04,$AC,$03,$00,$07
            .byte $AC,$40,$00,$07,$C8,$10,$00,$05
            .byte $55,$40,$00,$00,$00,$00,$00,$00
            .byte $01,$40,$00,$00,$04,$43,$00,$00
            .byte $18,$0F,$00,$00,$4E,$30,$00,$01
            .byte $EB,$40,$00,$01,$EB,$40,$00,$00
            .byte $4E,$30,$00,$00,$18,$0F,$00,$00
            .byte $04,$43,$00,$00,$01,$40,$00,$00
            .byte $00,$00,$00,$00,$04,$00,$00,$00
            .byte $1D,$00,$00,$00,$7B,$40,$00,$01
            .byte $E2,$D0,$00,$01,$C0,$D0,$00,$07
            .byte $00,$34,$00,$04,$00,$04,$00,$10
            .byte $00,$01,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$05
            .byte $55,$40,$00,$00,$0F,$D4,$00,$00
            .byte $00,$B4,$00,$00,$00,$2D,$00,$00
            .byte $00,$0D,$00,$00,$00,$0D,$00,$00
            .byte $00,$01,$00,$00,$00,$01,$00,$00
            .byte $00,$01,$00,$00,$00,$01,$00,$00
            .byte $00,$00,$00,$00,$40,$00,$00,$00
            .byte $14,$00,$00,$00,$0D,$40,$00,$00
            .byte $03,$D0,$00,$00,$00,$B4,$00,$00
            .byte $00,$2D,$00,$00,$00,$B4,$00,$00
            .byte $03,$D0,$00,$00,$0D,$40,$00,$00
            .byte $14,$00,$00,$00,$40,$00,$00,$00
            .byte $00,$00,$00,$10,$00,$00,$00,$10
            .byte $00,$00,$00,$10,$00,$00,$00,$10
            .byte $00,$00,$00,$1C,$00,$00,$00,$1C
            .byte $00,$00,$00,$1E,$00,$00,$00,$07
            .byte $80,$00,$00,$05,$FC,$00,$00,$00
            .byte $55,$54,$00,$00,$00,$40,$00,$00
            .byte $05,$00,$00,$00,$5C,$00,$00,$01
            .byte $F0,$00,$00,$07,$80,$00,$00,$1E
            .byte $00,$00,$00,$07,$80,$00,$00,$01
            .byte $F0,$00,$00,$00,$5C,$00,$00,$00
            .byte $05,$00,$00,$00,$00,$40,$00,$00
            .byte $14,$00,$00,$00,$C3,$00,$00,$00
            .byte $28,$00,$00,$00,$05,$00,$00,$00
            .byte $03,$C0,$00,$00,$00,$20,$00,$00
            .byte $00,$20,$00,$00,$01,$40,$00,$00
            .byte $0F,$00,$00,$00,$20,$00,$00,$00
            .byte $20,$00,$00,$00,$00,$30,$00,$00
            .byte $50,$84,$00,$03,$08,$63,$00,$03
            .byte $03,$58,$00,$03,$00,$00,$00,$08
            .byte $00,$00,$00,$08,$00,$00,$00,$08
            .byte $00,$00,$00,$04,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$0C,$00,$28
            .byte $00,$21,$00,$03,$00,$61,$00,$03
            .byte $43,$4C,$00,$00,$43,$00,$00,$00
            .byte $28,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$01,$00,$00
            .byte $00,$08,$00,$00,$00,$08,$00,$00
            .byte $00,$08,$00,$00,$00,$30,$00,$09
            .byte $70,$30,$00,$32,$48,$30,$00,$04
            .byte $81,$40,$00,$03,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $0A,$00,$00,$00,$30,$40,$00

            .byte $0C,$70,$70,$00,$12,$40,$30,$00
            .byte $12,$00,$0A,$00,$0C,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$04,$00,$00
            .byte $00,$04,$00,$00,$00,$15,$00,$00
            .byte $04,$11,$04,$00,$04,$22,$04,$00
            .byte $0B,$F3,$F8,$00,$0C,$1D,$0C,$00
            .byte $0F,$FB,$FC,$00,$0C,$22,$0C,$00
            .byte $08,$11,$08,$00,$00,$40,$40,$00
            .byte $00,$10,$01,$00,$00,$80,$54,$00
            .byte $03,$31,$44,$00,$0C,$0A,$14,$00
            .byte $23,$3C,$90,$00,$00,$5F,$80,$00
            .byte $03,$F7,$31,$00,$16,$B4,$08,$00
            .byte $00,$B3,$30,$00,$00,$40,$C0,$00
            .byte $00,$42,$00,$00,$00,$00,$00,$00
            .byte $0B,$F9,$40,$00,$00,$CC,$00,$00
            .byte $10,$CC,$00,$00,$06,$DE,$50,$00
            .byte $00,$B0,$15,$00,$06,$DE,$50,$00
            .byte $10,$CC,$00,$00,$00,$CC,$00,$00
            .byte $0B,$F9,$40,$00,$00,$00,$00,$00
            .byte $00,$20,$40,$00,$00,$C0,$40,$00
            .byte $03,$33,$80,$00,$08,$07,$A5,$00
            .byte $13,$37,$F0,$00,$00,$BD,$40,$00
            .byte $01,$8F,$32,$00,$05,$28,$0C,$00
            .byte $04,$53,$30,$00,$05,$40,$80,$00
            .byte $10,$01,$00,$00,$00,$00,$00,$00
            .byte $00,$5B,$F8,$00,$00,$0C,$C0,$00
            .byte $00,$0C,$C1,$00,$01,$6D,$E4,$00
            .byte $15,$03,$80,$00,$01,$6D,$E4,$00
            .byte $00,$0C,$C1,$00,$00,$0C,$C0,$00
            .byte $00,$5B,$F8,$00,$00,$00,$00,$00
DATA264BY_L4898:
            .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$03,$00,$00,$00,$C7,$20,$00
            .byte $08,$3D,$80,$00,$02,$AE,$00,$00
            .byte $00,$3B,$C0,$00,$03,$C8,$30,$00
            .byte $20,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$30,$00
            .byte $03,$00,$C0,$00,$00,$C7,$02,$00
            .byte $00,$C7,$28,$00,$28,$3D,$80,$00
            .byte $02,$AE,$50,$00,$00,$3B,$C0,$00
            .byte $03,$C9,$3C,$00,$30,$21,$00,$00
            .byte $00,$80,$40,$00,$00,$80,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$C0,$00
            .byte $00,$C3,$00,$00,$00,$C7,$28,$00
            .byte $08,$3D,$80,$00,$02,$AA,$40,$00
            .byte $00,$3B,$C0,$00,$0F,$C9,$30,$00
            .byte $00,$21,$00,$00,$00,$20,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$03,$00,$00
            .byte $00,$C7,$20,$00,$00,$3D,$80,$00
            .byte $02,$AA,$40,$00,$00,$3B,$C0,$00
            .byte $03,$C8,$00,$00,$00,$20,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$03,$00,$00
            .byte $00,$3C,$00,$00,$00,$A2,$40,$00
            .byte $00,$3B,$00,$00,$00,$C8,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$C4,$00,$00
            .byte $00,$3B,$00,$00,$00,$08,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00
L49A0       .byte $40,$3E,$3C,$3B,$3A,$36,$34,$32
            .byte $30,$2E,$2C,$2A,$28,$27,$26,$24
            .byte $23,$22,$21,$1C,$1A,$18,$16,$14
            .byte $12,$14,$16,$18,$1A,$1C,$1E,$20
            .byte $22,$24,$26,$28,$2A,$2C,$2E,$30
            .byte $0A,$00,$0A,$00,$0A,$00,$0A,$0A
            .byte $7E,$7C,$7A,$78,$76,$74,$70,$6E
            .byte $6C,$6A,$68,$64,$62,$60,$5E,$5C
            .byte $5A,$56,$54,$52,$50,$4E,$4A,$48
            .byte $46,$40,$40,$40,$00,$00,$00,$50
            .byte $50,$50,$50,$50,$00,$00,$50,$50
            .byte $50,$50,$50,$50,$00,$00,$00,$00
            .byte $90,$88,$80,$78,$70,$68,$60,$58
            .byte $50,$48,$40,$38,$30,$28,$20,$00
            .byte $00,$AA,$AC,$AE,$B0,$B2,$B4,$B6
            .byte $B8,$BA,$BC,$BE,$C0,$00,$CA,$CC
            .byte $CE,$D0,$D2,$D4,$D6,$D8,$DA,$DC
            .byte $DE,$E0,$E2,$E4,$E6,$E8,$EA,$EC
            .byte $35,$35,$35,$46,$48,$4A,$4C,$4E
            .byte $50,$52,$54,$56,$58,$5A,$5C,$5E
            .byte $60,$5E,$5C,$5A,$58,$56,$54,$52
            .byte $50,$4E,$4C,$4A,$48,$46,$44,$42
            .byte $40,$42,$44,$46,$48,$4A,$4C,$4E
            .byte $50,$52,$54,$56,$58,$5A,$5C,$30
            .byte $4A,$49,$48,$47,$48,$60,$60,$60
            .byte $62,$64,$66,$68,$6A,$70,$70,$6E
            .byte $6C,$6A,$68,$66,$68,$6A,$6C,$70
            .byte $70,$6E,$6C,$68,$66,$64,$68,$6A
            .byte $68,$66,$64,$60,$5E,$5C,$58,$58
            .byte $58,$54,$52,$50,$4E,$4C,$4A,$48
            .byte $60,$60,$61,$62,$62,$63,$64,$64
            .byte $65,$66,$66,$67,$68,$68,$69,$6A
            .byte $6A,$6B,$6C,$6C,$6D,$6E,$6E,$6F
            .byte $70,$70,$71,$72,$72,$73,$74,$74
            .byte $75,$76,$76,$77,$78,$78,$79,$7A
            .byte $7A,$7B,$7C,$7C,$00,$00,$00,$00
            .byte $10,$10,$16,$16,$18,$1F,$23,$28
            .byte $28,$2A,$2D,$2F,$32,$35,$39,$3C
            .byte $40,$44,$48,$4C,$51,$55,$5B,$60
            .byte $66,$6C,$72,$79,$80,$88,$72,$66
            .byte $60,$5B,$51,$48,$40,$39,$32,$2D
            .byte $28,$23,$1F,$1F,$18,$18,$16,$16
            .byte $90,$92,$94,$96,$98,$9A,$9C,$9E
            .byte $38,$36,$34,$32,$30,$20,$1E,$1C
            .byte $1A,$18,$20,$24,$25,$27,$29,$2A
            .byte $30,$32,$35,$40,$44,$46,$48,$50
            .byte $90,$90,$90,$90,$90,$8C,$8A,$88
            .byte $86,$84,$82,$80,$7C,$70,$70,$70
            .byte $23,$21,$1F,$1D,$1F,$21,$32,$32
            .byte $32,$35,$39,$39,$3C,$40,$40,$3C
            .byte $3C,$39,$35,$32,$35,$39,$3C,$40
            .byte $40,$3C,$3C,$39,$35,$32,$39,$3C
            .byte $39,$35,$32,$2F,$2D,$2A,$28,$28
            .byte $28,$25,$23,$21,$1F,$1D,$1D,$1F
            .byte $0A,$10,$14,$16,$18,$1A,$1D,$00
            .byte $2A,$30,$34,$36,$38,$3A,$3D,$40
            .byte $5A,$60,$64,$66,$68,$6A,$6D,$70
            .byte $A0,$A1,$A2,$A3,$A4,$A6,$A7,$A8
            .byte $AA,$AB,$AA,$A9,$A8,$A7,$A5,$A3
            .byte $A0,$9E,$9A,$98,$96,$95,$94,$93
L4B80:      .byte $0A,$2E,$08,$4D,$06,$76,$04,$7D
            .byte $02,$B0,$00,$B3,$08,$B4,$00,$B5
            .byte $08,$B6,$00,$B7,$08,$B8,$00,$B9
            .byte $08,$BA,$00,$BB,$08,$BC,$00,$BD
            .byte $08,$BE,$00,$BF,$08,$C0,$00,$C1
            .byte $08,$C2,$00,$C3,$08,$C4,$00,$C5
            .byte $08,$C6,$00,$C7,$02,$D1,$0E,$F2
            .byte $0C,$00,$0A,$09,$08,$1A,$06,$29
            .byte $0A,$4E,$08,$6B,$06,$97,$04,$A6
            .byte $02,$C5,$00,$E4,$0E,$F4,$0C,$00
            .byte $0A,$16,$08,$29,$06,$44,$08,$57
            .byte $0C,$74,$0A,$88,$08,$99,$04,$BD
            .byte $06,$CF,$04,$DE,$02,$E8,$00,$F8
            .byte $0E,$00,$02,$29,$04,$3D,$06,$69
            .byte $08,$88,$0A,$B4,$0C,$C6,$0E,$F1
            .byte $00,$00,$0A,$0C,$0C,$16,$0A,$22
            .byte $0C,$2A,$0A,$3B,$08,$43,$06,$52
            .byte $04,$61,$02,$70,$00,$7F,$0E,$8F
            .byte $0C,$99,$0A,$A5,$08,$AF,$06,$BB
            .byte $04,$C5,$06,$D1,$04,$DB,$06,$E9
            .byte $04,$F3,$06,$00,$06,$2D,$08,$36
            .byte $0A,$59,$08,$7B,$06,$94,$04,$A3
            .byte $02,$BB,$00,$CA,$0E,$DF,$0C,$F5
            .byte $0A,$00,$06,$1C,$02,$3A,$04,$4D
            .byte $08,$50,$02,$78,$06,$80,$08,$90
            .byte $0A,$B0,$0C,$C1,$0E,$E8,$0A,$F0
            .byte $0C,$00,$04,$0F,$06,$22,$08,$37
            .byte $00,$46,$02,$5E,$04,$73,$06,$91
            .byte $08,$99,$0A,$A4,$0C,$B7,$0E,$CF
            .byte $0C,$E9,$0A,$00,$06,$09,$04,$11
            .byte $06,$1B,$04,$29,$06,$34,$08,$43
            .byte $0A,$53,$0C,$5E,$0E,$68,$00,$74
            .byte $02,$80,$04,$88,$06,$91,$04,$9A
            .byte $06,$A2,$04,$AA,$06,$B7,$08,$C8
            .byte $0A,$DB,$0C,$EA,$0A,$F3,$0C,$FD
            .byte $0A,$00,$0A,$12,$08,$1A,$06,$40
            .byte $02,$50,$00,$56,$0E,$64,$0C,$6A
            .byte $0A,$7C,$08,$88,$06,$CD,$08,$E0
            .byte $0A,$00,$00,$00,$00,$00,$00,$00
//TODO declare DATA
.proc SUB_L4CB8
            lda #<L30D8
            sta PTR_L00B7
            lda #>L30D8
            sta PTR_L00B7+1		; B7=$30D8		
            lda #<grscreen
            sta PTR_L00BA
            lda #>grscreen
            sta PTR_L00BA+1		; init 2 pointer variables
            ldx #$00
l1: 	    lda PTR_L00BA+1
            sta GRLINESH_L3708,X
            lda PTR_L00BA
            sta GRLINESL_L37E0,X		; fill table with grscreen locations
            lda PTR_L00BA
            clc
            adc #40			; one pointer every 40 bytes (every screen line)
            sta PTR_L00BA
            lda PTR_L00BA+1
            adc #$00
            sta PTR_L00BA+1
            inx
            cpx #202			; for all 202 lines
            bne l1
l2:         lda #>DATA44_L3AD4
            sta GRLINESH_L3708,X
            lda #<DATA44_L3AD4
            sta GRLINESL_L37E0,X
            inx
            cpx #214
            bne l2			; write 12 more pointers to table, all to $3AD4

            ldy #$00
            lda #$80
            sta u16_d0			; D0=$80
            lda #$04
            sta u16_d0+1		; D1=$04
l3:         lda u16_d0			; fill another table
            sta TABLE60_16bit_L3A00,Y
            iny
            lda u16_d0+1
            sta TABLE60_16bit_L3A00,Y
            lda u16_d0
            clc
            adc #44
            sta u16_d0
            lda u16_d0+1
            adc #00
            sta u16_d0+1
            iny
            cpy #120			; 60 16bit values $0480+$2C... (1152 + 44)
            bne l3

            lda #$00
            sta ZPVAR_L00B2		; b2 = 0
            sta L00B1			; b1 = 0
            
            jsr part2			; to second part of subroutine
            
L4:         ldy ZPVAR_L00B2		; while (true) l4
            lda TABLE60_16bit_L3A00,Y
            sta PTR_L00BA
            lda TABLE60_16bit_L3A00+1,Y	; load ptr_BA from table
            sta PTR_L00BA+1
            inc ZPVAR_L00B2
            inc ZPVAR_L00B2		; set index to next pointer

l41:        ldy #$00			; while (true) l41
l411:       lda DATA44_L3AD4,Y			; for (i=0; i<44; i++)
            sta (PTR_L00BA),Y		; ptr_BA[i]=L3AD4[i]
            iny
            cpy #44
            bne l411			; endfor
            
            ldx #$00			; for(i=0; i<44; i+=4)
l412: 	    lda DATA44_L3AD4+3,X
            clc
            lsr
            lsr
            sta DATA44_L3AD4+3,X			; L3AD7[i] >>= 2

            lda DATA44_L3AD4+2,X
            and #$03
            asl
            asl
            asl
            asl
            asl
            asl
            adc DATA44_L3AD4+3,X
            sta DATA44_L3AD4+3,X			; L3AD7[i] = ((L3AD6[i] & 3) << 6) + L3AD7[i]

            lsr DATA44_L3AD4+2,X
            lsr DATA44_L3AD4+2,X			; L3AD6[i] >>= 2

            lda DATA44_L3AD4+1,X
            and #$03
            asl
            asl
            asl
            asl
            asl
            asl
            clc
            adc DATA44_L3AD4+2,X
            sta DATA44_L3AD4+2,X			; L3AD6[i] = ((L3AD5[i] & 3) << 6) + L3AD6[i]

            lsr DATA44_L3AD4+1,X
            lsr DATA44_L3AD4+1,X			; L3AD5[i] >>= 2

            lda DATA44_L3AD4,X
            and #$03
            asl
            asl
            asl
            asl
            asl
            asl
            clc
            adc DATA44_L3AD4+1,X
            sta DATA44_L3AD4+1,X			; L3AD5[i] = ((L3AD4[i] & 3) << 6) + L3AD5[i]
            lsr DATA44_L3AD4,X
            lsr DATA44_L3AD4,X			; DATA44_L3AD4[i] >>= 2
            inx
            inx
            inx
            inx
            cpx #44
            bne l412		; endfor l412
            
            inc PTR_L00BA+1
            inc PTR_L00BA+1	; ptr_BA+=512
            lda PTR_L00BA	
            clc
            adc #148		
            sta PTR_L00BA
            lda PTR_L00BA+1
            adc #$00
            sta PTR_L00BA+1	; ptr_BA+=148  (512+148=660)

            inc ZPVAR_L00B3
            lda ZPVAR_L00B3	; 0..3
            cmp #$04
            beq l41_out
            jmp l41			; end while(true) l41

l41_out:    jsr part2
            jmp l4			; end while(true) l4
            
part2:      lda #$00
            sta ZPVAR_L00B3
            
            ldy #$00
l21:        lda (PTR_L00B7),Y
            sta DATA44_L3AD4,Y
            iny
            cpy #44
            bne l21			; copy 44bytes from ptr_b7 to $3AD4
            
            lda PTR_L00B7
            clc
            adc #44
            sta PTR_L00B7
            lda PTR_L00B7+1
            adc #$00
            sta PTR_L00B7+1		; ptr_b7 += 44
            inc L00B1			; b1++
            lda L00B1
            cmp #15
            beq else1
            rts				; if (b1<15) return

else1:      ldy #$00			
            tya				; a=0
					; for(i=0; i<256; i++)
l22:        sta star_column_values,Y			; star_column_values[i]=a
            clc
            adc #$01			; a++
            cmp #40			; if (a==40) a=0
            bne else2
            lda #$00			
else2:      iny
            cpy #$00
            bne l22			; endfor
            
            pla
            pla
            rts				; return from last 2 jsr
.endp            
            
SUB_L4DFA:  ldx L00B6
            lda GRLINESH_L3708,X
            sta PTR_L00BA+1
            lda GRLINESL_L37E0,X
            sta PTR_L00BA
            lda L00B5
            and #$03
            sta L00B0
            lda L00B5
            lsr
            lsr
            sta L00B4
            lda L00B0
            beq SKIP_L4E4B
            cmp #$01
            beq SKIP_L4E3C
            cmp #$02
            beq SKIP_L4E2D
            ldy L00BE
            lda TABLE60_16bit_L3A00+90,Y
            sta PTR_L00BC
            lda TABLE60_16bit_L3A00+91,Y
            sta PTR_L00BC+1
            jmp SKIP_L4E5A
SKIP_L4E2D: ldy L00BE
            lda TABLE60_16bit_L3A00+60,Y
            sta PTR_L00BC
            lda TABLE60_16bit_L3A00+61,Y
            sta PTR_L00BC+1
            jmp SKIP_L4E5A
SKIP_L4E3C: ldy L00BE
            lda TABLE60_16bit_L3A00+30,Y
            sta PTR_L00BC
            lda TABLE60_16bit_L3A00+31,Y
            sta PTR_L00BC+1
            jmp SKIP_L4E5A
SKIP_L4E4B: ldy L00BE
            lda TABLE60_16bit_L3A00,Y
            sta PTR_L00BC
            lda TABLE60_16bit_L3A00+1,Y
            sta PTR_L00BC+1
            jmp SKIP_L4E5A
SKIP_L4E5A: lda #$0C
            sta L00B1
            lda #$00
            sta ZPVAR_L00B2
            tax
            ldy L00B4
LOOP_L4E65: sta (PTR_L00BA),Y
            iny
            inx
            cpx #$04
            bne LOOP_L4E65
            jmp SKIP_L4E88
LOOP_L4E70: lda L00B4
            sta ZPVAR_L00B3
            ldx #$00
LOOP_L4E76: ldy ZPVAR_L00B2
            lda (PTR_L00BC),Y
            ldy ZPVAR_L00B3
            sta (PTR_L00BA),Y
            iny
            inx
            inc ZPVAR_L00B2
            inc ZPVAR_L00B3
            cpx #$04
            bne LOOP_L4E76
SKIP_L4E88: inc L00B6
            ldx L00B6
            lda GRLINESL_L37E0,X
            sta PTR_L00BA
            lda GRLINESH_L3708,X
            sta PTR_L00BA+1
            dec L00B1
            bne LOOP_L4E70
            lda #$00
            tax
            ldy L00B4
LOOP_L4E9F: sta (PTR_L00BA),Y
            iny
            inx
            cpx #$04
            bne LOOP_L4E9F
            rts
//TODO            
            .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00
            
main3:      ldx #$00
LOOP_L4EBA: stx L00B1
            ldx L00D3
            txa
            tay
            sta L00F0
            lda DATA6_L3A88,Y
            sta L00C6
            ldx L5160,Y
LOOP_L4ECA: ldy L34E8,X
            beq SKIP_L4F31
            cpy #$C1
            bcc SKIP_L4ED9
            jsr SUB_L50F8
            jmp SKIP_L4F31
SKIP_L4ED9: lda GRLINESL_L37E0,Y
            sta PTR_L00C7
            lda GRLINESH_L3708,Y
            sta PTR_L00C7+1
            ldy DATA192_L3488,X
            lda (PTR_L00C7),Y
            and L3548,X
            sta (PTR_L00C7),Y
            lda PTR_L00C7
            clc
            adc #$28
            sta PTR_L00C7
            bcc SKIP_4EF8
            inc PTR_L00C7+1
SKIP_4EF8:  lda (PTR_L00C7),Y
            and L3548,X
            sta (PTR_L00C7),Y
            lda PTR_L00C7
            clc
            adc #$C8
            sta PTR_L00C7
            bcc SKIP_4F0A
            inc PTR_L00C7+1
SKIP_4F0A:  lda (PTR_L00C7),Y
            and L3548,X
            clc
            adc L35A8,X
            sta (PTR_L00C7),Y
            lda PTR_L00C7
            clc
            adc #$28
            sta PTR_L00C7
            bcc SKIP_L4F20
            inc PTR_L00C7+1
SKIP_L4F20: lda (PTR_L00C7),Y
            and L3548,X
            clc
            adc L35A8,X
            sta (PTR_L00C7),Y
            inc L34E8,X
            inc L34E8,X
SKIP_L4F31: inx
            cpx L00C6
            bne LOOP_L4ECA
            ldx L00B1
            inx
            cpx L009C
            beq SKIP_L4F40
            jmp LOOP_L4EBA
SKIP_L4F40: ldx L00D3
            cpx #$00
            bne SKIP_L4F49
            jsr SUB_L5601
SKIP_L4F49: ldx L00D3
            cpx #$03
            bne SKIP_L4F52
            jsr SUB_L5601
SKIP_L4F52: ldx L00D3
            lda L00A0,X
            beq SKIP_L4F6B
            bmi SKIP_L4F63
            ldy #$00
LOOP_L4F5C: iny
            cpy waitLoopCount
            bne LOOP_L4F5C
            beq SKIP_L4F6B
SKIP_L4F63: ldy #$00
LOOP_L4F63: nop
            iny
            cpy L00D2
            bne LOOP_L4F63
SKIP_L4F6B: inc L00D3
            cpx #$05
            bne L4FD9
            lda #$00
            sta L00D3
            inc L00BF
            lda L00BF
            cmp #$03
            bne L4FC2
            lda #$00
            sta L00BF
            ldx L00C0
LOOP_L4F83: lda DATA6_L3988,X
            bmi SKIP_L4F8A
            bne SKIP_L4F96
SKIP_L4F8A: inx
            cpx #$06
            bne LOOP_L4F83
            lda #$00
            sta L00C0
            jmp L4FD7
SKIP_L4F96: stx L00C0
            inc L00C0
            cpx #$05
            bne SKIP_L4FA2
            ldy #$00
            sty L00C0
SKIP_L4FA2: sta L00BE
            cmp #$1C
            bne L4FAF
            lda #$80
            sta DATA6_L3988,X
            sta L00A0,X
L4FAF:      inc DATA6_L3988,X
            inc DATA6_L3988,X
            lda DATA6_L3A90,X
            sta L00B5
            lda DATA6_L3A96,X
            sta L00B6
            jsr SUB_L4DFA
L4FC2:      ldy #$00
L4FC4:      lda DATA6_L3988,Y
            beq L4FD2
            bmi L4FD2
            sty L00DC
            jsr L509E
            ldy L00DC
L4FD2:      iny
            cpy #$06
            bne L4FC4
L4FD7:      ldx #$05
L4FD9:      lda DATA6_L3988,X
            beq L4FE1
            jmp main3
L4FE1:      stx L00DC
            jsr L5139
            ldx L00DC
            ldy DATA6_L3A80,X
            inc DATA6_L3A80,X
            lda L3608,Y
            bne L4FF9
            dec DATA6_L3A96,X
            jmp L5044
L4FF9:      cmp #$02
            bne L5006
            inc DATA6_L3A90,X
            dec DATA6_L3A96,X
            jmp L5044
L5006:      cmp #$04
            bne L5010
            inc DATA6_L3A90,X
            jmp L5044
L5010:      cmp #$06
            bne L501D
            inc DATA6_L3A90,X
            inc DATA6_L3A96,X
            jmp L5044
L501D:      cmp #$08
            bne L5027
            inc DATA6_L3A96,X
            jmp L5044
L5027:      cmp #$0A
            bne L5034
            dec DATA6_L3A90,X
            inc DATA6_L3A96,X
            jmp L5044
L5034:      cmp #$0C
            bne L503E
            dec DATA6_L3A90,X
            jmp L5044
L503E:      dec DATA6_L3A90,X
            dec DATA6_L3A96,X
L5044:      sta L00BE
            lda DATA6_L3A90,X
            cmp #$FF
            bne L5050
            inc DATA6_L3A90,X
L5050:      cmp #$95
            bne L5057
            dec DATA6_L3A90,X
L5057:      lda DATA6_L3A96,X
            bne L505F
            jmp L5063
L505F:      cmp #$CA
            bne L508E
L5063:      lda DATA6_L3A90,X
            sta L00B5
            lda DATA6_L3A96,X
            sta L00B6
            lda #$1C
            sta L00BE
            stx L00DC
            jsr SUB_L4DFA
            ldx L00DC
            lda #$00
            sta L00BE
            lda RANDOM
            and #$93
            sta DATA6_L3A90,X
            lda RANDOM
            and #$3F
            adc #$0A
            sta DATA6_L3A96,X
L508E:      lda DATA6_L3A90,X
            sta L00B5
            lda DATA6_L3A96,X
            sta L00B6
            jsr SUB_L4DFA
            jmp main3
L509E:      ldx L00C9,Y
            bne L50AE
            ldx L5160,Y
            inx
            stx L00C9,Y
            lda DATA6_L3980,Y
            sta DATA6_L3A88,Y
L50AE:      txa
            cmp DATA6_L3A88,Y
            bne L50B5
            rts
L50B5:      lda DATA6_L3A96,Y
            cmp #$96
            bcc SKIP_L50C2
            lda #$80
            sta L00A0,Y
            rts
SKIP_L50C2: adc #$05
            sta L34E8,X
            stx L00B1
            txa
            cmp DATA6_L3A88,Y
            beq SKIP_L50D3
            tya
            tax
            inc L00C9,X
SKIP_L50D3: ldx L00B1

entry_L50D5:
            lda DATA6_L3A90,Y
            lsr
            lsr
            sta DATA192_L3488,X
            lda RANDOM
            bpl SKIP_L50E5
            inc DATA192_L3488,X
SKIP_L50E5: lda RANDOM
            and #$03
            tay
            lda RND_VALUES_L5158,Y
            sta L35A8,X
            lda RND_VALUES_L515C,Y
            sta L3548,X
            rts

.proc SUB_L50F8
            lda GRLINESL_L37E0,Y
            sta PTR_L00C7
            lda GRLINESH_L3708,Y
            sta PTR_L00C7+1
            ldy DATA192_L3488,X
            lda #$00
            sta DATA192_L3488,X
            sta L34E8,X
            sta L00C5			; C5 loop variable (for i=0; i<8; i++) {
l1:         lda (PTR_L00C7),Y
            and L3548,X
            sta (PTR_L00C7),Y		; *ptr &= L3548[x]

            lda PTR_L00C7
            clc
            adc #40
            sta PTR_L00C7
            bcc s1
            inc PTR_L00C7+1		; ptr+=40

s1:         inc L00C5
            lda L00C5
            cmp #$08
            bne l1			; } end for
            
            inx
            txa
            dex				; a=x+1
            ldy L00F0
            cmp DATA6_L3980,Y
            bne s2
            lda #128
            sta L00A0,Y
s2:         rts
.endp

.proc L5139
            lda RANDOM		; A=rnd 0..255
            bne L514F		; if (A==0) {
            txa
            tay
            ldx L5160,Y
            lda L34E8,X
            bne L514F
            lda DATA6_L3A96,Y
            cmp #$96
            bcc entry_L5150	; } endif
L514F:      rts
.endp

entry_L5150:
            adc #$0A
            sta L34E8,X
            jmp entry_L50D5
            
RND_VALUES_L5158:      .byte $01,$04,$10,$40
RND_VALUES_L515C:      .byte $FC,$F3,$CF,$3F
L5160:      .byte $00,$10,$20,$30,$40,$50,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00
VBLKDgame_L5178:
            lda dis_VBLKD_L5178
            beq SKIP_L517F
            jmp XITVBV
SKIP_L517F: lda L0090
            beq SKIP_L5186
            jmp L52ED
SKIP_L5186: inc L00DE
            lda L00DE
            cmp #$02
            bne L5198
            lda #$01
            sta L00DE
            jsr update_shipExhaust
            jmp L51BF
L5198:      ldx #$00
L519A:      lda #$00
            sta L00EE
            lda L00EB,X
            bne L51B7
            ldy L5A86,X
L51A5:      lda mis0+31,Y
            ora L5A82,X
            sta mis0+31,Y
            iny
            inc L00EE
            lda L00EE
            cmp #$09
            bne L51A5
L51B7:      inx
            cpx #$02
            bne L519A
            jsr update_shipExhaust
L51BF:      lda L00AF
            beq L51E5
            ldx #$00
L51C5:      inc L00AE
            inx
            cpx #$0A
            bne L51C5
            lda L00AE
            sta AUDF3
            cmp #$C8
            bne L51E5
            lda #$C0
            sta POKMSK
            lda #$00
            sta L00AF
            sta ATRACT
            sta AUDC3
            sta AUDF3
L51E5:      lda L0096
            beq L51F0
            lda L0097
            bne L51FB
            jmp L522D
L51F0:      ldx joyIndex
            lda STRIG0,X
            bne L5229
            lda L00A8
            bne L522D
L51FB:      lda #$01
            sta L00AF
            lda #$00
            sta L0097
            lda #$88
            sta AUDC3
            lda #$14
            sta L00AE
            ldx L00EF
            lda L00EB,X
            bne L5229
            lda #$01
            sta L00A8
            sta L00EB,X
            lda mis0x,X
            sta L00F2,X
            cpx #$00
            bne L522D
            sta L00ED
            lda mis2x
            sta L00F4
            jmp L522D
L5229:      lda #$00
            sta L00A8
L522D:      lda L00F6
            bne L5234
            jmp L52C3
L5234:      cmp #$02
            beq L523C
L5238:      lda #$00
            sta L00F6
L523C:      lda #$00
            sta L00F5
            
L5240:      lda update_highscore
            bne SKIP_L525A		; if (A6==0) {
            
            ldx #$00
L5246:      lda scrline1+12,X
            clc
            adc #192
            cmp scrline2+7,X		; compare score and highscore
            bne SKIP_L525A
            inx
            cpx #$06
            bne L5246
            
            lda #$01
            sta update_highscore			; if (score==highscore) A6=1
					; } endif (A6==0)

SKIP_L525A: ldx #$04			; i=4
					; while (true) {
LOOP_L525C: inc scrline2+7,X		; score[i]++
            cpx #$FF
            bne SKIP_L5267		
            lda #$01			; if (i<0) $8F=1
            sta L008F
SKIP_L5267: cpx #$01
            bne L528E			; if (i==0) { ; 100000 points
            lda L008F			; if (8F==1) break
            bne L528E
            lda #40
            sta L008A			; 8A=40
            lda #$AF
            sta varAUDF4
            sta AUDC4			; AUD4 C=$AF F=$AF
            sta L00A9			; A9 = $AF

            lda #$00
            sta AUDC1			; silence AUD1
            
            inc lifes
            lda lifes
            cmp #41
            bne SKIP_L528B
            dec lifes			; get one more live up to 40

SKIP_L528B: jsr show_lifes		; } endif (i==0)

L528E:      lda scrline2+7,X		;
            cmp #$DA			; ? score[i]==10
            bne L529E			; if (no_dec_overflow) break
            lda #$D0
            sta scrline2+7,X		; score[i]=0
            dex				; i--
            jmp LOOP_L525C		; }  end while
            
L529E:      inc L00F5
            lda L00F5
            cmp L009E
            bne L5240
            lda L00F6
            cmp #$02
            bne L52AF
            jmp L5238
            
L52AF:      lda update_highscore
            beq L52C3			; if ($A6) {
            
            ldx #$00
L52B5:      lda scrline2+7,X
            sec
            sbc #$C0
            sta scrline1+12,X
            inx
            cpx #$06
            bne L52B5			; copy score to highscore with different color
            				; } endif
L52C3:      inc L0098
            bne L52ED
            lda #$FF
            sta L0098
            
            ldx #$02
L52CD:      lda P0PF,X
            and #$01			; detect collision with first playfield color for pl2 and 3
            bne L52DC
            inx
            cpx #$04
            bne L52CD
            
            jmp L52ED
L52DC:      lda L0096			; if (collision) {
            beq L52E5
            lda RANDOM
            bne L52ED
L52E5:      lda #$01
            sta L0090
            lda #$00
            sta L00F8			; } endif (collision)

L52ED:      sta HITCLR			; clear collision detection
            lda L00A9
            bne SKIP_L5317
            ldx L00D4
            lda DATA48_L3990,X
            cmp #$00
            bne SKIP_L5303
            sta AUDC1
            jmp SKIP_L5308
SKIP_L5303: ldy #$A6
            sty AUDC1
SKIP_L5308: sta AUDF1
            inc L00D4
            lda L00D4
            cmp #$30
            bne SKIP_L5317
            lda #$00
            sta L00D4
SKIP_L5317: lda L008A
            beq SKIP_L5340
            dec L008A
            bne SKIP_L532A
            lda #$00
            sta AUDC4
            ldy L00F7
            beq SKIP_L532A
            sta L00A9
SKIP_L532A: and #$01
            bne SKIP_L5336
            lda #$00
            sta AUDF4
            jmp SKIP_L5340
SKIP_L5336: lda varAUDF4
            sec
            sbc #$08
            sta varAUDF4
            sta AUDF4
SKIP_L5340: lda L00E1
            beq SKIP_L5372
            bmi SKIP_L5355
            lda #$0F
            sta L00E2
            sta AUDC2
            lda #$80
            sta L00E1
            lda #$24
            sta L00E3
SKIP_L5355: ldx L00E3
            stx AUDF2
            inx
            stx L00E3
            cpx #$29
            bne SKIP_L5372
            lda #$24
            sta L00E3
            dec L00E2
            lda L00E2
            sta AUDC2
            cmp #$00
            bne SKIP_L5372
            sta L00E1
SKIP_L5372: jsr draw_stars
            jmp XITVBV

; draws 15 stars from first_star to last star
; does scrolling and generation of new stars
.proc draw_stars
            ldx firstStar			; for (i=C1; i<C2; i++) {
l1:         ldy star_lines,X		; Y = star_lines[i]		get star line number
            cpy #202
            bne s1			; if (star_lines[i] == 202) {  (out of screen)
            lda #$02
            sta star_lines,X		; Y = star_lines[i] = 2	     (new star at line 2)
            jsr new_rnd_star		; star with rnd column and pixeldata
            ldy #$02			; } endif

s1:         lda GRLINESL_L37E0,Y
            sta PTR_L00C3
            lda GRLINESH_L3708,Y
            sta PTR_L00C3+1		; ptr_c3 = grlines[y]

            lda star_values,X		; A=star_values[i]		data
            ldy star_columns,X		; Y=star_columns[i]		column
            sta (PTR_L00C3),Y		; ptr_c3[column]=data
            lda star_values,X		; A=star_values[i]		data //TODO useless repeat?
            sta (PTR_L00C3),Y		; ptr_c3[column]=data
            lda PTR_L00C3		
            sec
            sbc #80
            sta PTR_L00C3
            bcs s2
            dec PTR_L00C3+1		; ptr_c3 -= 80 ; 2 lines back

s2:         lda #$00
            sta (PTR_L00C3),Y		; ptr_c3[column]=0
            inc star_lines,X		; star_lines[i]++	; increment line number in array
            inx
            cpx lastStar
            bne l1			; } endfor
            
            cpx #60
            bne s3			; if (i==60) {
            sta firstStar			; c1=0
            lda #15
            sta lastStar			; c2=15
            rts				; } else {
s3:         lda lastStar
            clc
            adc #$0F
            sta lastStar			; c2+=15
            lda firstStar
            clc
            adc #$0F			; c1+=15
            sta firstStar			; }
            rts
.endp            

; parameter X- star number 0..59
; clear star column in line 200+201
; get new_star
.proc new_rnd_star
            dey
            dey				; y-=2; y=200
            lda GRLINESL_L37E0,Y
            sta PTR_L00C3
            lda GRLINESH_L3708,Y
            sta PTR_L00C3+1		; ptr_c3=grlines[200]
            lda #$00
            ldy star_columns,X		; y = 38FC[i] ; column
            sta (PTR_L00C3),Y		; ptr_c3[y]=0
            lda PTR_L00C3
            clc
            adc #40
            sta PTR_L00C3		; ptr_c3+=40 ; next line
            bcc s1
            inc PTR_L00C3+1
s1          lda #$00
            sta (PTR_L00C3),Y		; ptr_c3[y]=0
.endp					; fallthrough            

; takes parm x=0..59
; get star number x          
.proc get_star
            jsr get_starpixel		; //TODO inline
            ldy RANDOM
            lda star_column_values,Y		; read random value from 256byte table value = 0..39
            sta star_columns,X		; store value to star column table
            rts
.endp

; takes parm x=0..59
; get pixeldata for star x
.proc get_starpixel
l1:				; do {
            lda RANDOM
            and #$03		; a=rnd 0..3
            beq l1
            cmp #$03
            beq l1		; } while (a==0 or a==3)

            cmp #$02		; if (a==2) {
            bne s1
            lda RANDOM
            and #$03		; a=rnd 0..3
            tay			; y=a
            lda star_pixels_col3,Y		; 
            sta star_values,X		; star_values[x]=L5A7A[y]
            rts
            			; } endif
s1:         lda RANDOM
            and #$03		; a=rnd 0..3
            tay			; y=a
            lda star_pixels_col2,Y
            sta star_values,X		; star_values[X]=L5A7E[y]
            rts
.endp

.proc update_shipExhaust
            inc L00FF			; $FF++
            lda L00FF
            cmp #$04
            bne out			; if ($FF==4) { 	; every 5th call
            lda #$00
            sta L00FF			; $FF=0
            ldx L00FE			; X=$FE
            ldy pldata_idx,X		; Y=pldata_idx[X]
            inc L00FE			; $FE++
            lda L00FE
            cmp #$04
            bne s1
            lda #$00
            sta L00FE			; if ($FE==4) $FE=0
s1:         ldx #$00			; X=0;

l1:         lda Exhaust_pl0data_L5ACC,Y
            sta pl0+224,X
            lda Exhaust_pl1data_L5ACC,Y
            sta pl1+224,X
            iny
            inx
            cpx #10			; copy 10bytes of pldata from pldata[Y] to pl0 and pl1 
            bne l1			; } end if
out:        rts
.endp

; program entry
.proc main
            lda L00D2
            bne s1			; if (!initialized) {
            lda #15
            sta lastStar		;   lastStar=15	
s1:					; } endif
	    ldx #$00			; for(i=0; i<14; i++) {
l1:         lda highscore_str,X
            sta scrline1+2,X
            inx
            cpx #$14
            bne l1			; } endfor ; wite high string to screen
main_1:     lda #$03
            sta SKCTL			; enable kbd debounce+scanning, get POKEY out of two tone mode
            lda #$00
            sta L00F8
            sta L00FE			; playerdata index
            sta dis_VBLKD_L5178			; some variable inits
            sta COLOR4			; BAK color black
            sta AUDCTL			; silence
            lda #<DLIST_L6500
            sta SDLSTL
            lda #>DLIST_L6500
            sta SDLSTH			; enable custom display list

            jsr SUB_L625D		; initialize plpos + scrline1 pos

            lda #01
            sta L00A9
            sta L009E			; variable inits

            jsr SUB_L54F2		; some variable inits
            jsr SUB_L4CB8		; fill some tables
            jsr clr_grmem		; clear grmem and DATA_L3488
            jsr init_players_starfield		; init players and some random data
            
            ldx #>VBLKDgame_L5178
            ldy #<VBLKDgame_L5178
            lda #07
            jsr SETVBV			; enable VBLANK routine

            lda #00
            sta L0096			; init $96
            lda #02
            sta L009C			; init $9C
            jsr sel_players
            lda #09
            sta COLORIDX_L00CF
            jsr SUB_L6278
            jsr SUB_L4CB8
            jsr SUB_L54F2
            ldy #$00
            jsr switch_playerdata
            jsr init_score
            lda twopl2
            beq s2
            jsr sel_difficulty
s2:         jsr SUB_L54F2
            ldy #$0E
            jsr switch_playerdata
            
            ldx #$00
            stx L00A9
l2:         lda DATA20_L3AC0,X
            sta scrline1+2,X
            inx
            cpx #20
            bne l2
            
            lda #$00
            sta L0098
            jmp main2
.endp

; some variable inits
.proc SUB_L54F2
            lda #$06
            sta L00F7
            lda #$05
            sta lifes
            lda #$0A
            sta L00AA
            lda #$00
            sta update_highscore
            sta L009B
            sta L009D
            sta joyIndex
            sta COLORIDX_L00CF
            sta L008F
            rts
.endp
            
SUB_L550D:  ldy #$00
            lda L00F2,X
            sec
            sbc #$31
            sta L00DF
            lda L00E7,X
            clc
            adc #$0B
            sta L00E0
LOOP_L551D: lda DATA6_L3A90,Y
            cmp L00DF
            bcs SKIP_L555A
            clc
            adc #$0B
            cmp L00DF
            bcc SKIP_L555A
            lda DATA6_L3A96,Y
            cmp L00E0
            bcs SKIP_L555A
            clc
            adc #$16
            cmp L00E0
            bcc SKIP_L555A
            lda DATA6_L3988,Y
            bne OUT_L5561
            lda #$10
            sta DATA6_L3988,Y
            sta L00A0,Y
            sta L00E1
            dec L00F7
            bne SKIP_L554E
            sta L00A9
SKIP_L554E: ldx L00F0
            inc L00F6
            ldy L00E7,X
            jsr L5792
            ldx L00F0
            rts
SKIP_L555A: iny
            cpy #$06
            bne LOOP_L551D
            ldx L00F0
OUT_L5561:  rts

; resets score directly in screen ram
.proc init_score
            ldx #$00
            lda #"0"+3*64	; 0 in color3
l1:         sta scrline2+7,X
            inx
            cpx #$06
            bne l1
            rts
.endp            
            
.proc init_players_starfield
            jsr init_score
            ldy #$00
            tya
l1:         sta pl3,Y
            iny
            bne l1		; clear 256 bytes at pl3

            lda #62		; DMAMODE normal playfield, pl and miss enable, single line player resolution, fetch DMA
            sta SDMCTL
            
            lda #50		; 3 color player, combine missiles, pl01-pf-pl23-bak
            sta GPRIOR
            
            lda #$03            
            sta GRACTL		; turn on pl and missiles

            lda #>pmdata
            sta PMBASE		; set PMBASE
            
            ldy #$04
l2:         lda COLOR8BYTES_L5B08,Y	; for (i=4; i<8;i++)
            sta COLOR0-4,Y		; color[i]=COLORBYTES[i]
            iny
            cpy #$08
            bne l2			; endfor l2

            jsr init_players		; init player data
            
            lda L00D2			
            bne OUT			; if (!D2) {
            ldy #$00
            ldx #$00			; a=2; x=0
;
; distribute 60 stars evenly on grlines
            lda #$02			; for (i=0; i<60; i++)
l3:         sta star_lines,Y		; star_lines[i]=a
            clc
            adc #$03			; a+=3
            inx				; x++
            cpx #10			; if (x==10) a+=3; x=0
            bne else1
            clc
            adc #$03
            ldx #$00
else1:      iny				; endif
            cpy #60
            bne l3			; endfor l3
					; star_lines = [2,5,8,11,14,17,20,23,26,!32!,35,38,41,44,47,50,53,56,59,!65!...]
            
            ldx #$00			; for(i=0; i<60; i++) 
l4:         lda RANDOM
            and #$03			; a=rnd 0..3
            sta L00A7			; A7=a
            lda star_lines,X		
            clc
            adc L00A7
            sta star_lines,X		; star_lines[i]+=rnd 0..3; modify lines with random offset
            jsr get_star		; get star with rnd column and pixeldata
            inx
            cpx #60
            bne l4			; endfor l4
            
OUT:        rts				; endif
.endp

.proc main2
            jsr SUB_L55E9
            lda #$06
            sta L00F7
            jsr SUB_L6468
            ldx #$00
            txs
            jmp main3
.endp            
            
.proc SUB_L55E9
            ldx #$00
l1:         lda #$4A
            sta DATA6_L3A90,X
            lda #$36
            sta DATA6_L3A96,X
            lda DATA5BYTES_L5E75,X
            sta DATA6_L3A88,X
            inx
            cpx #06
            bne l1
            rts
.endp            
            
SUB_L5601:  lda L0090
            beq SKIP_L5608
            jmp L57D8
SKIP_L5608: lda L0096
            beq SKIP_L5612
            jsr SUB_L5A1A
            jmp L5635
SKIP_L5612: ldx joyIndex
            lda STICK0,X
            cmp #$05
            beq L561F
            cmp #$07
            bne L5623
L561F:      lda #$07
            sta L00FD
L5623:      cmp #$09
            beq L562B
            cmp #$0B
            bne L562F
L562B:      lda #$0B
            sta L00FD
L562F:      cmp #$0F
            bne L5635
            sta L00FD
L5635:      lda L00FC
            cmp #200
            beq SKIP_L564E
            lda L00FD
            cmp #$07
            bne SKIP_L564E
            ldx #$00
LOOP_L5643: inc mis0x,X
            inc pl0x,X
            inx
            cpx #$03
            bne LOOP_L5643
            inc L00FC
SKIP_L564E: lda pl2x
            cmp #$30
            beq L5667
            lda L00FD
            cmp #$0B
            bne L5667
            ldx #$00
LOOP_L565C: dec mis0x,X
            dec pl0x,X
            inx
            cpx #$03
            bne LOOP_L565C
            dec L00FC
L5667:      ldx #$00
L5669:      lda L00EB,X
            bne L5674
            lda mis0x,X
            sta HPOSM0,X
            sta L00F2,X
L5674:      inx
            cpx #$03
            bne L5669
            ldx #$00
L567B:      lda pl0x,X
            sta HPOSP0,X
            inx
            cpx #$04
            bne L567B
            lda L00F7
            bne L56B0
            lda #$01
            sta L00A9
            lda #$00
            sta AUDC1
            sta L00D4
            inc L00F8
            bne L56B0
            dec L00AA
            bne L56A9
            ldx #$00
            txs
            lda #$0A
            sta L00AA
            jsr SUB_L6278
            jsr warptoNextLevel
L56A9:      lda #$00
            sta L00A9
            jmp main2
L56B0:      inc L00F1
            lda L00F1
            cmp #$02
            bne L5732
            lda #$00
            sta L00F1
            lda CONSOL
            cmp #$05
            bne L56D1
            jsr clr_grmem
            jsr L6240
            lda #$00
            sta AUDC1
            jmp main.main_1
L56D1:      cmp #$06
            bne L56FE
            jsr clr_grmem
            jmp L61DB

.proc clr_grmem				; clear 8192 bytes grmem
            lda #<grscreen
            sta PTR_L00BA
            lda #>grscreen
            sta PTR_L00BA+1
            ldx #$00
l1:         ldy #$00			; for (i=0; i<32; i++)
            tya
l11:        sta (PTR_L00BA),Y		; for (j=0; j<255; j++)
            iny				; grmem[j]=0
            bne l11			; endfor l11
            inc PTR_L00BA+1		; grmem+=256
            inx
            cpx #32
            bne l1			; endfor l1
            tay
l2:         sta DATA192_L3488,Y			; clear 192bytes at L3488
            iny
            cpy #192
            bne l2
            rts
.endp            
            
L56FE:      ldx #$00
L5700:      stx L00F0
            jsr SUB_L550D
            inx
            cpx #$03
            bne L5700
            lda CH			; get last key pressed
            cmp #$21
            bne L5732			; if (SPACE) {
            sta dis_VBLKD_L5178			; disable VBLKD_L5178
            ldx #$00
            txa
L5716:      sta AUDF1,X
            inx
            cpx #$08
            bne L5716
            lda #$80
            sta ATRACT
L5722:      ldx joyIndex
            lda STRIG0,X
            bne L5722
            sta ATRACT
            sta dis_VBLKD_L5178
            lda #$FF
            sta CH			; reset last key pressed
L5732:      ldx #$00			; } endif (SPACE)
L5734:      lda L00EB,X
            bne L5740
            inx
            cpx #$02
            bne L5734
            jmp L5791
L5740:      lda L00E7,X
            sec
            sbc #$05
            sta L00E7,X
            tay
            cpx #$00
            bne L574E
            sty L00E9
L574E:      cpy #$F8
            bcs L5792
            ldy L00E7,X
            cpy #$70
            bcs L575E
            lda L00EF
            eor #$01
            sta L00EF
L575E:      lda #$00
            sta L00DD
L5762:      lda mis0+31,Y
            ora L5A82,X
            sta mis0+31,Y
            iny
            inc L00DD
            lda L00DD
            cmp #$05
            bne L5762
            lda L00E7,X
            clc
            adc #$09
            tay
            lda #$05
            sta L00DD
L577E:      lda mis0+31,Y
            and L5A84,X
            sta mis0+31,Y
            iny
            dec L00DD
            bne L577E
            inx
            cpx #$02
            bne L5734
L5791:      rts
L5792:      lda #$0E
            sta L00DD
L5796:      lda #$00
            sta mis0+31,Y
            iny
            dec L00DD
            bne L5796
            cpx #$01
            beq L57C1
            lda L5A86
            sta L00E7
            lda L5A88
            sta L00E9
            lda mis0x
            sta HPOSM0
            lda mis2x
            sta HPOSM2
            lda #$00
            sta L00EB
            sta L00ED
            jmp L57CF
L57C1:      lda L5A87
            sta L00E8
            lda mis1x
            sta HPOSM1
            lda #$00
            sta L00EC
L57CF:      lda #$01
            sta L00EF
            lda #$00
            sta L00DE
            rts
L57D8:      inc L00F8
            lda L00F8
            cmp #$26
            beq L5808
            jsr L5732
            lda #$00
            sta RTCLOK+2
            sta AUDC3
            sta L00FE
            sta L00FF
            lda #$01
            sta L00DE
            ldx #$00
            lda #$34
L57F6:      sta PCOLR0,X
            inx
            cpx #$04
            bne L57F6
            lda #$A8
            sta AUDC2
            lda #$0A
            sta L00AE
            rts
L5808:      lda #$25
            sta L00F8
            lda RTCLOK+2
            cmp #$02
            beq L5813
            rts
L5813:      lda #$00
            sta RTCLOK+2
            inc L00DE
            lda L00DE
            cmp #$0D
            beq L5833
            ldx #$00
L5821:      inc PCOLR0,X
            inx
            cpx #$04
            bne L5821
            lda L00AE
            sta AUDF2
            lda #$01
            sta L00E1
            rts
L5833:      lda #$0C
            sta L00DE
            lda RANDOM
            ldx #$00
LOOP_L583C: sta PCOLR0,X
            inx
            cpx #$03
            bne LOOP_L583C
            inc L00FF
            lda L00FF
            cmp #$03
            beq L584F
            jmp OUT_L58CE
L584F:      lda #$00
            sta L00FF
            lda pl2x
            sec
            sbc #$04
            sta HPOSP2
            lda pl0x
            clc
            adc #$08
            sta HPOSP0
            jsr clear_player
            ldx L00FE				; x = 2 * index of playerdata
            ldy TABLE_OFFSETS_L5B10,X		; y = start offset of playerdata in table
            lda TABLE_OFFSETS_L5B10+1,X
            sta L00B9				; b9 = end offset of playerdata in table
            lda L5B22,X
            tax
            inc L00FE
            inc L00FE
            lda L00FE
            cmp #$12
            beq SKIP_L5897
LOOP_L587E: lda L5B34,Y
            sta pl0+198,X
            lda L5BA0,Y
            sta pl1+198,X
            lda L5C0C,Y
            sta pl2+198,X
            inx
            iny
            cpy L00B9
            bne LOOP_L587E
            rts
SKIP_L5897: inc hits
            lda hits
            cmp #20
            beq dead
            lda #$10
            sta L00FE
            lda #$00
            sta AUDC2
            jmp OUT_L58CE
            
dead:       lda #$00
            sta L00FF
            sta hits
            sta L00FE
            sta L0098
            dec lifes			; lost 1 life
            jsr L5F57
            lda lifes			; if (lifes=0) {
            bne L58CB
            jsr SUB_L60FA
            lda #$01
            sta L00A9
            jsr L5FEE
            jmp L6191			; } endif

L58CB:      jsr init_players

OUT_L58CE:  rts

; centers ship
; warps forward
; changes colors
.proc warptoNextLevel
            lda #$00
            sta L00B1			; loop variable
l1:         lda #$01			; for (B1=0; B1<38; B1++) {
            sta L00A8			; A8=1
            jsr L5732			; //TODO
            
            ldx #$00
waitloop:   nop
            nop
            nop
            nop
            nop
            nop
            inx
            cpx #$00
            bne waitloop		; wait 256* (6*nop+inx+bne) cycles
            
            inc L00B1
            lda L00B1
            cmp #38
            bne l1			; } endfor

            jsr SUB_L4CB8
            lda L00FC
            cmp #129
            beq L5969
            bcs s5
					; while (FC < 129) {		
l2:         ldx #$00
					; for (x=0; x<3; x++)
l3:         inc mis0x,X			; 
            inc pl0x,X			; 
            inx
            cpx #$03
            bne l3			; endfor 		set players and missiles right one position
            
            inc L00FC
            jsr updatePMxPositions
            lda L00FC
            cmp #129
            bne l2			; end while
            
            beq L5969
s5:            
l5:         ldx #$00			; while (FC > 129) {
l4:         dec mis0x,X
            dec pl0x,X
            inx
            cpx #$03
            bne l4			; endfor 		set players and missiles left one position
            
            dec L00FC
            jsr updatePMxPositions
            lda L00FC
            cmp #129
            bne l5			; } endwhile
            beq L5969
            
.proc updatePMxPositions
            ldx #$00
l1:         lda pl0x,X
            sta HPOSP0,X
            inx
            cpx #$04
            bne l1		; update player positions

            ldx #$00
l2:         lda mis0x,X
            sta HPOSM0,X
            inx
            cpx #$03
            bne l2		; update missile positions

            lda #$00
            sta RTCLOK+2
l3:         lda #$01
            sta L00A8
            lda RTCLOK+2
            cmp #$02
            bne l3		; wait 2 frames

            lda ZPVAR_L00B3
            bne s1
            lda #$0A
            sta AUDF3
            sta ZPVAR_L00B3
            lda #$A8
            sta AUDC3		; if (B3==0) play AUD3
            rts
           
s1          lda #$00		; else silence AUD3
            sta AUDF3
            sta ZPVAR_L00B3
            rts
.endp
         			; if (FC==129) {   
L5969:      lda #$82			
            sta L00E2
            lda #$FF
            sta L00AE
            lda #$00
            sta L00B1
            sta ZPVAR_L00B2
            ldx #>VBLKDshort_L649E
            ldy #<VBLKDshort_L649E
            lda #$07
            jsr SETVBV			; set VBLANK Routine
            ldy COLORIDX_L00CF
            lda COLORTBL_L5A5C,Y
            sta COLOR0
            ldy #$FF
            sty L00AB
            
L598C:      ldx #$00
L598E:      inx
            cpx #$08
            bne L598E
            dey
            bne L598C			; waitloop

            jsr draw_stars
            jsr draw_stars
            jsr draw_stars
            jsr draw_stars
            jsr update_shipExhaust
            dec L00AB
            ldy L00AB
            bne L598C			; next move cycle with shorter waitloop

            ldy COLORIDX_L00CF
            lda COLORTBL_L5A66,Y
            sta COLOR1
            
            ldy #$00
L59B5:      sty L00AB
            ldx #$00
L59B9:      stx L00F0
            jsr draw_stars
            jsr draw_stars
            jsr draw_stars
            jsr update_shipExhaust
            ldx L00F0
            inx
            cpx #$00
            bne L59B9
            ldy L00AB
            iny
            cpy #$02
            bne L59B5			; some more ship move forward cycles
            
            ldy COLORIDX_L00CF
            lda COLORTBL_L5A70,Y
            sta COLOR2
            
            ldy #$01
            sty L00AB
L59E1:      ldx #$00
L59E3:      inx
            cpx #$12
            bne L59E3
            dey
            bne L59E1			; waitloop
            
            jsr draw_stars
            jsr draw_stars
            jsr draw_stars
            jsr draw_stars
            jsr draw_stars
            jsr draw_stars
            jsr update_shipExhaust
            inc L00AB
            ldy L00AB
            cpy #$E0
            bne L59E1			; some more ship move forward cycles

            ldx #>VBLKDgame_L5178
            ldy #<VBLKDgame_L5178
            lda #$07
            jsr SETVBV			; set VBLANK Routine
            lda #$00
            sta AUDC3
            sta AUDF3			; silence AUD3
            rts				; } endif
.endp            
            
SUB_L5A1A:  lda RANDOM
            and #$3F
            bne SKIP_L5A38
            lda RANDOM
            bmi SKIP_L5A2B
            lda #$07
            jmp SKIP_L5A2D
SKIP_L5A2B: lda #$0B
SKIP_L5A2D: sta L00FD
            lda RANDOM
            cmp #$0F
            bne SKIP_L5A38
            sta L00FD
SKIP_L5A38: lda L00F7
            beq SKIP_L5A47
            lda RANDOM
            and #$0F
            cmp #$01
            bne SKIP_L5A47
            sta L0097
SKIP_L5A47: lda L00FC
            cmp #200
            bne SKIP_L5A51
            lda #$0B
            sta L00FD
SKIP_L5A51: lda pl2x
            cmp #$30
            bne SKIP_L5A5B
            lda #$07
            sta L00FD
SKIP_L5A5B: rts

COLORTBL_L5A5C:
            .byte $0E,$DA,$0C,$76,$EC,$7C,$5C,$18
            .byte $DE,$36
COLORTBL_L5A66:
            .byte $36,$7C,$16,$C8,$26,$F8,$88,$CE
            .byte $8E,$DE
COLORTBL_L5A70:
            .byte $B8,$48,$78,$EE,$78,$BC,$36,$0C
            .byte $3A,$88
            
star_pixels_col3:      .byte $03,$0C,$30,$C0		; green star pixels
star_pixels_col2:      .byte $02,$08,$20,$80		; red star pixels

L5A82:      .byte $11,$04
L5A84:      .byte $04,$11
L5A86:      .byte $B7
L5A87:      .byte $AF
L5A88:      .byte $B7

TABLEinit_misx:      .byte $87,$7F,$77		; initial xpos for mis0..mis2
TABLEinit_plx:      .byte $7C,$7C,$78,$81		; initial xpos for pl0..pl3

pl0bitmap:      .byte $00,$00,$00,$14,$14,$14,$14,$36
            .byte $36,$63,$00,$00,$00,$00		; 14 byte bitmap for pl0
pl1bitmap:      .byte $00,$00,$08,$08,$08,$00,$00,$08
            .byte $08,$08,$08,$14,$63,$00		; 14 byte bitmap for pl1
pl2bitmap:      .byte $00,$00,$00,$01,$01,$01,$01,$03
            .byte $03,$06,$08,$99,$B6,$E0		; 14 byte bitmap for pl2
pl3bitmap:      .byte $00,$00,$00,$80,$80,$80,$80,$C0
            .byte $C0,$60,$10,$99,$6D,$07		; 14 byte bitmap for pl3

pldata_idx:      .byte 00,10,20,10				; index to plxdata
Exhaust_pl0data_L5ACC:      .byte $08,$00,$10,$04,$10,$00,$00,$00	; 3 * 10 byte pl0data
            .byte $00,$00,$08,$00,$04,$10,$04,$20
            .byte $02,$00,$00,$00,$00,$00,$08,$1C
            .byte $12,$08,$36,$08,$10,$49
Exhaust_pl1data_L5ACC:      .byte $00,$08,$00,$08,$04,$00,$00,$00	; 3 * 10 byte pl1data
            .byte $00,$00,$00,$10,$08,$00,$10,$08
            .byte $14,$00,$00,$00,$00,$08,$00,$00
            .byte $20,$14,$08,$36,$45,$22
COLOR8BYTES_L5B08:
            .byte $34,$76,$0C,$0C,$0E,$36,$B8,$C8	; 4 player colors followed by 4 playfield colors

TABLE_OFFSETS_L5B10:					; pairs of start end offset in TABLE_L5B34      
            .byte $00
            .byte $0D,$0D,$1F,$1F,$36,$36,$50,$50
            .byte $6C,$36,$50,$1F,$36,$0D,$1F,$00
            .byte $0D

L5B22:      .byte $0B,$00,$09,$00,$05,$00,$03,$00
            .byte $02,$00,$03,$00,$05,$00,$09,$00
            .byte $0B,$00
L5B34:      .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $40,$80,$00,$00,$00,$00,$00,$00
            .byte $00,$40,$80,$00,$80,$40,$40,$00
            .byte $00,$00,$40,$80,$80,$00,$00,$00
            .byte $00,$60,$80,$80,$00,$00,$00,$40
            .byte $80,$00,$80,$C0,$20,$20,$20,$20
            .byte $40,$80,$80,$A0,$40,$40,$80,$06
            .byte $04,$08,$30,$48,$48,$84,$80,$80
            .byte $00,$08,$10,$A0,$C0,$20,$30,$18
            .byte $00,$30,$20,$40,$80,$90,$B0,$40
            .byte $41,$A2,$06,$04,$88,$30,$48,$48
            .byte $A4,$92,$83,$40,$28,$14,$A6,$C0
            .byte $20,$30,$58,$00
L5BA0:      .byte $10,$50,$48,$25,$39,$4E,$18,$2C
            .byte $2A,$48,$94,$02,$02,$02,$84,$D4
            .byte $52,$4A,$25,$39,$CE,$18,$2C,$2A
            .byte $48,$D4,$92,$83,$01,$00,$00,$01
            .byte $02,$42,$24,$28,$9C,$C5,$4A,$32
            .byte $24,$38,$D4,$92,$97,$69,$29,$4A
            .byte $D4,$93,$89,$08,$04,$04,$00,$80
            .byte $40,$40,$20,$12,$14,$8E,$CA,$51
            .byte $21,$22,$3C,$D2,$11,$93,$AC,$68
            .byte $49,$55,$93,$A9,$A8,$04,$04,$02
            .byte $00,$80,$90,$60,$44,$22,$12,$14
            .byte $8E,$CA,$55,$21,$22,$3C,$D2,$11
            .byte $93,$AC,$68,$49,$55,$93,$A9,$A8
            .byte $24,$14,$12,$01
L5C0C:      .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$06,$03,$00,$00,$0C,$04
            .byte $02,$01,$02,$04,$00,$00,$00,$00
            .byte $00,$00,$02,$02,$01,$10,$08,$08
            .byte $06,$03,$00,$00,$0C,$04,$02,$01
            .byte $02,$04,$00,$01,$02,$00,$00,$00
            .byte $00,$00,$00,$06,$82,$61,$30,$08
            .byte $08,$06,$03,$01,$61,$30,$0C,$04
            .byte $02,$01,$02,$0C,$08,$01,$02,$02
            .byte $02,$01,$00,$00,$00,$02,$00,$02
            .byte $06,$82,$61,$30,$08,$08,$16,$23
            .byte $01,$61,$30,$0C,$04,$02,$01,$02
            .byte $0C,$18,$21,$02,$02,$04
            
GRDATA10x7_L5C7A:     					; 70 byte graphics data (10x7) (40x7 px)
            .byte $15,$04,$10,$11,$50,$00,$50,$44
            .byte $54,$54,$40,$04,$14,$51,$00,$01
            .byte $04,$44,$40,$41,$40,$15,$11,$11
            .byte $00,$01,$04,$44,$40,$41,$44,$11
            .byte $10,$11,$40,$01,$04,$44,$50,$41
            .byte $41,$15,$10,$11,$00,$01,$04,$44
            .byte $40,$54,$41,$11,$10,$11,$00,$01
            .byte $04,$10,$40,$44,$15,$11,$10,$11
            .byte $50,$00,$50,$10,$54,$41
            
GRDATA6x7_L5CC0:					; 42 byte graphics data (6x7) (24x7 px)
            .byte $50,$80,$30,$44,$A8,$FC,$44,$80
            .byte $30,$44,$80,$C3,$44,$80,$FC,$54
            .byte $80,$C3,$50,$80,$CC,$10,$A0,$C3
            .byte $40,$80,$FC,$10,$80,$FC,$40,$80
            .byte $CC,$10,$80,$CC,$40,$A8,$CC,$10
            .byte $A8,$C3
            
GRDATA2x7_L5CEA:					; 14 byte graphics data 2x(1x7) 2x(4x7 px)
            .byte $04,$14,$04,$04,$04,$04,$15,$14
            .byte $41,$01,$01,$04,$10,$55
            
highscore_str:
            .byte "    HIGH  000000    "
twopl_str:
            .byte "TWO PLAYERS?    "
OPTIONSTRINGS:            
NOSTR_L5D1C:
            .byte "NO  "
YESSTR_L5D20:
            .byte "YES "
DEMOSTR_L5D24:
            .byte "DEMO"            
DIFSTR_L5D28:
            .byte "SELECT DIFFICULTY  1"
                        
STR_L5D3C:  .byte "ENGLISH SOFTWARE CO."
            .byte " PRESENTSHYPERB"
            .byte "LAST!BY JOHN BR"
            .byte "IERLEY   COPYRIGHT ("
            .byte "C.) 1983 J.P. BRIERL"
            .byte "EY ALL RIGHTS RESERV"
            .byte "ED"

DATA_L5DBB: .byte $48,$00,$48,$00,$48,$00,$48,$00
            .byte $51,$00,$5B,$00,$5B,$00,$60,$00
            .byte $6C,$00,$6C,$00,$5B,$00,$48,$00
            .byte $35,$00,$35,$00,$35,$00,$35,$00
            .byte $3C,$00,$44,$00,$44,$00,$48,$00
            .byte $51,$00,$51,$00,$48,$00,$44,$00
            .byte $48,$00,$44,$00,$48,$00,$39,$00
            .byte $44,$00,$48,$00,$48,$00,$51,$00
            .byte $5B,$00,$5B,$00,$60,$00,$6C,$00
            .byte $60,$00,$60,$00,$60,$00,$60,$00
            .byte $5B,$00,$60,$00,$6C,$00,$5B,$00
            .byte $48,$00,$35,$00,$00
DATA_L5E18: .byte $13,$02,$13,$02,$13,$02,$13,$02
            .byte $12,$02,$12,$02,$12,$02,$12,$02
            .byte $12,$02,$12,$02,$12,$02,$12,$02
            .byte $12,$02,$12,$02,$12,$02,$12,$02
            .byte $12,$02,$12,$02,$12,$02,$12,$02
            .byte $12,$02,$12,$02,$12,$02,$12,$02
            .byte $12,$02,$12,$02,$12,$02,$12,$02
            .byte $12,$02,$12,$02,$12,$02,$12,$02
            .byte $12,$02,$12,$02,$12,$02,$12,$02
            .byte $12,$02,$12,$02,$12,$02,$12,$02
            .byte $12,$02,$12,$02,$12,$02,$12,$02
            .byte $12,$02,$1B,$00,$04
DATA5BYTES_L5E75:
            .byte $01,$11,$21,$31,$41,$51
L5E7B:      .byte $06,$07,$08,$09,$0A,$0B,$0C,$0D
            .byte $0E,$0F,$10
DATA_L5E86: .byte $37,$32,$2D,$28,$19,$14,$0F,$08
            .byte $03,$01,$01
DATA_L5E91: .byte $0F,$0A,$05,$01

//TODO
.proc sel_players
            ldx #$00
            stx AUDF1			; silence chanel 1
            stx L00B1			; B1=0

l1:         lda scrline1+2,X
            sta DATA20_L3AC0,X
            lda twopl_str,X
            sta scrline1+2,X
            inx
            cpx #20
            bne l1			; save scrline1 and write twopl_str
            
            lda #$07
            sta ZPVAR_L00B3		; $B3=7

					; do {
l3:         jsr wait14frames
            lda STICK0			; read joystick
            cmp #07			; if (east) {
            bne s2
            inc L00B1
            inc L00B1
            inc L00B1
            inc L00B1			; B1+=4
            lda L00B1
            cmp #12			; if ($B1==12) $B1=0
            bne s1
            lda #$00
            sta L00B1			
            				; } endif (east)
s1:         tay				; y=B1 (one of 0,4,8)
            ldx #$00
l2:         lda OPTIONSTRINGS,Y		
            sta scrline1+18,X
            iny
            inx
            cpx #$04
            bne l2			; write option string (no/yes/demo) to screen
            
s2:         lda STRIG0
            bne l3			; enddo } until (trigger pressed)

            lda scrline1+18
            cmp #"D"			; if (scrline1[18] != "D") {
            beq s3
            cmp #"N"		
            bne s4
            lda #$00			; scrline1[18] == N { , "NO" single player
            sta twopl2	
            sta twopl1			; $99 = $8D = 0
            jmp sel_difficulty		; } continue at entry2
s3:         lda #$00			; } else scrline1[18] == "D" { , DEMO mode
            sta twopl2
            sta twopl1			; $99 = $8D = 0	
            lda #$01
            sta L0096			; $96 = 1
            rts
s4:         lda #$01			; scrline1[18] != "D" && != "N" { ("YES")
            sta twopl2			
            sta twopl1			; $99 = $8D = 1 ,two players continue at entry2
					; }
.endp					; fallthrough

.proc sel_difficulty 
            ldx #$00
l4:         lda DIFSTR_L5D28,X
            sta scrline1+2,X
            inx
            cpx #20
            bne l4			; write string to scrline1
            
            lda twopl2
            beq s5
            jsr SUB_L5F41		; if (twopl2) jsr //TODO
s5:
l5:         
            jsr wait14frames

            lda STICK0			; do {
            cmp #$07
            bne s6			; if (stick0==east) {
            inc scrline1+21			; scrline1[21]++
            lda scrline1+21
            cmp #"4"
            bne s6			; if (scrline1[21]=="4") scrline1[21]="1"
            lda #"1"
            sta scrline1+21		; } endif 

s6:         lda STRIG0			
            bne l5			; } enddo until trigger pressed

            lda scrline1+21
            sec
            sbc #$10
            sta L009C			; $9C = difficulty (1..3)
            rts
.endp

.proc SUB_L5F41
            lda ZPVAR_L00B3
            cmp #$00
            bne s1
            lda #$07
            sta ZPVAR_L00B3		; if (B3==0) B3=7
            jsr SUB_L6011		; //TODO
            rts
       
s1:         lda #$00
            sta ZPVAR_L00B3		; else B3=0
            jsr SUB_L6011		; //TODO
            rts
.endp
            
L5F57:      lda twopl2
            bne L5F5E
            jmp L5FE9
L5F5E:      jsr SUB_L60FA
            lda #$01
            sta L00A9
            lda #$00
            sta AUDC1
            lda lifes
            bne L5F79
            jsr L5FEE
            lda twopl2
            sta twopl1
            lda #$00
            sta twopl2
L5F79:      ldy L009D
            beq L5F8F
            lda #$00
            sta L009D
            sta joyIndex
            sta ZPVAR_L00B3
            jsr switch_playerdata
            jsr SUB_L6011
            jmp L5FA1
            rts
L5F8F:      lda #$0E
            sta L009D
            lda #$01
            sta joyIndex
            lda #$07
            sta ZPVAR_L00B3
            jsr switch_playerdata
            jsr SUB_L6011
L5FA1:      lda #$00
            sta update_highscore
            lda #$01
            sta L009E
            lda L009B
            beq L5FB6
            sta L00B1
LOOP_L5FAF: jsr SUB_L63D2
            dec L00B1
            bne LOOP_L5FAF
L5FB6:      lda COLORIDX_L00CF
            sta L00B1
            lda #$09
            sta COLORIDX_L00CF
L5FBE:      jsr SUB_L6278
            lda L00B1
            beq L5FCA
            dec L00B1
            jmp L5FBE
L5FCA:      dec L009B
            jsr SUB_L6468
            jsr SUB_L55E9
            jsr SUB_L4CB8
            ldx COLORIDX_L00CF
            lda COLORTBL_L5A5C,X
            sta COLOR0
            lda COLORTBL_L5A66,X
            sta COLOR1
            lda COLORTBL_L5A70,X
            sta COLOR2
L5FE9:      lda #$00
            sta L00A9
            rts
            
.proc L5FEE
            lda L009D
            beq s1
            lda #$07
            sta ZPVAR_L00B3
            jsr L602A
            lda playerdata_L3AA4
            bne out
            jmp L6191
s1:         lda #$00
            sta ZPVAR_L00B3
            jsr L602A
            lda playerdata_L3AA4+7
            bne out
            jmp L6191
out:      rts
.endp

.proc SUB_L6011
            lda #$00
            sta RTCLOK+2
l1:         lda #$01
            sta L00A8			; $A8=1
            lda ZPVAR_L00B3
            sta L00DC			; $DC = $B3
            jsr SUB_L6070		; //TODO
            lda RTCLOK+2
            cmp #$64			; wait 64frames
            bne l1
            jsr clearGrscreenArea
            rts
.endp

.proc L602A
            lda #$00
            sta RTCLOK+2
l1:         lda #$01
            sta L00A8
            jsr L6049
            lda ZPVAR_L00B3
            sta L00DC
            jsr SUB_L6070
            lda RTCLOK+2
            cmp #$64			; 64 frames
            bne l1
            
            jsr clearGrscreenArea2
            jsr clearGrscreenArea
            rts
.endp            

.proc L6049
            lda #$07
            sta L00B1
            lda #<(grscreen+62*40+15)
            sta PTR_L00BA
            lda #>(grscreen+62*40+15)
            sta PTR_L00BA+1
            ldx #$00
l1:         lda #10
            sta ZPVAR_L00B2
            ldy #$00
l2:         lda GRDATA10x7_L5C7A,X
            sta (PTR_L00BA),Y
            iny
            inx
            dec ZPVAR_L00B2
            bne l2
            jsr BAptr_nextLine
            dec L00B1
            bne l1
            rts
.endp
            
//TODO            
.proc SUB_L6070
            lda #$07
            sta L00B1			; $B1=7
            lda #$00			
            pha				; push 0
            lda #<(grscreen+(74*40)+16)
            sta PTR_L00BA
            lda #>(grscreen+(74*40)+16)
            sta PTR_L00BA+1		; ptr_BA = L1BD8
l1:         lda #$06			; for (i=7; i>0; i--) {
            sta ZPVAR_L00B2		; $B2 = 6
            pla				; pop a
            tax				; x=a

            ldy #$00			; for (j=6; j>0; j--) {
l12:        lda GRDATA6x7_L5CC0,X
            sta (PTR_L00BA),Y		; ptr_BA[y] = L5CC0[x] , write sth to grscreen
            iny		
            inx				; x++;y++
            dec ZPVAR_L00B2
            bne l12			; endfor l12			write 6 bytes to screen
            
            txa				; a=x
            pha				; push a
            iny				; y++
            ldx L00DC			; x=$DC
            lda GRDATA2x7_L5CEA,X
            sta (PTR_L00BA),Y		; ptr_BA[y] = L5CEA[x] , write sth to grscreen
            jsr BAptr_nextLine
            inc L00DC			; $DC++
            dec L00B1			; $B1--
            bne l1			; } endfor l1
            pla				; pop a
            rts
.endp

; clear 10 bytes in 7 screenlines
.proc clearGrscreenArea2
            lda #<(grscreen+62*40+15)
            sta PTR_L00BA
            lda #>(grscreen+62*40+15)
            sta PTR_L00BA+1
            
            ldx #$07
l1:         ldy #$00

            tya
l2:         sta (PTR_L00BA),Y
            iny
            cpy #$0A
            bne l2
            
            jsr BAptr_nextLine
            dex
            bne l1
            
            rts
.endp            

; clear 8 bytes in 7 screenlines (line 74-81 byte 16-24)	
.proc clearGrscreenArea
            lda #<(grscreen+74*40+16)
            sta PTR_L00BA
            lda #>(grscreen+74*40+16)
            sta PTR_L00BA+1		; ptr_BA=L1BD8
            ldx #$07
l1:         ldy #$00			; l1 7x
            tya
            
l2:         sta (PTR_L00BA),Y		; clear 8bytes
            iny
            cpy #$08
            bne l2
            
            jsr BAptr_nextLine		; next line
            dex
            bne l1			; end l1 7x

            rts
.endp            
            
.proc BAptr_nextLine
            lda PTR_L00BA	
            clc
            adc #40
            sta PTR_L00BA
            lda PTR_L00BA+1
            adc #$00
            sta PTR_L00BA+1		; ptr_BA+=40
            rts
.endp            

.proc wait14frames
	    lda #$00
            sta RTCLOK+2
l1:         lda #$01
            sta L00A8		; $A8=1
            lda RTCLOK+2
            cmp #$14		; wait 14 frames
            bne l1
            rts
.endp            

.proc SUB_L60FA
            ldx #$00
l1:         lda DATA6_L3988,X		; for (i=0; i<6; i++) {
            bmi s1
            lda DATA6_L3A90,X
            sta L00B5
            lda DATA6_L3A96,X
            sta L00B6
            lda #$1C
            sta L00BE
            lda #$82
            sta DATA6_L3988,X
            sta L00A0,X
            
            stx L00F0		; save x
            jsr SUB_L4DFA
            ldx L00F0		; restore x
            
s1:         inx
            cpx #$06
            bne l1		; } end for
            rts
.endp            
            
.proc switch_playerdata
            lda L00F7
            sta playerdata_L3AA4,Y
            lda lifes
            sta playerdata_L3AA4+1,Y
            lda COLORIDX_L00CF
            sta playerdata_L3AA4+2,Y
            lda L00AA
            sta playerdata_L3AA4+3,Y
            lda L009B
            sta playerdata_L3AA4+4,Y
            lda L009C
            sta playerdata_L3AA4+5,Y
            lda L008F
            sta playerdata_L3AA4+6,Y
            ldx #$00
            
l1:         lda scrline2+7,X
            sta playerdata_L3AA4+7,Y
            iny
            inx
            cpx #$06
            bne l1
            
            cpy #$06
            bne s1
            ldy #14
            jmp s2
s1:         ldy #$00

s2:         lda playerdata_L3AA4,Y
            sta L00F7
            lda playerdata_L3AA4+1,Y
            sta lifes
            lda playerdata_L3AA4+2,Y
            sta COLORIDX_L00CF
            lda playerdata_L3AA4+3,Y
            sta L00AA
            lda playerdata_L3AA4+4,Y
            sta L009B
            lda playerdata_L3AA4+5,Y
            sta L009C
            lda playerdata_L3AA4+6,Y
            sta L008F
            ldx #$00
            
l2:         lda playerdata_L3AA4+7,Y
            sta scrline2+7,X
            iny
            inx
            cpx #$06
            bne l2
            rts
.endp
            
L6191:      lda #$00
            sta AUDC1
            tay
L6197:      lda #<$0F00
            sta line1_ptr
            lda #>$0F00
            sta line1_ptr+1
            lda #$08
            sta L00B1
            
            ldx #$00
LOOP_L61A7: lda STR_L5D3C,X
            sta scrolldata,X
            inx
            cpx #127
            bne LOOP_L61A7		; load scrolldata for screenline1
            
            lda #$AA
            sta AUDC1
L61B7:      lda DATA_L5DBB,Y
            sta AUDF1
            lda DATA_L5E18,Y
            sta ZPVAR_L00B3
LOOP_L61C2: lda #$00
            sta RTCLOK+2
LOOP_L61C6: lda RTCLOK+2
            beq LOOP_L61C6		; wait 1 frame
            lda CONSOL
            cmp #05			; if (SELECT pressed) {
            bne SKIP_L61D7
            jsr SUB_L625D
            jmp main.main_1		; }
SKIP_L61D7: cmp #$06			; if (not START pressed) {
            bne L6210			; }
L61DB:      lda twopl1			; if (START pressed) {
            sta twopl2
            beq L6202
            lda playerdata_L3AB1+6
            pha
            lda playerdata_L3AA4+5
            pha
            jsr L6240
            ldy #$00
            pla
            sta L009C
            jsr switch_playerdata
            jsr SUB_L54F2
            jsr init_score
            ldy #$0E
            pla
            sta L009C
            jsr switch_playerdata
L6202:      jsr L6240
            lda #$00
            sta L00F8
            sta L00A9
            sta L0098
            jmp main2			; } endif

L6210:      dec L00B1			; (not START pressed)
            lda L00B1
            sta HSCROL
            cmp #$FF
            bne SKIP_L622F
            lda #$07
            sta L00B1
            sta HSCROL
            inc line1_ptr
            lda line1_ptr			; horizontal scrolling in line1
            cmp #$95
            bne SKIP_L622F
            jmp L6197
SKIP_L622F: dec ZPVAR_L00B3
            bne LOOP_L61C2
            iny
            cpy #$5D
            beq L623B
            jmp L61B7
L623B:      ldy #$00
            jmp L61B7
L6240:      lda #$01
            sta L009E
            jsr SUB_L60FA
            jsr SUB_L54F2
            lda #$09
            sta COLORIDX_L00CF
            jsr SUB_L6278
            jsr SUB_L54F2
            jsr SUB_L4CB8
            jsr init_players_starfield
            jsr init_score

.proc SUB_L625D
            ldx #$00
            txa
l1:         sta HPOSP0,X		; set HPOS of all players+missiles to 0
            inx
            cpx #$08
            bne l1
            
            lda #<scrline1
            sta line1_ptr
            lda #>scrline1
            sta line1_ptr+1
            lda #$00
            sta HSCROL			; set initial scrmem address for first line, reset HSCROLL
            rts
.endp
            
SUB_L6278:  lda #$00
            sta L00DC
            lda #<main
            sta CASINI
            lda #>main		
            sta CASINI+1		; set CASINI to main
            lda #$02
            sta BOOT			; RESET will use CASINI
            ldy COLORIDX_L00CF
            inc COLORIDX_L00CF
            cpy #09
            bne SKIP_L62AF
            jsr SUB_L637A
            ldy #$00
            sty COLORIDX_L00CF
            
            lda #<L4B80
            sta PTR_L00D7
            lda #>L4B80
            sta PTR_L00D7+1
            lda #<L4000
            sta PTR_L00D5
            lda #>L4000
            sta PTR_L00D5+1
            lda #<L49A0
            sta PTR_L00AC
            lda #>L49A0
            sta PTR_L00AC+1		; set some pointers

SKIP_L62AF: ldx #$00
            ldy #$01
            lda (PTR_L00D7),Y
            sta L00DB			; $DB = D7[1] count
LOOP_L62B7: dey
            lda (PTR_L00D7),Y		; A = D7[0] value
L62BA:      sta L3608,X
            inx
            cpx L00DB
            bne L62BA			; write count times value to L3608
            iny
            iny
            iny				; y += 3
            lda (PTR_L00D7),Y
            sta L00DB
            cpx #$00
            bne LOOP_L62B7
            lda PTR_L00D7
            dey
            sty L00DB
            clc
            adc L00DB
            sta PTR_L00D7
            lda PTR_L00D7+1
            adc #$00
            sta PTR_L00D7+1
            ldy #$00
L62DF:      lda (PTR_L00AC),Y
            sta DATA48_L3990,Y
            iny
            cpy #48
            bne L62DF
            tya
            clc
            adc PTR_L00AC
            sta PTR_L00AC
            lda PTR_L00AC+1
            adc #$00
            sta PTR_L00AC+1
            lda #<(RAM264_L3238-248)
            sta PTR_L0094
            lda #>(RAM264_L3238-248)
            sta PTR_L0094+1
            lda #<(DATA264BY_L4898-248)
            sta PTR_L0092
            lda #>(DATA264BY_L4898-248)
            sta PTR_L0092+1
            
            ldx #$02
            ldy #248
LOOP_L6309: lda (PTR_L0092),Y
            sta (PTR_L0094),Y
            iny
            cpy #$00
            bne LOOP_L6309
            inc PTR_L0092+1
            inc PTR_L0094+1
            ldy #$00
            dex
            bne LOOP_L6309		; copy 264 bytes from ptr_92+248 to ptr94+248
            
LOOP_L631B: jsr SUB_L6321
            jmp SKIP_L6339
SUB_L6321:  ldy L00DC
            lda TABLEL_L648F,Y
            sta PTR_L00D9
            lda TABLEH_L648A,Y
            sta PTR_L00D9+1
            ldy #$00
LOOP_L632F: lda (PTR_L00D5),Y
            sta (PTR_L00D9),Y
            iny
            cpy #$2C
            bne LOOP_L632F
            rts
SKIP_L6339: ldy L00DC
            ldx #$00
            lda TABLEL_L6499,Y
            sta PTR_L00D9
            lda TABLEH_L6494,Y
            sta PTR_L00D9+1
LOOP_L6347: ldy #$00
LOOP_L6349: lda (PTR_L00D5),Y
            sta (PTR_L00D9),Y
            iny
            cpy #$04
            bne LOOP_L6349
            lda PTR_L00D5
            clc
            adc #$04
            sta PTR_L00D5
            lda PTR_L00D5+1
            adc #$00
            sta PTR_L00D5+1
            lda PTR_L00D9
            sec
            sbc #$04
            sta PTR_L00D9
            lda PTR_L00D9+1
            sbc #$00
            sta PTR_L00D9+1
            inx
            cpx #$0B
            bne LOOP_L6347
            inc L00DC
            lda L00DC
            cmp #$05
            bne LOOP_L631B
            rts
SUB_L637A:  ldy L009B
            lda L009C
            cmp #$01
            bne SKIP_L6394
            cpy #$0B
            bcc SKIP_L6388
            ldy #$0A
SKIP_L6388: lda #$A0
            sta L00D2
            lda DATA_L5E86,Y
            sta waitLoopCount
            jmp SKIP_L63B8
SKIP_L6394: cmp #$02
            bne SKIP_L63AA
            cpy #$04
            bcc SKIP_L639E
            ldy #$03
SKIP_L639E: lda #$90
            sta L00D2
            lda DATA_L5E91,Y
            sta waitLoopCount
            jmp SKIP_L63B8
SKIP_L63AA: cpy #$04
            bcc SKIP_L63B0
            ldy #$03
SKIP_L63B0: lda #$88
            sta L00D2
            lda #$01
            sta waitLoopCount
SKIP_L63B8: ldx #$00
            lda L5E7B,Y
LOOP_L63BD: sta DATA6_L3980,X
            clc
            adc #$10
            inx
            cpx #$06
            bne LOOP_L63BD
            inc L009B
            lda L009B
            cmp #$16
            bne SUB_L63D2
            dec L009B
SUB_L63D2:  inc L009E
            lda L009E
            cmp #21
            bne L63DC
            dec L009E
L63DC:      rts

.proc clear_player
            ldx #$00
            txa
            sta HPOSP3
            sta HPOSM0
            sta HPOSM1
            sta HPOSM2
l1:         sta pl0+192,X
            sta pl1+192,X
            sta pl2+192,X
            inx
            cpx #46
            bne l1
            rts
.endp            
            
.proc init_players
            ldy #$00
l1:         lda COLOR8BYTES_L5B08,Y
            sta PCOLR0,Y
            iny
            cpy #$04
            bne l1			; set player colors

            ldx #$00
l2:         lda L5A86,X
            sta L00E7,X
            lda TABLEinit_misx,X
            sta mis0x,X
            inx
            cpx #$03			; initialize E4...E9
            bne l2
            
            ldx #$00
l3:         lda TABLEinit_plx,X
            sta pl0x,X
            inx
            cpx #$04
            bne l3			; initialize player x positions
            
            ldx #$00
l4:         lda pl0bitmap,X
            sta pl0+210,X
            lda pl1bitmap,X
            sta pl1+210,X
            lda pl2bitmap,X
            sta pl2+210,X
            lda pl3bitmap,X
            sta pl3+210,X
            inx
            cpx #14
            bne l4			; initialize player bitmaps
            
            lda #$00
            sta L0090
            sta L00DE			; init 90 and DE

            ldx #$00
            txa
l5:         sta scrline3,X
            inx
            cpx #40
            bne l5			; clear statusline
 .endp					; fallthrough to show_lifes
            
.proc show_lifes
            ldy #$00			; init_statusline
            lda #"1"
l1:         sta scrline3,Y		; for (i=0; i<$9A; i++)
            iny				; scrline[i] = "1"
            cpy lifes
            bne l1			; endfor
            dey
            lda #" "
            sta scrline3,Y		; scrline[$9A-1] = " "
            rts
.endp            

.proc SUB_L6468
            ldx #$00
            lda L00F7
            beq s1
            txa
l1:         sta DATA6_L3988,X
            sta L00A0,X
            sta L00C9,X			; clear memory at 3988 A0 C9 size F7
            inx
            cpx L00F7
            bne l1
            
s1:         ldx #$00
            txa
l2:         sta DATA6_L3A80,X
            clc
            adc #$2A
            inx
            cpx #$06
            bne l2			; write 0, 42,..5*42 to $3A80
            rts
.endp
            
TABLEH_L648A:
            .byte $30,$31,$31,$31,$31
TABLEL_L648F:
            .byte $D8,$04,$30,$B4,$E0
TABLEH_L6494:
            .byte $31,$31,$3B,$32,$3B
TABLEL_L6499:
            .byte $B0,$84,$00,$34,$00

.proc VBLKDshort_L649E
            lda ZPVAR_L00B2
            bne s3			; if (B2==0) {
            inc L00B1			; B1++
            lda L00B1
            cmp #20
            bne s1
            inc L00E2			; if (B1==20) B1=0; E2++
            lda #$00
            sta L00B1
s1:         lda L00AE
            cmp #$01
            bne s2
            sta ZPVAR_L00B2		; if (AE==1) B2=1
s2:         lda L00E2
            sta AUDC3
            lda L00AE
            sta AUDF3			; set AUD3		; decreasing freq until 1 then toggle flag B2
            dec L00AE
            jmp XITVBV			; } endif
s3:         inc L00B1			; else {
            lda L00B1
            cmp #20
            bne s4
            dec L00E2			; if (B1=20) B1=0; E2--
            lda #$00
            sta L00B1
s4:         lda L00E2
            sta AUDC3
            lda L00AE
            sta AUDF3			; set AUD3		; increasing freq
            inc L00AE			
            jmp XITVBV			; }
.endp
            
            .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00
DLIST_L6500:
            .byte AEMPTY4
            .byte AHSCR+ALMS+$06
line1_ptr:  .word scrline1
            .byte ALMS+$06
            .word scrline2
            .byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
            .byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
            .byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
            .byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
            .byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
            .byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
            .byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
            .byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
            .byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
            .byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
            .byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
            .byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
            .byte $0E,$0E,$0E,$0E,$0E			; 101 lines mode E 4 colors 160 xres 1 scanlines high, 40 bytes per line
            .byte ALMS+$0E
            .word grscreen2
            .byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
            .byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
            .byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
            .byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
            .byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
            .byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
            .byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
            .byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
            .byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
            .byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
            .byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
            .byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
            .byte $0E,$0E,$0E,$0E			; 101 lines mode E 4 colors 160 xres 1 scanlines high, 40 bytes per line
            .byte ALMS+$04				; 1 line mode 4 4 colors 40 chars 8 scanlines high
            .word scrline3
            .byte AVB+AJMP
            .word DLIST_L6500

            run main         
