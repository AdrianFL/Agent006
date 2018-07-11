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
;; THIS FILE CONTAINS MAP DATA TO BE LOADED INTO 
;; THE GAME AND IT IS PRESENT UNIQUELY AS AN 
;; INCLUDE IN ENVIRONMENT.S
;; HERE WE STORE mapx_init and mapx_end FOR
;; EACH PLAYABLE MAP
;;=================================================
.include "turret.h.s"
.include "soldier.h.s"
.include "collision.h.s"
.include "obstacle.h.s"
.include "platform.h.s"
.include "sprite.h.s"
.include "collectables.h.s"
.include "miniboss.h.s"
.include "utility.h.s"
.include "player.h.s"
.include "includes.h.s"
.globl return_init
.globl return_erase
.globl draw_end

.globl _sprite_checkpoint
.globl _sprite_phantisdinamic_0
.globl _sprite_phantisdinamic_1
.globl _sprite_phantisdinamic_2
.globl _sprite_phantisdinamic_3
.globl _sprite_phantisdinamic_4
.globl _sprite_phantisdinamic_5
.globl _sprite_phantisdinamic_6

.globl _sprite_powerups_1
.globl _sprite_powerups_3

.globl _tB_tileset
.globl _tJ_tileset
.globl _tF_tileset
.globl _tInB_tileset
.globl _tB2J_tileset
.globl _tJ2F_tileset

;;===================================================
;; MAP VARIABLES
;;===================================================

map_list: .dw #0xffff, #0xffff
	  .dw #map1_init, #map1_end, #map2_init, #map2_end
	  .dw #map3_init, #map3_end, #map4_init, #map4_end
	  .dw #map5_init, #map5_end, #map6_init, #map6_end
	  .dw #map7_init, #map7_end, #map8_init, #map8_end
	  .dw #map9_init, #map9_end, #map10_init, #map10_end
	  .dw #map11_init, #map11_end, #map12_init, #map12_end
	  .dw #map13_init, #map13_end, #map13_2_init, #map13_2_end
	  .dw #map13_3_init, #map13_3_end, #map14_init, #map14_end
	  .dw #map15_init, #map15_end, #map18_init, #map18_end
	  .dw #map19_init, #map19_end, #map22_init, #map22_end
	  .dw #map23_init, #map23_end, #map24_init, #map24_end
	  .dw #map25_init, #map25_end, #map26_init, #map26_end
	  .dw #map27_init, #map27_end, #map28_init, #map28_end
	  .dw #map29_init, #map29_end, #map30_init, #map30_end
	  .dw #map31_init, #map31_end, #map32_init, #map32_end
	  .dw #map33_init, #map33_end, #map34_init, #map34_end
	  .dw #map35_init, #map35_end, #map36_init, #map36_end
	  .dw #map37_init, #map37_end, #map38_init, #map38_end
	  .dw #map39_init, #map39_end, #map40_init, #map40_end
	  .dw #map42_init, #map42_end, #map43_init, #map43_end
	  .dw #map46_init, #map46_end, #map47_init, #map47_end
	  .dw #map48_init, #map48_end, #map49_init, #map49_end
	  .dw #map50_init, #map50_end, #map51_init, #map51_end
	  .dw #map52_init, #map52_end, #map53_init, #map53_end
	  .dw #map54_init, #map54_end, #map55_init, #map55_end
	  .dw #map56_init, #map56_end, #map57_init, #map57_end
	  .dw #map58_init, #map58_end, #map59_init, #map59_end
	  .dw #map60_init, #map60_end, #map61_init, #map61_end
	  .dw #map62_init, #map62_end, #map63_init, #map63_end
	  .dw #map64_init, #map64_end, #map65_init, #map65_end
	  .dw #map66_init, #map66_end, #map67_init, #map67_end
	  .dw #map68_init, #map68_end, #map69_init
	  .dw #0xffff, #0xffff
current_map_list: .dw 0x0000 	;;ptr to map list

;;===================================================
;; COLLISION MAPS
;;===================================================

;;Altura base 167
;;Altura media 143
;;Altura alta 119
;;Altura maxima 95
;;X Minimo	 00
;;X Maximo 	 80

allocateMemory 0x0792

collisionMap_map0: .db #00, #0, #00, #00, #0xff

collisionMap_map: .db #00, #167, #80, #02, #0xff ;; x, y, w, h, end

collisionMap_map2: .db #00, #167, #30, #02
			.db #35, #143, #45, #02, #0xff

collisionMap_map3: .db #00, #143, #80, #02, #0xff

collisionMap_map4: .db #00, #143, #25, #02
			.db #30, #167, #45, #02, #0xff

collisionMap_map5: .db #00, #167, #30, #02
			.db #50, #167, #30, #02
			.db #35, #143, #8, #02, #0xff

collisionMap_map6: .db #00, #167, #50, #02
			.db #55, #143, #15, #02, #0xff

collisionMap_map7: .db #00, #143, #27, #02
			.db #37, #119, #43, #02, #0xff

collisionMap_map8: .db #50, #167, #30, #02
			.db #33, #143, #11, #02
			.db #00, #119, #22, #02, #0xff

collisionMap_map9: .db #00, #167, #27, #02
			.db #53, #167, #30, #02, #0xff

collisionMap_map10: .db #00, #143, #25, #02
			.db #38, #119, #14, #02
			.db #55, #95, #5, #02, #0xff

collisionMap_map11: .db #40, #167, #40, #02
			.db #35, #119, #05, #02
			.db #00, #95, #22, #02, #0xff

collisionMap_map13: .db #00, #167, #80, #02
			.db #30, #119, #55, #02, #0xff

deallocateMemory

allocateMemory 0x0E95

collisionMap_map13_2: .db #00, #167, #27, #02, #0xff

collisionMap_map14: .db #00, #167, #80, #02
			.db #00, #119, #30, #02, #0xff

collisionMap_map14_2: .db #40, #167, #50, #02
			.db #55, #143, #15, #02, #0xff

collisionMap_map16: .db #35, #143, #45, #02
			.db #00, #119, #27, #02, #0xff

collisionMap_map17: .db #52, #167, #28, #02
			.db #00, #143, #43, #02, #0xff

collisionMap_map18: .db #00, #167, #47, #02
			.db #55, #143, #25, #02, #0xff

collisionMap_map19: .db #31, #167, #49, #02
			.db #00, #143, #24, #02, #0xff
			
collisionMap_map20: .db #00, #167, #27, #02
			.db #36, #143, #44, #02, #0xff

collisionMap_map21: .db #00, #167, #38, #02
			.db #36, #119, #44, #02, #0xff

collisionMap_map22: .db #51, #167, #29, #02
			.db #35, #143, #08, #02
			.db #00, #119, #27, #02, #0xff

deallocateMemory

allocateMemory 0x2C80

collisionMap_map23: .db #00, #167, #80, #02
			.db #35, #119, #45, #02, #0xff

collisionMap_map24: .db #00, #167, #47, #02
			.db #55, #143, #15, #02
			.db #00, #119, #27, #02, #0xff

collisionMap_map25: .db #00, #143, #27, #02
			.db #35, #119, #13, #02
			.db #55, #95, #25, #02, #0xff

collisionMap_map26: .db #55, #143, #25, #02
			.db #36, #119, #11, #02
			.db #00, #95, #27, #02, #0xff

collisionMap_map27: .db #00, #143, #24, #02
			.db #31, #167, #17, #02, #0xff

collisionMap_map28: .db #31, #167, #49, #02, #0xff

collisionMap_map29: .db #00, #167, #27, #02
			.db #51, #167, #30, #02
			.db #35, #143, #09, #02, #0xff

collisionMap_map33: .db #53, #167, #30, #02, #0xff

collisionMap_map34: .db #00, #167, #80, #02 
			.db #53, #119, #30, #02, #0xff

collisionMap_map35: .db #00, #167, #47, #02
			.db #57, #143, #22, #02
			.db #00, #119, #26, #02, #0xff

collisionMap_map36: .db #52, #167, #28, #02
			.db #00, #143, #42, #02, #0xff

collisionMap_map37: .db #00, #167, #27, #02
			.db #37, #143, #45, #02, #0xff

deallocateMemory

allocateMemory 0x2000

collisionMap_map38: .db #00, #143, #22, #02
			.db #37, #119, #45, #02, #0xff

collisionMap_map39: .db #33, #143, #47, #02
			.db #00, #119, #22, #02, #0xff

collisionMap_map40: .db #31, #167, #49, #02
			.db #00, #143, #22, #02
			.db #53, #119, #10, #02, #0xff

