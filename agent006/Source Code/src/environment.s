;;=================================================
;; FUNCTIONS RELATED WITH MAP AND LEVEL MANAGEMENT
;;=================================================
.area _CODE

;;=========================================
;; INCLUDE AREA
;;=========================================
.include "../includes/maps.s"
.globl _tB_tileset
.globl _tJ_tileset
.globl _tF_tileset
.globl _tInB_tileset
.globl _tB2J_tileset
.globl _tJ2F_tileset

;;Intros
.globl _i_IB_1
.globl _i_B2J_1
.globl _i_B2J_2
.globl _i_J2F_1
.globl _i_J2F_2

;;Beach skies
.globl _s_B_0 
.globl _s_B_N1
.globl _s_B_N2
;.globl _s_B_N3
.globl _s_B_T1
.globl _s_B_T2
.globl _s_B_TC1
.globl _s_B_TC2

;;Beach grounds
.globl _g_B_1 
.globl _g_B_2
.globl _g_B_2T1
.globl _g_B_2T2
.globl _g_B_3
.globl _g_B_3T1
.globl _g_B_3T2
.globl _g_B_4T1
.globl _g_B_4T2
.globl _g_B_5
.globl _g_B_5T1
.globl _g_B_5T2
.globl _g_B_6T1
.globl _g_B_6T2

;;Jungle skies 
.globl _s_J_0
.globl _s_J_N1
.globl _s_J_N2
;.globl _s_J_N3
;.globl _s_J_T1
.globl _s_J_T2
.globl _s_J_TC1
.globl _s_J_TC2

;;Jungle grounds
.globl _g_J_1 
.globl _g_J_2
.globl _g_J_2T1
.globl _g_J_2T2
.globl _g_J_3
.globl _g_J_3T1
.globl _g_J_3T2
.globl _g_J_4T1
.globl _g_J_4T2
.globl _g_J_5
.globl _g_J_5T1
.globl _g_J_5T2
.globl _g_J_6T1
.globl _g_J_6T2

;;Factory skies
.globl _s_F_0 
.globl _s_F_N1
.globl _s_F_N2
;.globl _s_F_N3
.globl _s_F_T1
.globl _s_F_T2
;.globl _s_F_TC1
;.globl _s_F_TC2

;;Factory grounds
.globl _g_F_1 
.globl _g_F_2
.globl _g_F_2T1
.globl _g_F_2T2
.globl _g_F_3
.globl _g_F_3T1
.globl _g_F_3T2
.globl _g_F_4
.globl _g_F_4T1
.globl _g_F_4T2
;.globl _g_F_5
.globl _g_F_5T1
.globl _g_F_5T2
.globl _g_F_6T1
.globl _g_F_6T2

;;=========================================
;;=========================================
;; PRIVATE DATA
;;=========================================
;;=========================================


;;define maps BEACH
defineMap map00, _s_B_0, _s_B_0, _i_IB_1, _g_B_1
defineMap map01, _s_B_N1, _s_B_N2, _g_B_1, _g_B_1
defineMap map02,  _s_B_0, _s_B_N2, _g_B_1, _g_B_1
defineMap map03,  _s_B_N1, _s_B_0, _g_B_1, _g_B_2T1
defineMap map04,  _s_B_T2, _s_B_TC1, _g_B_2, _g_B_2
defineMap map05,  _s_B_TC2, _s_B_N1, _g_B_2, _g_B_2T2
defineMap map06,  _s_B_0, _s_B_N1, _g_B_1, _g_B_2T1
defineMap map07,  _s_B_0, _s_B_N2, _g_B_2T2, _g_B_1
defineMap map08,  _s_B_0, _s_B_T2, _g_B_2T1, _g_B_3T1
defineMap map09,  _s_B_TC1, _s_B_TC2, _g_B_3, _g_B_3T2
defineMap map10,  _s_B_0, _s_B_N1, _g_B_2T2, _g_B_6T1
defineMap map11,  _s_B_N2, _s_B_0, _g_B_6T2, _g_B_5T1
defineMap map12,  _s_B_T2, _s_B_0, _g_B_5, _g_B_5T2
defineMap map13,  _s_B_0, _s_B_N2, _g_B_1, _g_B_6T1
defineMap map13_2,  _s_B_0, _s_B_N2, _s_B_T1, _s_B_T1
defineMap map13_3,  _s_B_N1, _s_B_N2, _g_B_2T1, _g_B_3T1
defineMap map14,  _s_B_N1, _s_B_0, _g_B_4T1, _g_B_4T2
defineMap map15,  _s_B_N1, _s_B_N2, _g_B_1, _g_B_6T1
defineMap map18,  _s_B_0, _s_B_N1, _s_B_T1, _s_B_T1
defineMap map19,  _s_B_N1, _s_B_N2, _s_B_T1, _s_B_T1
defineMap map22,  _s_B_0, _s_B_N2, _g_B_6T2, _g_B_1
defineMap map23,  _s_B_N1, _s_B_0, _g_B_1, _g_B_1

