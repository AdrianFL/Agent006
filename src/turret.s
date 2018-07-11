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
;; FUNCTIONS RELATED WITH TURRET MOVEMENT AND ACTIONS
;;====================================================

.area _CODE

;;=========================================
;;=========================================
;; PRIVATE DATA
;;=========================================
;;=========================================

.include "includes.h.s"		 ;;file containing cpct includes
.include "bullets.h.s"
.include "utility.h.s"		;;shared functions

.globl _sprite_turret_0
.globl _sprite_turret_1
.globl _playerMaskTable

allocateMemory 0x3180
;;TURRET DATA

;;define turret
defineObject turret1, 0xFF, 0xFF, 5, 20, 0xFF, 0xFF, 0, 5, 0xFF, 0xFF, 0xFF, 0xFF
;;define bullet
defineBullet turret1, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0

;;define turret
defineObject turret2, 0xFF, 0xFF, 5, 20, 0xFF, 0xFF, 0, 5, 0xFF, 0xFF, 0xFF, 0xFF
;;define bullet
defineBullet turret2, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0

;;=========================================
;;=========================================
;; PUBLIC FUNCTIONS
;;=========================================
;;=========================================

;;=========================================
;; Draws the turret
;; DESTROYS: AF; BC; HL
;;=========================================
turret_draw::

	ld ix, #turret1	
	call turret_single_draw
	ld ix, #turret2	
	call turret_single_draw

ret


;;=========================================
;; Updates the turret
;; DESTROYS: AF; BC; DE; HL
;;=========================================
turret_update::

	ld ix, #turret1
	call turret_single_update
	ld ix, #turret2
	call turret_single_update

ret

;;=========================================
;; Erases the turret
;; INPUT: A - Turret to be erased (0 or 1)
;; DESTROYS: AF, BC, DE, HL AF’, BC’, DE’, HL’
;;=========================================
turret_erase::

	dec a ;;check if we try to add first or second turret
	jr z, second_erase
		
		ld ix, #turret1
		jr continue_erasing

	second_erase:
		ld ix, #turret2

	continue_erasing:

	call utility_object_erase
ret

;;=========================================
;; Removes the turret
;; INPUT: 	A - turret to remove (0 or 1)
;; DESTROYS: AF, BC, DE, HL
;;=========================================
turret_remove::

	dec a ;;check if we try to add first or second turret
	jr z, second_remove
		
		ld ix, #turret1
		jr continue_removing

	second_remove:

		ld ix, #turret2

	continue_removing:

	ld a, obj_x(ix)
	cp #0xff 
	ret z			;;don't remove turret if its not set

	ld a, #0xff 
	ld obj_x(ix), a		;;erase and remove turret

	push ix
	call utility_object_erase2
	pop ix

	ld bc, #turr_bull
	add ix, bc
	call bullet_remove	;;removes turret bullet

ret 

;;=========================================
;; Add turret
;; Input: 	BC - pos x, pos y (in pixels)
;;		DE - bullet dir x,y
;;		A  - turret to add (0 or 1)
;; DESTROYS: AF, BC, DE, HL
;;=========================================
turret_add::

		dec a ;;check if we try to add first or second turret
		jr z, second_turret
		
			ld ix, #turret1
			jr continue_adding

		second_turret:

			ld ix, #turret2

		continue_adding:

		;;check if there is a turret set 
		ld a, obj_x(ix)	;;load turret value in a 
		cp #0xFF 	;;if x is negative, turret is not set 
		ret nz		;;if turret is set, don't change

		;;save position
		ld obj_x(ix), b 	;;store x 
		ld obj_y(ix), c 	;;store y 

		ld turr_bull+bul_dx(ix), d	;;store dir x
		ld turr_bull+bul_dy(ix), e	;;store dir y

		call utility_update_tiles	;;update turret tiles (to erase)

		call utility_initializePosition	;;update x,y initial position

ret

