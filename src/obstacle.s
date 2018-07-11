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
;; FUNCTIONS RELATED WITH OBSTACLE
;;====================================================

.area _CODE

;;=========================================
;; INCLUDE AREA
;;=========================================


.include "includes.h.s"		 ;;file containing cpct includes
.include "utility.h.s"		;;shared functions
.include "bullets.h.s"	
.include "player.h.s"	

.globl _sprite_obstacle_0
.globl _sprite_soldier_1
.globl _sprite_soldier_0


;;=========================================
;;=========================================
;; PRIVATE DATA
;;=========================================
;;=========================================
;;OBSTACLE DATA

;;define obstacle
defineObstacle obs, 0xFF, 0xFF,  5, 20, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0
;;define bullet
defineBullet obs, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0, 0, 0xFF, 0xFF, 0xFF, 0xFF, 0

;;define obstacle2
defineObstacle obs2, 0xFF, 0xFF,  5, 20, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0
;;define bullet
defineBullet obs2, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0, 0, 0xFF, 0xFF, 0xFF, 0xFF, 0

;;define obstacle3
defineObstacle obs3, 0xFF, 0xFF,  5, 20, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0
;;define bullet
defineBullet obs3, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0, 0, 0xFF, 0xFF, 0xFF, 0xFF, 0

;;define animation
defineAnimation obstacle, 0x0064, _sprite_obstacle_0, _sprite_obstacle_0, 2, 0, 20, 20, 0

weapon_w: .db 0 	;;weapon width position
weapon_h: .db 5 	;;weapon height position
move_cd: .db #25


;;type 0 is a drop obstacle	
;;type 1 is a moving object with loop
;;type 2 is a drop obstacle with loop
;;type 3 soldier
;;type 4 is a drop obstacle with loop and shoot
;;type 5 is a drop obstacle	with shoot

;;=========================================
;;=========================================
;; PUBLIC FUNCTIONS
;;=========================================
;;=========================================

;;=========================================
;; Draws the obstacle
;; DESTROYS: AF; BC; HL
;;=========================================
obstacle_draw::

	ld ix, #obs
	call obstacle_single_draw
	ld ix, #obs_bullet
	call obstacle_bullet_draw

	ld ix, #obs2
	call obstacle_single_draw
	ld ix, #obs2_bullet
	call obstacle_bullet_draw

	ld ix, #obs3
	call obstacle_single_draw
	ld ix, #obs3_bullet
	call obstacle_bullet_draw


ret

;;=========================================
;; Draws the obstacle
;; INPUT: 	IX - ptr to obstacle
;; DESTROYS: AF; BC; HL
;;=========================================
obstacle_single_draw:

	;;check if obstacle is set
	ld a, obs_x(ix)
	cp #0xFF ;;see if it's not set
	ret z ;;if not set, end drawing

	ld a, obs_tp(ix)
	cp #3
	jr nz, continue_drawing

		ld a, obs_dr(ix)
		dec a
		ld bc, #_sprite_soldier_0
		jr z, draw

		ld bc, #_sprite_soldier_1	
		jr draw

	continue_drawing:
	ld iy, #obstacle_animation
	call utility_advanceAnimation

	draw:
	call utility_object_draw_masked	;;draw our obstacle


ret

;;=========================================
;; Draws the obstacle bullet
;; DESTROYS: AF; BC; HL
;;=========================================

obstacle_bullet_draw:

	ld b, #0x0c			        ;;bullet color (blue)
	call bullet_draw		    ;;draw our bullet

ret

;;=========================================
;; Updates the obstacle
;; Input: 	IX - ptr to obstacle
;; DESTROYS: AF; BC; DE; HL
;;=========================================
obstacle_update::

	ld ix, #obs
	call obstacle_single_update

	ld ix, #obs2
	call obstacle_single_update

	ld ix, #obs3
	call obstacle_single_update
	
ret