collisionMap_map41: .db #00, #167, #46, #02
			.db #00, #119, #20, #02, #0xff

collisionMap_map42: .db #33, #167, #15, #02
			.db #57, #143, #23, #02, #0xff

collisionMap_map43: .db #00, #143, #22, #02
			.db  #37, #119, #05, #02
			.db  #53, #95, #27, #02, #0xff

collisionMap_map44: .db #53, #143, #27, #02
			.db #37, #119, #05, #02
			.db #00, #95, #26, #02, #0xff

collisionMap_map45: .db #31, #167, #17, #02
			.db #00, #143, #22, #02
			.db #57, #143, #23, #02, #0xff

collisionMap_map46: .db #53, #167, #27, #02
			.db #00, #95, #40, #02, #0xff

collisionMap_map47: .db #13, #167, #53, #02
			.db #33, #119, #13, #02, #0xff

collisionMap_map48: .db #00, #167, #26, #02
			.db #53, #167, #30, #02, #0xff

deallocateMemory

;;===================================================
;; BOSS BULLETS
;;===================================================

boss1: 	.db #20, #30, #0x00, #0x02
	.db #36, #30, #0x00, #0x04
	.db #60, #30, #0x00, #0x06
	.db #10, #160, #0x01, #0x00
	.db #70, #140, #0xff, #0x00
	.db #10, #140, #0x02, #0x00
	.db #70, #160, #0x01, #0x00
	.db #60, #30, #0x00, #0x08
	.db #70, #160, #0xff, #0x00
	.db #10, #140, #0x02, #0x00
	.db #30, #30, #0x00, #0x08
	.db #10, #140, #0x01, #0x00
	.db #70, #160, #0xff, #0x00
	.db #36, #30, #0x00, #0x08
	.db #70, #160, #0xff, #0x00
	.db #10, #140, #0x03, #0x00
	.db #10, #140, #0x03, #0x00
	.db #20, #30, #0x00, #0x08
	.db #36, #30, #0x00, #0x08
	.db #60, #30, #0x00, #0x08
	.db #0xff

;;===================================================
;; 
;; MAPS
;;
;;===================================================

maps_init:	;;initialization of our first map

	setBorder 57

	call collectables_draw_chars

	ld hl, #collisionMap_map
	call collision_setColMap

	ld hl, #_tInB_tileset
	call cpct_etm_setTileset2x4_asm

jp return_inits

;;===================================================
;; MAP 1
;;===================================================

map1_init:

	ld hl, #_tInB_tileset
	call cpct_etm_setTileset2x4_asm
	
	call collectables_draw_chars
	
	ld hl, #collisionMap_map
	call collision_setColMap

jp return_init

map1_end:
jp return_erase

;;===================================================
;; MAP 2
;;===================================================

map2_init:

	ld hl, #_tB_tileset
	call cpct_etm_setTileset2x4_asm
	
	call collectables_draw_chars

	ld hl, #collisionMap_map
	call collision_setColMap

jp return_init

map2_end:
jp return_erase

;;===================================================
;; MAP 3
;;===================================================

map3_init:

	call collectables_draw_chars

	ld bc, #0x3C98
	ld de, #0xFF00
	call add_turret1_right

	;ld a, #5
	;call utility_setcheckpoint


	ld hl, #collisionMap_map
	call collision_setColMap

jp return_init

map3_end:
	call remove_turret1_right
jp return_erase

;;===================================================
;; MAP 4
;;===================================================

map4_init:

	call collectables_draw_chars
	
	ld hl, #collisionMap_map2
	call collision_setColMap

	ld bc, #0x1498
	ld de, #0xff00
	call add_turret1_left

	ld bc, #0x4180
	ld de, #0xff00
	call add_turret2_right


jp return_init

map4_end:
	call remove_turret1_left
	call remove_turret2_right
jp return_erase

;;===================================================
;; MAP 5
;;===================================================

map5_init:

	call collectables_draw_chars
	
	ld hl, #collisionMap_map3
	call collision_setColMap

	ld bc, #0x1980
	ld de, #0xff00
	call add_turret2_left	

	ld bc, #0x4698
	ld de, #0xffff
	call add_turret1_right

	ld bc, #0x4032
	ld d, #0x32
	ld e, #0x45
	call add_obstacle1_right
	ld a, #1
	ld d, #2
	call obstacle_add_type

jp return_init

map5_end:
	call remove_turret2_left
	call remove_turret1_right
	call remove_obstacle1_right
jp return_erase


;;===================================================
;; MAP 6
;;===================================================

map6_init:

	call collectables_draw_chars
	
	ld hl, #collisionMap_map4
	call collision_setColMap

	ld bc, #0x1E98
	ld de, #0xFFFF
	call add_turret1_left

	ld bc, #0x1832
	ld d, #0x32
	ld e, #0x45
	call add_obstacle1_left
	ld a, #1
	ld d, #2
	call obstacle_add_type



jp return_init

map6_end:
	call remove_turret1_left
	call remove_obstacle1_left
jp return_erase

;;===================================================
;; MAP 7
;;===================================================

map7_init:

	call collectables_draw_chars

	ld hl, #collisionMap_map5
	call collision_setColMap

	ld bc, #0x2880
	ld de, #0xFF01
	call add_turret1_right

	ld bc, #0x3C98
	ld de, #0xFF00
	call add_turret2_right

	ld bc, #0x421A
	ld d, #0x1A
	ld e, #0x0
	call add_obstacle2_right
	ld a, #2
	ld d, #0
	call obstacle_add_type

	ld bc, #0x4158
	ld a, #0
	call platform_add

	ld bc, #0x3450
	ld a, #0
	call platform_add

	call collectables_get_chars1	;;check is collectable has already
	and #0b00001000			;;been added, just for chars
	jp nz, return_init	

	ld bc, #0x2532			;;add collectable
	ld de, #0x0208
	ld hl, #_sprite_phantisdinamic_4
	call collectables_add

jp return_init

map7_end:
	call remove_turret1_right
	call remove_turret2_right
	call remove_obstacle2_right
	call platform_remove
	call collectables_delete
jp return_erase

;;===================================================
;; MAP 8
;;===================================================

map8_init:

	call collectables_draw_chars

	ld hl, #collisionMap_map6
	call collision_setColMap

	ld bc, #0x2B4E
	ld de, #0xFF04
	call add_turret1_right

	ld bc, #0x1498
	ld de, #0xFF00
	call add_turret2_left

	ld bc, #0x4530
	ld d, #0x30
	ld e, #0x50
	call add_obstacle1_right
	ld a, #1
	ld d, #2
	call obstacle_add_type

	ld bc, #0x1A1A
	ld d, #0x1A
	ld e, #0x0
	call add_obstacle2_left
	ld a, #2
	ld d, #0
	call obstacle_add_type

	ld bc, #0x2C78
	ld a, #0
	call platform_add

	ld bc, #0x2960
	ld a, #0
	call platform_add

	ld bc, #0x1958
	ld a, #0
	call platform_add

	ld bc, #0x0C50
	ld a, #0
	call platform_add


jp return_init

map8_end:
	call remove_turret2_left
	call remove_turret1_right
	call remove_obstacle1_right
	call remove_obstacle2_left
	call platform_remove
jp return_erase

;;===================================================
;; MAP 9
;;===================================================

map9_init:

	call collectables_draw_chars

	ld hl, #collisionMap_map7
	call collision_setColMap

	ld bc, #0x034E
	ld de, #0xFF04
	call add_turret1_left

	ld bc, #0x2d68
	ld de, #0xFF01
	call add_turret2_right

	ld bc, #0x2730
	ld d, #0x30
	ld e, #0x50
	call add_obstacle1_left
	ld a, #1
	ld d, #2
	call obstacle_add_type

	ld bc, #0x0478
	ld a, #0
	call platform_add

	ld bc, #0x0160
	ld a, #0
	call platform_add

jp return_init

map9_end:
	call remove_turret2_right
	call remove_turret1_left
	call remove_obstacle1_left
	call platform_remove
jp return_erase

;;===================================================
;; MAP 10
;;===================================================

map10_init:

	call collectables_draw_chars

	ld a, #1
	call utility_setcheckpoint

	ld hl, #0x030E
	ld de, #_sprite_checkpoint
	ld bc, #0x106F
	call sprite_add

	ld hl, #collisionMap_map8
	call collision_setColMap

	ld bc, #0x1468
	ld de, #0xFF00
	call add_turret2_left

	ld bc, #0x3C98
	ld de, #0xFFFF
	call add_turret1_right


jp return_init

