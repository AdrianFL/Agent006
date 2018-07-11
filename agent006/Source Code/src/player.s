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
;; FUNCTIONS RELATED WITH PLAYER MOVEMENT AND ACTIONS
;;====================================================

.area _CODE

;;=========================================
;; INCLUDE AREA
;;=========================================

.include "includes.h.s"		 ;;file containing cpct includes
.include "environment.h.s"
.include "bullets.h.s"
.include "platform.h.s"
.include "utility.h.s"		;;shared functions
.include "collision.h.s"
.include "collectables.h.s"
.include "miniboss.h.s"

.globl _sprite_player_down_0
.globl _sprite_player_down_4
.globl _sprite_player_up_0
.globl _sprite_player_up_1
.globl _sprite_player_kneel_0
.globl _sprite_player_kneel_2

;;=========================================
;;=========================================
;; PRIVATE DATA
;;=========================================
;;=========================================

;;HERO DATA

;;define player
defineObject player, 20, 80, 5, 27, 10, 30, 2, 11, 20, 80, 20, 80
;;define bullet
defineBullet player, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 25
;;other data
player_jump:	.db #-1 	;;jump frame
player_colBox_x: .db #10
player_colBox_y: .db #137, #4, #5	;;player collision box of 8x5
player_dir: 	.db #1	;;direction of the player (1 right)
player_kneel: 	.db #0	;;if player is kneeling
player_kneel_advance: .db #0	;;control if player moves faster or not
w_released: 	.db #1	;;1 if w has been released
animation_pos: .db #1

player_aux_draw:  .db #00, #00, #5, #16 ;;additional bytes for drawing the player
player_aux_draw1: .db #00, #00, #5, #11 ;;additional bytes for drawing the player

power_up_time: .db #0xFF

music_muted: .db #1

player_coll: .db #0

player_notPlatform: .db #0

;;define animations
defineAnimation player_right, 0x0037, _sprite_player_down_0, _sprite_player_down_0, 4, 0, 8, 8, 0
defineAnimation player_left, 0x0037, _sprite_player_down_4, _sprite_player_down_4, 4, 0, 8, 8, 0
defineAnimation kneel_right, 0x004B, _sprite_player_kneel_0, _sprite_player_kneel_0, 2, 0, 10, 10, 0
defineAnimation kneel_left, 0x004B, _sprite_player_kneel_2, _sprite_player_kneel_2, 2, 0, 10, 10, 0

;;JUMP TABLE 
jumptable:
	.db #-7, #-6, #-6, #-5, #-3, #-2, #-1
	.db #00, #00
	.db #01, #02, #02, #03, #03, #04, #05, #04
	.db #0x80 ;;end of the jump table

jumptable1:	;;alternative jump table
	.db #-11, #-9, #-7, #-6, #-5, #-4, #-3
	.db #00, #00
	.db #02, #02, #03, #03, #04, #05, #05, #04
	.db #0x80 ;;end of the jump table

;;=========================================
;;=========================================
;; PUBLIC FUNCTIONS
;;=========================================
;;=========================================