;;=========================================
;; Updates the obstacle
;; Input: 	IX - ptr to obstacle
;; DESTROYS: AF; BC; DE; HL
;;=========================================
obstacle_single_update:

		call utility_updatePosition_obstacle
		;;check if obstacle is set
		ld a, obs_x(ix)
		cp #0xFF
		ret z 				;; if not set, end drawing

		;;check if is at the limit 
		call check_limits
		cp #00
		jr z, change_obs		;; if is at the limit, call reset position to do the loop

		;; check type 0 or 1-2 and update actual position
		ld a, obs_tp(ix)
		cp #0
		jr z, type0

		ld a, obs_tp(ix)
		cp #5
		jr z, type0

			;; check type 1-2 or 3-4
			ld a, obs_tp(ix)
			cp #1
			jr z, moving

				ld a, obs_tp(ix)
				cp #2
				jr z, moving

				push ix
				call obstacle_update_bullet
				pop ix

			moving:
				call obstacle_move_loop
			
			ret


		type0:
			ld a, obs_ini(ix)
			add obs_p(ix)
			sub obs_y(ix)
			cp #0
			jr z, reset

				ld a, obs_y(ix)
				inc a
				ld obs_y(ix), a 	;; move one position 

				ld a, obs_tp(ix)
				cp #5
				jr nz, continue_type0

					push ix
					call obstacle_update_bullet
					pop ix

				continue_type0:
				call utility_update_tiles_obs	;;update bullet tiles

				ret

		change_obs:
			;; check type 0 or 1-2 and update actual position
			ld a, obs_tp(ix)
			cp #0
			jr z, reset

			ld a, obs_tp(ix)
			cp #5
			jr z, reset


				ld a, obs_dr(ix)
				cp #0
				jr z, change_to_1

					ld a, #0
					ld obs_dr(ix), a
					call obstacle_move_loop

				change_to_1:
					ld a, #1
					ld obs_dr(ix), a
					call obstacle_move_loop

				ret

		reset:

			ld a, obs_tp(ix)
			cp #5
			jr nz, continue_type0_2

				push ix
				call obstacle_update_bullet
				pop ix

			continue_type0_2:
			call obstacle_reset
			call utility_update_tiles_obs	;;update bullet tiles

			ret

ret



;;=========================================
;; Update move obstacle 1 or 2 to do loop
;; Input: 	IX - ptr to obstacle
;; DESTROYS: AF; BC; DE; HL
;;=========================================
obstacle_move_loop:


	ld a, obs_tp(ix)
	cp #5
	ret z

	;; check type 1 or 2 and update actual position
	ld a, obs_tp(ix)
	cp #1
	jr z, type1

		;; check type 3 or 4 and update actual position
		ld a, obs_tp(ix)
		cp #3
		jr z, type1


		call obstacle_check_direction
		ld a, obs_dr(ix)
		cp #1
		jr z, other_dir

			ld a, obs_y(ix)
			inc a
			ld obs_y(ix), a
			call utility_update_tiles_obs	;;update bullet tiles

			ret

		other_dir:

			ld a, obs_y(ix)
			dec a
			ld obs_y(ix), a
			call utility_update_tiles_obs	;;update bullet tiles

			ret

	type1:

			call obstacle_check_direction

			ld a, obs_dr(ix)
			cp #1
			jr z, other_dir2

				ld a, (move_cd)
				dec a
				ld (move_cd), a 
				ret nz

					ld a, #25
					ld (move_cd), a

					ld a, obs_x(ix)
					dec a
					ld obs_x(ix), a
					call utility_update_tiles_obs	;;update bullet tiles

					ret

			other_dir2:

				ld a, (move_cd)
				dec a
				ld (move_cd), a 
				ret nz

					ld a, #25
					ld (move_cd), a

					ld a, obs_x(ix)
					inc a
					ld obs_x(ix), a
					call utility_update_tiles_obs	;;update bullet tiles

					ret

ret

