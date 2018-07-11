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
;; FUNCTIONS RELATED WITH SPRITES
;;====================================================

;;====================================================
;; INCLUDE AREA
;;====================================================

.include "utility.h.s"
.include "includes.h.s"

;;=========================================
;;=========================================
;; PRIVATE DATA
;;=========================================
;;=========================================

spr: .dw 0xFFFF

;;define sprite
defineObject sprite, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0, 0, 0xFF, 0xFF, 0xFF, 0xFF


.globl _sprite_turret_1
;;=========================================
;;=========================================
;; PUBLIC FUNCTIONS
;;=========================================
;;=========================================


;;=========================================
;; Draws the sprite
;; DESTROYS: AF; BC; HL
;;=========================================
sprite_draw::

	ld ix, #sprite

	ld a, (spr+1) 
	ld b, a
	ld a, (spr)
	ld c, a

	call utility_object_draw_masked 		;;draw our sprite
	ret

ret

;;=========================================
;; Add sprite
;; Input: 	BC - pos x, pos y (in pixels)
;;			DE - sprite
;;			HL - Width and height of the sprite
;; DESTROYS: AF, BC, DE, HL
;;=========================================
sprite_add::
	
		ld ix, #sprite

		;;check if there is a sprite set 
		ld a, obj_x(ix)	;;load sprite value in a 
		cp #0xff 	;;if x is negative, sprite is not set 
		ret nz		;;if sprite is set, don't change

		;;save position
		ld obj_x(ix), b 	;;store x 
		ld obj_y(ix), c 	;;store y

		ld obj_w(ix), h 	;;store w 
		ld obj_h(ix), l 	;;store h

		ld a, d 
		ld (spr+1), a
		ld a, e
		ld (spr), a

		call utility_update_tiles	;;update sprite tiles (to erase)
		call utility_initializePosition	;;update x,y initial position


ret

;;=========================================
;; Erases the sprite
;; DESTROYS: AF, BC, DE, HL AF’, BC’, DE’, HL’
;;=========================================
sprite_erase::

	ld ix, #sprite

	call utility_object_erase	;;erases the sprite space

ret

;;=========================================
;; Removes the sprite
;; DESTROYS: AF, BC, DE, HL
;;=========================================
sprite_remove::

	
	ld ix, #sprite 

	ld a, obj_x(ix)
	cp #0xff 
	ret z		;;don't remove if its not set

	ld a, #0xff 
	ld obj_x(ix), a

	call utility_object_erase	;;erases the sprite space
	call utility_object_erase2	;;erases the sprite space

ret 