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

;;=========================================================
;; ALL UTILITIES ARE PUBLIC
;;=========================================================
.AREA _CODE


;;=================================================
;; INCLUDE AREA
;;=================================================
.include "includes.h.s"
.include "environment.h.s"
.include "player.h.s"
.include "collectables.h.s"
.include "obstacle.h.s"
.include "turret.h.s"
.include "platform.h.s"
.include "soldier.h.s"
.include "miniboss.h.s"
.include "doublebuffer.h.s"
.include "sprite.h.s"


;;=================================================
;;
;; PRIVATE DATA
;;
;;=================================================

starting_pos: .db #0

change: .db #03
ouch: .db #79,#85,#67,#72,#33,#00
aghh: .db #65,#71,#72,#72,#33,#00
pfff: .db #80,#70,#70,#70,#33,#00
wtf:  .db #87,#84,#70,#33,#33,#00

enemies1: .db 0x00 ;;variable for checking is a temporal enemy is alive or dead

;;=================================================
;;
;; PUBLIC FUNCTIONS
;;
;;=================================================

;;=============================================
;; Updates the position in tiles of the object
;; INPUT: IX - ptr to the object
;; DESTROYS: A; DE; HL; BC
;;=============================================
utility_update_tiles::

	;;x tile - we divide object/2
	ld a, obj_x(ix)	;;we load the object_x position
	srl a 		;;shift bits right (divide between 2)
	ld obj_tx(ix),a ;;save the result in the tile

	;;y tile - we divide object/4
	ld a, obj_y(ix)	;;we load the object_y position
	srl a 		;;shift bits right (divide between 2)
	srl a 		;;shift bits right (divide between 2)
	ld obj_ty(ix),a	;;save the result in the tile

ret


;;=============================================
;; Updates the position in tiles of the object
;; INPUT: IX - ptr to the object
;; DESTROYS: A; DE; HL; BC
;;=============================================
utility_update_tiles_obs::

	;;x tile - we divide object/2
	ld a, obs_x(ix)	;;we load the object_x position
	srl a 		;;shift bits right (divide between 2)
	ld obs_tx(ix),a ;;save the result in the tile

	;;y tile - we divide object/4
	ld a, obs_y(ix)	;;we load the object_y position
	srl a 		;;shift bits right (divide between 2)
	srl a 		;;shift bits right (divide between 2)
	ld obs_ty(ix),a	;;save the result in the tile

ret

;;=========================================
;; Checks collision
;; INPUT: IX - object 1
;; 	  IY - object 2
;; Return: A - Ox01 if collision, 0x00 if not
;; DESTROYS : A
;;=========================================
utility_checkCollision::
	;;
	;; if (obs_x + obs_w - hero_x <= 0) no_collision
	;;
	ld a, obj_x(iy)	;;load obs_x	
	add obj_w(iy)	;;obs_x + obs_w
	sub obj_x(ix)	;;(obs_x+obs_w) - hero_x

	jp m, no_collision	;;si ha dado negativo
	jr z, no_collision	;;si ha dado 0

	;;
	;; if (hero_x + hero_w - obs_x <= 0) no_collision
	;;
	ld a, obj_x(ix)	;;load hero_x
	add obj_w(ix)	;;hero_x + hero_w 
	sub obj_x(iy)	;;(hero_x + hero_w) - obs_x 

	jp m, no_collision	;;si ha dado negativo
	jr z, no_collision	;;si ha dado 0

	;;
	;; if (hero_y + hero_h - obs_y <= 0) no_collision
	;;
	ld a, obj_y(ix)	;;load hero_x
	add obj_h(ix)	;;hero_x + hero_w 
	sub obj_y(iy)	;;(hero_x + hero_w) - obs_x 

	jp m, no_collision	;;si ha dado negativo
	jr z, no_collision	;;si ha dado 0

	;;
	;; if (obsy + obsh - hero_y <= 0) no_collision
	;;
	ld a, obj_y(iy)	;;load obs_x	
	add obj_h(iy)	;;obs_x + obs_w
	sub obj_y(ix)	;;(obs_x+obs_w) - hero_x

	jp m, no_collision	;;si ha dado negativo
	jr z, no_collision	;;si ha dado 0

	;;Collision
	ld a, #0x01
	ret

	;;No collision
	no_collision:
		ld a, #0x00	;;return value