map10_end:
call sprite_remove
call remove_turret2_left
call remove_turret1_right
jp return_erase

;;===================================================
;; MAP 11
;;===================================================

map11_init:

	call collectables_draw_chars

	ld hl, #collisionMap_map9
	call collision_setColMap

	ld bc, #0x1498
	ld de, #0xFF00
	call add_turret1_left

	ld bc, #0x4198
	ld de, #0xFF00
	call add_turret2_right

	ld bc, #0x3030
	ld d, #0x30
	ld e, #0x45
	call add_obstacle1_right
	ld a, #1
	ld d, #0
	call obstacle_add_type

	ld bc, #0x2390
	ld a, #0
	call platform_add

	ld bc, #0x3A58
	ld a, #0
	call platform_add

	ld bc, #0x214E			;;add collectable
	ld de, #0x0140
	ld hl, #_sprite_powerups_1
	call collectables_add

	;call utility_setcheckpoint

jp return_init

map11_end:
	call remove_turret2_right
	call remove_turret1_left
	call platform_remove
	call remove_obstacle1_right
	call collectables_delete
jp return_erase

;;===================================================
;; MAP 12
;;===================================================

map12_init:


	call collectables_draw_chars

	ld hl, #collisionMap_map13
	call collision_setColMap

	ld bc, #0x1998
	ld de, #0xFF00
	call add_turret2_left


	ld bc, #0x3C68
	ld de, #0xFF02
	call add_turret1_right


	ld bc, #0x0845
	ld d, #0x45
	ld e, #0x35
	call add_obstacle1_left
	ld a, #1
	ld d, #0
	call obstacle_add_type

	ld bc, #0x3278
	ld d, #0x78
	ld e, #0x10
	call add_obstacle2_right
	ld a, #2
	ld d, #2
	call obstacle_add_type

	ld bc, #0x3A90
	ld a, #0
	call platform_add

	ld bc, #0x1258
	ld a, #0
	call platform_add

jp return_init

map12_end:
	call remove_turret1_right
	call remove_turret2_left
	call remove_obstacle1_left
	call remove_obstacle2_right
	call platform_remove
jp return_erase

;;===================================================
;; MAP 13
;;===================================================

map13_init:


	call collectables_draw_chars

	ld bc, #0x1468
	ld de, #0xFF02
	call add_turret1_left

	ld bc, #0x3C98
	ld de, #0xFF00
	call add_turret2_right

	ld bc, #0x0A78
	ld d, #0x78
	ld e, #0x10
	call add_obstacle2_left
	ld a, #2
	ld d, #2
	call obstacle_add_type

	ld bc, #0x1290
	ld a, #0
	call platform_add

	ld hl, #collisionMap_map14
	call collision_setColMap

jp return_init

map13_end:
	call remove_turret1_left
	call remove_turret2_right
	call remove_obstacle2_left
	call platform_remove
jp return_erase

;;===================================================
;; MAP 13_2
;;===================================================

map13_2_init:


	ld bc, #0x2380
	ld a, #0
	call platform_add

	ld bc, #0x3778
	ld a, #0
	call platform_add

	ld bc, #0x1480
	ld de, #0xFF00
	call add_turret2_left

	ld hl, #collisionMap_map13_2
	call collision_setColMap

jp return_init

map13_2_end:
	call remove_turret2_left
	call platform_remove
jp return_erase

;;===================================================
;; MAP 13_3
;;===================================================

map13_3_init:

	ld bc, #0x0F78
	ld a, #0
	call platform_add

	ld bc, #0x3C80
	ld de, #0xFF00
	call add_turret2_right

	ld hl, #collisionMap_map14_2
	call collision_setColMap

jp return_init

map13_3_end:
	call remove_turret2_right
	call platform_remove
jp return_erase

;;===================================================
;; MAP 14
;;===================================================

map14_init:

	call collectables_draw_chars

	ld bc, #0x1480
	ld de, #0xFF00
	call add_turret2_left

	ld bc, #0x3A50
	ld de, #0xFF01
	call add_turret1_right


	ld bc, #0x2D6B
	ld d, #0x6B
	ld e, #0x0
	call add_obstacle1_right
	ld a, #1
	ld d, #0
	call obstacle_add_type

	ld hl, #collisionMap_map10
	call collision_setColMap

jp return_init

map14_end:

	call remove_turret2_left
	call remove_turret1_right
	call remove_obstacle1_right

jp return_erase

;;===================================================
;; MAP 15
;;===================================================

map15_init:

	call collectables_draw_chars

	ld bc, #0x1250
	ld de, #0xFF01
	call add_turret1_left

	ld bc, #0x4098
	ld de, #0xFFFF
	call add_turret2_right

	ld bc, #0x056B
	ld d, #0x6B
	ld e, #0x0
	call add_obstacle1_left
	ld a, #1
	ld d, #0
	call obstacle_add_type

	ld bc, #0x3948
	ld a, #0
	call platform_add

	ld bc, #0x2935			;;add collectable
	ld de, #0x0140
	ld hl, #_sprite_powerups_1
	call collectables_add


	ld hl, #collisionMap_map11
	call collision_setColMap

jp return_init

map15_end:
	call remove_turret1_left
	call remove_turret2_right
	call remove_obstacle1_left
	call platform_remove
	call collectables_delete
jp return_erase

;;===================================================
;; MAP 18
;;===================================================

map18_init:

	call collectables_draw_chars

	ld hl, #collisionMap_map13_2
	call collision_setColMap

	ld bc, #0x1898
	ld de, #0xFFFF
	call add_turret2_left

	ld bc, #0x1148
	ld a, #0
	call platform_add

	ld bc, #0x2360
	ld a, #0
	call platform_add

	ld bc, #0x2390
	ld a, #0
	call platform_add

	ld bc, #0x3778
	ld a, #0
	call platform_add

	ld bc, #0x0135			;;add collectable
	ld de, #0x0140
	ld hl, #_sprite_powerups_1
	call collectables_add

jp return_init

map18_end:
	call remove_turret2_left
	call platform_remove
	call collectables_delete
jp return_erase

;;===================================================
;; MAP 19
;;===================================================

map19_init:

	call collectables_draw_chars

	ld bc, #0x0F78
	ld a, #0
	call platform_add

	ld bc, #0x2988
	ld a, #0
	call platform_add

	ld bc, #0x2050
	ld a, #0
	call platform_add

	ld bc, #0x3A48
	ld a, #0
	call platform_add

	ld bc, #0x3880
	ld a, #0
	call platform_add


	ld hl, #collisionMap_map0
	call collision_setColMap

jp return_init

map19_end:
	call platform_remove
jp return_erase


;;===================================================
;; MAP 22
;;===================================================

map22_init:

	ld hl, #_tB_tileset
	call cpct_etm_setTileset2x4_asm
	
	call collectables_draw_chars

	ld bc, #0x2590
	ld a, #0
	call platform_add

	ld bc, #0x1248
	ld a, #0
	call platform_add

	ld bc, #0x1080
	ld a, #0
	call platform_add

	ld hl, #collisionMap_map33
	call collision_setColMap

	call collectables_get_chars1	;;check is collectable has already
	and #0b00100000			;;been added, just for chars
	jp nz, return_init	

	ld bc, #0x2B3A			;;add collectable
	ld de, #0x0220
	ld hl, #_sprite_phantisdinamic_2
	call collectables_add

jp return_init

map22_end:
	call platform_remove
	call collectables_delete
jp return_erase


;;===================================================
;; MAP 23
;;===================================================

map23_init:

	ld hl, #_tB2J_tileset
	call cpct_etm_setTileset2x4_asm

	setBorder 57
	
	call collectables_draw_chars
	
	ld hl, #collisionMap_map
	call collision_setColMap

	call collectables_get_chars1	;;check is collectable has already
	and #0b00100000			;;been added, just for chars
	jp nz, return_init	

	ld bc, #0x033A			;;add collectable
	ld de, #0x0220
	ld hl, #_sprite_phantisdinamic_2
	call collectables_add

jp return_init

map23_end:
	call collectables_delete
jp return_erase

;;===============
;;START JUNGLE
;;===============

;;===================================================
;; MAP 24
;;===================================================

map24_init:

	ld hl, #_tB2J_tileset
	call cpct_etm_setTileset2x4_asm
	
	setBorder 44

	call collectables_draw_chars
	
	ld hl, #collisionMap_map
	call collision_setColMap

jp return_init

map24_end:
jp return_erase

;;===================================================
;; MAP 25
;;===================================================

