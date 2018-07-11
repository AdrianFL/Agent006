;;-----------------------------LICENSE NOTICE-----------------------------------------------------
;;  This file is part of Amstrad CPC videogame "Agent 006"
;;  Copyright (C) 2017 APLSoft / Adrian Frances Lillo / Pablo Lopez Iborra / Luis Gonzalez Aracil
;;  Copyright (C) 2015-2016 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
;;
;;  This program is free software: you can redistribute it and/or modify
;;  it under the terms of the GNU Lesser General Public License as published by
;;  the Free Software Foundation, either version 3 of the License, or
;;  (at your option) any later version.
;;
;;  This program is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;  GNU Lesser General Public License for more details.
;;
;;  You should have received a copy of the GNU Lesser General Public License
;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;-----------------------------LICENSE NOTICE-----------------------------------------------------

;;====================================================
;; FUNCTIONS RELATED WITH COLLECTABLES
;;====================================================

;;====================================================
;; INCLUDE AREA
;;====================================================
.include "utility.h.s"
.include "includes.h.s"
.include "collision.h.s"
.include "player.h.s"

.globl _song
.globl _powerup

;;globals
.globl _sprite_phantisdinamic_0
.globl _sprite_phantisdinamic_1
.globl _sprite_phantisdinamic_2
.globl _sprite_phantisdinamic_3
.globl _sprite_phantisdinamic_4
.globl _sprite_phantisdinamic_5
.globl _sprite_phantisdinamic_6
.globl _sprite_powerups_1
.globl _sprite_powerups_3

;; constants
.equ coll_x, 0
.equ coll_y, 1
.equ coll_w, 2
.equ coll_h, 3
.equ coll_tx, 4
.equ coll_ty, 5
.equ coll_type, 6
.equ coll_pos, 7
.equ coll_spr, 8
.equ coll_spr1, 9

;;=========================================
;;=========================================
;; PRIVATE DATA
;;=========================================
;;=========================================
power_up_active: .db #0x00		;;power up has been picked and is
;; Longer bullet	10000000 - 128	;;active
;; Higher jump		01000000 - 64
;; Piercing bullets	00100000 - 32
;; Unvulnerability	00010000 - 16
;; Unknown		00001000 - 8
;; Unknown		00000100 - 4
;; Unknown		00000010 - 2
;; Unknown	 	00000001 - 1
phantis_active: .db #0x00 		;;a phantis character has been picked
;; P			10000000 - 128	;;and is shown above
;; H			01000000 - 64
;; A			00100000 - 32
;; N			00010000 - 16
;; T			00001000 - 8
;; I			00000100 - 4
;; S			00000010 - 2
;; Unknown		00000001 - 1

collectable: .db #0xFF, #0x00, #0x04, #0x10, #0x00, #0x00, #0x00, #0x00, #0x00, #0x00, #0x00, #0x00
;;		 pos x  pos y size x  size y tile x tile y collec collec
;;							   type   pos 
	     .dw #0x0000 ;;sprite to be drawn   

;;type 1 - power up
;;type 2 - character 1
;;type 3 - character 2

;;=========================================
;;=========================================
;; PUBLIC FUNCTIONS
;;=========================================
;;=========================================

;;==================================================
;; Adds a new collectable, only 1 per map
;; INPUT: BC - x, y
;;	  DE - type, pos
;;	  HL - sprite
;; DESTROYS : A, IX
;;==================================================
collectables_add::

	ld ix, #collectable

	ld a, obj_x(ix)
	cp #0xff 
	ret nz 			;;if collectable is set, don't add 

	ld a, b 
	ld coll_x(ix), a 	;;set x

	ld a, c 
	ld coll_y(ix), a 	;;set y

	ld a, d 
	ld coll_type(ix), a	;;type of collectable

	ld a, e 
	ld coll_pos(ix), a	;;binary position of collectable

	ld a, h			;;sprite to be drawn
	ld coll_spr1(ix), a 
	ld a, l 
	ld coll_spr(ix), a

	call utility_update_tiles

ret


;;==================================================
;; Checks if we have collision with a collectable
;; DESTROYS : AF; BC; IX; IY; HL; DE
;;==================================================
collectables_update::

	ld iy, #collectable

	ld a, coll_x(iy)
	cp #0xff 
	ret z 			;;if collectable is not set, don't update 

	call player_getPlayer
	call utility_checkCollision
	dec a 			;;check if our player collects the item
	ret nz  		;;return if not 

	ld de, #0x0540
	call utility_piano_sound

	;;if we collect the item 
	ld ix, #collectable
	call utility_updatePosition	;;erase the item

	ld ix, #collectable
	call utility_object_erase2	;;erase the item

	ld a, #0xff
	ld coll_x(ix), a	;;disable the item 

	ld a, coll_type(ix)	;;load item type 
	dec a 
	jr nz, continue_u1	;;if it's not type 0, jump 

		;;it is type 0 (a power up)
		ld a, (power_up_active)
		or coll_pos(ix)
		ld (power_up_active), a	;;update/add power up

		call cpct_akp_stop_asm

		ld de, #_powerup
		call cpct_akp_musicInit_asm

		ret

	continue_u1:
	dec a
	ret nz	;;if it's not type 1, exit 

		;;it is type 0 (phantis char)
		ld a, (phantis_active)
		or coll_pos(ix)
		ld (phantis_active), a	;;update/add phantis char
		call collectables_draw_chars