ret


;;=============================================
;; Draws a masked object in screen
;; INPUT: IX - ptr to object_x 
;;  	  BC - sprite to be drawn
;; DESTROYS: A; DE; HL; BC; IX
;;=============================================
utility_object_draw_masked::

	ld a, 0(ix)
	cp #0xff 
	ret z

	push bc 		;;save sprite to be drawn

	call utility_screenPtr

	ld c, obj_w(ix)		;;load object_w in c
	ld b, obj_h(ix)		;;load object_h in b 
	push bc  
	pop ix			;;put object height and width in ix

	;;Draw a our player
	ld hl, #_playerMaskTable	;;our mask
	pop bc				;;our sprite		
	
	call cpct_drawSpriteMaskedAlignedTable_asm ;;we call the function for drawing a transparent sprite

ret

;;=============================================
;; Draws an object in screen
;; INPUT: IX - ptr to object_x 
;;  	  BC - sprite to be drawn
;; DESTROYS: A; DE; HL; BC; IX
;;=============================================
utility_object_draw::

	ld a, 0(ix)
	cp #0xff 
	ret z

	push bc 		;;save sprite to be drawn

	call utility_screenPtr

	pop hl

	ld c, obj_w(ix)		;;load object_w in c
	ld b, obj_h(ix)		;;load object_h in b 	
	
	call cpct_drawSprite_asm ;;we call the function for drawing a transparent sprite

ret

;;============================================
;; Get video ptr to screen 
;; INPUT: BC - y,x
;;============================================
utility_screenPtr::
;;Calculate screen position
	call db_getVideoPtr
	ex de, hl		;;save returned value in de
	ld c, obj_x(ix)		;;| C=player_x
	ld b, obj_y(ix)		;;| B=player_y
	call cpct_getScreenPtr_asm ;;Get pointer to screen
	ex de, hl		;;save return value in hl
ret
;;=============================================
;; Erases an object in screen
;; INPUT: IX - object
;; DESTROYS: A; DE; HL; BC
;;=============================================
utility_object_erase::

	ld a, 0(ix)
	cp #0xff 
	ret z

	ld hl, #0x3800
	push hl			;;we send the parameter
	
	call db_getVideoPtr
	push hl
;
	call utility_update_tiles2	;;number of tiles to erase in de
;
	call utility_update_tiles3	;;pos in tiles to be erased
	dec c 
	dec b

	ld a, #40	;;width in tiles of a row of the map
	call cpct_etm_drawTileBox2x4_asm
ret


;;=============================================
;; Erases an object in screen, used for bullets
;; INPUT: IX - object
;; DESTROYS: A; DE; HL; BC
;;=============================================
utility_object_erase3::

	ld a, 0(ix)
	cp #0xff 
	ret z

	ld hl, #0x3800
	push hl			;;we send the parameter
	
	call db_getVideoPtr
	push hl
;
	call utility_update_tiles2	;;number of tiles to erase in de
;
	call utility_update_tiles3	;;pos in tiles to be erased
	dec c 
	dec b
	dec c 
	dec b 
	inc d 
	inc d 
	inc e 
	inc e

	ld a, #40	;;width in tiles of a row of the map
	call cpct_etm_drawTileBox2x4_asm
ret

;;=============================================
;; Erases player
;; INPUT: IX - object
;; DESTROYS: A; DE; HL; BC
;;=============================================
utility_player_erase::

	ld a, 0(ix)
	cp #0xff 
	ret z

	ld hl, #0x3800
	push hl			;;we send the parameter
	
	call db_getVideoPtr
	push hl
;
	call utility_update_tiles2	;;number of tiles to erase in de
;
	call utility_update_tiles3	;;pos in tiles to be erased
	dec c 
	dec b

	call player_getColl
	dec a 
	call nz, aux


	ld a, #40	;;width in tiles of a row of the map
	call cpct_etm_drawTileBox2x4_asm
ret


;;aux for player erase
aux:
	dec c 
	dec b 
	inc d 
	inc e 
	inc d 

ret

;;=============================================
;; Erases an object in screen
;; INPUT: IX - object
;; DESTROYS: A; DE; HL; BC
;;=============================================
utility_object_erase2::

	ld hl, #0x3800
	push hl			;;we send the parameter
	
	call db_getVideoPtr
	ld a, h 
	xor #0x40
	ld h, a
	push hl
;
	call utility_update_tiles2	;;number of tiles to erase in de
;
	call utility_update_tiles4	;;pos in tiles to be erased

	ld a, #40	;;width in tiles of a row of the map
	call cpct_etm_drawTileBox2x4_asm
ret


;;=============================================
;; Erases an obstacle in screen
;; INPUT: IX - obstacle
;; DESTROYS: A; DE; HL; BC
;;=============================================
utility_obstacle_erase::

	ld hl, #0x3800
	push hl			;;we send the parameter
	
	call db_getVideoPtr
	push hl
;
	call utility_update_tiles_obstacle	;;number of tiles to erase in de
;
	call utility_update_tiles_obstacle2	;;pos in tiles to be erased
	dec c 
	dec b

	ld a, #40	;;width in tiles of a row of the map
	call cpct_etm_drawTileBox2x4_asm
ret


;;=============================================
;; Erases an obstacle in screen
;; INPUT: IX - obstacle
;; DESTROYS: A; DE; HL; BC
;;=============================================
utility_obstacle_erase2::

	ld hl, #0x3800
	push hl			;;we send the parameter
	
	call db_getVideoPtr
	ld a, h 
	xor #0x40
	ld h, a
	push hl
;
	call utility_update_tiles_obstacle	;;number of tiles to erase in de
;
	call utility_update_tiles_obstacle3	;;pos in tiles to be erased
	dec c 
	dec b

	ld a, #40	;;width in tiles of a row of the map
	call cpct_etm_drawTileBox2x4_asm
ret


;;=============================================
;; Updates the tiles and returns the result
;; INPUT: IX - object ptr
;; DESTROYS: DE;
;; RETURNS: DE - divided size
;;=============================================
utility_update_tiles_obstacle::
 	
	ld e, obs_h(ix)	;;load in e object_w
	srl e 		;;divide object_w/2
	inc e 		;;add 1 mhore tile to object_w
	inc e
	inc e

	ld d, obs_w(ix)	;;load in e object_h
	srl d 		;;divide object_h/2
	srl d 		;;divide object_h/2
	inc d 		;;add 1 mhore tile to object_h
	inc d		;;add 1 mhore tile to object_h
	inc d
	;;we have in de height and width in tiles to be erased
ret

;;=================================================
;; Updates the position in tiles of the old object
;; INPUT: IX - ptr to the object
;; OUTPUT: BC - tiles to be erased
;; DESTROYS: A; DE; HL; BC
;;=================================================
utility_update_tiles_obstacle2::

	;;x tile - we divide object/2
	ld a, obs_x2(ix)	;;we load the object_x position
	srl a 		;;shift bits right (divide between 2)
	ld c,a ;;save the result in the tile

	;;y tile - we divide object/4
	ld a, obs_y2(ix)	;;we load the object_y position
	srl a 		;;shift bits right (divide between 2)
	srl a 		;;shift bits right (divide between 2)
	ld b,a	;;save the result in the tile

ret

;;=================================================
;; Updates the position in tiles of the old object
;; INPUT: IX - ptr to the object
;; OUTPUT: BC - tiles to be erased
;; DESTROYS: A; DE; HL; BC
;;=================================================
utility_update_tiles_obstacle3::

	;;x tile - we divide object/2
	ld a, obs_x1(ix)	;;we load the object_x position
	srl a 		;;shift bits right (divide between 2)
	ld c,a ;;save the result in the tile

	;;y tile - we divide object/4
	ld a, obs_y1(ix)	;;we load the object_y position
	srl a 		;;shift bits right (divide between 2)
	srl a 		;;shift bits right (divide between 2)
	ld b,a	;;save the result in the tile

ret


;;=============================================
;; Updates the tiles and returns the result
;; INPUT: IX - object ptr
;; DESTROYS: DE;
;; RETURNS: DE - divided size
;;=============================================
utility_update_tiles2::
 	
	ld e, obj_w(ix)	;;load in e object_w
	srl e 		;;divide object_w/2
	inc e 		;;add 1 mhore tile to object_w
	inc e
	inc e

	ld d, obj_h(ix)	;;load in e object_h
	srl d 		;;divide object_h/2
	srl d 		;;divide object_h/2
	inc d 		;;add 1 mhore tile to object_h
	inc d		;;add 1 mhore tile to object_h
	inc d
	;;we have in de height and width in tiles to be erased
ret

;;=================================================
;; Updates the position in tiles of the old object
;; INPUT: IX - ptr to the object
;; OUTPUT: BC - tiles to be erased
;; DESTROYS: A; DE; HL; BC
;;=================================================
utility_update_tiles3::

	;;x tile - we divide object/2
	ld a, obj_x2(ix)	;;we load the object_x position
	srl a 		;;shift bits right (divide between 2)
	ld c,a ;;save the result in the tile

	;;y tile - we divide object/4
	ld a, obj_y2(ix)	;;we load the object_y position
	srl a 		;;shift bits right (divide between 2)
	srl a 		;;shift bits right (divide between 2)
	ld b,a	;;save the result in the tile

ret

;;=================================================
;; Updates the position in tiles of the old object
;; INPUT: IX - ptr to the object
;; OUTPUT: BC - tiles to be erased
;; DESTROYS: A; DE; HL; BC
;;=================================================
utility_update_tiles4::

	;;x tile - we divide object/2
	ld a, obj_x1(ix)	;;we load the object_x position
	srl a 		;;shift bits right (divide between 2)
	ld c,a ;;save the result in the tile

	;;y tile - we divide object/4
	ld a, obj_y1(ix)	;;we load the object_y position
	srl a 		;;shift bits right (divide between 2)
	srl a 		;;shift bits right (divide between 2)
	ld b,a	;;save the result in the tile

ret


;;=============================================
;; Sets checkpoint
;;=============================================
utility_setcheckpoint::
	ld (starting_pos), a
ret



;;=============================================
;; Restarts the game
;; DESTROYS: DE; HL; AF; BC
;;=============================================
utility_resetGame::
	;;first line 
	ld a, (change)
	dec a
	ld (change), a 
	jr z, other

	ld de,#0xDB8E
    	ld bc, #0x040F
    	ld hl, #ouch
    	call cpct_drawStringM0_asm

    	ld de,#0x9B8E
    	ld bc, #0x040F
    	ld hl, #aghh
    	call cpct_drawStringM0_asm
    	jr continue

    	other:

    	ld a, #03 
    	ld (change), a

    	ld de,#0xDB8E
    	ld bc, #0x040F
    	ld hl, #pfff
    	call cpct_drawStringM0_asm

    	ld de,#0x9B8E
    	ld bc, #0x040F
    	ld hl, #wtf
    	call cpct_drawStringM0_asm

    	continue:

    	call cpct_waitVSYNC_asm ;;wait for vsync

	;;play a note
	ld de, #0x0055
	call utility_piano_sound

	;;wait 0,5 seconds
	ld bc, #0x0196
	call utility_wait

	;;play a note
	ld de, #0x0052
	call utility_piano_sound

	;;wait 0,5 seconds
	ld bc, #0x0196
	call utility_wait

	;;play a note
	ld de, #0x0549
	call utility_piano_sound

	;;wait 0,5 seconds
	ld bc, #0x0196
	call utility_wait

	call interruption_playMusic

	call sprite_remove

	call collectables_delete ;;reset power up draw

	call collectables_resetAll

 	ld a, (starting_pos)
 	cp #0
	call z, env_initMap
	call nz, env_loadcheckpoint
	call player_resetPos	;;reset player and map

	;;ld de, #_song
	;;call cpct_akp_musicInit_asm	;;reset song

	ld a, #0
	call obstacle_remove	;;delete obstacle
	ld a, #1
	call obstacle_remove	;;delete obstacle
	ld a, #2
	call obstacle_remove	;;delete obstacle
	
	ld a, #0
	call turret_remove	
	ld a, #1
	call turret_remove;;delete all turrets

	;;call soldier_remove

	call miniboss_remove	;;remove miniboss

	call platform_remove ;;remove platforms

	call player_removeBullet

