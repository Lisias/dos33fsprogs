;=====================================
; XMAS2018 -- Wreath Part
;=====================================


wreath:

	;===================
	; init screen

	;===================
	; init vars
	lda	#15
	sta	XPOS
	lda	#38
	sta	YPOS

	lda	#0
	sta	FRAME
	sta	FRAMEH

	;=============================
	; Load graphic hgr

	lda	#<wreath_hgr
	sta	LZ4_SRC
	lda	#>wreath_hgr
	sta	LZ4_SRC+1

	lda	#<(wreath_hgr_end-8)	; skip checksum at end
	sta	LZ4_END
	lda	#>(wreath_hgr_end-8)	; skip checksum at end
	sta	LZ4_END+1

	lda	#<$2000
	sta	LZ4_DST
	lda	#>$2000
	sta	LZ4_DST+1

	jsr	lz4_decode

	;==============================
	; setup graphics for vapor lock
	;==============================

	jsr	vapor_lock						; 6

	; vapor lock returns with us at beginning of hsync in line
	; 114 (7410 cycles), so with 5070 lines to go

	; so we have 5070 + 4550 = 9620 to kill

	; FIXME: clear page0/page1 screens

;	jsr	gr_copy_to_current		; 6+ 9292

	; now we have 322 left

	; GR part
;	bit	HIRES							; 4
	bit	SET_GR							; 4
	bit	FULLGR							; 4

	; 9620
	;   -8 mode set
	;  - 3 for jmp
	;=======
	; 9609

	; Try X=239 Y=8 cycles=9609

        ldy	#8							; 2
wrloopA:ldx	#239							; 2
wrloopB:dex								; 2
	bne	wrloopB							; 2nt/3
	dey								; 2
	bne	wrloopA							; 2nt/3

	jmp	wreath_begin_loop
.align  $100


	;================================================
	; Wreath Loop
	;================================================
	; each scan line 65 cycles
	;       1 cycle each byte (40cycles) + 25 for horizontal
	;       Total of 12480 cycles to draw screen
	; Vertical blank = 4550 cycles (70 scan lines)
	; Total of 17030 cycles to get back to where was

wreath_begin_loop:

wreath_display_loop:

	; (40*65)-4 = 2596

	; 40 lines of LORES
	bit	LORES							; 4

	; Try X=42 Y=12 cycles=2593 R3

	lda	$0	; nop						; 3

	ldy	#12							; 2
wrloopC:ldx	#42							; 2
wrloopD:dex								; 2
	bne	wrloopD							; 2nt/3
	dey								; 2
	bne	wrloopC							; 2nt/3


	; rest of screen is hires page0
	; (152*65)-4 = 9876

	bit	HIRES							; 4

	; Try X=13 Y=139 cycles=9870 R6

	nop
	nop
	nop

	ldy	#139							; 2
wrloopE:ldx	#13							; 2
wrloopF:dex								; 2
	bne	wrloopF							; 2nt/3
	dey								; 2
	bne	wrloopE							; 2nt/3



;======================================================
; We have 4550 cycles in the vblank, use them wisely
;======================================================

	; do_nothing should be      4550
	;			     -10 keypress
	;			===========
	;			    4540


;	jsr	play_music		; 6+1032


	; Try X=9 Y=89 cycles=4540

	ldy	#89							; 2
wrloop1:ldx	#9							; 2
wrloop2:dex								; 2
	bne	wrloop2							; 2nt/3
	dey								; 2
	bne	wrloop1							; 2nt/3

	; no keypress =  10+(24)   = 34

	lda	KEYPRESS				; 4
	bpl	wr_no_keypress				; 3
							; -1
	jmp	wr_handle_keypress			; 3
wr_no_keypress:
	jmp	wreath_display_loop			; 3

wr_handle_keypress:
	bit	KEYRESET	; clear keypress	; 4
	rts						; 6