map25_init:

	ld hl, #_tB2J_tileset
	call cpct_etm_setTileset2x4_asm
	
	call collectables_draw_chars
	
	ld hl, #collisionMap_map
	call collision_setColMap

jp return_init

map25_end:
jp return_erase

;;===================================================
;; MAP 26
;;===================================================

map26_init:

	ld a, #2
	call utility_setcheckpoint

	ld hl, #_tJ_tileset
	call cpct_etm_setTileset2x4_asm
	
	call collectables_draw_chars
	
	ld hl, #0x030E
	ld de, #_sprite_checkpoint
	ld bc, #0x109F
	call sprite_add

	ld hl, #collisionMap_map
	call collision_setColMap

	ld bc, #0x4698
	ld de, #0xFF00
	call add_turret1_right

jp return_init

map26_end:
	call remove_turret1_right
	call sprite_remove
jp return_erase


;;===================================================
;; MAP 27
;;===================================================

map27_init:
	
	call collectables_draw_chars
	
	ld hl, #collisionMap_map18 		
	call collision_setColMap
	
	ld bc, #0x1E98
	ld de, #0xFF00
	call add_turret1_left

	ld bc, #0x3C80
	ld de, #0xFF01
	call add_turret2_right

	ld bc, #0x313A
	ld d, #0x3A
	ld e, #0x0
	call add_obstacle1_right
	ld a, #1
	ld d, #5
	call obstacle_add_type
	ld de, #0x0202
	ld a, #1
	call obstacle_add_bullet

jp return_init

map27_end:
	call remove_turret1_left
	call remove_turret2_right
	call remove_obstacle1_right
jp return_erase

;;===================================================
;; MAP 28
;;===================================================

map28_init:
	
	call collectables_draw_chars
	
	ld hl, #collisionMap_map7
	call collision_setColMap

	ld bc, #0x1480
	ld de, #0xFF00
	call add_turret2_left

	ld bc, #0x3C68
	ld de, #0xFF00
	call add_turret1_right

	ld bc, #0x093A
	ld d, #0x3A
	ld e, #0x0
	call add_obstacle1_left
	ld a, #1
	ld d, #5
	call obstacle_add_type
	ld de, #0x0202
	ld a, #1
	call obstacle_add_bullet

	ld bc, #0x2F40
	ld d, #0x40
	ld e, #0x0
	call add_obstacle2_right
	ld a, #2
	ld d, #5
	call obstacle_add_type
	ld de, #0xFF02
	ld a, #2
	call obstacle_add_bullet

jp return_init

map28_end:
	call remove_turret1_right
	call remove_turret2_left
	call remove_obstacle2_right
	call remove_obstacle1_left
jp return_erase

;;===================================================
;; MAP 29
;;===================================================

map29_init:
	
	call collectables_draw_chars
	
	ld hl, #collisionMap_map16
	call collision_setColMap

	ld bc, #0x1468
	ld de, #0xFF00
	call add_turret1_left

	ld bc, #0x3280
	ld de, #0xFFFF
	call add_turret2_right

	ld bc, #0x0740
	ld d, #0x40
	ld e, #0x0
	call add_obstacle2_left
	ld a, #2
	ld d, #5
	call obstacle_add_type
	ld de, #0xFF02
	ld a, #2
	call obstacle_add_bullet

	ld bc, #0x2E40
	ld d, #0x40
	ld e, #0x0
	call add_obstacle1_right
	ld a, #1
	ld d, #5
	call obstacle_add_type
	ld de, #0xFF04
	ld a, #1
	call obstacle_add_bullet

	ld bc, #0x443D
	ld d, #0x3D
	ld e, #0x0
	call add_obstacle3_right
	ld a, #3
	ld d, #5
	call obstacle_add_type
	ld de, #0x0004
	ld a, #3
	call obstacle_add_bullet

jp return_init

map29_end:
	call remove_turret1_left
	call remove_turret2_right
	call remove_obstacle2_left
	call remove_obstacle1_right
	call remove_obstacle3_right
jp return_erase

;;===================================================
;; MAP 30
;;===================================================

map30_init:
	
	call collectables_draw_chars
	
	ld hl, #collisionMap_map19 		
	call collision_setColMap

	ld bc, #0x0A80
	ld de, #0xFF00
	call add_turret2_left

	ld bc, #0x2D98
	ld de, #0xFFFF
	call add_turret1_right

	ld bc, #0x0640
	ld d, #0x40
	ld e, #0x0
	call add_obstacle1_left
	ld a, #1
	ld d, #5
	call obstacle_add_type
	ld de, #0xFF04
	ld a, #1
	call obstacle_add_bullet

	ld bc, #0x1C3D
	ld d, #0x3D
	ld e, #0x0
	call add_obstacle3_left
	ld a, #3
	ld d, #5
	call obstacle_add_type
	ld de, #0x0004
	ld a, #3
	call obstacle_add_bullet

	ld bc, #0x454B
	ld d, #0x4B
	ld e, #0x3C
	call add_obstacle2_right
	ld a, #2
	ld d, #2
	call obstacle_add_type

jp return_init

map30_end:
	call remove_turret2_left
	call remove_turret1_right
	call remove_obstacle1_left
	call remove_obstacle3_left
	call remove_obstacle2_right
jp return_erase

;;===================================================
;; MAP 31
;;===================================================

map31_init:
	
	call collectables_draw_chars
	
	ld hl, #collisionMap_map20 		
	call collision_setColMap

	ld bc, #0x0598
	ld de, #0xFFFF
	call add_turret1_left

	ld bc, #0x3C80
	ld de, #0xFF00
	call add_turret2_right

	ld bc, #0x1D4B
	ld d, #0x4B
	ld e, #0x3C
	call add_obstacle2_left
	ld a, #2
	ld d, #2
	call obstacle_add_type

	ld bc, #0x4350
	ld d, #0x50
	ld e, #0x0
	call add_obstacle1_right
	ld a, #1
	ld d, #5
	call obstacle_add_type
	ld de, #0xFF02
	ld a, #1
	call obstacle_add_bullet

jp return_init

map31_end:
	call remove_turret2_right
	call remove_turret1_left
	call remove_obstacle2_left
	call remove_obstacle1_right
jp return_erase

;;===================================================
;; MAP 32
;;===================================================

map32_init:
	
	call collectables_draw_chars
	
	ld hl, #collisionMap_map17
	call collision_setColMap

	ld bc, #0x1480
	ld de, #0xFF00
	call add_turret2_left

	ld bc, #0x1B50
	ld d, #0x50
	ld e, #0x0
	call add_obstacle1_left
	ld a, #1
	ld d, #5
	call obstacle_add_type
	ld de, #0xFF02
	ld a, #1
	call obstacle_add_bullet


	call collectables_get_chars1	;;check is collectable has already
	and #0b10000000			;;been added, just for chars
	jp nz, return_init	

	ld bc, #0x4430			;;add collectable
	ld de, #0x0280
	ld hl, #_sprite_phantisdinamic_0
	call collectables_add

jp return_init

map32_end:
	call remove_turret2_left
	call remove_obstacle1_left
	call collectables_delete
jp return_erase

;;===================================================
;; MAP 33
;;===================================================

map33_init:
	
	call collectables_draw_chars
	
	ld bc, #0x2F90
	ld a, #1
	call platform_add

	ld hl, #collisionMap_map21
	call collision_setColMap

	ld bc, #0x3C68
	ld de, #0xFF00
	call add_turret1_right

	call collectables_get_chars1	;;check is collectable has already
	and #0b10000000			;;been added, just for chars
	jp nz, return_init	

	ld bc, #0x1C30			;;add collectable
	ld de, #0x0280
	ld hl, #_sprite_phantisdinamic_0
	call collectables_add

jp return_init

map33_end:
	call remove_turret1_right
	call platform_remove
	call collectables_delete
jp return_erase

;;===================================================
;; MAP 34
;;===================================================

map34_init:
	
	ld a, #3
	call utility_setcheckpoint

	ld hl, #0x030E
	ld de, #_sprite_checkpoint
	ld bc, #0x106F
	call sprite_add


	call collectables_draw_chars
	
	ld bc, #0x0790
	ld a, #1
	call platform_add

	ld hl, #collisionMap_map22
	call collision_setColMap

	ld bc, #0x1468
	ld de, #0xFF00
	call add_turret1_left

	ld bc, #0x3C98
	ld de, #0xFFFF
	call add_turret2_right

jp return_init

map34_end:
	call sprite_remove
	call remove_turret1_left
	call remove_turret2_right
	call platform_remove
jp return_erase

;;===================================================
;; MAP 35
;;===================================================