;;define maps JUNGLE
defineMap map24,  _s_B_N1, _i_B2J_2, _g_B_1, _i_B2J_1
defineMap map25,  _s_J_N1, _s_J_N2, _g_J_1, _g_J_1
defineMap map26,  _s_J_N2, _s_J_N1, _g_J_1, _g_J_1
defineMap map27,  _s_J_TC2, _s_J_TC1, _g_J_2T1, _g_J_3T1
defineMap map28,  _s_J_T2, _s_J_T2, _g_J_3, _g_J_3T2
defineMap map29,  _s_J_T2, _s_J_TC2, _g_J_2, _g_J_2T2
defineMap map30,  _s_J_0, _s_J_TC1, _g_J_1, _g_J_2T1
defineMap map31,  _s_J_TC2, _s_J_N2, _g_J_2, _g_J_2
defineMap map32,  _s_J_TC1, _s_J_T2, _g_J_2T2, _g_J_5T1
defineMap map33,  _s_J_T2, _s_J_T2, _g_J_3, _g_J_3T2
defineMap map34,  _s_J_TC2, _s_J_N1, _g_J_2T2, _g_J_6T1
defineMap map35,  _s_J_N2, _s_J_0, _g_J_6T2, _g_J_5T1
defineMap map36,  _s_J_N1, _s_J_0, _g_J_5, _g_J_5T2
defineMap map37,  _s_J_TC1, _s_J_TC2, _g_J_2T1, _g_J_3T1
defineMap map38,  _s_J_N1, _s_J_N2, _g_J_4T1, _g_J_4T2
defineMap map39,  _s_J_TC1, _s_J_TC2, _g_J_3T2, _g_J_2T2
defineMap map40,  _s_J_N1, _s_J_N2, _g_J_6T1, _g_J_6T2
defineMap map42,  _s_J_0, _s_J_TC1, _g_J_1, _g_J_2T1
defineMap map43,  _s_J_TC2, _s_J_N2, _g_J_2T2, _g_J_1
defineMap map46,  _s_J_N2, _s_J_N1, _g_J_1, _g_J_1 
defineMap map47,  _s_J_0, _s_J_N1, _g_J_1, _g_J_1

;;defina maps TRON :D
defineMap map48,  _s_J_N1, _i_J2F_2, _g_J_1, _i_J2F_1
defineMap map49,  _s_F_N1, _s_F_N1, _g_F_1, _g_F_1
defineMap map50,  _s_F_N1, _s_F_N1, _g_F_1, _g_F_1
defineMap map51,  _s_F_0, _s_F_N1, _g_F_5T1, _g_F_5T2
defineMap map52,  _s_F_0, _s_F_N2, _g_F_2T1, _g_F_2
defineMap map53,  _s_F_N2, _s_F_N1, _g_F_2, _g_F_2
defineMap map54,  _s_F_0, _s_F_N2, _g_F_2T2, _g_F_2T1
defineMap map55,  _s_F_N1, _s_F_N2, _g_F_2, _g_F_3T1
defineMap map56,  _s_F_N1, _s_F_0, _g_F_3, _g_F_3T2
defineMap map57,  _s_F_N2, _s_F_0, _g_F_2, _g_F_2T2
defineMap map58,  _s_F_N1, _s_F_0, _g_F_5T1, _g_F_1