;;=========================================
;; Returns the turret in IX
;;=========================================
turret_getTurret1::

	ld ix, #turret1

ret

;;=========================================
;; Returns the bullet in IY
;;=========================================
turret_getBullet1::

	ld iy, #turret1_bullet

ret

;;=========================================
;; Returns the turret in IX
;;=========================================
turret_getTurret2::

	ld ix, #turret2

ret

;;=========================================
;; Returns the bullet in IY
;;=========================================
turret_getBullet2::

	ld iy, #turret2_bullet

ret

;;=========================================
;;=========================================
;; PRIVATE FUNCTIONS
;;=========================================
;;=========================================

;;=========================================
;; Adds a new bullet to the turret
;; INPUT: IX
;; DESTROYS: AF, BC, DE, HL
;;=========================================
turret_add_bullet:

	ld a, obj_x(ix)		;;player start x
	add obj_ww(ix)		;;bullet start x
	ld b, a 

	ld a, obj_y(ix)		;;player start y
	add obj_wh(ix)		;;bullet start y  	
	ld c, a

	ld hl, #0x0502		;;bullet size 

	ld de, #turr_bull
	add ix, de

	ld d, bul_dx(ix)	;;bullet dir x
	ld e, bul_dy(ix)	;;bullet dir y

	call bullet_add		;;add a bullet

	ld de, #0x0660
	dec a
	call z, utility_shot_sound 	;;shoot sound to be played
ret

;;=========================================
;; Draws a single turret
;; INPUT: IX - Turret to be drawn
;; DESTROYS: AF; BC; HL
;;=========================================
turret_single_draw:

	;;check if turret is set
	ld a, obj_x(ix)
	cp #0xff ;;see if it's not set
	ret z ;;if not set, end drawing

	push ix 

	ld bc, #turr_bull		;;draw bullet first
	add ix, bc 			;;jump to bullet ptr in ix
	ld b, #0x0c			;;bullet color (blue)
	call bullet_draw		;;draw our bullet

	pop ix

	ld a, turr_bull+bul_dx(ix)
	cp #00
	jp p, face_right
		;;if we are facing left
		ld bc, #_sprite_turret_0
		jr continue_draw

	face_right:
	 	ld bc, #_sprite_turret_1

	continue_draw:

	call utility_object_draw_masked	;;draw our player

ret

;;=========================================
;; Updates the turret
;; INPUT: IX - Ptr to the turret
;; DESTROYS: AF; BC; DE; HL
;;=========================================
turret_single_update:

	;;check if turret is set
	ld a, obj_x(ix)
	cp #0xff ;;see if it's not set
	ret z ;;if not set, end drawing

	call utility_updatePosition ;;updates old object positions

	ld a, turr_bull+bul_bt(ix)	;;load bullet time
	cp #0x00		;;since last shoot
	jr nz, continue_update	;;if timer is set to 0, then we continue

		;;if we are not shooting
		push ix
		ld de, #0xFEFE		;;bullet direction
		call turret_add_bullet
		pop ix

		ld a, #20		;;time to reset
		ld turr_bull+bul_bt(ix), a

	continue_update:

	ld bc, #turr_bull
	add ix, bc		;;go to bullet ptr
	call bullet_erase	;;erase bullet

	call bullet_update	;;update bullet position

	call bullet_dec_time	;;check that at least 25 frames happened

ret

;;=========================================
;; Erases the turret
;; IX - Ptr to turret
;; DESTROYS: AF, BC, DE, HL AF’, BC’, DE’, HL’
;;=========================================
turret_single_erase:

	;;check if turret is set
	ld a, obj_x(ix)
	cp #0xff ;;see if it's not set
	ret z ;;if not set, end drawing

	call utility_object_erase	;;erases the turret space

	ld bc, #turr_bull
	add ix, bc		;;go to bullet ptr
	call bullet_erase	;;erases turret bullet
ret

deallocateMemory