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
;; FUNCTIONS RELATED WITH MINI BOSS MANAGEMENT
;;=================================================
.area _CODE

;;=========================================
;; INCLUDE AREA
;;=========================================
.include "includes.h.s"		;;file containing cpct includes
.include "bullets.h.s"
.include "utility.h.s"

.globl _intro
.globl _song

;;=========================================
;;=========================================
;; PRIVATE DATA
;;=========================================
;;=========================================
allocateMemory 0x32D4

;;define bullets
defineBullet miniboss1, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
defineBullet miniboss2, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
defineBullet miniboss3, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF

miniboss_active: .db #00	;;if boss is active or not
miniboss_bullets:.dw #0xFFFF	;;instructions for boss bullets

bug_count: .db #0x0A	;;time between one bug and another

;;=========================================
;;=========================================
;; PUBLIC FUNCTIONS
;;=========================================
;;=========================================

;;=========================================
;; Returns bullet 1 in IY
;; DESTROYS: IY
;;=========================================
miniboss_getBullet1::
	ld iy, #miniboss1_bullet
ret

;;=========================================
;; Returns bullet 2 in IY
;; DESTROYS: IY
;;=========================================
miniboss_getBullet2::
	ld iy, #miniboss2_bullet
ret

;;=========================================
;; Returns bullet 3 in IY
;; DESTROYS: IY
;;=========================================
miniboss_getBullet3::
	ld iy, #miniboss3_bullet
ret

;;=========================================
;; Returns if boss is active in A
;; DESTROYS: A
;;=========================================
miniboss_isActive::
	ld a, (miniboss_active)
ret 

;;=========================================
;; Adds a boss
;; INPUT: HL - ptr to the array of boss bullets 
;; DESTROYS: A
;;=========================================
miniboss_add::
	ld a, h 
	ld (miniboss_bullets+1), a 
	ld a, l 
	ld (miniboss_bullets), a 	;;set start of the array of bullets 

	ld a, #01
	ld (miniboss_active), a		;;set boss to active state 

	call cpct_akp_stop_asm

	ld de, #_intro
	call cpct_akp_musicInit_asm

ret

;;=========================================
;; Removes a boss
;; DESTROYS: A
;;=========================================
miniboss_remove::
	ld a, #0
	ld (miniboss_active), a

	ld ix, #miniboss1_bullet
	call bullet_remove
	ld ix, #miniboss2_bullet
	call bullet_remove
	ld ix, #miniboss3_bullet
	call bullet_remove

	call cpct_akp_stop_asm

	ld de, #_song
	call cpct_akp_musicInit_asm

	;ld hl, #0xC000
	;ld de, #0x8000
	;ld bc, #0x4000
	;ldir
ret

;;=========================================
;; Draws the 3 bullets of a boss
;; DESTROYS: Almost everything
;;=========================================
miniboss_draw::

	ld a, (miniboss_active)
	dec a 
	ret nz 			;;don't update if miniboss is not active

	ld ix, #miniboss1_bullet
	ld b, #0x01 
	var: ld c, #0x00
	call utility_object_draw
	ld a, (var+1)
	inc a 
	ld (var+1), a
;
	ld ix, #miniboss2_bullet
	ld b, #0x00 
	var1: ld c, #0x00
	call utility_object_draw
	ld a, (var1+1)
	inc a 
	ld (var1+1), a
;
	ld ix, #miniboss3_bullet
	ld b, #0x04 
	var2: ld c, #0x00
	call utility_object_draw
	ld a, (var2+1)
	inc a 
	ld (var2+1), a

	;ld a, (bug_count)
	;dec a 
	;ld (bug_count), a 
	;ret nz ;;if not 0, end here 
;
	;ld a, #0x0A 
	;ld (bug_count), a ;;reset bug count
;
	;ld hl, #0x8002
	;ld de, #0x8000
	;ld bc, #0x3800
	;ldir
;
	;ld hl, #0x8000
	;ld de, #0xC000 
	;ld bc, #0x4000
	;ldir
ret

;;=========================================
;; Erases the 3 bullets of a boss
;; DESTROYS: Almost everything
;;=========================================
miniboss_erase::

	ld a, (miniboss_active)
	dec a 
	ret nz 			;;don't update if miniboss is not active

	ld ix, #miniboss1_bullet
	call bullet_erase

	ld ix, #miniboss2_bullet
	call bullet_erase

	ld ix, #miniboss3_bullet
	call bullet_erase

ret


;;=========================================
;; Updates the 3 bullets of the boss
;; DESTROYS: Almost everything
;;=========================================
miniboss_update::

	ld a, (miniboss_active)
	dec a 
	ret nz 			;;don't update if miniboss is not active

	ld iy, #miniboss1_bullet
	ld ix, #miniboss1_bullet
	call miniboss_bullet_update ;;add bullet 1

	ld ix, #miniboss1_bullet
	call bullet_update	;;update bullet 1

	ld iy, #miniboss2_bullet
	ld ix, #miniboss2_bullet
	call miniboss_bullet_update ;;add bullet 2

	ld ix, #miniboss2_bullet
	call bullet_update	;;update bullet 2

	ld iy, #miniboss3_bullet
	ld ix, #miniboss3_bullet
	call miniboss_bullet_update ;;add bullet 3

	ld ix, #miniboss3_bullet
	call bullet_update	;;update bullet 3

	ld a, (miniboss1_bullet)
	cp #0xff 
	ret nz 
	ld a, (miniboss2_bullet)
	cp #0xff 
	ret nz 
	ld a, (miniboss3_bullet)
	cp #0xff 
	ret nz 
	call miniboss_remove	;;if all bullets have disappeared, remove boss

ret
deallocateMemory
;;=========================================
;;=========================================
;; PRIVATE FUNCTIONS
;;=========================================
;;=========================================

;;=========================================
;; Updates a bullet
;; INPUT: IY - bullet to update
;;	  IX - bullet to update
;; DESTROYS: Almost everything
;;=========================================
miniboss_bullet_update: 

	ld a, (miniboss_active)
	dec a 
	ret nz 			;;don't update if miniboss is not active

	ld a, bul_x(iy)		;;load bullet x 
	cp #0xff 		;;if it's 0, add a new bullet 
	ret nz 			;;if not 0, bullet has been updated 

	ld hl, #0x1004			;;load bullet size
	ld iy, (miniboss_bullets)	;;load ptr to bullet data
	ld b, 0(iy)	;;load bullet_x

		;;check if we got to the end of the array 
		ld a, b 
		cp #0xff 
		ret z

	continue_adding:

	ld c, 1(iy)	;;load bullet_y
	ld d, 2(iy)	;;load bullet_dir_x
	ld e, 3(iy)	;;load bullet_dir_y

	call bullet_add

	;;increase current bullet in the array 
	ld_a_iyh
	ld h, a 
	ld_a_iyl
	ld l, a 
	ld bc, #0x0004
	add hl, bc 

	ld a, h
	ld (miniboss_bullets+1), a 
	ld a, l 
	ld (miniboss_bullets), a

ret