;;=========================================
;; Draws the player
;; DESTROYS: AF; BC; HL
;;=========================================
player_draw::

	ld ix, #player_bullet		;;put player bullet ptr in hl
	ld b, #0xf0			;;bullet color (yellow)
	call bullet_draw		;;draw our bullet

	ld ix, #player		

	ld a, (player_dir) ;;check player direction
	dec a 
	jr z, go_right

		;;go_left
		ld iy, #player_left_animation
		call utility_advanceAnimation
		jr continue_draw_kneel

	go_right:
		;;ld a, (animation_pos) 	;;check if we need to change sprite
		;;cp #0
		;;jr nz, change_sprite

		;;change_sprite:
			ld iy, #player_right_animation
			call utility_advanceAnimation
			ld ix, #player

	continue_draw_kneel:
		ld a, (player_kneel) ;;check if player is kneeling
		dec a 
		jr nz, continue_draw ;;if not, draw normally
	
			;;kneeling left
			ld iy, #kneel_left_animation
			call utility_advanceAnimation
			
			ld a, (player_dir)
			dec a 
			jr nz, continue_draw_kneeling
	
				;;kneeling right
				ld iy, #kneel_right_animation
				call utility_advanceAnimation

			continue_draw_kneeling:

				call utility_object_draw_masked	;;draw our player
				ret

	continue_draw:

		;;draw second half of our player
		ld a, (player_x)
		ld (player_aux_draw1), a ;;x 
		ld a, (player_y)
		add #16
		ld (player_aux_draw1+1), a ;;y 

		ld ix, #player_aux_draw1
		call utility_object_draw_masked

		;first half of our player

		ld a, (player_dir) ;;check player direction
		dec a 
		jr z, draw_right_up

			;;draw left up 
			ld bc, #_sprite_player_up_1
			jr draw_left_up

		draw_right_up:

			ld bc, #_sprite_player_up_0

		draw_left_up:

		;;draw first half of our player
		ld a, (player_x)
		ld (player_aux_draw), a ;;x 
		ld a, (player_y)
		ld (player_aux_draw+1), a ;;y 

		ld ix, #player_aux_draw
		call utility_object_draw_masked

ret


;;=========================================
;; Updates the player
;; DESTROYS: AF; BC; DE; HL
;;=========================================
player_update::

	ld ix, #player

	call utility_updatePosition ;;updates old object positions

	call utility_update_tiles	;;update the tile numbers of the player
	call jumpControl 	;;Do jumps! :D
	call checkUserInput	;;check if user presses any key
	call update_playerColBox ;;update collision box position
	
	ld ix, #player_bullet
	call bullet_update	;;update bullet position

	call bullet_dec_time	;;check that at least 25 frames happened

	call powerup_update


ret

;;=========================================
;; Updates power up music
;; DESTROYS: AF; BC; DE; HL
;;=========================================
powerup_update:

	ld a, (power_up_time)
	add #0xFA
	ret c

	call cpct_akp_stop_asm
;
	ld de, #_song
	call cpct_akp_musicInit_asm
ret


;;=========================================
;; Erases the player
;; DESTROYS: AF, BC, DE, HL AF’, BC’, DE’, HL’
;;=========================================
player_erase::

	ld ix, #player
	call utility_player_erase	;;erases the player space

	ld ix, #player_bullet
	call bullet_erase	;;erases player bullet

ret

;;=========================================
;; Returns the player in HL
;;=========================================
player_getPlayer::

	ld ix, #player

ret

;;=========================================
;; Returns the player in HL
;;=========================================
player_getPlayer_iy::

	ld iy, #player

ret

;;=========================================
;; Returns the player collision box in IX
;;=========================================
player_getColBox::

	ld ix, #player_colBox_x

ret

;;=========================================
;; Returns the player in IY
;;=========================================
player_getBullet::

	ld iy, #player_bullet

ret

;;=========================================
;; Returns the player jump state in A
;;=========================================
player_getJump::

	ld a, (player_jump)

ret

;;=========================================
;; Returns the player Y in A
;;=========================================
player_getY::

	ld a, (player_y)

ret

;;=========================================
;; Returns the player direction
;; Flag 0 set if facing right
;;=========================================
player_getDir::

	ld a, (player_dir)
	dec a

ret

;;=========================================
;; Decreases player_y by given value
;; INPUT: B - value to add
;;=========================================
player_decreaseY::

	ld a, (player_y)
	add b 
	ld (player_y), a

ret

;;=========================================
;; Removes the player bullet
;;=========================================
player_removeBullet::

	ld ix, #player_bullet
	call bullet_remove

ret

