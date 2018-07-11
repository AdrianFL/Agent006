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

;;=================================================
;; FUNCTIONS RELATED WITH BULLET MANAGEMENT
;;=================================================
.area _CODE

;;=========================================
;; INCLUDE AREA
;;=========================================
.include "includes.h.s"		;;file containing cpct includes
.include "environment.h.s"
.include "utility.h.s"
.include "doublebuffer.h.s" 

;;=========================================
;;=========================================
;; PRIVATE DATA
;;=========================================
;;=========================================

;;BULLET FORMAT
;;	position x
;;	position y
;;	size x
;;	size y
;;	tile x
;;	tile y
;;	direction x
;;	direction y
				

;;=========================================
;;=========================================
;; PUBLIC FUNCTIONS
;;=========================================
;;=========================================

;;=========================================
;; Add bullet
;; Input: 	HL - Size of the bullet we want to add (x,y)
;;		IX - Ptr to bullet start
;; 		BC - Position of the bullet we want to add (x,y)
;;		DE - Direction / Velocity of the bullet we want to add
;; DESTROYS: AF, BC, DE, HL
;; OUTPUT - A (0 if not added, 1 if added)
;;=========================================
bullet_add::

		;;check if there is a bullet set 
		ld a, bul_x(ix)	;;load bullet value in a 
		cp #0xFF 	;;if x is negative, bullet is not set 
		ld a, #0
		ret nz		;;if bullet is set, don't change

		;;save data 
		ld bul_x(ix), b 	;;store x 
		ld bul_y(ix), c 	;;store y 

		ld bul_h(ix), h	;;size x
		ld bul_w(ix), l	;;size y 

		ld bul_dx(ix), d 	;;store x direction
		ld bul_dy(ix), e 	;;store y direction

		call utility_update_tiles

		call utility_initializePosition	;;update x,y initial position

		ld a, #1

ret

;;=========================================
;; Draws the bullets
;; INPUT: IX - Ptr to bullet array
;;	  B  - Bullet color
;; DESTROYS: AF; BC; HL; DE
;;=========================================
bullet_draw::
		;;check if bullet is set
		ld a, bul_x(ix)
		cp #0xff	;;see if it's not set
		ret z ;;if not set, end drawing

		;;if bullet is set
		push bc ;;store bullet color in stack

		;;Calculate screen position
		call db_getVideoPtr
		ex de, hl		;;save returned value in de
		ld c, bul_x(ix)		;;| C=bullet_x
		ld b, bul_y(ix)		;;| B=bullet_y

		call cpct_getScreenPtr_asm ;;Get pointer to screen
		ex de, hl		;;return value in hl

		;;Draw a bullet 
		pop af		;;retrieve bullet color
		ld c, bul_w(ix)		;;size x
		ld b, bul_h(ix) 	;;size y
		call cpct_drawSolidBox_asm
ret

;;=========================================
;; Updates the bullets
;; INPUT: IX - Ptr to bullet array
;; DESTROYS: AF; HL; DE; BC
;;=========================================
bullet_update::

		;;check if bullet is set
		ld a, bul_x(ix)
		cp #0xff	;;see if it's not set
		ret z		 ;;if not set, end updating

		call utility_updatePosition ;;updates old object positions

		call check_limits	;;check the bullet is inside the limits
		cp #00
		ret z			;;if output is 0, don't update

		;;if bullet is set
		ld a, bul_x(ix)	;;load bullet in a
		add bul_dx(ix)	;;bullet_x + bullet_dir_x
		ld bul_x(ix),a 	;;save in bullet_x

		ld a, bul_y(ix)	;;load bullet in a
		add bul_dy(ix)	;;bullet_y + bullet_dir_y
		ld bul_y(ix),a 	;;save in bullet_y

		call utility_update_tiles	;;update bullet tiles
ret

;;=========================================
;; Erases the bullet
;; INPUT: IX - bullet ptr
;; DESTROYS: AF, BC, DE, HL AF’, BC’, DE’, HL’
;;=========================================
bullet_erase::

	call utility_object_erase

ret


;;=========================================
;; Removes the bullet
;; INPUT: IX - prt to bullet
;; DESTROYS: AF, BC, DE, HL AF’, BC’, DE’, HL’
;;=========================================
bullet_remove::
	ld a, bul_x(ix)
	cp #0xff	;;see if it's not set
	ret z		 ;;if not set, end removing

	call utility_object_erase3	;;remover bullet in both buffers

	ld a, #0xff 	;;load reset value 
	ld obj_x(ix), a 	;;remove the bullet

	call utility_object_erase2
ret

;;=========================================
;; Checks time since last shoot
;; INPUT: IX - Ptr to bullet
;; Output - A
;;=========================================
bullet_check_time::
	ld	a, bul_bt(ix)
ret

;;=========================================
;; Sets the counter to its original value
;; INPUT: IX - Ptr to bullet
;; 	  A  - Time to reset
;; DESTROYS: A
;;=========================================
bullet_reset_time::

	ld 	bul_bt(ix), a ;;save new time in its position

ret

;;=========================================
;; Decreases by 1 bullet time
;; INPUT: IX - Ptr to bullet
;; Output - A
;;=========================================
bullet_dec_time::
	ld	a, bul_bt(ix)
	cp 	#00
	jr	z, bullet_time_end	;;if time is already 0, don't change

	dec 	a
	ld 	bul_bt(ix),    a

	bullet_time_end:
ret

;;=========================================
;;=========================================
;; PRIVATE FUNCTIONS
;;=========================================
;;=========================================

;;==================================================
;; Check limits and destroy bullet if out of screen
;; INPUT: IX - Ptr to bullet array
;; OUTPUT: A - 0 if out of limit, 1 if not
;; MODIFIES: Bullet position
;; DESTROYS: AF; IX;
;;==================================================
check_limits:

	ld a, bul_x(ix)	;;load x in a 
	cp #07	;;left limit (if x-8 < 0)
	jp m, limits	
	cp #-57	;;right limit (if x+57 > 128)
	jp m, limits 

	ld a, bul_y(ix)	;;load y in a 
	srl a		;;lower limit / 2
	cp #0x0D		;;upper limit (if y/2-13 < 0)
	jp m, limits
	cp #-42 	;;lower limit (if y/2 + 42 > 128)
	jp m, limits
;
	;;if it doesn't limit 
	ld  a, #0x01 	;;output 1
	ret 

	;;if it limits in any axis
	limits:
		call bullet_remove
		ld a, #0x00 	;;output 0

		ret
ret