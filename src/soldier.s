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
;; FUNCTIONS RELATED WITH SOLDIER MOVEMENT AND ACTIONS
;;====================================================


;.area _CODE
;
;
;;;=========================================
;;;=========================================
;;; PRIVATE DATA
;;;=========================================
;;;=========================================
;
;.include "includes.h.s"		 ;;file containing cpct includes
;.include "bullets.h.s"
;.include "utility.h.s"		;;shared functions
;
;.globl _sprite_soldier_1
;
;move_cd: .db 25
;move_max: .db 05
;move_min: .db 00
;
;;;define soldier
;defineObject soldier, 0xFF, 0xFF, 5, 30, 0xFF, 0xFF, 2, 15, 0xFF, 0xFF, 0xFF, 0xFF
;;;define bullet
;defineBullet soldier, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0
;;;define soldier
;defineObject soldier2, 0xFF, 0xFF, 5, 30, 0xFF, 0xFF, 2, 15, 0xFF, 0xFF, 0xFF, 0xFF
;;;define bullet
;defineBullet soldier2, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0
;
;;;=========================================
;;;=========================================
;;; PUBLIC FUNCTIONS
;;;=========================================
;;;=========================================
;
;;;=========================================
;;; Draws the soldier
;;; DESTROYS: AF; BC; HL
;;;=========================================
;
;soldier_draw::
;	ld ix, #soldier
;	call soldier_single_draw
;	ld ix, #soldier_bullet
;	call soldier_bullet_draw
;
;	ld ix, #soldier2
;	call soldier_single_draw
;	ld ix, #soldier2_bullet
;	call soldier_bullet_draw
;
;ret
;
;;;=========================================
;;; Draws the soldier
;;; DESTROYS: AF; BC; HL
;;;=========================================
;
;soldier_single_draw:
;
;	ld bc, #_sprite_soldier_1
;	call utility_object_draw_masked	;;draw our soldier
;
;ret
;
;;;=========================================
;;; Draws the soldier bullet
;;; DESTROYS: AF; BC; HL
;;;=========================================
;
;soldier_bullet_draw:
;
;	ld b, #0x0c			        ;;bullet color (blue)
;	call bullet_draw		    ;;draw our bullet
;
;ret
;
;
;;;=========================================
;;; Removes the soldier
;;; DESTROYS: AF, BC, DE, HL
;;;=========================================
;soldier_remove::
;
;	ld ix, #soldier
;	call remove1
;
;	;;second soldier
;	ld ix, #soldier2
;	call remove1
;
;
;ret
;
;;;aux function for remove 
;remove1:
;	ld a, obj_x(ix)
;	cp #0xff 
;	ret z			;;don't remove turret if its not set
;
;	ld a, #0xff 
;	ld obj_x(ix), a		;;erase and remove turret
;
;	push ix
;	call utility_object_erase2
;	pop ix
;
;	ld bc, #turr_bull
;	add ix, bc
;	call bullet_remove	;;removes turret bullet
;ret 
;
;;;=========================================
;;; Remove the soldier
;;; Input 	A - soldier to be remove (0 or 1)
;;; DESTROYS: AF, BC, DE, HL
;;;=========================================
;soldier_single_remove::
;
;	dec a ;;check if we try to add first or second turret
;	jr z, second_remove
;		
;		ld ix, #soldier
;		jr continue_removing
;
;	second_remove:
;
;		ld ix, #soldier2
;
;	continue_removing:
;	call remove1
;
;ret
;
;
;;;=========================================
;;; Erases the soldier
;;; DESTROYS: AF, BC, DE, HL
;;;=========================================
;soldier_erase::
;
;	ld ix, #soldier
;	call utility_object_erase	;;erases the player space
;
;	;;second soldier
;	ld ix, #soldier2
;	call utility_object_erase	;;erases the player space
;
;ret
;
;;;=========================================
;;; Erase the soldier
;;; Input 	A - soldier to be remove (0 or 1)
;;; DESTROYS: AF, BC, DE, HL
;;;=========================================
;soldier_single_erase::
;
;	dec a ;;check if we try to add first or second turret
;	jr z, second_erase
;		
;		ld ix, #soldier
;		jr continue_erasing
;
;	second_erase:
;		ld ix, #soldier2
;
;	continue_erasing:
;
;		call utility_object_erase	;;erases the player space
;
;ret
;
;;;=========================================
;;; Returns the bullet in IX
;;;=========================================
;soldier_getSoldier::
;
;	ld ix, #soldier
;
;ret
;
;;;=========================================
;;; Returns the bullet in IY
;;;=========================================
;soldier_getBullet::
;
;	ld iy, #soldier_bullet
;
;ret
;
;
;;;=========================================
;;; Returns the bullet in IX
;;;=========================================
;soldier_getSoldier2::
;
;	ld ix, #soldier2
;
;ret
;
;;;=========================================
;;; Returns the bullet in IY
;;;=========================================
;soldier_getBullet2::
;
;	ld iy, #soldier2_bullet
;
;ret
;;;=========================================
;;; Updates the soldier
;;; Input 	IX - ptr to soldier
;;; DESTROYS: AF; BC; DE; HL
;;;=========================================
;
;soldier_single_update:
;
;	;check if soldier is set
;	ld a, obj_x(ix)
;	cp #0xff ;;see if it's not set
;	ret z ;;if not set, end drawing
;
;	call utility_updatePosition ;;updates old object positions
;
;	ld a, turr_bull+bul_bt(ix)	;;load bullet time
;	cp #0x00		;;since last shoot
;	jr nz, move	;;if timer is set to 0, then we continue
;
;		;;if we are not shooting
;		push ix
;		ld de, #0xFEFE		;;bullet direction
;		call soldier_add_bullet
;		pop ix
;
;		ld a, #50		;;time to reset
;		ld turr_bull+bul_bt(ix), a
;		jr continue_update
;
;		move:
;			;;Actualizamos cd de movimiento
;			ld a, (move_cd)
;			dec a
;			ld (move_cd), a
;			jr nz, continue_update
;
;			;;Case left	
;			ld a, (move_max)
;			cp #0x00
;			jr z, move_right
;			dec a
;			ld (move_max), a
;			jr z, initiate_right
;
;			ld a, obj_x(ix)
;			dec a
;			ld obj_x(ix), a
;			ld a, #25
;			ld (move_cd), a
;			jr continue_update
;
;			move_right:
;			ld a, (move_min)
;			cp #0x00
;			jr z, initiate_left
;			dec a
;			ld (move_min), a
;
;			ld a, obj_x(ix)
;			inc a
;			ld obj_x(ix), a
;			ld a, #25
;			ld (move_cd), a
;			jr continue_update
;
;			initiate_right:
;			ld a, #5
;			ld (move_max), a
;			jr continue_update
;
;			initiate_left:
;			ld a, #5
;			ld (move_min), a
;			jr continue_update
;
;
;
;	continue_update:
;
;	ld bc, #turr_bull
;	add ix, bc		;;go to bullet ptr
;	call bullet_erase	;;erase bullet
;
;	call bullet_update	;;update bullet position
;
;	call bullet_dec_time	;;check that at least 25 frames happened
;
;
;ret
;
;;;=========================================
;;; Updates the soldier
;;; DESTROYS: AF; BC; DE; HL
;;;=========================================
;
;soldier_update::
;
;	ld ix, #soldier
;	call soldier_single_update
;
;	ld ix, #soldier2
;	call soldier_single_update
;
;ret
;
;;;=========================================
;;; Adds a new bullet to the soldier
;;; INPUT: IX
;;; DESTROYS: AF, BC, DE, HL
;;;=========================================
;
;soldier_add_bullet:
;
;	ld a, obj_x(ix)		;;player start x
;	add obj_ww(ix)		;;bullet start x
;	ld b, a 
;
;	ld a, obj_y(ix)		;;player start y
;	add obj_wh(ix)		;;bullet start y  	
;	ld c, a
;
;	ld hl, #0x0502		;;bullet size 
;
;	ld de, #turr_bull
;	add ix, de
;
;	ld d, bul_dx(ix)	;;bullet dir x
;	ld e, bul_dy(ix)	;;bullet dir y
;
;	call bullet_add		;;add a bullet
;
;	ld de, #0x0015
;	dec a
;	call z, utility_shot_sound 	;;shoot sound to be played
;ret
;
;;;=========================================
;;; Add soldier
;;; Input: 	BC - pos x, pos y (in pixels)
;;;          DE - Dir x, y of the bullet
;;; DESTROYS: AF, BC, DE, HL
;;;=========================================
;
;
;soldier_add::
;
;		call soldier_check_add
;
;		;;check if there is a soldier set 
;		ld a, obj_x(ix)	;;load turret value in a 
;		cp #0xFF 	;;if x is negative, turret is not set 
;		ret nz		;;if turret is set, don't change
;
;		;;save position
;		ld obj_x(ix), b 	;;store x 
;		ld obj_y(ix), c 	;;store y 
;
;		ld turr_bull+bul_dx(ix), d	;;store dir x
;		ld turr_bull+bul_dy(ix), e	;;store dir y
;
;		call utility_update_tiles	;;update turret tiles (to erase)
;		call utility_initializePosition	;;update x,y initial position
;ret
;
;
;
;;;=========================================
;;; Check first to add
;;; DESTROYS: 
;;;=========================================
;soldier_check_add:
;
;	ld ix, #soldier
;	
;	;;check if there is a obstacle set 
;	ld a, obj_x(ix)	;;load obstacle value in a 
;	cp #0xFF 	;;if x is negative, obstacle is not set 
;	jr nz, other		;;if obstacle is set, don't change
;
;	ret
;
;	other:
;
;		ld ix, #soldier2
;			
;ret