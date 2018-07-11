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

;;=========================================
;; MAIN FILE
;;=========================================
.area _DATA
.area _CODE



;;=========================================
;; INCLUDE AREA
;;=========================================
.include "environment.h.s"	;;file containing environment includes
.include "player.h.s"
.include "turret.h.s"		
.include "soldier.h.s"
.include "obstacle.h.s"
.include "platform.h.s"
.include "sprite.h.s"
.include "collision.h.s"
.include "collectables.h.s"
.include "miniboss.h.s"
.include "doublebuffer.h.s"
.include "utility.h.s"
.include "menu.h.s"
.include "../includes/interruptions.s"


.globl _sprite_palette		;;include player palette
.globl cpct_disableFirmware_asm		;;unique use cpct function
.globl cpct_setInterruptHandler_asm	;;unique use cpct function


;;========================================
;;MAIN FUNCTIONS
;;========================================

;;initialize
initialize:

	call cpct_disableFirmware_asm	;;disable firmware 

	ld hl, #isr	;;pointer to function
	call cpct_setInterruptHandler_asm ;;set interruption handler 

	ld c, #0
	call cpct_setVideoMode_asm	;;set video mode to 0

	ld hl, #_sprite_palette
	ld de, #16
	call cpct_setPalette_asm		;;change the palette

ret 

;;initialize post menu 
initialize_post_menu:

	ld c, #0
	call cpct_setVideoMode_asm	;;set video mode to 0

	ld hl, #_sprite_palette
	ld de, #16
	call cpct_setPalette_asm		;;change the palette

	;;INITIALIZE BACKBUFFER
	call db_initialize

	call env_initMap	;;we start the map system

	ld de, #_song
	call cpct_akp_musicInit_asm	;;initiate song

	call interruption_playMusic
ret

;;=========================================
;;=========================================
;; MAIN
;;=========================================
;;=========================================

;;=============================================
;; Updates the position in tiles of the object
;; INPUT: IX - ptr to the object
;; DESTROYS: A; DE; HL; BC
;;=============================================
_main::

	;;SET STACK POSITION
	ld sp, #0x8000

	;;INITIALIZATION
	call initialize
	
	;;MENU 
	call db_setVideoPtrC0
	call menu_system
	call db_setVideoPtr80

	;;INIT MAP 
	call initialize_post_menu

	;;MAIN lOOP
	main_loop::

		;;========================================
		;; ERASE 
		;;========================================
		call player_erase 	;;Erases player
		call obstacle_erase_all
		call miniboss_erase
		;call soldier_erase
	
		;;========================================
		;; UPDATE
		;;========================================
		call player_update	;;Updates player
		call turret_update
		;call soldier_update
		call miniboss_update
		call collectables_update
		call obstacle_update
		call platform_update
	
		;;========================================
		;; DRAW
		;;========================================
		call platform_draw
		call player_draw		;;Draws the player
		call turret_draw
		;call soldier_draw
		call miniboss_draw
		call obstacle_draw
		call collectables_draw
		call sprite_draw

		;;========================================
		;; COLLISIONS
		;;========================================
		call collision_checkAll	;;checks all collisions that happen

		;;========================================
		;; DOUBLE BUFFER
		;;========================================
		call check_frame
		call cpct_waitVSYNC_asm ;;wait for vsync
		call db_switchBuffers 

	jr main_loop 		;; return to main_loop