;;=========================================
;; Update bullet
;; Input: 	IX - ptr to obstacle
;; DESTROYS: AF; BC; DE; HL
;;=========================================
obstacle_update_bullet:

	ld a, obs_bull+bul_bt(ix)	;;load bullet time
	cp #0x00		;;since last shoot
	jr nz, continue_updating	;;if timer is set to 0, then we continue

		;;if we are not shooting
		push ix
		ld de, #0xFEFE		;;bullet direction
		call obstacle_new_bullet
		pop ix

		ld a, #20		;;time to reset
		ld obs_bull+bul_bt(ix), a

		continue_updating:
			ld bc, #obs_bull
			add ix, bc		;;go to bullet ptr
			call bullet_erase	;;erase bullet

			call bullet_update	;;update bullet position

			call bullet_dec_time	;;check that at least 25 frames happened

ret


;;=========================================
;; Add obstacle
;; Input: 	BC - pos x, pos y (in pixels)
;;			 D - pixel init
;;			 E - movement in pixels
;; 			 A - obstacle (0, 1 or 2)
;; DESTROYS: AF, BC, DE, HL
;;=========================================
obstacle_add::

		cp #0
		jr nz, other_obstacle

			ld ix, #obs
			jr continue_add

		other_obstacle:
		cp #1
		jr nz, other_obstacle2

			ld ix, #obs2
			jr continue_add
			
		other_obstacle2:
		cp #2
		ret nz

			ld ix, #obs3
		
		continue_add:
		;;check if there is a obstacle set 
		ld a, obs_x(ix)	;;load obstacle value in a 
		cp #0xFF 	;;if x is negative, obstacle is not set 
		ret nz		;;if obstacle is set, don't change
		

		;;save position
		ld obs_x(ix), b 	;;store x 
		ld obs_y(ix), c 	;;store y 

		ld obs_x1(ix), b 	;;store x1 
		ld obs_y1(ix), c 	;;store y1 

		ld obs_x2(ix), b 	;;store x2 
		ld obs_y2(ix), c 	;;store y2 

		ld obs_ini(ix), d 	;;store init to reset position
		ld obs_p(ix), e 	;;store movement in pixels

		call utility_update_tiles_obs	;;update obstacle tiles (to erase)

ret

;;=========================================
;; Add obstacle
;; Input: 	
;;          DE - Dir x, y of the bullet
;; 			 A - obstacle (0, 1 or 2)
;; DESTROYS: AF, BC, DE, HL
;;=========================================
obstacle_add_bullet::

		cp #1
		jr nz, sec_obstacle	

			ld ix, #obs
			jr continue_adding

		sec_obstacle:
			cp #2
			jr nz, thi_obstacle

				ld ix, #obs2
				jr continue_adding

		thi_obstacle:	
			cp #3
			ret nz

				ld ix, #obs3


		continue_adding:

		ld obs_bull+bul_dx(ix), d	;;store dir x
		ld obs_bull+bul_dy(ix), e	;;store dir y

ret

;;=========================================
;; Adds a new bullet to the obstacle
;; INPUT: IX
;; DESTROYS: AF, BC, DE, HL
;;=========================================

obstacle_new_bullet:

	ld a, (weapon_w) 		;;player start x
	add obs_x(ix)		;;bullet start x
	ld b, a 

	ld a, (weapon_h)		;;player start y
	add obs_y(ix)		;;bullet start y  	
	ld c, a

	ld hl, #0x0502		;;bullet size 

	ld de, #obs_bull
	add ix, de

	ld d, bul_dx(ix)	;;bullet dir x
	ld e, bul_dy(ix)	;;bullet dir y

	call bullet_add		;;add a bullet

	ld de, #0x0015
	dec a
	call z, utility_shot_sound 	;;shoot sound to be played
ret