defineMap map59,  _s_F_N1, _s_F_0, _g_F_6T1, _g_F_6T2
defineMap map60,  _s_F_T1, _s_F_0, _g_F_2T1, _g_F_3T1
defineMap map61,  _s_F_T2, _s_F_T2, _g_F_4T1, _g_F_4T2
defineMap map62,  _s_F_N2, _s_F_N1, _g_F_3T2, _g_F_2T2
defineMap map63,  _s_F_T1, _s_F_T2, _g_F_2T1, _g_F_3T1
defineMap map64,  _s_F_T1, _s_F_T1, _g_F_4T1, _g_F_4
defineMap map65,  _s_F_T2, _s_F_N2, _g_F_6T2, _g_F_5T1
defineMap map66,  _s_F_T1, _s_F_T2, _g_F_5T2, _g_F_6T1
defineMap map67,  _s_F_T2, _s_F_T1, _g_F_6T2, _g_F_1
defineMap map68,  _s_F_0, _s_F_0, _g_F_1, _g_F_1


;defineMap map03, _tB2J_tileset, _s_B_N1, _s_B_N1, _g_B_1, _g_B_1
;defineMap map04, _tB2J_tileset, _s_B_N1, _i_B2J_2, _g_B_1, _i_B2J_1
;defineMap map05, _tB2J_tileset, _s_J_1, _s_J_1, _g_J_1, _g_J_1
;defineMap map06, _tJ_tileset, _s_J_1, _s_J_1, _g_J_1, _g_J_1
;defineMap map07, _tJ_tileset, _s_J_1, _s_J_1, _g_J_1, _g_J_1
;defineMap map08, _tJ_tileset, _s_J_1, _s_J_1, _g_J_1, _g_J_1
;defineMap map09, _tJ2F_tileset, _s_J_1, _s_J_1, _g_J_1, _g_J_1
;defineMap map10, _tJ2F_tileset, _s_J_1, _i_J2F_2, _g_J_1, _i_J2F_1
;defineMap map11, _tJ2F_tileset, _s_F_1, _s_F_1, _g_F_1, _g_F_1
;defineMap map12, _tF_tileset, _s_F_1, _s_F_1, _g_F_1, _g_F_1
;defineMap map13, _tF_tileset, _s_F_1, _s_F_1, _g_F_1, _g_F_1
;defineMap map14, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000
;defineMap map15, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000
;defineMap map16, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000
;defineMap map17, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000




;;array of levels
maps: .dw #0xFFFF
      .dw #map00_map, #map01_map, #map02_map, #map03_map, #map04_map
      .dw #map05_map, #map06_map, #map07_map, #map08_map, #map09_map
      .dw #map10_map, #map11_map, #map12_map, #map13_map, #map13_2_map
      .dw #map13_3_map, #map14_map, #map15_map, #map18_map, #map19_map
      .dw #map22_map, #map23_map, #map24_map
      .dw #map25_map, #map26_map, #map27_map, #map28_map, #map29_map
      .dw #map30_map, #map31_map, #map32_map, #map33_map, #map34_map
      .dw #map35_map, #map36_map, #map37_map, #map38_map, #map39_map
      .dw #map40_map, #map42_map, #map43_map, #map46_map, #map47_map
      .dw #map48_map, #map49_map, #map50_map, #map51_map, #map52_map
      .dw #map53_map, #map54_map, #map55_map, #map56_map, #map57_map
      .dw #map58_map, #map59_map, #map60_map, #map61_map, #map62_map
      .dw #map63_map, #map64_map, #map65_map, #map66_map, #map67_map
      .dw #map68_map
      .dw #0xFFFF ;;map pointers in order and with limits
current_map: .dw #0x0000	;;we need to know in which map we are

;;=========================================
;;=========================================
;; PUBLIC FUNCTIONS
;;=========================================
;;=========================================

;;=========================================
;; Gets the first map in our map array
;; DESTROYS: A, HL, BC, IX
;;=========================================
env_initMap::

	;;init map list
	ld hl, #map_list ;;we get the direction of the map_list
	ld bc, #0x0004
	add hl, bc 	;;go to first position in the list
	ld a, l		;;we store h value in a 
	ld (current_map_list), a  ;;we save the value in current_map_list
	inc hl 
	ld a, h	;;we store h value in a 
	ld (current_map_list+1), a    ;;we save the value in current_map_list

	ld hl, #maps_init
	jp (hl)	;;jump to map_init
	return_inits:

	;;init map 
	ld ix, #map00_map
	call decode_map_left
	ld ix, #map01_map
	call decode_map_right

	;;set initial map 
	ld hl, #maps 
	ld bc, #0x0004 
	add hl, bc
	ld a, h		;;we store h value in a 
	ld (current_map+1), a  ;;we save the value in current_map
	ld a, l 	;;we store h value in a 
	ld (current_map), a    ;;we save the value in current_map

	call drawFullMap
	call drawFullMap1