map35_init:
	
	call collectables_draw_chars
	

	ld hl, #collisionMap_map9
	call collision_setColMap

	ld bc, #0x1498
	ld de, #0xFFFF
	call add_turret2_left

	ld bc, #0x3798
	ld de, #0xFF00
	call add_turret1_right


	ld bc, #0x3054
	ld d, #0x54
	ld e, #0x0
	call add_obstacle1_right
	ld a, #1
	ld d, #0
	call obstacle_add_type

	ld bc, #0x2398
	ld a, #1
	call platform_add

	ld bc, #0x3A60
	ld a, #1
	call platform_add

	ld bc, #0x2950			;;add collectable
	ld de, #0x0140
	ld hl, #_sprite_powerups_1
	call collectables_add

jp return_init

map35_end:
	call remove_turret1_right
	call platform_remove
	call remove_turret2_left
	call remove_obstacle1_right
	call collectables_delete
jp return_erase

;;===================================================
;; MAP 36
;;===================================================

map36_init:
	
	call collectables_draw_chars

	ld hl, #collisionMap_map23
	call collision_setColMap

	ld bc, #0x0F98
	ld de, #0xFF00
	call add_turret1_left

	ld bc, #0x0854
	ld d, #0x54
	ld e, #0x0
	call add_obstacle1_left
	ld a, #1
	ld d, #0
	call obstacle_add_type

	ld bc, #0x3A90
	ld a, #1
	call platform_add

	ld bc, #0x1260
	ld a, #1
	call platform_add

	ld bc, #0x0150			;;add collectable
	ld de, #0x0140
	ld hl, #_sprite_powerups_1
	call collectables_add

jp return_init

map36_end:
	call platform_remove
	call remove_turret1_left
	call remove_obstacle1_left
	call collectables_delete
jp return_erase

;;===================================================
;; MAP 37
;;===================================================

map37_init:
	
	call collectables_draw_chars
	
	ld hl, #collisionMap_map24
	call collision_setColMap

	ld bc, #0x3780
	ld de, #0xFF01
	call add_turret1_right

	ld bc, #0x1290
	ld a, #1
	call platform_add

	ld bc, #0x4630			;;add collectable
	ld de, #0x0110
	ld hl, #_sprite_powerups_3
	call collectables_add

jp return_init

map37_end:
	call remove_turret1_right
	call platform_remove
	call collectables_delete
jp return_erase

;;===================================================
;; MAP 38
;;===================================================

map38_init:
	
	call collectables_draw_chars
	
	ld hl, #collisionMap_map25
	call collision_setColMap

	ld bc, #0x0F80
	ld de, #0xFF01
	call add_turret1_left

	ld bc, #0x3C50
	ld de, #0xFF01
	call add_turret2_right

	ld bc, #0x2F85
	ld d, #0x85
	ld e, #0x0
	call add_obstacle1_right
	ld a, #1
	ld d, #5
	call obstacle_add_type
	ld de, #0xFFFF
	ld a, #1
	call obstacle_add_bullet

	ld bc, #0x3040
	ld d, #0x40
	ld e, #0x0
	call add_obstacle2_right
	ld a, #2
	ld d, #5
	call obstacle_add_type
	ld de, #0xFF02
	ld a, #2
	call obstacle_add_bullet


	ld bc, #0x1E30			;;add collectable
	ld de, #0x0110
	ld hl, #_sprite_powerups_3
	call collectables_add

jp return_init

map38_end:
	call remove_turret1_left
	call remove_turret2_right
	call remove_obstacle1_right
	call remove_obstacle2_right
	call collectables_delete
jp return_erase


;;===================================================
;; MAP 39
;;===================================================

map39_init:
	
	call collectables_draw_chars
	
	ld hl, #collisionMap_map26
	call collision_setColMap
	
	ld bc, #0x1450
	ld de, #0xFF01
	call add_turret2_left

	ld bc, #0x3C80
	ld de, #0xFFFF
	call add_turret1_right

	ld bc, #0x0785
	ld d, #0x85
	ld e, #0x0
	call add_obstacle1_left
	ld a, #1
	ld d, #5
	call obstacle_add_type
	ld de, #0xFFFF
	ld a, #1
	call obstacle_add_bullet

	ld bc, #0x0840
	ld d, #0x40
	ld e, #0x0
	call add_obstacle2_left
	ld a, #2
	ld d, #5
	call obstacle_add_type
	ld de, #0xFF02
	ld a, #2
	call obstacle_add_bullet


	call collectables_get_chars1	;;check is collectable has already
	and #0b00000010		;;been added, just for chars
	jp nz, return_init	

	ld bc, #0x4C48			;;add collectable
	ld de, #0x0202
	ld hl, #_sprite_phantisdinamic_6
	call collectables_add


jp return_init

map39_end:
	call remove_turret2_left
	call remove_turret1_right
	call remove_obstacle1_left
	call remove_obstacle2_left
	call collectables_delete
jp return_erase

;;===================================================
;; MAP 40
;;===================================================

map40_init:
	
	call collectables_draw_chars
		
	ld bc, #0x1480
	ld de, #0xFFFF
	call add_turret1_left

	ld bc, #0x3798
	ld a, #1
	call platform_add

	ld hl, #collisionMap_map27
	call collision_setColMap

	call collectables_get_chars1	;;check is collectable has already
	and #0b00000010		;;been added, just for chars
	jp nz, return_init	

	ld bc, #0x2448			;;add collectable
	ld de, #0x0202
	ld hl, #_sprite_phantisdinamic_6
	call collectables_add

jp return_init

map40_end:
	call remove_turret1_left
	call platform_remove
	call collectables_delete
jp return_erase


;;===================================================
;; MAP 42
;;===================================================

map42_init:
	
	call collectables_draw_chars
	
	ld bc, #0x1098
	ld a, #1
	call platform_add

	ld bc, #0x4540
	ld d, #0x40
	ld e, #0x0
	call add_obstacle1_right
	ld a, #1
	ld d, #5
	call obstacle_add_type
	ld de, #0x0004
	ld a, #1
	call obstacle_add_bullet

	ld hl, #collisionMap_map28
	call collision_setColMap

jp return_init

map42_end:
	call platform_remove
	call remove_obstacle1_right
jp return_erase

;;===================================================
;; MAP 43
;;===================================================

map43_init:
	
	call collectables_draw_chars

	ld bc, #0x1D40
	ld d, #0x40
	ld e, #0x0
	call add_obstacle1_left
	ld a, #1
	ld d, #5
	call obstacle_add_type
	ld de, #0x0004
	ld a, #1
	call obstacle_add_bullet

	ld bc, #0x3238
	ld d, #0x38
	ld e, #0x0
	call add_obstacle2_right
	ld a, #2
	ld d, #5
	call obstacle_add_type
	ld de, #0x0004
	ld a, #2
	call obstacle_add_bullet

	ld bc, #0x3F79
	ld d, #0x79
	ld e, #0x0
	call add_obstacle3_right
	ld a, #3
	ld d, #5
	call obstacle_add_type
	ld de, #0xFF00
	ld a, #3
	call obstacle_add_bullet

	ld hl, #collisionMap_map29
	call collision_setColMap


jp return_init

map43_end:
	call remove_obstacle1_left
	call remove_obstacle2_right
	call remove_obstacle3_right
jp return_erase

;;===================================================
;; MAP 46
;;===================================================

map46_init:

	ld hl, #_tJ_tileset
	call cpct_etm_setTileset2x4_asm


	call collectables_draw_chars
	
	ld bc, #0x0A38
	ld d, #0x38
	ld e, #0x0
	call add_obstacle2_left
	ld a, #2
	ld d, #5
	call obstacle_add_type
	ld de, #0x0004
	ld a, #2
	call obstacle_add_bullet

	ld bc, #0x1779
	ld d, #0x79
	ld e, #0x0
	call add_obstacle3_left
	ld a, #3
	ld d, #5
	call obstacle_add_type
	ld de, #0xFF00
	ld a, #3
	call obstacle_add_bullet

	ld hl, #collisionMap_map
	call collision_setColMap

jp return_init

map46_end:
	call remove_obstacle2_left
	call remove_obstacle3_left
jp return_erase

;;===================================================
;; MAP 47
;;===================================================

map47_init:

	ld hl, #_tJ2F_tileset
	call cpct_etm_setTileset2x4_asm
	
	setBorder 44

	call collectables_draw_chars
	
	ld hl, #collisionMap_map
	call collision_setColMap

jp return_init

map47_end:
jp return_erase

;;===============
;;START TRON
;;===============