ret



;;==================================================
;; Redraws current collectable
;; DESTROYS : A, IX
;;==================================================
collectables_draw::
	ld ix, #collectable

	ld a, coll_x(ix)
	cp #0xff 
	ret z 			;;if collectable is not set, don't draw 

	ld b, coll_spr1(ix)
	ld c, coll_spr(ix)
	call utility_object_draw_masked
ret

;;==================================================
;; Disable current collectable
;; DESTROYS : A, IX
;;==================================================
collectables_delete::
	ld ix, #collectable 
	ld a, #0xff 
	ld coll_x(ix), a
ret

;;==================================================
;; Return active collectables in A
;; DESTROYS : A
;;==================================================
collectables_get_power::
	ld a, (power_up_active)
ret

;;==================================================
;; Resets a power up to 0
;; INPUT: B - Negated mask
;; DESTROYS : A
;;==================================================
collectables_reset_power::

	ld a, (power_up_active)
	and b 
	ld (power_up_active), a
ret

;;==================================================
;; Return active chars phantis in A
;; DESTROYS : A
;;==================================================
collectables_get_chars1::
	ld a, (phantis_active)
ret

;;==================================================
;; Resets all power ups
;; DESTROYS : A
;;==================================================
collectables_resetAll::
	ld a, #00
	ld (power_up_active), a
ret

;;==================================================
;; Draws all the characters that have been picked
;; DESTROYS : AF; BC; HL; DE
;;==================================================
collectables_draw_chars::

	ld a, (phantis_active)
	and #0b10000000					;;first char
	jr z, continue_c1

		ld bc, #_sprite_phantisdinamic_0	;;sprite ptr
		ld de, #0xD01A				;;memory ptr
		
		call draw

		ld de, #0x901A
		call cpct_drawSpriteMaskedAlignedTable_asm

	continue_c1:

	ld a, (phantis_active)
	and #0b01000000					;;first char
	jr z, continue_c2

		ld bc, #_sprite_phantisdinamic_1	;;sprite ptr
		ld de, #0xD01E				;;memory ptr
		
		call draw

		ld de, #0x901E
		call cpct_drawSpriteMaskedAlignedTable_asm

	continue_c2:

	ld a, (phantis_active)
	and #0b00100000					;;first char
	jr z, continue_c3

		ld bc, #_sprite_phantisdinamic_2	;;sprite ptr
		ld de, #0xD022				;;memory ptr
		
		call draw

		ld de, #0x9022
		call cpct_drawSpriteMaskedAlignedTable_asm

	continue_c3:

	ld a, (phantis_active)
	and #0b00010000					;;first char
	jr z, continue_c4

		ld bc, #_sprite_phantisdinamic_3	;;sprite ptr
		ld de, #0xD026				;;memory ptr
		
		call draw

		ld de, #0x9026
		call cpct_drawSpriteMaskedAlignedTable_asm

	continue_c4:

	ld a, (phantis_active)
	and #0b00001000					;;first char
	jr z, continue_c5

		ld bc, #_sprite_phantisdinamic_4	;;sprite ptr
		ld de, #0xD02A				;;memory ptr
		
		call draw

		ld de, #0x902A
		call cpct_drawSpriteMaskedAlignedTable_asm

	continue_c5:

	ld a, (phantis_active)
	and #0b00000100					;;first char
	jr z, continue_c6

		ld bc, #_sprite_phantisdinamic_5	;;sprite ptr
		ld de, #0xD02E				;;memory ptr
		
		call draw

		ld de, #0x902E
		call cpct_drawSpriteMaskedAlignedTable_asm

	continue_c6:

	ld a, (phantis_active)
	and #0b00000010					;;first char
	jr z, continue_c7

		ld bc, #_sprite_phantisdinamic_6	;;sprite ptr
		ld de, #0xD032				;;memory ptr
		
		call draw

		ld de, #0x9032
		call cpct_drawSpriteMaskedAlignedTable_asm

	continue_c7:

ret

;;auxiliar function for drawing chars
draw:
	ld ix, #0x1004				;;size 
	ld hl, #_playerMaskTable		;;transparency

	push bc
	push ix 
	push hl
	call cpct_drawSpriteMaskedAlignedTable_asm
	pop hl 
	pop ix
	pop bc
ret