ret


;;=========================================
;; Gets the first map in our map array
;; DESTROYS: A, HL, BC, IX
;;=========================================
env_loadcheckpoint::

	;;init map list
	ld hl, #map_list ;;we get the direction of the map_list
	cp #1
	push af
	jr z, checkmaplist1
	cp #2
	jr z, checkmaplist2
	cp #3
	jr z, checkmaplist3
	cp #4
	jr z, checkmaplist4
	jr nz, checkmaplist5

	checkmaplist1:
	ld bc, #0x0028
	jr addcheckmaplist

	checkmaplist2:
	ld bc, #0x0060
	jr addcheckmaplist

	checkmaplist3:
	ld bc, #0x0080
	jr addcheckmaplist

	checkmaplist4:
	ld bc, #0x00AC
	jr addcheckmaplist

	checkmaplist5:
	ld bc, #0x00D4

	addcheckmaplist:
	add hl, bc 	;;go to first position in the list
	ld a, l		;;we store h value in a 
	ld (current_map_list), a  ;;we save the value in current_map_list
	inc hl 
	ld a, h	;;we store h value in a 
	ld (current_map_list+1), a    ;;we save the value in current_map_list
	
	
	call collectables_draw_chars
	
	pop af
	cp #1
	push af
	jr z, collisionmap
	cp #2
	jr z, collisionmap2
	cp #3
	jr z, collisionmap3
	cp #4
	jr z, collisionmap4
	jr nz, collisionmap5

	collisionmap:
	ld hl, #0x030E
	ld de, #_sprite_checkpoint
	ld bc, #0x106F
	call sprite_add
	ld hl, #collisionMap_map8
	jr drawcollisionmap

	collisionmap2:
	ld hl, #0x030E
	ld de, #_sprite_checkpoint
	ld bc, #0x109F
	call sprite_add
	ld hl, #collisionMap_map
	jr drawcollisionmap

	collisionmap3:
	ld hl, #0x030E
	ld de, #_sprite_checkpoint
	ld bc, #0x106F
	call sprite_add
	ld hl, #collisionMap_map22
	jr drawcollisionmap

	collisionmap4:
	ld hl, #_tJ2F_tileset
	call cpct_etm_setTileset2x4_asm
	ld hl, #0x030E
	ld de, #_sprite_checkpoint
	ld bc, #0x109F
	call sprite_add
	ld hl, #collisionMap_map
	jr drawcollisionmap

	collisionmap5:
	ld hl, #_tF_tileset
	call cpct_etm_setTileset2x4_asm
	ld hl, #0x030E
	ld de, #_sprite_checkpoint
	ld bc, #0x1086
	call sprite_add
	ld bc, #0x3760			;;add collectable
	ld de, #0x0110
	ld hl, #_sprite_powerups_3
	call collectables_add
	ld hl, #collisionMap_map40

	drawcollisionmap:
	call collision_setColMap


	pop af
	cp #1
	push af
	jr z, drawmaps
	cp #2
	jr z, drawmaps2
	cp #3
	jr z, drawmaps3
	cp #4
	jr z, drawmaps4
	jr nz, drawmaps5

	drawmaps:
	ld ix, #map09_map
	call decode_map_left
	ld ix, #map10_map
	call decode_map_right
	jr afterdrawingmaps

	drawmaps2:
	ld ix, #map25_map
	call decode_map_left
	ld ix, #map26_map
	call decode_map_right
	jr afterdrawingmaps

	drawmaps3:
	ld ix, #map33_map
	call decode_map_left
	ld ix, #map34_map
	call decode_map_right
	jr afterdrawingmaps
	
	drawmaps4:
	ld ix, #map47_map
	call decode_map_left
	ld ix, #map48_map
	call decode_map_right
	jr afterdrawingmaps

	drawmaps5:
	ld ix, #map57_map
	call decode_map_left
	ld ix, #map58_map
	call decode_map_right

	afterdrawingmaps:
	pop af
	ld hl, #maps
	cp #1
	jr z, definemap
	cp #2
	jr z, definemap2
	cp #3
	jr z, definemap3
	cp #4
	jr z, definemap4
	jr nz, definemap5

	definemap:
	ld bc, #0x0014
	jr continuedefinemap

	definemap2:
	ld bc, #0x0030
	jr continuedefinemap

	definemap3:
	ld bc, #0x0040
	jr continuedefinemap

	definemap4:
	ld bc, #0x0056
	jr continuedefinemap

	definemap5:
	ld bc, #0x006A

	continuedefinemap:
	add hl, bc
	ld a, h		;;we store h value in a 
	ld (current_map+1), a  ;;we save the value in current_map
	ld a, l 	;;we store h value in a 
	ld (current_map), a    ;;we save the value in current_map
	
	ld hl, (current_map)
	inc hl
	inc hl
	ld a, h
	ld (current_map+1), a
	ld a, l
	ld (current_map), a
	
	call drawFullMap
	call drawFullMap1