;;=========================================
;; Resets the player position
;; DESTROYS: A
;;=========================================
player_resetPos::

	ld a, #20
	ld (player_x), a ;;reset x

	ld a, #60
	ld (player_y), a ;;reset y 

	call player_resetJump

ret

;;=========================================
;; Resets the player jump
;; DESTROYS: A
;;=========================================
player_resetJump::
	ld a, #-1
	ld (player_jump), a
ret

;;=========================================
;; Sets platfrom value
;; INPUT: A
;; DESTROYS: A
;;=========================================
player_setPlat::
	ld (player_notPlatform), a
ret



;;=========================================
;; Set if player has collision with map or platforms
;; INPUT: A - Collision (0x00 no collision, 0x01 collision)
;;=========================================
player_setColl::

	ld (player_coll), a

ret

;;=========================================
;; Set if player has collision with map or platforms
;; INPUT: A - Collision (0x00 no collision, 0x01 collision)
;;=========================================
player_getColl::

	ld a, (player_coll)

ret

;;=========================================
;;=========================================
;; PRIVATE FUNCTIONS
;;=========================================
;;=========================================

;;=========================================
;; Checks user input and reacts
;; DESTROYS: AF; BC; DE; HL
;;=========================================
checkUserInput:

	call get_pressedKeys1
	and #8
	jp nz, check_Space

	check_D:
	call get_pressedKeys0

	and #16
	jr	z, check_A		;;if not 0, update


		;;if player is keeling
		ld a, (player_kneel)
		dec a 	
		jr nz, regular_D 

			;;if we are keeling, we move slower
			ld a, (player_kneel_advance)
			xor #1				;;check if we move
			ld (player_kneel_advance), a
			ld a, (player_x)
			jr z, continue_D
				ld 	a, (player_x)	;;A=hero_x
				inc a 
				jr continue_D


		regular_D:
		;;D is pressed
		ld 	a, (player_x)	;;A=hero_x
		inc 	a		;;A++

		continue_D:

		call check_limits	;;we check if user reaches a limit

		ld 	a, #1
		ld 	(player_dir), a ;;update player direction


		;;ld a, #50 		;;time animation
		;;ld bc, #_sprite_player_1 			;; sprite to animation right movement of the player 
		;;call utility_createAnimation
		;;ld (animation_pos), a 		;;update animation position, 1 is one sprite, 0 other


		jr check_W	;;if we are moving right, don't go left

	check_A:
	call get_pressedKeys0
	and #64
	jr	z, check_W		;;if not 0, update

		;;if player is keeling
		ld a, (player_kneel)
		dec a 	
		jr nz, regular_A 

			;;if we are keeling, we move slower
			ld a, (player_kneel_advance)
			xor #1				;;check if we move
			ld (player_kneel_advance), a
			ld a, (player_x)
			jr z, continue_A

				ld 	a, (player_x)	;;A=hero_x
				dec a 
				jr continue_A

		regular_A:
		;;A is pressed
		ld 	a, (player_x)	;;A=hero_x
		dec 	a		;;A--

		continue_A:

		call check_limits	;;we check if user reaches a limit

		ld 	a, #0
		ld 	(player_dir), a ;;update player direction

	check_W:
	call get_pressedKeys0
	and #128
	jr	z, check_W_release	;;if not 0, update

		ld a, (player_coll)	;;check if we are in the air
		cp #0x00			;;if we do, we don't jump 
		jr z, check_S

		ld a, (player_kneel)	;;if we are keeling, we can't jump
		dec a 
		jr z, check_S

		ld a, (w_released)
		dec a 
		jr nz, check_S	;;continue is w has been released


		ld a, #0
		ld (w_released), a	;;w has been pressed

		;;W is pressed
		call startJump
		jr check_S

		;;if w is not pressed
		check_W_release:
			ld a, #1
			ld (w_released), a	;;w has been released

	check_S:
	call get_pressedKeys0
	and #32
	jr	z, check_S_release	;;if not 0, update

		ld a, (player_coll)	;;check if we are in the air
		cp #0x01			;;if we do, we don't jump 
		call nz, decrease_y
		ld a, (player_coll)	;;check if we are in the air
		cp #0x01			;;if we do, we don't jump 
		jr nz, check_Space

			ld a, (player_kneel)
			cp #00
			call z, kneel		;;if player is not keeling
						;;change its values 
			ld a, #1
			ld (player_kneel), a	;;player is kneeling
			jr check_Space

			;;if s is not pressed
			check_S_release:
				ld a, (player_kneel)
				cp #01
				call z, not_kneel	;;if player is keeling
							;;change its values 
				ld a, #0
				ld (player_kneel), a	;;player is not kneeling

	check_Space:
	call get_pressedKeys1
	and #128
	jr	z, check_Mute	;;if not 0, update

		call check_bullet	;;check if there's a bullet, 
					;,if not, set it

	check_Mute:
	call get_pressedKeys1
	and #4
	jr z, unpress_m

	ld a, (music_muted)
	dec a
	jr nz, check_end
	call change_musicStatus
	ld a, #0
	ld (music_muted), a
	jr check_end

	unpress_m:

	ld a, #1
	ld (music_muted), a

	check_end:

