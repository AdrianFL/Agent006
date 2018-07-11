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

;;====================================================
;; INCLUDE AREA
;;====================================================
.include "utility.h.s"
.include "includes.h.s"
.include "turret.h.s"
.include "soldier.h.s"
.include "obstacle.h.s"
.include "platform.h.s"
.include "player.h.s"
.include "environment.h.s"
.include "collectables.h.s"
.include "miniboss.h.s"


;;=========================================
;;=========================================
;; PRIVATE DATA
;;=========================================
;;=========================================
current_colMap: .dw 0x0000 ;;pointer to the current collision map

power_up_time: .db #0xff 

;;=========================================
;;=========================================
;; PUBLIC FUNCTIONS
;;=========================================
;;=========================================

;;==================================================
;; Check all collisions and act
;; DESTROYS : A, BC; DE; HL
;;==================================================
collision_checkAll::

	;;is invulnerability set?

		call collectables_get_power	;;check is invulnerability is 
		and #0b00010000		;;active
		jr z, dont_skip
	
		;;if power up is active, decrease value
		ld a, (power_up_time)
		dec a 
		ld (power_up_time), a
		jr nz, skip
	
		;;if we don't have more time
		ld a, #0xFF
		ld (power_up_time), a 
		ld b, #0b11011111
		call collectables_reset_power

	;;collisions with player are skipped if invulnerable
	dont_skip:

	;;collision with obstacle
	call obstacle_getObstacle
	call collision_playerObstacle
	call obstacle_getObstacle2
	call collision_playerObstacle
	call obstacle_getObstacle3
	call collision_playerObstacle

	;;collisions with bullet turrets
	call turret_getBullet1
	call collision_playerTurretBullet
	call turret_getBullet2
	call collision_playerTurretBullet

	;;collisions with soldier bullets
	;call soldier_getBullet
	;call collision_playerTurretBullet
	;call soldier_getBullet2
	;call collision_playerTurretBullet

	;;collisions with boss bullets
	call miniboss_getBullet1 
	call collision_playerMinibossBullet
	call miniboss_getBullet2
	call collision_playerMinibossBullet
	call miniboss_getBullet3
	call collision_playerMinibossBullet

	;;collisions with obstacle turrets
	call obstacle_getBullet
	call collision_playerTurretBullet
	call obstacle_getBullet2
	call collision_playerTurretBullet
	call obstacle_getBullet3
	call collision_playerTurretBullet

	skip:

	;;collisions to our bullets to turrets
	call turret_getTurret1
	ld a, #0
	call collision_turretPlayerBullet
	call turret_getTurret2
	ld a, #1
	call collision_turretPlayerBullet

	;; check collision soldier with player Bullet
	call obstacle_getObstacle_ix
	ld a, #0
	call collision_soldierPlayerBullet
	call obstacle_getObstacle2_ix
	ld a, #1
	call collision_soldierPlayerBullet
	call obstacle_getObstacle3_ix
	ld a, #2
	call collision_soldierPlayerBullet

	call collision_playerMap
	call player_setColl

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

;;==================================================
;; Checks collisions player with platform
;; DESTROYS : A, BC; DE; HL
;;==================================================
collision_platform:

	call player_getColBox

	call platform_getPlatform
	call utility_checkCollision ;;check collisions 
	cp #0x01
	jr z, coll_pos

	call platform_getPlatform2
	call utility_checkCollision ;;check collisions 
	cp #0x01
	jr z, coll_pos

	call platform_getPlatform3
	call utility_checkCollision ;;check collisions 
	cp #0x01
	jr z, coll_pos

	call platform_getPlatform4
	call utility_checkCollision ;;check collisions 
	cp #0x01
	jr z, coll_pos

	call platform_getPlatform5
	call utility_checkCollision ;;check collisions 
	cp #0x01
	jr z, coll_pos

	ld a, #0x00
	ret

	coll_pos:
	ld a, #0x01

ret

;;==================================================
;; Checks collisions between the player and the map
;; DESTROYS : A, BC; DE; HL
;;==================================================
collision_playerMapPlatform::

	call collision_platform
	cp #0x01
	jr z, plat_coll

	check_next1:
		call player_getJump
		cp #7			;;if player is mid way in the jump
		ld a, #0x00		;;return 0
		ret p 			;;don't decrease y

		;;if we don't find collision, decrease y player
		ld b, #0x03 
		call player_decreaseY

		;;return 0
		ld h, #0x00
		call platform_setPlat_Coll

		ld a, #0x00
		ret

	plat_coll:
		ld h, #0x01
		call platform_setPlat_Coll
		ld a, #0x01
		call player_setColl
		call player_setPlat

ret

;;==================================================
;; Sets a new collision map
;; INPUT: HL - ptr to collision map
;; DESTROYS : HL
;;==================================================
collision_setColMap::

	ld (current_colMap), hl

ret

;;=========================================
;;=========================================
;; PRIVATE FUNCTIONS
;;=========================================
;;=========================================