;;=========================================
;; Check direction
;; DESTROYS: 
;;=========================================
obstacle_check_direction:


	ld a, obs_tp(ix)
	cp #5
	ret z
		;; check type 1 or 2 and update actual position
		ld a, obs_tp(ix)
		cp #1
		jr z, type_1

			;; check type 3 or 4 and update actual position
			ld a, obs_tp(ix)
			cp #3
			jr z, type_1

				ld a, obs_dr(ix)
				cp #1
				jr z, change_direction

					ld a, obs_ini(ix)
					add obs_p(ix)
					sub obs_y(ix)
					cp #0
					jr z, change

						ret

					change:
						ld a, #1
						ld obs_dr(ix), a

						ret

				change_direction:
					ld a, obs_ini(ix)
					sub obs_y(ix)
					cp #0
					jr z, change2

						ret

					change2:
						ld a, #0
						ld obs_dr(ix), a

						ret

		type_1:

			call player_getPlayer_iy
			ld a, obs_x(ix)
			sub obj_x(iy)
			jp p, left_dir

				ld a, #1
				ld obs_dr(ix), a

					ld a, obs_bull+bul_x(ix)	
					cp #0xff		
					ret nz	

						ld obs_bull+bul_dx(ix), #0x01	;;store dir x
						ld obs_bull+bul_dy(ix), #0x00	;;store dir y
						ret

			left_dir:
				ld a, #0
				ld obs_dr(ix), a

					ld a, obs_bull+bul_x(ix)	
					cp #0xff		
					ret nz	

						ld obs_bull+bul_dx(ix), #0xFF	;;store dir x
						ld obs_bull+bul_dy(ix), #0x00	;;store dir y

ret


;;=========================================
;; ADD TYPE TO OBSTACLE
;; INPUT 		D - type (0, 1, 2, 3, 4, 5)
;; 				A - Obstacle (1, 2 or 3)
;; DESTROYS: 
;;=========================================
obstacle_add_type::

		cp #1
		jr nz, other_obstacle3

			ld ix, #obs
			jr continue_adding2

		other_obstacle3:
		cp #2
		jr nz, other_obstacle4

			ld ix, #obs2
			jr continue_adding2
			
		other_obstacle4:
		cp #3
		ret nz

			ld ix, #obs3
		
		continue_adding2:

		ld a, obj_x(ix)
		cp #0xFF
		ret z

		ld obs_tp(ix), d

		
ret

;;;=========================================
;;; Reset obstacle
;;; Input: 	IX - ptr to obstacle
;;; DESTROYS: AF, BC, DE, HL
;;;=========================================
obstacle_reset:
	;; check type and we reset
			ld a, obs_tp(ix)
			cp #0
			jr z, type_0
				ld a, obs_tp(ix)
				cp #5
				jr z, type_0

			ld a, obs_ini(ix)
			ld obs_x(ix), a

			type_0:

				ld a, obs_ini(ix)
				ld obs_y(ix), a
ret




;;==================================================
;; Check limits and reset obstacle if out of screen
;; INPUT: IX - Ptr to bullet array
;; OUTPUT: A - 0 if out of limit, 1 if not
;; MODIFIES: obstacle position
;; DESTROYS: AF; IX;
;;==================================================
check_limits:

	ld a, obs_x(ix)	;;load x in a 
	cp #04	;;left limit (if x-2 < 0)
	jp m, limits	
	cp #-55	;;right limit (if x+53 > 128)
	jp m, limits 

	ld a, obs_y(ix)	;;load y in a 
	srl a		;;lower limit / 2
	cp #0x0D		;;upper limit (if y/2-13 < 0)
	jp m, limits
	cp #-40 	;;lower limit (if y/2 + 31 > 128)
	jp m, limits

	;;if it doesn't limit 
	ld  a, #0x01 	;;output 1
	ret 

	;;if it limits in any axis
	limits:
		ld a, #0x00 	;;output 0

		ret
ret