ret

;;short aux function 
decrease_y:
	ld a, (player_notPlatform)
	cp #01
	ret nz
	ld a, (player_y)		;;if player is too way down, reset game
	add #84				;;(255-160) 160=max_y
	call p, utility_resetGame
	ld a, (player_y)
	add #3
	ld (player_y), a
ret

;;=========================================
;; Controls jump movement
;;=========================================
jumpControl:

	ld a, (player_kneel)	;;if we are keeling, we can't jump
	dec a 
	jr z, reset_jump

	call platform_getPlat_Coll
	cp #0x01
	ld h, #0x00
	call platform_setPlat_Coll
	jr z, reset_jump

	;;Check if we are jumping
	ld 	a, (player_jump) 	;; A=hero jump status
	cp 	#-1			;; is A equal to -1
	ret 	z			;; makes ret if it was 0

	;;Get jump value from our data
	call 	power_up_longer_jump	;;get jump table
	ld 	a, (player_jump)
	ld 	c, a			;;
	ld 	b, #0			;; BC = A (offset)
	add 	hl, bc			;; HL += BC

	;;Do jump movement
	ld	a, (player_y)		;; A = hero_y
	add  	(hl) 			;; A += B (add jump movement)
	ld 	(player_y), a		;;update hero_y value

	;;increment hero_jump index
	inc 	hl			;;go to next position in jump table
	ld 	a, (hl)			;; a = jump movement
	cp	#0x80 			;;check if it is latest value
	jr	nz, continue_jump

		;;End jump if it's the last value
		ld 	a, #-1 		;;set to no jump status	
		ld 	(player_jump), a  ;;we reset the jump
		ret

	continue_jump:
	ld 	a, (player_jump)	
	inc 	a
	ld 	(player_jump), a		;; Hero_jump ++
	ret

	reset_jump:
	call get_pressedKeys0
	and #128
	jr z, w_was_released

	call get_pressedKeys0
	and #32
	jr nz, s_is_pressed

	ld a, (w_released)
	dec a 
	ret nz	;;continue is w has been released

	ld a, #00
	ld (player_jump), a

	w_was_released:
	ld a, #1
	ld (w_released), a	;;w has been released
	ret	

	s_is_pressed:
	ld a, #0 
	ld (w_released), a
ret

;;=========================================
;; Controls jump start
;;=========================================
startJump:
	ld	a, (player_jump) 	;; A=player_jump
	cp	#-1			;; A==-1? Is jump active?
	ret 	nz			;; if jump is active, return

	;;jump is inactive, activate it
	ld 	a, #0
	ld	(player_jump), a	;; player_jump = 0 -> activate

ret

