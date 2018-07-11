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
;; FUNCTIONS RELATED WITH PLATFORMS
;;====================================================

;;====================================================
;; INCLUDE AREA
;;====================================================

.include "utility.h.s"
.include "includes.h.s"


.globl _sprite_turret_0
.globl _sprite_turret_1

;;=========================================
;;=========================================
;; PRIVATE DATA
;;=========================================
;;=========================================


;;define platform
defineObject platform, 0xFF, 0xFF, 08, 2, 0xFF, 0xFF, 0, 0, 0xFF, 0xFF, 0xFF, 0xFF

;;define platform2
defineObject platform2, 0xFF, 0xFF, 08, 2, 0xFF, 0xFF, 0, 0, 0xFF, 0xFF, 0xFF, 0xFF

;;define platform3
defineObject platform3, 0xFF, 0xFF, 08, 2, 0xFF, 0xFF, 0, 0, 0xFF, 0xFF, 0xFF, 0xFF

;;define platform4
defineObject platform4, 0xFF, 0xFF, 08, 2, 0xFF, 0xFF, 0, 0, 0xFF, 0xFF, 0xFF, 0xFF

;;define platform5
defineObject platform5, 0xFF, 0xFF, 08, 2, 0xFF, 0xFF, 0, 0, 0xFF, 0xFF, 0xFF, 0xFF

platform_type: .db #0
plat_coll: .db #0x00

;; Type 0 - Beach
;; Type 1 - Jungle
;; Type 2 - Tron :)

;;=========================================
;;=========================================
;; PUBLIC FUNCTIONS
;;=========================================
;;=========================================

;;=========================================
;; Draws the platforms
;; DESTROYS: AF; BC; HL
;;=========================================
platform_draw::

	ld ix, #platform	
	call platform_single_draw
	ld ix, #platform2	
	call platform_single_draw
	ld ix, #platform3	
	call platform_single_draw
	ld ix, #platform4	
	call platform_single_draw
	ld ix, #platform5	
	call platform_single_draw

ret

;;=========================================
;; Updates the platform
;; DESTROYS: AF; BC; DE; HL
;;=========================================
platform_update::

	ld ix, #platform	
	call platform_single_update
	ld ix, #platform2	
	call platform_single_update
	ld ix, #platform3	
	call platform_single_update
	ld ix, #platform4	
	call platform_single_update
	ld ix, #platform5	
	call platform_single_update

ret

;;=========================================
;; Draws the platform
;; DESTROYS: AF; BC; HL
;;=========================================

platform_single_draw:

	;check if platform is set
	ld a, obj_x(ix)
	cp #0xff ;;see if it's not set
	ret z ;;if not set, end drawing

	ld a, (platform_type)
	cp #0
	jr nz, jungle

		ld bc, #0x0f7f
		call draw_platform		;;draw our platform
		ret

	jungle:
		ld a, (platform_type)
		cp #1
		jr nz, tron

			ld bc, #0x3C89
			call draw_platform 		;;draw our platform
			ret

		tron:
			ld bc, #0x0ff0
			call draw_platform		;;draw our platform
ret


;;=========================================
;; Updates the platform
;; DESTROYS: AF; BC; DE; HL
;;=========================================
platform_single_update:

	;;check if platform is set
	ld a, obj_x(ix)
	cp #0xff ;;see if it's not set
	ret z ;;if not set, end drawing

	call utility_updatePosition ;;updates old object positions

	call utility_update_tiles	;;update bullet tiles


ret

;;=========================================
;; Erases the platform
;; DESTROYS: AF, BC, DE, HL AF’, BC’, DE’, HL’
;;=========================================
platform_erase::

	ld ix, #platform

	call utility_object_erase	;;erases the platform space

	;;second platform
	ld ix, #platform2

	call utility_object_erase	;;erases the platform space

	;;third platform
	ld ix, #platform3
	
	call utility_object_erase	;;erases the platform space

	;;fourth platform
	ld ix, #platform4
	
	call utility_object_erase	;;erases the platform space

	;;fifth platform
	ld ix, #platform5
	
	call utility_object_erase	;;erases the platform space
ret

;;=========================================
;; Removes the platform
;; DESTROYS: AF, BC, DE, HL
;;=========================================
platform_remove::

	
	ld ix, #platform 
	call remove1

	;;second platform
	ld ix, #platform2 
	call remove1

	;third platform
	ld ix, #platform3 
	call remove1

	;fourth platform
	ld ix, #platform4 
	call remove1

	;fifth platform
	ld ix, #platform5 
	call remove1