;;===================================================
;; MAP 48
;;===================================================

map48_init:

	ld a, #4
	call utility_setcheckpoint

	ld hl, #_tJ2F_tileset
	call cpct_etm_setTileset2x4_asm

	setBorder 54

	ld hl, #0x030E
	ld de, #_sprite_checkpoint
	ld bc, #0x109F
	call sprite_add

	call collectables_draw_chars
	
	ld hl, #collisionMap_map
	call collision_setColMap

jp return_init

map48_end:
	call sprite_remove
jp return_erase

;;===================================================
;; MAP 49
;;===================================================

map49_init:
	
	ld hl, #_tJ2F_tileset
	call cpct_etm_setTileset2x4_asm

	call collectables_draw_chars
	
	ld hl, #collisionMap_map
	call collision_setColMap

jp return_init

map49_end:
jp return_erase


;;===================================================
;; MAP 50
;;===================================================
map50_init:

	ld hl, #_tF_tileset
	call cpct_etm_setTileset2x4_asm
	
	call collectables_draw_chars
	
	ld hl, #collisionMap_map
	call collision_setColMap

	ld bc, #0x2D98
	ld d, #0x01
	ld e, #0x01
	ld a, #0
	call obstacle_add
	ld a, #1
	ld d, #3
	call obstacle_add_type
	ld de, #0xFF00
	ld a, #1
	call obstacle_add_bullet

jp return_init

map50_end:
	ld a, #0
	call obstacle_remove
jp return_erase


;;===================================================
;; MAP 51
;;===================================================
map51_init:

	call collectables_draw_chars
	

	ld hl, #collisionMap_map34
	call collision_setColMap

	ld bc, #0x3468
	ld de, #0xFF02
	call add_turret1_right

	ld bc, #0x2D98
	ld d, #0x01
	ld e, #0x01
	ld a, #0
	call obstacle_add
	ld a, #1
	ld d, #3
	call obstacle_add_type
	ld de, #0xFF00
	ld a, #1
	call obstacle_add_bullet

	call collectables_get_chars1	;;check is collectable has already
	and #0b00000100		;;been added, just for chars
	jp nz, return_init	

	ld bc, #0x3C60			;;add collectable
	ld de, #0x0204
	ld hl, #_sprite_phantisdinamic_5
	call collectables_add

jp return_init

map51_end:
	call collectables_delete
	ld a, #0
	call obstacle_remove
	call remove_turret1_right
jp return_erase


;;===================================================
;; MAP 52
;;===================================================
;;OBS DE TIPO 4 APUNTANDO EN DIAGONAL ABAJO IZQ O IZQ
map52_init:

	call collectables_draw_chars
	
	ld hl, #collisionMap_map35
	call collision_setColMap

	ld bc, #0x1198
	ld de, #0xFF02
	call add_turret1_left

	ld bc, #0x3C80
	ld de, #0xFF01
	call add_turret2_right

	ld bc, #0x3558
	ld d, #0x58
	ld e, #0x30
	call add_obstacle1_right
	ld a, #1
	ld d, #4
	call obstacle_add_type
	ld de, #0xFF01
	ld a, #1
	call obstacle_add_bullet

	call collectables_get_chars1	;;check is collectable has already
	and #0b00000100		;;been added, just for chars
	jp nz, return_init	

	ld bc, #0x1460			;;add collectable
	ld de, #0x0204
	ld hl, #_sprite_phantisdinamic_5
	call collectables_add

jp return_init

map52_end:
	call collectables_delete
	call remove_turret1_left
	call remove_turret2_right
	call remove_obstacle1_right
jp return_erase


;;===================================================
;; MAP 53
;;===================================================

map53_init:

	call collectables_draw_chars
	
	ld hl, #collisionMap_map3
	call collision_setColMap

	ld bc, #0x1480
	ld de, #0xFF01
	call add_turret2_left


	ld bc, #0x0D58
	ld d, #0x58
	ld e, #0x30
	call add_obstacle1_left
	ld a, #1
	ld d, #4
	call obstacle_add_type
	ld de, #0xFF01
	ld a, #1
	call obstacle_add_bullet

	ld bc, #0x2B80
	ld d, #0x01
	ld e, #0x01
	ld a, #1
	call obstacle_add
	ld a, #2
	ld d, #3
	call obstacle_add_type
	ld de, #0xFF00
	ld a, #2
	call obstacle_add_bullet

	ld bc, #0x3558
	ld d, #0x58
	ld e, #0x00
	call add_obstacle3_right
	ld a, #3
	ld d, #5
	call obstacle_add_type
	ld de, #0xFF01
	ld a, #3
	call obstacle_add_bullet

jp return_init

map53_end:
	call remove_turret2_left
	call remove_obstacle1_left
	ld a, #1
	call obstacle_remove
	call remove_obstacle3_right
jp return_erase

;;===================================================
;; MAP 54
;;===================================================

map54_init:

	call collectables_draw_chars
	
	ld bc, #0x0D58
	ld d, #0x58
	ld e, #0x00
	call add_obstacle3_left
	ld a, #3
	ld d, #5
	call obstacle_add_type
	ld de, #0xFF01
	ld a, #3
	call obstacle_add_bullet

	ld bc, #0x2E83
	ld d, #0x83
	ld e, #0x00
	call add_obstacle1_right
	ld a, #1
	ld d, #5
	call obstacle_add_type
	ld de, #0xFF00
	ld a, #1
	call obstacle_add_bullet

	ld hl, #collisionMap_map36 
	call collision_setColMap

	ld bc, #0x3780
	ld a, #2
	call platform_add

jp return_init

map54_end:
	call remove_obstacle3_left
	call remove_obstacle1_right
	call platform_remove
jp return_erase


;;===================================================
;; MAP 55
;;===================================================

map55_init:

	call collectables_draw_chars

	ld bc, #0x3280
	ld de, #0xFF00
	call add_turret2_right

	ld bc, #0x0683
	ld d, #0x83
	ld e, #0x00
	call add_obstacle1_left
	ld a, #1
	ld d, #5
	call obstacle_add_type
	ld de, #0xFF00
	ld a, #1
	call obstacle_add_bullet

	ld hl, #collisionMap_map37
	call collision_setColMap

	ld bc, #0x2D67
	ld d, #0x67
	ld e, #0x00
	call add_obstacle2_right
	ld a, #2
	ld d, #5
	call obstacle_add_type
	ld de, #0xFF02
	ld a, #2
	call obstacle_add_bullet

	ld bc, #0x2B80			;;add collectable
	ld de, #0x0140
	ld hl, #_sprite_powerups_1
	call collectables_add

	ld bc, #0x0F80
	ld a, #2
	call platform_add

jp return_init

map55_end:
	call remove_obstacle1_left
	call remove_obstacle2_right
	call remove_turret2_right
	call collectables_delete
	call platform_remove
jp return_erase


;;===================================================
;; MAP 56
;;===================================================

map56_init:

	call collectables_draw_chars
	

	ld bc, #0x0380			;;add collectable
	ld de, #0x0140
	ld hl, #_sprite_powerups_1
	call collectables_add

	ld hl, #collisionMap_map38
	call collision_setColMap

	ld bc, #0x3268
	ld de, #0xFF01
	call add_turret1_right

	ld bc, #0x0A80
	ld de, #0xFF00
	call add_turret2_left

	ld bc, #0x0567
	ld d, #0x67
	ld e, #0x00
	call add_obstacle2_left
	ld a, #2
	ld d, #5
	call obstacle_add_type
	ld de, #0xFF02
	ld a, #2
	call obstacle_add_bullet

	ld bc, #0x2D6A
	ld d, #0x6A
	ld e, #0x00
	call add_obstacle3_right
	ld a, #3
	ld d, #0
	call obstacle_add_type

jp return_init

map56_end:
	call remove_turret1_right
	call remove_obstacle2_left
	call remove_obstacle3_right
	call remove_turret2_left
	call collectables_delete
jp return_erase


;;===================================================
;; MAP 57
;;===================================================

map57_init:

	call collectables_draw_chars
	
	ld hl, #collisionMap_map39
	call collision_setColMap

	ld bc, #0x0A68
	ld de, #0xFF01
	call add_turret1_left


	ld bc, #0x056A
	ld d, #0x6A
	ld e, #0x00
	call add_obstacle3_left
	ld a, #3
	ld d, #0
	call obstacle_add_type


jp return_init

map57_end:
	call remove_turret1_left
	call remove_obstacle3_left
jp return_erase

;;===================================================
;; MAP 58
;;===================================================