;;=============================================
;; Check limits and change map if necessary
;; INPUT: player pos in A
;;=============================================
check_limits:

	ld b, a

	call miniboss_isActive
	dec a 
	ld a, b
	jr z, end_check

	cp #16 ;;check left limit 
	jr z, check_left

	cp #66-6 ;;check right limit 
	jr z, check_right

	end_check:

	ld 	(player_x), a ;;save player position

	ret

	check_left:

		ld a, #00		;;parameter to go left
		call env_changeMap	;;call to change the map
		dec a 
		ret nz			;;if changed A==0

		ld a, #64-6		;;if the map changes, we change the position
		ld (player_x), a	;;of our player in the map
		ld a, #0xFF
		ld (player_bullet), a 	;;and we delete out player_bullet

		ld ix, #player
		call utility_updatePosition ;;update new player position

		ret

	check_right:

		ld a, #01		;;parameter to go left
		call env_changeMap	;;call to change the map
		dec a 		
		ret nz			;;if changed A==0
		
		ld a, #18		;;if the map changes, we change the position
		ld (player_x), a	;;of our player in the map
		ld a, #0xFF
		ld (player_bullet), a 	;;and we delete out player_bullet

		ld ix, #player
		call utility_updatePosition ;;update new player position
ret


;;=============================================
;; Updates player collision box
;; DESTROYS: HL; A
;;=============================================
update_playerColBox:

	ld a, (player_x)
	ld (player_colBox_x), a	;;update x 

	ld a, (player_kneel)	;;check if player is keeling
	dec a 
	jr nz, not_kneeling

		ld a, (player_y)
		add #7
		ld (player_colBox_y), a ;;update y 

		ret 

	not_kneeling:

	ld a, (player_y)
	add #17
	ld (player_colBox_y), a ;;update y 

ret


;;=============================================
;; Adds a player in almost every dire
;; INPUT: DE - Bullet direction
;; 	  HL - Bullet size
;; DESTROYS: AF; BC; DE; HL
;;=============================================
add_bullet:

	ld ix, #player		;;ptr to player

	ld a, obj_x(ix)		;;player start x
	add obj_ww(ix)		;;bullet start x
	ld b, a 

	ld a, obj_y(ix)		;;player start y
	add obj_wh(ix)		;;bullet start y  	
	ld c, a

	ld ix, #player_bullet	;;ptr to bullet

	call bullet_add		;;add a bullet

	ld de, #0x0030
	call nz, utility_shot_sound 	;;shoot sound to be played

ret