ret 

;;aux Function
remove1:

	ld a, obj_x(ix)
	cp #0xff 
	ret z		;;don't remove if its not set
	
	ld a, #0xff 
	ld obj_x(ix), a
 
	call utility_object_erase	;;erases the platform space
	call utility_object_erase2	;;erases the platform space

ret

;;=========================================
;; Add platform
;; Input: 	BC - pos x, pos y (in pixels)
;; 			 A - type of platform
;; DESTROYS: AF, BC, DE, HL
;;=========================================
platform_add::

		push hl
		ld h, a
		call platform_check_add
		ld a, h
		ld (platform_type), a
		pop hl
		
		;;check if there is a platform set 
		ld a, obj_x(ix)	;;load platform value in a 
		cp #0xFF 	;;if x is negative, platform is not set 
		ret nz		;;if platform is set, don't change

		;;save position
		ld obj_x(ix), b 	;;store x 
		ld obj_y(ix), c 	;;store y 

		call utility_update_tiles	;;update platform tiles (to erase)
		;call utility_initializePosition	;;update x,y initial position


ret

;;=========================================
;; Check first to add
;; DESTROYS: 
;;=========================================
platform_check_add:

		ld ix, #platform
		
		;;check if there is a platform set 
		ld a, obj_x(ix)	;;load platform value in a 
		cp #0xFF 	;;if x is negative, platform is not set 
		jr nz, other		;;if platform is set, don't change

		ret

		other:
			ld ix, #platform2
			
			;;check if there is a platform set 
			ld a, obj_x(ix)	;;load platform value in a 
			cp #0xFF 	;;if x is negative, platform is not set 
			jr nz, other2		;;if platform is set, don't change

			ret

		other2:
			ld ix, #platform3

			;;check if there is a platform set 
			ld a, obj_x(ix)	;;load platform value in a 
			cp #0xFF 	;;if x is negative, platform is not set 
			jr nz, other3		;;if platform is set, don't change

			ret

			other3:
				ld ix, #platform4

				;;check if there is a platform set 
				ld a, obj_x(ix)	;;load platform value in a 
				cp #0xFF 	;;if x is negative, platform is not set 
				jr nz, other4		;;if platform is set, don't change

				ret

				other4:
					ld ix, #platform5
ret

;;=========================================
;; Returns the platform in HL
;;=========================================
platform_getPlatform::

	ld iy, #platform

ret

;;=========================================
;; Returns the platform in HL
;;=========================================
platform_getPlatform2::

	ld iy, #platform2

ret

;;=========================================
;; Returns the platform in HL
;;=========================================
platform_getPlatform3::

	ld iy, #platform3

ret

;;=========================================
;; Returns the platform in HL
;;=========================================
platform_getPlatform4::

	ld iy, #platform4

ret

;;=========================================
;; Returns the platform in HL
;;=========================================
platform_getPlatform5::

	ld iy, #platform5

ret

;;=========================================
;; Set if player has collision with the platform in H
;;=========================================
platform_setPlat_Coll::

	ld a, h
	ld (plat_coll), a

ret

;;=========================================
;; Get if player has collision with the platform in A
;;=========================================
platform_getPlat_Coll::

	ld a, (plat_coll)

ret


;;========================================
;;Function for drawing platforms
;;INPUT: BC - Two colors to be drawn
;;========================================
draw_platform:

	push bc 

	call utility_screenPtr
	ex de, hl

	ld bc, #0x2000
	add hl, bc	;;skip four pixels 

	pop bc 
	ld a, b
	push bc 	;;get colour 1
;
	ld_iyL_nn
	.db #0x04 	;;draw first 4 lines 
;
	call draw_lines ;;draw first 4 lines

	ld bc, #0xC050
	add hl, bc

	pop bc 
	ld a, c 

	ld_iyL_nn
	.db #0x08 

	call draw_lines 
ret

;;draws a line using the given colour in a and dir in hl 
draw_line:
	ld bc, #0x0007
	ld (hl), a ;;(hl) is our given colour
	ld d, h
	ld e, l 
	inc de 	;;de is hl+1
	ldir

	ld bc, #0x07F9
	add hl, bc
ret

;;draws multiple lines, in iyl
draw_lines:
	call draw_line 
	dec_iyl
	jr nz, draw_lines 
ret