map58_init:

	ld a, #5
	call utility_setcheckpoint

	call collectables_draw_chars

	ld hl, #collisionMap_map40 		
	call collision_setColMap

	ld hl, #0x030E
	ld de, #_sprite_checkpoint
	ld bc, #0x1086
	call sprite_add

	ld bc, #0x3760			;;add collectable
	ld de, #0x0110
	ld hl, #_sprite_powerups_3
	call collectables_add

	ld bc, #0x3C40
	ld d, #0x40
	ld e, #0x30
	call add_obstacle1_right
	ld a, #1
	ld d, #4
	call obstacle_add_type
	ld de, #0xFF01
	ld a, #1
	call obstacle_add_bullet

	ld bc, #0x2D80
	ld d, #0x80
	ld e, #0x30
	call add_obstacle2_right
	ld a, #2
	ld d, #4
	call obstacle_add_type
	ld de, #0xFFFF
	ld a, #2
	call obstacle_add_bullet

jp return_init

map58_end:
	call remove_obstacle1_right
	call remove_obstacle2_right
	call sprite_remove
	call collectables_delete
jp return_erase

;;===================================================
;; MAP 59
;;===================================================

map59_init:

	call collectables_draw_chars
	
	ld hl, #collisionMap_map41
	call collision_setColMap

	ld bc, #0x0F60			;;add collectable
	ld de, #0x0110
	ld hl, #_sprite_powerups_3
	call collectables_add

	ld bc, #0x3890
	ld a, #2
	call platform_add

	ld bc, #0x1440
	ld d, #0x40
	ld e, #0x30
	call add_obstacle1_left
	ld a, #1
	ld d, #4
	call obstacle_add_type
	ld de, #0xFF01
	ld a, #1
	call obstacle_add_bullet

	ld bc, #0x0580
	ld d, #0x80
	ld e, #0x30
	call add_obstacle2_left
	ld a, #2
	ld d, #4
	call obstacle_add_type
	ld de, #0xFFFF
	ld a, #2
	call obstacle_add_bullet

jp return_init

map59_end:
	call remove_obstacle1_left
	call remove_obstacle2_left
	call platform_remove
	call collectables_delete
jp return_erase

;;===================================================
;; MAP 60
;;===================================================

map60_init:

	call collectables_draw_chars
	
	ld hl, #collisionMap_map42
	call collision_setColMap

	ld bc, #0x1090
	ld a, #2
	call platform_add

jp return_init

map60_end:
	call platform_remove
jp return_erase


;;===================================================
;; MAP 61
;;===================================================

map61_init:

	call collectables_draw_chars
	
	ld hl, #collisionMap_map43
	call collision_setColMap

	ld bc, #0x4140
	ld d, #0x40
	ld e, #0x00
	call add_obstacle1_right
	ld a, #1
	ld d, #5
	call obstacle_add_type
	ld de, #0xFF01
	ld a, #1
	call obstacle_add_bullet

	ld bc, #0x4650
	ld d, #0x50
	ld e, #0x45
	call add_obstacle2_right
	ld a, #2
	ld d, #0
	call obstacle_add_type

	ld bc, #0x3C50
	ld de, #0xFF01
	call add_turret1_right

	call collectables_get_chars1	;;check is collectable has already
	and #0b01000000		;;been added, just for chars
	jp nz, return_init	

	ld bc, #0x4842			;;add collectable
	ld de, #0x0240
	ld hl, #_sprite_phantisdinamic_1
	call collectables_add

jp return_init

map61_end:
	call collectables_delete
	call remove_turret1_right
	call remove_obstacle1_right
	call remove_obstacle2_right
jp return_erase


;;===================================================
;; MAP 62
;;===================================================

map62_init:

	call collectables_draw_chars
	
	ld hl, #collisionMap_map44
	call collision_setColMap

	ld bc, #0x0F40
	ld d, #0x40
	ld e, #0x00
	call add_obstacle1_left
	ld a, #1
	ld d, #5
	call obstacle_add_type
	ld de, #0xFF01
	ld a, #1
	call obstacle_add_bullet

	ld bc, #0x1450
	ld de, #0xFF01
	call add_turret1_left

	ld bc, #0x1B70
	ld a, #2
	call platform_add

	ld bc, #0x2050
	ld d, #0x50
	ld e, #0x45
	call add_obstacle2_left
	ld a, #2
	ld d, #0
	call obstacle_add_type

	call collectables_get_chars1	;;check is collectable has already
	and #0b01000000		;;been added, just for chars
	jp nz, return_init	

	ld bc, #0x2042			;;add collectable
	ld de, #0x0240
	ld hl, #_sprite_phantisdinamic_1
	call collectables_add

	ld bc, #0x4650
	ld d, #0x50
	ld e, #0x50
	call add_obstacle3_right
	ld a, #3
	ld d, #0
	call obstacle_add_type

jp return_init

map62_end:
	call collectables_delete
	call remove_turret1_left
	call remove_obstacle1_left
	call remove_obstacle2_left
	call remove_obstacle3_right
	call platform_remove
jp return_erase

;;===================================================
;; MAP 63
;;===================================================

map63_init:

	call collectables_draw_chars
	
	ld hl, #collisionMap_map45
	call collision_setColMap

	ld bc, #0x1E50
	ld d, #0x50
	ld e, #0x50
	call add_obstacle3_left
	ld a, #3
	ld d, #0
	call obstacle_add_type

	ld bc, #0x3250
	ld d, #0x50
	ld e, #0x40
	call add_obstacle1_right
	ld a, #1
	ld d, #4
	call obstacle_add_type
	ld de, #0xFF00
	ld a, #1
	call obstacle_add_bullet

jp return_init

map63_end:
	call remove_obstacle3_left
	call remove_obstacle1_right
jp return_erase

;;===================================================
;; MAP 64
;;===================================================

map64_init:

	call collectables_draw_chars
	
	ld hl, #collisionMap_map43
	call collision_setColMap

	ld bc, #0x4650
	ld de, #0xFF00
	call add_turret1_right

	ld bc, #0x0A50
	ld d, #0x50
	ld e, #0x40
	call add_obstacle1_left
	ld a, #1
	ld d, #4
	call obstacle_add_type
	ld de, #0xFF00
	ld a, #1
	call obstacle_add_bullet

	ld bc, #0x373E
	ld d, #0x3E
	ld e, #0x0
	call add_obstacle2_right
	ld a, #2
	ld d, #5
	call obstacle_add_type
	ld de, #0xFF02
	ld a, #2
	call obstacle_add_bullet

jp return_init

map64_end:
	call remove_obstacle1_left
	call remove_obstacle2_right
	call remove_turret1_right
jp return_erase

;;===================================================
;; MAP 65
;;===================================================

map65_init:

	call collectables_draw_chars
	
	ld bc, #0x1E50
	ld de, #0xFF00
	call add_turret1_left

	ld bc, #0x0F3E
	ld d, #0x3E
	ld e, #0x0
	call add_obstacle2_left
	ld a, #2
	ld d, #5
	call obstacle_add_type
	ld de, #0xFF02
	ld a, #2
	call obstacle_add_bullet

	ld hl, #collisionMap_map46
	call collision_setColMap

jp return_init

map65_end:
	call remove_obstacle2_left
	call remove_turret1_left
jp return_erase

;;===================================================
;; MAP 66
;;===================================================

map66_init:

	call collectables_draw_chars

	ld hl, #boss1
	call miniboss_add

	ld hl, #collisionMap_map47
	call collision_setColMap

jp return_init

map66_end:
call miniboss_remove
jp return_erase

;;===================================================
;; MAP 67
;;===================================================

map67_init:

	call collectables_draw_chars
							
	ld bc, #0x2690
	ld a, #2
	call platform_add

	ld hl, #collisionMap_map48
	call collision_setColMap

	call collectables_get_chars1	;;check is collectable has already
	and #0b00010000		;;been added, just for chars
	jp nz, return_init	

	ld bc, #0x3C98			;;add collectable
	ld de, #0x0210
	ld hl, #_sprite_phantisdinamic_3
	call collectables_add

jp return_init

map67_end:
call platform_remove
call collectables_delete
jp return_erase

;;===================================================
;; MAP 68
;;===================================================

map68_init:

	call collectables_draw_chars
	
	ld hl, #collisionMap_map
	call collision_setColMap

	call collectables_get_chars1	;;check is collectable has already
	and #0b00010000		;;been added, just for chars
	jp nz, return_init	

	ld bc, #0x1498			;;add collectable
	ld de, #0x0210
	ld hl, #_sprite_phantisdinamic_3
	call collectables_add

