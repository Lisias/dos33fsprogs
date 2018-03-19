; Note: needs some extra work
; Set up initial pointer
; Skip/strip the LZ4 header

.include "zp.inc"

UNPACK_BUFFER	EQU	$4000

; Adjusted using incbin directive
LZ4_DATA_BEGIN	EQU	0

start:
	; set flags for HGR2
	bit	HIRES
	bit	PAGE1
	bit	FULLGR

	lda	#<(data+LZ4_DATA_BEGIN)
	sta	LZ4_SRC
	lda	#>(data+LZ4_DATA_BEGIN)
	sta	LZ4_SRC+1

	lda	#<(data_end-data+LZ4_DATA_BEGIN)
	sta	LZ4_END
	lda	#>(data_end-data+LZ4_DATA_BEGIN)
	sta	LZ4_END+1

	jsr	lz4_decode



	jmp	$4000

;===============================================
; External modules
;===============================================

.include "../asm_routines/lz4_decode.s"

; Load, skipping 11 bytes of header
data:
.incbin	"MODE7_DEMO.lz4",11
data_end:
