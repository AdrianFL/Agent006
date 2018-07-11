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
;; FILE FOR MACROS AND CONSTANTS FOR OUR GAME
;;====================================================


;;====================================================
;; OBJECTS
;;====================================================

;; macro

.macro defineObject name, x, y, w, h, tx, ty, ww, wh, x1, y1, x2, y2
	name':
	name'_x: 	.db x		;;pos in x
	name'_y: 	.db y		;;pos in y
	name'_w:	.db w		;;width
	name'_h:	.db h		;;height
	name'_tile_x:   .db tx		;;starting tile in x
	name'_tile_y:	.db ty		;;starting tile in y
	name'_weapon_w: .db ww		;;weapon width position
	name'_weapon_h: .db wh		;;weapon height position
	name'_x1: 	.db x1		;;pos in x1
	name'_y1: 	.db y1		;;pos in y1
	name'_x2: 	.db x2		;;pos in x2
	name'_y2: 	.db y2		;;pos in y2
.endm

;; constants 

.equ obj_x, 0
.equ obj_y, 1
.equ obj_w, 2
.equ obj_h, 3
.equ obj_tx, 4
.equ obj_ty, 5
.equ obj_ww, 6
.equ obj_wh, 7
.equ obj_x1, 8
.equ obj_y1, 9
.equ obj_x2, 10
.equ obj_y2, 11

;;turret related extra constants
.equ turr_bull, 12 	;;ptr to the start of the bullet

;;====================================================
;; BULLETS
;;====================================================

;; macro

.macro defineBullet name, x, y, h, w, tx, ty, dx, dy, x1, y1, x2, y2, btime
	name'_bullet:
	name'_bullet_x: 	.db x		;;pos in x
	name'_bullet_y: 	.db y		;;pos in y
	name'_bullet_w:		.db h		;;width
	name'_bullet_h:		.db w		;;height
	name'_bullet_tile_x:   	.db tx		;;starting tile in x
	name'_bullet_tile_y:	.db ty		;;starting tile in y
	name'_bullet_dir_x: 	.db dx		;;bullet x direction
	name'_bullet_dir_y: 	.db dy		;;bullet y direction
	name'_bullet_x1: 	.db x1		;;pos in x1
	name'_bullet_y1: 	.db y1		;;pos in y1
	name'_bullet_x2: 	.db x2		;;pos in x2
	name'_bullet_y2: 	.db y2		;;pos in y2
	name'_bullet_time:	.db btime	;;bullet reset time
.endm

;; constants 

.equ bul_x, 0
.equ bul_y, 1
.equ bul_w, 2
.equ bul_h, 3
.equ bul_tx, 4
.equ bul_ty, 5
.equ bul_dx, 6
.equ bul_dy, 7
.equ bul_x1, 8
.equ bul_y1, 9
.equ bul_x2, 10
.equ bul_y2, 11
.equ bul_bt, 12


;;====================================================
;; ANiMATIONS
;;====================================================

;; macros

.macro defineAnimation name, s, im, cm, ns, cs, t, ct, l
	name'_animation:
	name'_animation_s: 	.dw s		;;size in bytes of every sprite
	name'_animation_im: 	.dw im		;;ptr to start of the animation
	name'_animation_cm:	.dw cm		;;ptr to current animation
	name'_animation_ns:	.db ns		;;number of sprites of the animation
	name'_animation_cs: 	.db cs 		;;number of sprites in which we are
	name'_animation_t:   	.db t		;;time interval between sprites
	name'_animation_ct:	.db ct		;;current time of the animation
	name'_animation_l:	.db l		;;if we loop the animation or not

.endm

;; constants 

.equ anim_size, 0
.equ anim_siz1, 1
.equ anim_imem, 2
.equ anim_ime1, 3
.equ anim_cmem, 4
.equ anim_cme1, 5
.equ anim_spri, 6
.equ anim_cspr, 7
.equ anim_time, 8
.equ anim_ctim, 9
.equ anim_loop, 10