ret
;;=========================================
;; Changes the map if possible
;; Input: A - 0 left, 1 right
;; Output: A - 1 done, 0 false
;; DESTROYS: A, HL
;;=========================================
env_changeMap::

	ld hl, (current_map)	;;we get the current map direction

	push af

	cp #0x01	;;if A sets 0 flag, check right 
	jr z, increase

		;;we go left
		push hl		;;save hl
		call changeMapList
		pop hl 		;;retrieve hl

		dec hl
		dec hl			;;we go to the previous direction
		jr continue 		;;we decrease and continue with the normal flow
		
		;;we go right
		increase:

			push hl		;;save hl
			call changeMapList
			pop hl 		;;retrieve hl

			inc hl
			inc hl		;;we increase and continue with the normal flow

		continue:
			;;check we are not in the left limit
			push hl 
			dec hl 
			dec hl 
			ld a, (hl)
			cp #0xFF		;;if it is 0, then we don't update
			ld a, #00		;;we set the output to false
			pop hl
			pop bc
			ret z

			;;check we are not in the right limit
			push bc
			ld a, (hl)
			cp #0xFF		;;if it is 0, then we don't update
			ld a, #00		;;we set the output to false
			pop bc
			ret z


			;;if not, we change the map and update position
			call changeMap	
			ld   a, #01	;;we set the output to true	
ret

;;=========================================
;; Returns a pointer to the current map
;; DESTROYS: HL
;; OUTPUT: HL - current_map
;;=========================================
env_getCurrentMap::
	ld hl, (current_map) ;;return current_map direction
ret

;;=========================================
;;=========================================
;; PRIVATE FUNCTIONS
;;=========================================
;;=========================================

;;=========================================
;; Renders a full screen map
;; DESTROYS: AF, BC, DE, HL AF’, BC’, DE’, HL’
;;=========================================
drawFullMap:

	ld hl, #0x3800
	push hl		
	ld hl, #0xc000	;;memory to the start of video memory
	push hl
	ld bc, #0000	;;starting tile
	ld de, #0x3228	;;height in tiles to be drawn
	ld a, #40	;;width in tiles of a row of the map
	call cpct_etm_drawTileBox2x4_asm

	call collectables_draw_chars

ret

;;=========================================
;; Renders a full screen map in 8000
;; DESTROYS: AF, BC, DE, HL AF’, BC’, DE’, HL’
;;=========================================
drawFullMap1:
	ld hl, #0x3800
	push hl		
	ld hl, #0x8000	;;memory to the start of video memory
	push hl
	ld bc, #0000	;;starting tile
	ld de, #0x3228	;;height in tiles to be drawn
	ld a, #40	;;width in tiles of a row of the map
	call cpct_etm_drawTileBox2x4_asm

	call collectables_draw_chars

ret