ret

;;=============================================
;; Control animation loop
;; INPUT: 	IY - Ptr to the start of the animation data
;; RETURN: 	BC - Ptr to the sprite to be drawn
;; DESTROYS: 	A, BC, HL
;; PENDING: 	non-repeating animation
;;=============================================
utility_advanceAnimation::

	ld a, anim_ctim(iy)
	dec a 
	ld anim_ctim(iy), a
	jr nz, same_sprite			;;if a is not 0, return 

	;;reset anim current time
	ld a, anim_time(iy)
	ld anim_ctim(iy), a

	;;if a is 0, change animation
	ld a, anim_cspr(iy)
	inc a			;;increase a
	ld b, anim_spri(iy)
	cp b 			;;compare current sprite with n of sprites
	jr nz, not_reset

		;;reset sprite 
		ld a, #00	
		ld anim_cspr(iy), a 

		;;reset current sprite position
		ld b, anim_ime1(iy)
		ld c, anim_imem(iy)	;;load initial sprite in bc

		ld anim_cme1(iy), b
		ld anim_cmem(iy), c 	;;save initial  sprite 

		ret

	not_reset:
	ld anim_cspr(iy), a 

	ld h, anim_cme1(iy)
	ld l, anim_cmem(iy)	;;load initial sprite in bc

	ld b, anim_siz1(iy)
	ld c, anim_size(iy)	;;load sprite size 

	add hl, bc 		;;advance to next sprite 

	ld anim_cme1(iy), h
	ld anim_cmem(iy), l 	;;save current sprite

	ld b, h 
	ld c, l 		;;save hl in bc 

	ret 

	same_sprite:

	ld b, anim_cme1(iy)
	ld c, anim_cmem(iy)	;;return current sprite in bc

ret

;;=============================================
;; Initializes pos 1 and pos2 of the object
;; INPUT: 	IX - Ptr to the start of object
;; DESTROYS: 	A
;;=============================================
utility_initializePosition::

	ld a, obj_x(ix)
	ld obj_x1(ix), a
	ld obj_x2(ix), a ;;copy initial pos to x1 and x2 

	ld a, obj_y(ix)
	ld obj_y1(ix), a 
	ld obj_y2(ix), a ;;copy initial pos to y1 and y2 

ret

;;=============================================
;; Updates pos 1 and pos2 of the object
;; INPUT: 	IX - Ptr to the start of object
;; DESTROYS: 	A
;;=============================================
utility_updatePosition::

	;;load x1 in x2
	ld a, obj_x1(ix)
	ld obj_x2(ix), a

	ld a, obj_y1(ix)
	ld obj_y2(ix), a 

	;;load x in x1
	ld a, obj_x(ix)
	ld obj_x1(ix), a

	ld a, obj_y(ix)
	ld obj_y1(ix), a 

ret

;;=============================================
;; Put pos 1 in 0
;; INPUT: 	IX - Ptr to the start of object
;; DESTROYS: 	A
;;=============================================
utility_updatePosition1::

	;;load x2 in x0, x1
	ld a, obj_x2(ix)
	ld obj_x(ix), a
	ld obj_x1(ix), a

	;;load y0 in y1 and y2
	ld a, obj_y(ix)
	ld obj_y2(ix), a 
	ld obj_y1(ix), a