;;====================================================
;; MAPS
;;====================================================

;; macros

.macro defineMap name, s1, s2, g1, g2
	name'_map:
	name'_map_sky1:		.dw s1 		;;skies
	name'_map_sky2:		.dw s2 
	name'_map_ground1:	.dw g1 		;;grounds
	name'_map_ground2:	.dw g2 

.endm

;; constants 
.equ map_s11, 0
.equ map_s12, 1
.equ map_s21, 2
.equ map_s22, 3
.equ map_g11, 4
.equ map_g12, 5
.equ map_g21, 6
.equ map_g22, 7




;;====================================================
;; OBSTACLES
;;====================================================

;; macro

.macro defineObstacle name, x, y, h, w, tx, ty, tp, ini, p, x1, y1, x2, y2, dr
	name':
	name'_obstacle_x: 	.db x			;;pos in x
	name'_obstacle_y: 	.db y			;;pos in y
	name'_obstacle_h:		.db h		;;height
	name'_obstacle_w:		.db w		;;width
	name'_obstacle_tile_x:   	.db tx		;;starting tile in x
	name'_obstacle_tile_y:	.db ty		;;starting tile in y
	name'_obstacle_type:	.db tp		;;type of obstacle
	name'_obstacle_ini: 	.db ini		;; pos init on x or y according the type
	name'_obstacle_p: 	.db p			;; number of displacements
	name'_obstacle_x1: 	.db x1			;;pos in x1
	name'_obstacle_y1: 	.db y1			;;pos in y1
	name'_obstacle_x2: 	.db x2			;;pos in x2
	name'_obstacle_y2: 	.db y2			;;pos in y2
	name'_obstacle_dr: 	.db dr			;;pos in dr
	
	
.endm

;; constants 

.equ obs_x, 0
.equ obs_y, 1
.equ obs_h, 2
.equ obs_w, 3
.equ obs_tx, 4
.equ obs_ty, 5
.equ obs_tp, 6
.equ obs_ini, 7
.equ obs_p, 8
.equ obs_x1, 9
.equ obs_y1, 10
.equ obs_x2, 11
.equ obs_y2, 12
.equ obs_dr, 13


;;turret related extra constants
.equ obs_bull, 14 	;;ptr to the start of the bullet
;;====================================================
;; EXTENDED INSTRUCTIONS
;;====================================================

;; macros

.macro ld_a_iyh			;;macro for undocumented intruction
	.db #0xFD, #0x7c	;; ld a, iyh
.endm 

.macro ld_a_iyl			;;macro for undocumented intruction
	.db #0xFD, #0x7d	;; ld a, iyl
.endm 

.macro dec_iyh			;;macro for undocumented intruction
	.db #0xFD, #0x25	;; dec iyh
.endm 

.macro dec_iyl			;;macro for undocumented intruction
	.db #0xFD, #0x2D	;; dec iyl
.endm 

.macro ld_iyh_nn		;;macro for undocumented intruction
	.db #0xFD, #0x26	;; ld iyh, nn
.endm 

.macro ld_iyl_nn		;;macro for undocumented intruction
	.db #0xFD, #0x2E	;; ld iyl, nn
.endm 

.macro ld_ixh_b			;;macro for undocumented intruction
	.db #0xDD, #0x60	;; ld iyh, b
.endm 

.macro ld_ixl_c			;;macro for undocumented intruction
	.db #0xDD, #0x69	;; ld iyl, c
.endm 

.macro ld_iyl_a			;;macro for undocumented intruction
	.db #0xFD, #0x67	;; ld iyl, c
.endm 

;;====================================================
;; MEMORY ALLOCATION
;;====================================================

.macro allocateMemory pos
	.area _'pos'_ (ABS) 
	.org pos 
.endm

.macro deallocateMemory 
	.area _CSEG
	.area _CODE
.endm

;;====================================================
;; SET BORDER
;;====================================================
.macro setBorder color 
	ld hl, #0x'color'10
	call cpct_setPALColour_asm
.endm