;;=========================================
;; Changes the map and updates position
;; INPUT: B  - 1 if we go right, 0 left
;;	  HL - current map
;; DESTROYS: AF, BC, DE, HL, AF’, BC’, DE’, HL’, IX, IY
;;=========================================
changeMap:

	ld a, h		;;we store h value in a 
	ld (current_map+1), a  ;;we save the value in current_map
	ld a, l 	;;we store h value in a 
	ld (current_map), a    ;;we save the value in current_map

	ld a, b 
	dec a 
	jr z, go_right1 ;;if 0, we go right 

		;;if we go left 

		ld hl, #0x3800
		ld de, #0x3814
		call copy_half_map ;;copy left map to the right 

		ld hl, (current_map)	;;ptr to a ptr 
		dec hl 
		dec hl
		ld c, (hl)
		inc hl 
		ld b, (hl)		;;ptr to the map
		ld_ixl_c
		ld_ixh_b		;;save ptr to the map in ix
		call decode_map_left	;;redraw left map 

		call drawFullMap
		call drawFullMap1

		ret 

	go_right1:
	;;if we go right

		ld hl, #0x3814
		ld de, #0x3800
		call copy_half_map ;;copy right map to the left

		ld hl, (current_map)	;;ptr to a ptr 
		ld c, (hl)
		inc hl 
		ld b, (hl)		;;ptr to the map
		ld_ixl_c
		ld_ixh_b		;;save ptr to the map in ix
		call decode_map_right	;;redraw right map 

		call drawFullMap
		call drawFullMap1
ret


;;===============================================
;; Changes the map list if possible
;; INPUT: A - 1 right, 0 left
;; DESTROYS: AF, BC, DE?, HL
;;===============================================
changeMapList:

	push af 	;;store a value

	call check_changeMapList_direction	;;outputs in hl next map ptr

	ld a, (hl)
	cp #0xff 
	jp z, go_to_end	;;if next map is not set, do nothing 

	;;if next map is set
		ld hl, (current_map_list)
		inc hl
		inc hl ;;go to previous map erase

		ld e, (hl)
		inc hl 
		ld d, (hl)	;;we put in de the direction hl points to

		ex de, hl 	;;put in hl the direction hl points to

		jp (hl)	;;jump to map_erase
		return_erase:

		pop af 	;;retrieve a value

		call check_changeMapList_direction ;;outputs in hl next map ptr

		;;save next value
		ld a, h		;;we store h value in a 
		ld (current_map_list+1), a  ;;we save the value in current_map
		ld a, l 	;;we store h value in a 
		ld (current_map_list), a    ;;we save the value in current_map

		ld e, (hl)
		inc hl 
		ld d, (hl)	;;we put in de the direction hl points to

		ex de, hl 	;;put in hl the direction hl points to

		jp (hl)	;;jump to map_init
		return_init:

		ret		;;return

	go_to_end:
		pop af 		;;unstack the stacked value
ret


;;===============================================
;; Checks direction
;; INPUT: A - 1 right, 0 left
;; DESTROYS: BC, HL
;; OUTPUT: HL - next map
;;===============================================
check_changeMapList_direction:

	ld hl, (current_map_list)

	cp #0x01	;;check if we go right or left
	jr z, go_right

		;;if left 
		ld bc, #0xfffc	;;add -4
		jr go_left

	go_right:
		ld bc, #0x0004	;;add+4
	go_left:
	add hl, bc	;;go to next map

ret

;;===============================================
;; Decodes a single line
;; INPUT: DE - position we decode from
;;	  BC - destination of decoded bytes
;; DESTROYS: AF; BC; DE; HL;
;;===============================================
decode_line:

	ld hl, #0x0000
	call gb4_get4bits1
	inc bc 

	ld hl, #0x0000
	call g4b_get4bits2
	inc bc 

	ld hl, #0x0001
	call gb4_get4bits1
	inc bc 

	ld hl, #0x0001
	call g4b_get4bits2
	inc bc 

	ld hl, #0x0002
	call gb4_get4bits1
	inc bc 

	ld hl, #0x0002
	call g4b_get4bits2
	inc bc 

	ld hl, #0x0003
	call gb4_get4bits1
	inc bc 

	ld hl, #0x0003
	call g4b_get4bits2
	inc bc 

	ld hl, #0x0004
	call gb4_get4bits1
	inc bc 

	ld hl, #0x0004
	call g4b_get4bits2

ret