jp return_init

map68_end:
	call collectables_delete
jp return_erase

;;===================================================
;; MAP 69
;;===================================================

map69_init:
	
	call draw_end
	



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;ENEMIES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;ld bc, #0x0F98 		;;turret position, x,y
;;ld de, #0xFF00		;;turret bullet direction
add_turret1_left:
	;;ENEMY TURRET SECOND HALF
	call player_getDir	;;if we come from the right (we are facing left) (flag nZ)
	ld a, #0
	call nz, turret_add	;;add turret if we come from the right

	;;UPDATE SECOND HALF IF WE COME FROM THE LEFT
	call player_getDir	;;if we come from the left (we are facing right) (flag Z)
	call turret_getTurret1
	ld b, #1
	call z, utility_objectMap_update
ret 

;;ld bc, #0x3798 		;;turret position, x,y
;;ld de, #0xFF00		;;turret bullet direction
add_turret1_right:
	;;ENEMY TURRET FIRST HALF
	call player_getDir	;;if we come from the left (we are facing right) (flag Z)
	ld a, #0
	call z, turret_add	;;add turret if we come from the left

	;;UPDATE FIRST HALF IF WE COME FROM THE RIGHT
	call player_getDir	;;if we come from the right (we are facing left) (flag nZ)
	call turret_getTurret1
	ld b, #0
	call nz, utility_objectMap_update
ret 

remove_turret1_left:
	;;REMOVE ENEMY IF GOING RIGHT
	call player_getDir ;;if player goes right (we are facing right), remove turret
	ld a, #0
	call z, turret_remove	;;remove turret
ret 

remove_turret1_right:
	;;REMOVE ENEMY IF GOING LEFT
	call player_getDir ;;if player goes left (we are facing left), remove turret
	ld a, #0
	call nz, turret_remove	;;remove turret
ret


;;ld bc, #0x0F98 		;;turret position, x,y
;;ld de, #0xFF00		;;turret bullet direction
add_turret2_left:
	;;ENEMY TURRET SECOND HALF
	call player_getDir	;;if we come from the right (we are facing left) (flag nZ)
	ld a, #1
	call nz, turret_add	;;add turret if we come from the right

	;;UPDATE SECOND HALF IF WE COME FROM THE LEFT
	call player_getDir	;;if we come from the left (we are facing right) (flag Z)
	call turret_getTurret2
	ld b, #1
	call z, utility_objectMap_update
ret 

;;ld bc, #0x3798 		;;turret position, x,y
;;ld de, #0xFF00		;;turret bullet direction
add_turret2_right:
	;;ENEMY TURRET FIRST HALF
	call player_getDir	;;if we come from the left (we are facing right) (flag Z)
	ld a, #1
	call z, turret_add	;;add turret if we come from the left

	;;UPDATE FIRST HALF IF WE COME FROM THE RIGHT
	call player_getDir	;;if we come from the right (we are facing left) (flag nZ)
	call turret_getTurret2
	ld b, #0
	call nz, utility_objectMap_update
ret 

remove_turret2_left:
	;;REMOVE ENEMY IF GOING RIGHT
	call player_getDir ;;if player goes right (we are facing right), remove turret
	ld a, #1
	call z, turret_remove	;;remove turret
ret 

remove_turret2_right:
	;;REMOVE ENEMY IF GOING LEFT
	call player_getDir ;;if player goes left (we are facing left), remove turret
	ld a, #1
	call nz, turret_remove	;;remove turret
ret



;add_collectable:
;	call collectables_get_chars1	;;check is collectable has already
;	and #0b10000000			;;been added, just for chars
;	jp nz, return_init	
;
;	ld bc, #0x288C			;;add collectable
;	ld de, #0x0280
;	ld hl, #_sprite_phantisdinamic_0
;	call collectables_add
;ret

;;OBSTACLES

add_obstacle1_left:
	;;ENEMY OBSTACLE SECOND HALF
	call player_getDir	;;if we come from the right (we are facing left) (flag nZ)
	ld a, #0
	call nz, obstacle_add	;;add turret if we come from the right

	;;UPDATE SECOND HALF IF WE COME FROM THE LEFT
	call player_getDir	;;if we come from the left (we are facing right) (flag Z)
	call obstacle_getObstacle_ix
	ld b, #1
	call z, utility_obstacleMap_update
ret 

;;ld bc, #0x3798 		;;turret position, x,y
;;ld de, #0xFF00		;;turret bullet direction
add_obstacle1_right:
	;;ENEMY OBSTACLE FIRST HALF
	call player_getDir	;;if we come from the left (we are facing right) (flag Z)
	ld a, #0
	call z, obstacle_add	;;add turret if we come from the left

	;;UPDATE FIRST HALF IF WE COME FROM THE RIGHT
	call player_getDir	;;if we come from the right (we are facing left) (flag nZ)
	call obstacle_getObstacle_ix
	ld b, #0
	call nz, utility_obstacleMap_update
ret 

remove_obstacle1_left:
	;;REMOVE ENEMY IF GOING RIGHT
	call player_getDir ;;if player goes right (we are facing right), remove turret
	ld a, #0
	call z, obstacle_remove	;;remove turret
ret 

remove_obstacle1_right:
	;;REMOVE ENEMY IF GOING LEFT
	call player_getDir ;;if player goes left (we are facing left), remove turret
	ld a, #0
	call nz, obstacle_remove	;;remove turret
ret


add_obstacle2_left:
	;;ENEMY OBSTACLE SECOND HALF
	call player_getDir	;;if we come from the right (we are facing left) (flag nZ)
	ld a, #1
	call nz, obstacle_add	;;add turret if we come from the right

	;;UPDATE SECOND HALF IF WE COME FROM THE LEFT
	call player_getDir	;;if we come from the left (we are facing right) (flag Z)
	call obstacle_getObstacle2_ix
	ld b, #1
	call z, utility_obstacleMap_update
ret 

;;ld bc, #0x3798 		;;turret position, x,y
;;ld de, #0xFF00		;;turret bullet direction
add_obstacle2_right:
	;;ENEMY OBSTACLE FIRST HALF
	call player_getDir	;;if we come from the left (we are facing right) (flag Z)
	ld a, #1
	call z, obstacle_add	;;add turret if we come from the left

	;;UPDATE FIRST HALF IF WE COME FROM THE RIGHT
	call player_getDir	;;if we come from the right (we are facing left) (flag nZ)
	call obstacle_getObstacle2_ix
	ld b, #0
	call nz, utility_obstacleMap_update
ret 


remove_obstacle2_left:
	;;REMOVE ENEMY IF GOING RIGHT
	call player_getDir ;;if player goes right (we are facing right), remove turret
	ld a, #1
	call z, obstacle_remove	;;remove turret
ret 

remove_obstacle2_right:
	;;REMOVE ENEMY IF GOING LEFT
	call player_getDir ;;if player goes left (we are facing left), remove turret
	ld a, #1
	call nz, obstacle_remove	;;remove turret
ret


add_obstacle3_left:
	;;ENEMY OBSTACLE SECOND HALF
	call player_getDir	;;if we come from the right (we are facing left) (flag nZ)
	ld a, #2
	call nz, obstacle_add	;;add turret if we come from the right

	;;UPDATE SECOND HALF IF WE COME FROM THE LEFT
	call player_getDir	;;if we come from the left (we are facing right) (flag Z)
	call obstacle_getObstacle3_ix
	ld b, #1
	call z, utility_obstacleMap_update
ret 

;;ld bc, #0x3798 		;;turret position, x,y
;;ld de, #0xFF00		;;turret bullet direction
add_obstacle3_right:
	;;ENEMY OBSTACLE FIRST HALF
	call player_getDir	;;if we come from the left (we are facing right) (flag Z)
	ld a, #2
	call z, obstacle_add	;;add turret if we come from the left

	;;UPDATE FIRST HALF IF WE COME FROM THE RIGHT
	call player_getDir	;;if we come from the right (we are facing left) (flag nZ)
	call obstacle_getObstacle3_ix
	ld b, #0
	call nz, utility_obstacleMap_update
ret 


remove_obstacle3_left:
	;;REMOVE ENEMY IF GOING RIGHT
	call player_getDir ;;if player goes right (we are facing right), remove turret
	ld a, #2
	call z, obstacle_remove	;;remove turret
ret 

remove_obstacle3_right:
	;;REMOVE ENEMY IF GOING LEFT
	call player_getDir ;;if player goes left (we are facing left), remove turret
	ld a, #2
	call nz, obstacle_remove	;;remove turret
ret
