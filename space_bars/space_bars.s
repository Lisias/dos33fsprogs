;=====================================
; Rasterbars in Space
;
; a cycle-counting game
;
; by deater (Vince Weaver) <vince@deater.net>
;=====================================

; Zero Page
FRAMEBUFFER	= $00	; $00 - $0F

;; LZ4 addresses

LZ4_SRC		= $00
LZ4_DST		= $02
LZ4_END		= $04
COUNT		= $06
DELTA		= $08

CH		= $24
CV		= $25
GBASL		= $26
GBASH		= $27
BASL		= $28
BASH		= $29
MASK		= $2E
COLOR		= $30
FRAME		= $60
FRAMEH		= $61
BLARGH		= $69
ZPOS		= $78
DRAW_PAGE	= $EE
LASTKEY		= $F1
PADDLE_STATUS	= $F2
XPOS		= $F3
YPOS		= $F4
TEMP		= $FA
TEMPY		= $FB
INL		= $FC
INH		= $FD
OUTL		= $FE
OUTH		= $FF

; Soft Switches
KEYPRESS= $C000
KEYRESET= $C010
SET_GR	= $C050 ; Enable graphics
SET_TEXT= $C051 ; Enable text
FULLGR	= $C052	; Full screen, no text
PAGE0	= $C054 ; Page0
PAGE1	= $C055 ; Page1
LORES	= $C056	; Enable LORES graphics
HIRES	= $C057 ; Enable HIRES graphics
PADDLE_BUTTON0 = $C061
PADDL0	= $C064
PTRIG	= $C070



; ROM routines

TEXT	= $FB36				;; Set text mode
HOME	= $FC58				;; Clear the text screen
WAIT	= $FCA8				;; delay 1/2(26+27A+5A^2) us



	;==================
	; show title screen
	;==================

	jsr	title_screen

	;==================
	; Display Text
	;==================

	jsr	instructions

	;==================
	; Mode7
	;==================

	;==================
	; Rasterbars
	;==================

	jsr	game

	;==================
	; Game Over
	;==================

	jsr	game_over

loop_forever:
	jmp	loop_forever





	;==================================
	; HLINE
	;==================================

	; Color in A
	; Y has which line
hline:
	pha							; 3
	ldx	gr_offsets,y					; 4+
	stx	hline_loop+1					; 4
	lda	gr_offsets+1,y					; 4+
	clc							; 2
	adc	DRAW_PAGE					; 3
	sta	hline_loop+2					; 4
	pla							; 4
	ldx	#39						; 2
hline_loop:
	sta	$5d0,X		; 38				; 5
	dex							; 2
	bpl	hline_loop					; 2nt/3
	rts							; 6

	;==========================
	; Clear gr screen
	;==========================
	; Color in A
clear_gr:
	ldy	#46
clear_page_loop:
	jsr	hline
	dey
	dey
	bpl	clear_page_loop
	rts

gr_offsets:
	.word	$400,$480,$500,$580,$600,$680,$700,$780
	.word	$428,$4a8,$528,$5a8,$628,$6a8,$728,$7a8
	.word	$450,$4d0,$550,$5d0,$650,$6d0,$750,$7d0


.include "../asm_routines/gr_unrle.s"
.include "../asm_routines/keypress.s"
.include "gr_copy.s"
.include "title.s"
.include "instructions.s"
.include "game.s"
.include "text_print.s"
.include "game_over.s"
.align $100
.include "vapor_lock.s"
.include "delay_a.s"
.include "lz4_decode.s"
.align $100
.include "gr_putsprite.s"

.include "spacebars_title.inc"
.align $100
.include "mode7_sprites.inc"
