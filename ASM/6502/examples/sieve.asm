

.DEF	NN	= 20000

	org $2000

	ICL "../include/memset.asm"
	ICL "../include/atari/printu16.asm"
	ICL "../include/atari/printfr0.asm"
	ICL "../include/atari/fasc2str.asm"
	ICL "../include/atari/putnchar.asm"
	ICL "../include/atari/putline.asm"
	ICL "../include/atari/putc.asm"
;	ICL "asmlib/u16_div10.asm"

.align $100
.proc main
	lda #0
	sta 19
	sta 20		; set timer to 0

	ldx #NN&$FF
	stx u16_N
	ldx #NN/256
	stx u16_N+1
	
	ldx #flagbuf&255
	stx PTR1
	ldx #flagbuf/256
	stx PTR1+1
	ldy u16_N
	ldx u16_N+1
	jsr memset	; clear buffer memory

;	lda u16_N+1
;	lsr
;	sta u16_st+1
;	lda u16_N
;	ror
;	sta u16_st	; st = n>>1
			
	lda #1
	sta flagbuf	; flags[0]=1

	ldy #flagbuf/256
	ldx #flagbuf&$FF
	bne @+
	dey
@	dex
	stx PTR2
	sty PTR2+1	; PTR2=flagbuf-1
	
	ldy #2
	sty u16_i
	lda #0
	sta u16_i+1	; i=2
while1			; while(i<=st)
	lda u16_N
	cmp u16_i
	lda u16_N+1
	sbc u16_i+1
	bcc while1out		; i>st

	;ldy u16_i
	lda (PTR2),Y	; flag[i]
	bne else1
			; if !flag[i]
	inc u16_count
	bne @+
	inc u16_count+1	; count++
@	tya ;lda u16_i
	asl
	sta u16_k
	lda u16_i+1
	rol
	sta u16_k+1	; k=i+i

	lda PTR2									; 3
	sta PTR3									; 3
	lda PTR2+1									; 3
	sta PTR3+1	; (PTR2),Y==flag[i-1]						; 3

while2
	lda u16_N
	cmp u16_k
	lda u16_N+1
	sbc u16_k+1
	bcc while2out	; while (k<=n)

	lda PTR3
	clc
	adc u16_i
	sta PTR3
	lda PTR3+1
	adc u16_i+1
	sta PTR3+1	; PTR3=PTR3+i		

	lda #1
	sta (PTR3),Y

	lda u16_k
	adc u16_i
	sta u16_k
	lda u16_k+1
	adc u16_i+1
	sta u16_k+1	; k=k+i
			
	bcc while2	; end while2		; evtl bcc optimize 
while2out		 
else1			; endif
	iny
	sty u16_i
	bne while1
	inc u16_i+1	; i++; PTR1++
	inc PTR2+1
	bne while1	; end while1
while1out
;while3			; for(i=st; i<=n; i++)
;	lda u16_n
;	cmp u16_i
;	lda u16_n+1
;	sbc u16_i+1
;	bcc while3out	; i>st
;
;	ldy u16_i
;	lda (PTR2),Y	; flag[i]
;	bne else2
;			; if !flag[i]
;	inc u16_count
;	bne @+
;	inc u16_count+1	; count++
;@
;else2
;	inc u16_i
;	bne while3
;	inc u16_i+1	; i++; PTR1++
;	inc PTR2+1
;	bne while3		; next
;while3out
			
	lda 20
	ldx 19		; read timer
	sta u16_tm
	stx u16_tm+1

	lda #CR
	jsr putc	
	lda u16_count
	ldx u16_count+1
	jsr printu16	; print count
	lda #STR1&$FF
	sta PTR1
	lda #STR1/256
	sta PTR1+1
	jsr putline
	lda u16_tm
	ldx u16_tm+1
	jsr printu16	; print tm
	lda #STR2&$FF
	sta PTR1
	lda #STR2/256
	sta PTR1+1
	jsr putline
;	lda u16_ilc
;	ldx u16_ilc+1
;	jsr printu16	; print inner loop count

	
le	jmp le	
	rts
.endp		; main

CR	= $9B

; zero page locations	
PTR1 	= $80		; users memset, printfr0, putnchar
PTR2	= $82		; users main
PTR3	= $84		; users main

W1	= $80
W2	= $82

B3	= $82
B5	= $84
		; users memset

; CIO equates for IOCB0
ICHID  =   $0340
ICDNO  =   $0341
ICCOM  =   $0342
ICSTA  =   $0343
ICBAL  =   $0344
ICBAH  =   $0345
ICPTL  =   $0346
ICPTH  =   $0347
ICBLL  =   $0348
ICBLH  =   $0349
ICAX1  =   $034A
ICAX2  =   $034B

; OS jump table
CIOV   =   $E456

; floating point package
FR0	= $D4	; 6 byte FP register
INBUFF	= $F3	; 2 byte pointer to input buffer
FASC	= $D8E6	; floating point to ATASCII, LBUFF = (string)FR0, INBUFF = last char
IFP	= $D9AA ; 16bit integer in FR0 to floating point in FR0 

STR1		.byte ' PRIMES IN',CR
STR2		.byte ' JIFFIES',CR
u16_N		= $94
;u16_ST		.word	0
u16_count	= $92
;u16_ilc		.word	0
u16_i		= $90
u16_k		= $88

.align $100
flagbuf		.DS	NN
u16_tm		.DS	1

	
	run main
	
			