;;=================================================
;; Checks if we can add a bullet and if we do, add
;; depending on which keys are pressed
;; DESTROYS: AF; BC; DE; HL
;;=================================================
check_bullet:
	;Space is pressed
	ld a, (player_bullet)
	cp #0xFF 		;;check if we are shooting
	ret nz			;;if we are not shooting, shoot

	ld ix, #player_bullet
	call bullet_check_time	;;check that at least 25 frames happened
	cp #0x00		;;since last shoot
	ret nz			;;if timer is set to 0, then we continue

	ld a, #25		;;time to reset
	call bullet_reset_time	;;reset bullet time counter

	;;check sprite direction
	check_CRight:
	call get_pressedKeys0
	and #1
	jr	z, check_CLeft	;;if not 0, shoot up

		ld a, #1
		ld (player_dir), a	;;change where player faces

	;;check cursor left
	check_CLeft:
	call get_pressedKeys0
	and #4
	jr	z, check_direction	;;if not 0, we are facing left

		ld a, #0
		ld (player_dir), a	;;change where player faces


	;;check player direction
	check_direction:
	ld a, (player_dir)	;;check player direction
	dec a 
	jr z, bullet_right

		;;go_left
		ld de, #0xFE00	;;right direction
		jr continue_bullet

	bullet_right:
		ld de, #0x0200	;;left direction

	continue_bullet:
		ld hl, #0x0302	;;regular bullet size

	ld a, (player_kneel)
	dec a
	jr z, check_add_bullet 	;;if we are keeling, we can only shoot 
				;;left or right

	;;check cursor up
	check_CUp:
	call get_pressedKeys0
	and #8
	jr	z, check_CDown	;;if up, check left or right

		;;check cursor left
		call get_pressedKeys0
		and #4
		jr	z, check_CUpRight	;;if not 0, check right

			ld de, #0xFEFE	;;up-left

			jr check_add_bullet

		;;check cursor right
		check_CUpRight:
		call get_pressedKeys0
		and #1
		jr	z, continue_up	;;if not 0, shoot up

			ld de, #0x02FE	;;up-right

			jr check_add_bullet

		continue_up:

			ld de, #0x00FB	;;up
			ld hl, #0x0801  ;;up size

			jr check_add_bullet

	;;check cursor down
	check_CDown:
	call get_pressedKeys0
	and #2
	jr	z, check_add_bullet	;;if down, check left or right

		;;check cursor left
		call get_pressedKeys0
		and #4
		jr	z, check_CDownRight	;;if not 0, check right

			ld de, #0xFE02	;;down-left

			jr check_add_bullet

		;;check cursor right
		check_CDownRight:
		call get_pressedKeys0
		and #1
		jr	z, continue_down	;;if not 0, shoot down

			ld de, #0x0202	;;down-right

			jr check_add_bullet

		continue_down:

			ld de, #0x0004	;;down
			ld hl, #0x0801  ;;down size

			jr check_add_bullet

	check_add_bullet:
	
	call add_bullet ;;adds a bullet to the player
ret

;;=================================================
;; If we are keeling, update player values
;; DESTROYS: AF, IX
;;=================================================
kneel:
	ld ix, #player 	;;load our player data

	;;x remains unchanged
	call utility_object_erase2

	;;y = y+10
	ld a, obj_y(ix)	;;load y
	add #10 	;;add 10
	ld obj_y(ix), a	;;save y

	;;width remains unchanged

	;;height is half
	ld a, #15
	ld obj_h(ix), a 

	;;tile x remains unchanged

	;;tile y is 3 more
	ld a, obj_ty(ix)	;;load ty
	add #3			;;add 3
	ld obj_ty(ix), a 	;;save ty

	;;weapon w remains unchanged

	;;weapon h is 1
	ld a, #5
	ld obj_wh(ix), a

	call utility_updatePosition1
	;
	;call utility_object_erase2
	;call utility_object_erase3
ret

;;=================================================
;; If we aren't keeling, update player values
;; DESTROYS: AF, IX
;;=================================================
not_kneel:
	ld ix, #player 	;;load our player data

	;;y = y-10
	ld a, obj_y(ix)	;;load y
	add #-10 	;;add -10
	ld obj_y(ix), a	;;save y

	;;width remains unchanged

	;;height is 30
	ld a, #30
	ld obj_h(ix), a 

	;;tile x remains unchanged

	;;tile y is 3 less
	ld a, obj_ty(ix)	;;load ty
	add #-3			;;add -3
	ld obj_ty(ix), a 	;;save ty

	;;weapon w remains unchanged 

	;;weapon h is 15
	ld a, #11
	ld obj_wh(ix), a

	call utility_updatePosition1

ret

;;=================================================
;; Power up: longer bullet
;; OUTPUT: HL - jumptable
;; DESTROYS: A, B, HL
;;=================================================
power_up_longer_jump:

	call collectables_get_power
	and #0b01000000
	ld hl, #jumptable
	ret z

	;;if power up is active, decrease value
	ld a, (power_up_time)
	dec a 
	dec a 
	dec a
	ld (power_up_time), a
	ld hl, #jumptable1
	ret nz

	;;if we don't have more time
	ld a, #0xFF
	ld (power_up_time), a 
	ld b, #0b10111111
	call collectables_reset_power
ret