;;=========================================
;; Erases the obstacle
;; INPUT 		A - Obstacle to erase (0,1 or 2)
;; DESTROYS: AF, BC, DE, HL AF’, BC’, DE’, HL’
;;=========================================
obstacle_erase::

	cp #0
	jr nz, second

	ld ix, #obs
	call utility_obstacle_erase	;;erases the obstacle space
	ret

	;;second obstacle
	second:

	cp #1
	jr nz, third
;
	ld ix, #obs2
	call utility_obstacle_erase	;;erases the obstacle space
	ret

	;;third obstacle
	third:

	cp #2
	ret nz
;
	ld ix, #obs3
	call utility_obstacle_erase	;;erases the obstacle space
ret

;;=========================================
;; Removes the obstacle
;; INPUT 		A - Obstacle to remove (0,1 or 2)
;; DESTROYS: AF, BC, DE, HL
;;=========================================
obstacle_remove::

	cp #0
	jr nz, second2
	
	ld ix, #obs 

	call remove1


	;;second obstacle
	second2:

	cp #1
	jr nz, third2

	ld ix, #obs2 

	call remove1


	;third obstacle
	third2:

	cp #2
	ret nz

	ld ix, #obs3 

	call remove1

ret 

;;aux function 
remove1:
	ld a, obj_x(ix)
	cp #0xff 
	ret z		;;don't remove if its not set

	push ix
	call utility_obstacle_erase	;;erases the obstacle space
	ld a, #0xff 
	ld obs_x(ix), a
	call utility_obstacle_erase2	;;erases the obstacle space
	pop ix

	ld bc, #obs_bull
	add ix, bc
	call bullet_remove	;;removes obstacle bullet
ret

;;=========================================
;; Erases the obstacle
;; DESTROYS: AF, BC, DE, HL AF’, BC’, DE’, HL’
;;=========================================
obstacle_erase_all::

	ld hl, #obs

	;;check if obstacle is set
	ld a, (hl)
	cp #0xff ;;see if it's not set
	jr z, second3 ;;if not set, end drawing

	ld ix, #obs
	call utility_obstacle_erase	;;erases the obstacle space

	;;second obstacle
	second3:

	ld hl, #obs2
;
	;;check if obstacle is set
	ld a, (hl)
	cp #0xff ;;see if it's not set
	jr z, third3 	;;if not set, end drawing
;
	ld ix, #obs2
	call utility_obstacle_erase	;;erases the obstacle space

	;;third obstacle
	third3:

	ld hl, #obs3
;
	;;check if obstacle is set
	ld a, (hl)
	cp #0xff ;;see if it's not set
	ret z ;;if not set, end drawing
;
	ld ix, #obs3
	call utility_obstacle_erase	;;erases the obstacle space
ret

;;=========================================
;; Returns the obstacle in IY
;;=========================================
obstacle_getObstacle::

	ld iy, #obs

ret

;;=========================================
;; Returns the obstacle in IY
;;=========================================
obstacle_getObstacle2::

	ld iy, #obs2

ret

;;=========================================
;; Returns the obstacle in IY
;;=========================================
obstacle_getObstacle3::

	ld iy, #obs3

ret

;;=========================================
;; Returns the obstacle in IY
;;=========================================
obstacle_getBullet::

	ld iy, #obs_bullet

ret

;;=========================================
;; Returns the obstacle in IY
;;=========================================
obstacle_getBullet2::

	ld iy, #obs2_bullet

ret

;;=========================================
;; Returns the obstacle in IY
;;=========================================
obstacle_getBullet3::

	ld iy, #obs3_bullet

ret



;;=========================================
;; Returns the obstacle in IX
;;=========================================
obstacle_getObstacle_ix::

	ld ix, #obs

ret

;;=========================================
;; Returns the obstacle in IX
;;=========================================
obstacle_getObstacle2_ix::

	ld ix, #obs2

ret

;;=========================================
;; Returns the obstacle in IX
;;=========================================
obstacle_getObstacle3_ix::

	ld ix, #obs3

ret