;;===============================================
;; Decodes a chunck of bytes
;; INPUT: DE - position we decode from
;;	  BC - destination of decoded bytes
;; DESTROYS: AF; BC; DE; HL;
;;===============================================
decode_chunk:

	push bc 	;;store destination position

	call decode_line 

	pop hl 		;;retrive destination position
	ld bc, #0040	
	add hl, bc 	;;next destination position

	ld b, h
	ld c, l 	;;store result in bc 

	ld hl, #0005
	add hl, de	;;next origin position

	ld d, h 
	ld e, l 	;;store result in de 

	dec_iyl
	jr nz, decode_chunk

ret

;;===============================================
;; Decodes and creates left part of the map
;; INPUT: IX - Map array chunk to read
;; DESTROYS: AF; BC; DE; HL;
;;===============================================
decode_map_left:

	ld d, map_s12(ix)
	ld e, map_s11(ix)
	ld bc, #0x3800
	ld_iyl_nn
	.db #25
	call decode_chunk	;;sky1

	ld d, map_s22(ix)
	ld e, map_s21(ix)
	ld bc, #0x380A
	ld_iyl_nn
	.db #25
	call decode_chunk	;;sky2

	ld d, map_g12(ix)
	ld e, map_g11(ix)
	ld bc, #0x3BE8
	ld_iyl_nn
	.db #25
	call decode_chunk	;;ground1

	ld d, map_g22(ix)
	ld e, map_g21(ix)
	ld bc, #0x3BF2
	ld_iyl_nn
	.db #25
	call decode_chunk	;;ground2

ret

;;===============================================
;; Decodes and creates right part of the map
;; INPUT: IX - Map array chunk to read
;; DESTROYS: AF; BC; DE; HL;
;;===============================================
decode_map_right:

	ld d, map_s12(ix)
	ld e, map_s11(ix)
	ld bc, #0x3814
	ld_iyl_nn
	.db #25
	call decode_chunk	;;sky3

	ld d, map_s22(ix)
	ld e, map_s21(ix)
	ld bc, #0x381E
	ld_iyl_nn
	.db #25
	call decode_chunk	;;sky4

	ld d, map_g12(ix)
	ld e, map_g11(ix)
	ld bc, #0x3BFC
	ld_iyl_nn
	.db #25
	call decode_chunk	;;ground3

	ld d, map_g22(ix)
	ld e, map_g21(ix)
	ld bc, #0x3C06
	ld_iyl_nn
	.db #25
	call decode_chunk	;;ground4

ret

;;===============================================
;; Copies left part of the map to the right
;; INPUT: HL - Where to copy from (1000 or 1014)
;;	  DE - Where to copy to  (1014 or 1000)
;; DESTROYS: AF; BC; DE; HL; IY
;;===============================================
copy_half_map:

	ld_iyh_nn
	.db #50 
	ld bc, #20

	start_copy:
		ldir ;;copy 1 line 

		ld bc, #20
		ex de, hl ;;put de in hl
		add hl, bc 
		ex de, hl
		add hl, bc 

		dec_iyh
		jr nz, start_copy
ret


;;===============================================
;; Gets 4 more significant bits and saves them
;; INPUT: DE - Where we read from 
;; 	  HL - Index to be read
;;	  BC - Where to save bits
;; DESTROYS: HL, A
;;===============================================
gb4_get4bits1:
   add  hl, de         ;; [3] HL += DE => HL points to the target byte in the array 
   ld    a, (hl)       ;; [2] A = Target byte
   rrca                ;; [1] <| As we want the grop 0 (4 most significant bits), we rotate them
   rrca                ;; [1]  | 4 times and place them in bits 0 to 3. This makes it easier to
   rrca                ;; [1]  | return the value from 0 to 15, as we only will have to leave this 4
   rrca                ;; [1] <| bits out with and AND
   and   #0x0F         ;; [2] Leave out the 4 bits we wanted
   ld (bc), a		

ret

;;===============================================
;; Gets 4 less significant bits and saves them
;; INPUT: DE - Where we read from 
;; 	  HL - Index to be read
;;	  BC - Where to save bits
;; DESTROYS: HL, A
;;===============================================
g4b_get4bits2:
   add  hl, de         ;; [3] HL += DE => HL points to the target byte in the array 
   ld    a, (hl)       ;; [2] A = Target byte
   and   #0x0F         ;; [2] As we want group 1 (bits 0 to 3) we just need to leave these 4 bits out with an AND operation
   ld (bc), a
   
ret