;;==================================================
;; Check collision between player bullet and turret
;; INPUT: IX - Turret to be collided
;; 	  A - Turret to be erased
;; DESTROYS : A, BC; DE; HL
;;==================================================
collision_soldierPlayerBullet:

	ld b, a	;store A value
	
	ld a, obs_tp(ix)
	cp #3
	ret nz

	call player_getBullet ;;puts bullet direction in IY 

	ld a, bul_x(iy)
	cp #0xff 
	ret z	;;check that the bullet is set

		ld a, bul_x(ix)
		cp #0xff 
		ret z	;;check that the turret is set

		call utility_checkCollision ;;check collisions 

		cp #0x01 	
		ret nz ;; check if we had collision 

			;;if we had collision 
			push bc
			pop af	
			push bc ;;store A variable value
			call obstacle_erase
			pop af
			call obstacle_remove	;;erase turret

			call player_removeBullet ;;erase player bullet

			ld de, #0x0A27
			call utility_shot_sound
ret

;;==================================================
;; Check collision between player bullet and turret
;; INPUT: IX - Turret to be collided
;; 	  A - Turret to be erased
;; DESTROYS : A, BC; DE; HL
;;==================================================
collision_turretPlayerBullet:

	ld b, a	;store A value

	call player_getBullet ;;puts bullet direction in IY 

	ld a, bul_x(iy)
	cp #0xff 
	ret z	;;check that the bullet is set

		ld a, bul_x(ix)
		cp #0xff 
		ret z	;;check that the turret is set

		call utility_checkCollision ;;check collisions 

		cp #0x01 	
		ret nz ;; check if we had collision 

			;;if we had collision 
			push bc
			pop af	
			push bc ;;store A variable value
			call turret_erase
			pop af
			call turret_remove	;;erase turret

			call player_removeBullet ;;erase player bullet

			ld de, #0x0A20
			call utility_shot_sound
ret

;;==================================================
;; Check collision between player and turret bullet
;; INPUT: IY - Turret bullet to be collided
;; DESTROYS : A, BC; DE; HL
;;==================================================
collision_playerTurretBullet:

	ld a, obs_x(iy)
	cp #0xff 
	ret z	;;check that the obstacle is set

		;;if it is 
		call player_getPlayer ;;puts player direction in IX 

		call utility_checkCollision ;;check collisions 

		cp #0x01 	
		ret nz ;; check if we had collision 

			;;if we had collision 
			call utility_resetGame ;;reset player
ret

;;==================================================
;; Check collision between player and obstacle
;; INPUT: IY - Obstacle to be collided
;; DESTROYS : A, BC; DE; HL
;;==================================================
collision_playerObstacle:

	ld a, obs_x(iy)
	cp #0xff 
	ret z	;;check that the obstacle is set

		;;if it is 
		call player_getPlayer ;;puts player direction in IX 

		call utility_checkCollision ;;check collisions 

		cp #0x01 	
		ret nz ;; check if we had collision 

			;;if we had collision 
			push bc
			pop af	
			push bc ;;store A variable value
			call obstacle_erase
			pop af
			call obstacle_remove	;;erase turret

			call utility_resetGame ;;reset player
ret


;;==================================================
;; Check collision between player and map
;; INPUT : IX - ptr to player 
;;	   var - ptr to map array
;; DESTROYS : A, BC; DE; HL
;; OUTPUT: A - 0 if not collision, 1 if we do
;;==================================================
collision_playerMap::

	call player_getJump
	cp #7				;;if player is mid way in the jump, update
	jp p, not_reset_game
	cp #-1
	ret nz 				;;if player is jumping, don't update

	call player_getY		;;if player is too way down, reset game
	add #94 			;;(255-160) 160=max_y
	jp m, not_reset_game

		;;if we do reset the game 
		call utility_resetGame 
		ret


	not_reset_game:

	call player_getColBox		;;get player in ix 
	ld   iy, (current_colMap)	;;get collision map in iy

	init_collisionPlayerMap:

		;;check currentColMap is not empty
		ld a, obj_x(iy)			;;current col_box_x
		cp #0xff 
		jr z, end_collisionPlayerMap	;;if it is empty, we had no collision
						;;at all
	
		call utility_checkCollision	;;check collision

		;;check if we have collision
		cp #0x01 			;;if A=1; collision
		jr nz, not_collision 

			;;if we have collision 
			call player_getJump
			cp #7				;;if player is mid way in the jump
							;;reset jump

			ld a, #0x00
			call player_setPlat
			
			ld a, #0x01
			ret m				;;player is not mid way in the jump 

				;;player is mid way in the jump
				call player_resetJump
				ret

			not_collision:

			ld bc, #0x0004
			add iy, bc 	;;increment iy

			jr init_collisionPlayerMap 

	end_collisionPlayerMap:

		call collision_playerMapPlatform

ret

;;==================================================
;; Check collision between player and miniboss bullet
;; INPUT: IY - Turret bullet to be collided
;; DESTROYS : A, BC; DE; HL
;;==================================================
collision_playerMinibossBullet:

	ld a, bul_x(iy)
	cp #0xff 
	ret z	;;check that the bullet is set

		;;if it is 
		call player_getPlayer ;;puts player direction in IX 

		call utility_checkCollision ;;check collisions 

		cp #0x01 	
		ret nz ;; check if we had collision 

			;;if we had collision 
			call utility_resetGame ;;reset player
ret