ret


;;=============================================
;; Updates pos 1 and pos2 of the object
;; INPUT: 	IX - Ptr to the start of object
;; DESTROYS: 	A
;;=============================================
utility_updatePosition_obstacle::

	;;load x1 in x2
	ld a, obs_x1(ix)
	ld obs_x2(ix), a

	ld a, obs_y1(ix)
	ld obs_y2(ix), a 

	;;load x in x1
	ld a, obs_x(ix)
	ld obs_x1(ix), a

	ld a, obs_y(ix)
	ld obs_y1(ix), a 

ret


;;=============================================
;; Plays a shot sound effect
;; INPUT: DE - speed and tone to be played
;; DESTROYS: A lot of registers
;;=============================================
utility_shot_sound::
	push de
	ld de, #_SFX_shot
	call cpct_akp_SFXInit_asm
	pop de

	call play_sound
ret

;;=============================================
;; Plays a piano sound effect
;; INPUT: DE - speed and tone to be played
;; DESTROYS: A lot of registers
;;=============================================
utility_piano_sound::
	push de
	ld de, #_song
	call cpct_akp_SFXInit_asm
	pop de

	call play_sound
ret

;;=============================================
;; Draws a single color line
;; INPUT: DE - Where to draw 
;;	  A  - Color to draw 
;; DESTROYS: A; BC; DE; HL
;;=============================================
utility_draw_line::
	ld h, d 
	ld l, e ;;copy de in hl 

	ld (hl), a ;;first byte to color A 

	inc de 

	ld bc, #0x004F

	ldir
ret

;;=============================================
;; Waits a minimum of half a second
;; INPUT: B - Repetitions
;;        C - Number of halta
;; DESTROYS: A; BC; DE; HL
;;=============================================
utility_wait::

	push bc ;;preserve af

	ld a, c

	;;wait half second
	init_halt:
		halt
		dec a 
		jr nz, init_halt

	pop bc

	ld a, b
	dec a
	ld b, a
	
	jr nz, utility_wait 

ret

;;=============================================
;; Moves left/right the position of the object
;; INPUT: B (0 left, 1 right)
;;	  IX - Ptr to the object
;; DESTROYS: A; BC; DE; HL
;;=============================================
utility_objectMap_update::

	ld a, obj_x(ix)  ;;load obj_x in a
	cp #0xFF
	ret z 		;;if object is not set, return

	call map_update

		;;reset bullet 
		ld a, #0xFF 
		ld obj_x+turr_bull(ix), a
ret 


;;=============================================
;; Moves left/right the position of the object
;; INPUT: B (0 left, 1 right)
;;	  IX - Ptr to the object
;; DESTROYS: A; BC; DE; HL
;;=============================================
utility_obstacleMap_update::

	ld a, obj_x(ix)  ;;load obj_x in a
	cp #0xFF
	ret z 		;;if object is not set, return

	call map_update

		;;reset bullet 
		ld a, #0xFF 
		ld obj_x+obs_bull(ix), a
ret 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; aux function for map update 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
map_update:
	;;if object is set 
	ld a, b 	
	dec a 
	ld a, obj_x(ix)
	jr z, go_right2

		;;if we go left 
		add #40
		jr continue2

	go_right2:
	add #-40

	continue2:
		ld obj_x(ix), a 
ret

;;=================================================
;;
;; PRIVATE FUNCTIONS
;;
;;=================================================

;;=============================================
;; Private function for general sound functions
;; DESTROYS: A; BC; DE; HL
;;=============================================
play_sound:
	;;call cpct_akp_stop_asm
	ld hl, #0x0F01 ;;volume and instrument number
	ld bc, #0x0000 ;;pitch 
	ld a,  #0b00000100 ;;channel in which to play
	call cpct_akp_SFXPlay_asm
ret


