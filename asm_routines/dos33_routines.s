;     File I/O routines based on sample code in
;       "Beneath Apple DOS" by Don Worth and Pieter Lechner

;; For the disk-read code
RWTSH	  EQU $F1
RWTSL	  EQU $F0
DOSBUFH	  EQU $EF
DOSBUFL   EQU $EE
FILEMH    EQU $ED
FILEML	  EQU $EC

;; DOS Constants
OPEN     EQU $01
CLOSE    EQU $02
READ     EQU $03
WRITE    EQU $04
DELETE   EQU $05
CATALOG  EQU $06
LOCK     EQU $07
UNLOCK   EQU $08
RENAME   EQU $09
POSITION EQU $0A
INIT     EQU $0B
VERIFY   EQU $0C

LOCATE_FILEM_PARAM EQU $3DC
LOCATE_RWTS_PARAM  EQU $3E3
FILEMANAGER        EQU $3D6


	;================================
	; read from disk
	;================================

	jsr     LOCATE_FILEM_PARAM  	; load file manager param list
					; Y=low A=high

	sta	FILEMH
	sty	FILEML

	ldy    #7	 		; file type offset = 7
	lda    #0			; 0 = text
	sta    (FILEML),y

	iny    				; filename ptr offset = 8
	lda    #<filename
	sta    (FILEML),y
	iny
	lda    #>filename
	sta    (FILEML),y

	ldx    #1	 		; open existing file

	jsr    open			; open file

	jsr    read			; read buffer

	jsr    close			; close file


;=================================
; get_dos_buffer
;=================================
;
; Dos buffer format
; 0x000-0x0ff = data buffer
; 0x100-0x1ff = t/s list buffer
; 0x200-0x22c = file manager workarea (45 bytes)
; 0x22d-0x24a = file name buffer

; 0x24b-0x24c = address of file manager workarea
; 0x24d-0x24e = address of t/s list buffer
; 0x24f-0x250 = adress of data sector buffer
; 0x251-0x252 = address of file name field for the next buffer

; In DOS, $3D2 points to 0x22d of first buffer
;    add 0x24 to get chain pointer


open:
	; allocate one of the DOS buffers so we don't have to set them up

allocate_dos_buffer:
	lda     $3D2			; DOS load point
	sta	DOSBUFH
	ldy	#0
	sty	DOSBUFL

buf_loop:
	lda	(DOSBUFL),Y		; locate next buffer
	pha				; push on stack
					; we need this later
					; to test validity

	iny				; increment y
	lda	(DOSBUFL),Y		; load next byte
	sta	DOSBUFH			; store to buffer pointerl

	pla				; restore value from stack

	sta	DOSBUFL			; store to buffer pointerh

	bne	found_buffer		; if not zero, found a buffer

	lda	DOSBUFH			; also if not zero, found a buffer
	beq     error			; no buffer found, exit

found_buffer:
	ldy  	#0			; get filename
	lda	(DOSBUFL),Y		; get first byte
	beq	good_buffer		; if zero, good buffer

					; in use
	ldy	#$24	   		; point to next
	bne	buf_loop		; and loop

good_buffer:
	lda 	#$78
	sta	(DOSBUFL),Y		; mark as in use (can be any !0)

keep_opening:
	ldy	#0
	lda	#OPEN			; set operation code to OPEN
	sta	(FILEML),y

	ldy	#2	  		; point to record length
	lda	#0			; set it to zero (16-bits)
	sta	(FILEML),y
	iny
	sta	(FILEML),y

	iny		  		; point to volume num (0=any)
	sta	(FILEML),y

	jsr	LOCATE_RWTS_PARAM	; get current RWTS parameters
					; so we can get disk/slot info

	sty	RWTSL
	sta	RWTSH

	ldy	#1
	lda	(RWTSL),y		; get slot*16
	lsr	a
	lsr	a
	lsr	a
	lsr	a			; divide by 16

	ldy	#6			; address of slot
	sta	(FILEML),y		; store it

	ldy	#2
	lda	(RWTSL),y		; get drive
	ldy	#5			; address of drive
	sta	(FILEML),y

filemanager_interface:

	ldy 	#$1E
dbuf_loop:
	lda	(DOSBUFL),y		; get three buffer pointers
	pha				; push onto stack
	iny				; increment pointer
	cpy	#$24			; have we incremented 6 times?
	bcc	dbuf_loop		; if not, loop

	ldy	#$11			; point to the end of the same struct
					; in file manager
fmgr_loop:
	pla				; pop value
	sta	(FILEML),Y		; store it
	dey				; work backwards
	cpy	#$c			; see if we are done
	bcs	fmgr_loop		; loop

	jmp	FILEMANAGER		; run filemanager


;====================
; close DOS file
;====================

close:
        ldy    #0    			; command offset
	lda    #CLOSE			; load close
	sta    (FILEML),y

	jsr    filemanager_interface

	ldy    #0		    	; mark dos buffer as free again
	tya
	sta    (DOSBUFL),y

	rts

;=========================
; read from dos file
;=========================

read:
        ldy   #0			; command offset
	lda   #READ
	sta   (FILEML),y

	iny   				; point to sub-opcode
	lda   #2			; "range of bytes"
	sta   (FILEML),y

	ldy   #6			; point to number of bytes to read
	lda   #$ff
	sta   (FILEML),y		; we want to read 255 bytes
	iny
	lda   #$00
	sta   (FILEML),y

	ldy   #8			; buffer address
	lda   #<disk_buff
	sta   (FILEML),y
	iny
	lda   #>disk_buff
	sta   (FILEML),y

	bne   filemanager_interface     ; same as JMP

filename:
; CPUINFO__6502 (padded to be 30 chars long)
.byte $C3,$D0,$D5,$C9,$CE,$C6,$CF,$DF
.byte $DF,$B6,$B5,$B0,$B2,$A0,$A0,$A0
.byte $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
.byte $A0,$A0,$A0,$A0,$A0,$A0
