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
;; MENU RELATED FUNCTIONS
;;=========================================================

.AREA _CODE


;;=================================================
;; INCLUDE AREA
;;=================================================
.include "includes.h.s"
.include "utility.h.s"

.globl _sprite_006
.globl _sprite_APLSOFT
.globl _intro
.globl _powerup


;;=================================================
;;
;; PRIVATE DATA
;;
;;=================================================

allocateMemory 0x8800

;;menu text and sprites
msg1: .db #32,#49,#46,#32,#83,#84,#79,#82,#89, #00
msg2: .db #32,#50,#46,#32,#80,#76,#65,#89, #00
msg3: .db #32,#51,#46,#32,#73,#78,#83,#84,#82,#85,#67,#84,#73,#79,#78,#83, #00

sprite_006: .db #15, #7, #50, #40
aplsoft: .db #35, #84, #10, #32

agent_006: .db #227, #65, #71, #69, #78, #84, #227, #00

;;story text
line01: .db #89,#111,#117,#39,#114,#101,#32,#97,#32,#115,#101,#99,#114,#101,#116,#32
	.db #97,#103,#101,#110,#116,#32,#119,#111,#114,#107,#105,#110,#103,#32,#102,#111,#114,#00
line02: .db #116,#104,#101,#32,#112,#114,#111,#116,#101,#99,#116,#105,#111,#110,#32,#111,#102,#32
	.db #116,#104,#101,#32,#66,#73,#84,#32,#40,#66,#97,#115,#105,#99,#00
line03: .db #73,#110,#116,#101,#108,#108,#105,#103,#101,#110,#99,#101,#32
	.db #84,#114,#101,#97,#116,#121,#41,#32,#97,#110,#100,#32,#121,#111,#117,#39,#118,#101,#00
line04: .db #98,#101,#101,#110,#32,#115,#101,#110,#116,#32,#116,#111,#32,#97,#32
	.db #114,#101,#109,#111,#116,#101,#32,#105,#115,#108,#97,#110,#100,#32,#105,#110,#00
line05: .db #111,#114,#100,#101,#114,#32,#116,#111,#32,#100,#101,#115,#116,#114,#111,#121
	.db #46,#46,#46,#32,#116,#104,#101,#32,#83,#80,#82,#73,#84,#69,#32,#00
line06: .db #40,#83,#101,#99,#114,#101,#116,#32,#80,#111,#119,#101,#114,#102,#117,#108,#32
	.db #82,#97,#110,#100,#111,#109,#32,#73,#110,#116,#101,#108,#108,#105,#103,#101,#110,#116,#00
line07: .db #84,#101,#114,#109,#105,#110,#97,#116,#111,#114,#32,#69,#110,#103,#105,#110,#101,#41
	.db #46,#32,#73,#102,#32,#121,#111,#117,#32,#99,#97,#110,#39,#116,#32,#109,#97,#107,#101,#00
line08: .db #105,#116,#32,#105,#110,#32,#116,#105,#109,#101,#44,#32,#67,#72,#65,#79,#83,#32
	.db #119,#105,#108,#108,#32,#115,#112,#114,#101,#97,#100,#32,#97,#114,#111,#117,#110,#100,#00
line09: .db #46,#46,#46,#116,#104,#101,#32,#87,#79,#82,#76,#68,#33,#33,#33,#00

line11: .db #75,#101,#97,#98,#111,#97,#114,#100,#58,#00
line12: .db #87,#32,#45,#32,#74,#117,#109,#112,#32,#65,#32,#45,#32,#76,#101,#102,#116,#32,#83,#32,#45,#32,#75,#110
	.db #101,#101,#108,#32,#68,#32,#45,#32,#82,#105,#103,#104,#116, #00
line13: .db #83,#112,#97,#99,#101,#32,#45,#32,#83,#104,#111,#111,#116, #00
line14: .db #73,#44,#74,#44,#75,#44,#76,#43,#83,#112,#97,#99,#101,#32,#45,#32,#83,#104,#111,#111,#116
	.db #32,#105,#110,#32,#97,#110,#121,#32,#100,#105,#114,#101,#99,#116,#105,#111,#110,#00
line15: .db #74,#111,#121,#115,#116,#105,#99,#107,#58,#00
line16: .db #83,#116,#105,#99,#107,#32,#45,#32,#76,#101,#102,#116,#44,#32,#82,#105,#103,#104
	.db #116,#44,#32,#74,#117,#109,#112,#44,#32,#75,#110,#101,#101,#108,#00
line17: .db #70,#105,#114,#101,#32,#45,#32,#83,#104,#111,#111,#116,#00
line18: .db #75,#101,#101,#112,#70,#105,#114,#101,#32,#45,#32
	.db #77,#111,#116,#105,#111,#110,#108,#101,#115,#115,#32,#100,#105,#114,#101,#99,#116,#105,#111,#110,#97,#108,#32,#115,#104,#111,#116,#00
line19: .db #77,#58,#32,#77,#117,#116,#101,#32,#109,#117,#115,#105,#99,#00
;;=================================================
;;
;; PUBLIC FUNCTIONS
;;
;;=================================================


;;=============================================
;; Menu controller
;; DESTROYS: Almost everything
;;=============================================
menu_system::

	setBorder 58
	call draw_intro

	call draw_menu

	;;MENU LOOP
	menu_loop::
	
	call cpct_scanKeyboard_f_asm

	call get_pressedKeys1
	and #64
	call nz, draw_story	;;if 1 pressed, show story

	call get_pressedKeys1
	and #16
	call nz, draw_instructions	;;if 3 pressed, draw instructions

	call get_pressedKeys1
	and #32
	jr z, menu_loop		;; if 2 pressed, start game

	call black_screen
	ld bc, #0296
	call utility_wait
	
ret

;;=================================================
;;
;; PRIVATE FUNCTIONS
;;
;;=================================================

;;=============================================
;; Draws the menu
;; DESTROYS: Almost everything
;;=============================================
draw_menu:
	ld de, #_intro
	call cpct_akp_musicInit_asm	;;initiate song

	ld hl, #0xC000
	call draw_bar

	ld ix, #sprite_006
	ld bc, #_sprite_006
	call utility_object_draw

	ld hl, #0xC1E0
	call draw_bar

	ld de, #0xC2E3
    	ld bc, #0x0003
    	ld hl, #msg1
    	call cpct_drawStringM1_asm 

    	ld de, #0xC383
    	ld bc, #0x0003
    	ld hl, #msg2
    	call cpct_drawStringM1_asm

    	ld de, #0xC423
    	ld bc, #0x0003
    	ld hl, #msg3
    	call cpct_drawStringM1_asm
ret

;;=============================================
;; Draws the intro
;; DESTROYS: Almost everything
;;=============================================
draw_intro:
	
	call interruption_playMusic
	;;wait 1 seconds
	ld bc, #0x0296
	call utility_wait

	ld ix, #aplsoft
	ld bc, #_sprite_APLSOFT
	call utility_object_draw

	;;play a note
	ld de, #0x0040
	call utility_piano_sound

	;;wait 0,5 seconds
	ld bc, #0x0196
	call utility_wait

	;;play a note
	ld de, #0x0047
	call utility_piano_sound

	;;wait 0,5 seconds
	ld bc, #0x0196
	call utility_wait

	;;play a note
	ld de, #0x004C
	call utility_piano_sound

	;;wait 1 seconds
	ld bc, #0x0296
	call utility_wait

	;;black screen
	call black_screen1

	ld hl, #palette
	ld de, #4
	call cpct_setPalette_asm

	call black_screen

	ld c, #1
	call cpct_setVideoMode_asm

	setBorder 54

	;;wait 1 seconds
	ld bc, #0x0296
	call utility_wait
 
ret

;;=============================================
;; Draws the story
;; DESTROYS: Almost everything
;;=============================================
draw_story:
	call black_screen
	ld bc, #0296
	call utility_wait

	;;when entering stop music
	call interruption_stopMusic
	call cpct_akp_stop_asm
	;;reactivate sound
	ld de, #0x8000
	call cpct_akp_musicInit_asm	;;initiate song
	call interruption_playMusic

	;;wait 0,5 seconds
	ld bc, #0x0196
	call utility_wait

	;;draw bar
	ld hl, #0xD780
	call draw_bar

	;;draw bar
	ld hl, #0xC000
	call draw_bar

	;;wait 0,5 seconds
	ld bc, #0x0196
	call utility_wait

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;first line 
	ld de, #0xC144
    	ld bc, #0x0003
    	ld hl, #line01
    	call cpct_drawStringM1_asm

    	;;play a note
	ld de, #0x0530
	call utility_shot_sound

    	;;wait 1 second
	ld bc, #0x0296
	call utility_wait

	;;-----------------------------------------------------------
	;;second line 
	ld de, #0xC1E4
    	ld bc, #0x0003
    	ld hl, #line02
    	call cpct_drawStringM1_asm

    	;;play a note
	ld de, #0x0531
	call utility_shot_sound

    	;;wait 1 second
	ld bc, #0x0296
	call utility_wait

	;;-----------------------------------------------------------
	;;third line 
	ld de, #0xC284
    	ld bc, #0x0003
    	ld hl, #line03
    	call cpct_drawStringM1_asm

    	;;play a note
	ld de, #0x0530
	call utility_shot_sound

    	;;wait 1 second
	ld bc, #0x0296
	call utility_wait

	;;-----------------------------------------------------------
	;;fourth line 
	ld de, #0xC324
    	ld bc, #0x0003
    	ld hl, #line04
    	call cpct_drawStringM1_asm

    	;;play a note
	ld de, #0x0531
	call utility_shot_sound

    	;;wait 1 second
	ld bc, #0x0296
	call utility_wait

	;;-----------------------------------------------------------
	;;fifth line 
	ld de, #0xC3C4
    	ld bc, #0x0003
    	ld hl, #line05
    	call cpct_drawStringM1_asm

    	;;play a note
	ld de, #0x0530
	call utility_shot_sound

    	;;wait 1 second
	ld bc, #0x0296
	call utility_wait

	;;-----------------------------------------------------------
	;;sixth line 
	ld de, #0xC464
    	ld bc, #0x0003
    	ld hl, #line06
    	call cpct_drawStringM1_asm

    	;;play a note
	ld de, #0x0531
	call utility_shot_sound

    	;;wait 1 second
	ld bc, #0x0296
	call utility_wait

	;;-----------------------------------------------------------
	;;seventh line 
	ld de, #0xC504
    	ld bc, #0x0003
    	ld hl, #line07
    	call cpct_drawStringM1_asm

    	;;play a note
	ld de, #0x0532
	call utility_shot_sound

    	;;wait 1 second
	ld bc, #0x0296
	call utility_wait

	;;-----------------------------------------------------------
	;;eighth line 
	ld de, #0xC5A4
    	ld bc, #0x0003
    	ld hl, #line08
    	call cpct_drawStringM1_asm

    	;;play a note
	ld de, #0x0533
	call utility_shot_sound

    	;;wait 1 second
	ld bc, #0x0296
	call utility_wait

	;;-----------------------------------------------------------
	;;ninth line 
	ld de, #0xC644
    	ld bc, #0x0003
    	ld hl, #line09
    	call cpct_drawStringM1_asm

    	;;play a note
	ld de, #0x2534
	call utility_shot_sound

	;;wait 13 seconds
	ld bc, #0x1A96
	call utility_wait

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	;;erase screen
	call black_screen
	;;wait 1 second
	ld bc, #0x0296
	call utility_wait

	call draw_menu
ret

;;=============================================
;; Draws the instructions
;; DESTROYS: Almost everything
;;=============================================
draw_instructions:
	call black_screen
	ld bc, #0296
	call utility_wait

	;;when entering stop music
	call interruption_stopMusic
	call cpct_akp_stop_asm
	;;reactivate sound
	ld de, #0x8000
	call cpct_akp_musicInit_asm	;;initiate song
	call interruption_playMusic

	;;wait 0,5 seconds
	ld bc, #0x0196
	call utility_wait

	;;draw bar
	ld hl, #0xD780
	call draw_bar

	;;draw bar
	ld hl, #0xC000
	call draw_bar

	;;wait 0,5 seconds
	ld bc, #0x0196
	call utility_wait

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;first line 
	ld de, #0xC144
    	ld bc, #0x0003
    	ld hl, #line11
    	call cpct_drawStringM1_asm

    	;;play a note
	ld de, #0x002A
	call utility_piano_sound

    	;;wait 1 second
	ld bc, #0x0196
	call utility_wait

	;;-----------------------------------------------------------
	;;second line 
	ld de, #0xC1E4
    	ld bc, #0x0003
    	ld hl, #line12
    	call cpct_drawStringM1_asm

    	;;play a note
	ld de, #0x002B
	call utility_piano_sound

    	;;wait 1 second
	ld bc, #0x0196
	call utility_wait

	;;-----------------------------------------------------------
	;;third line 
	ld de, #0xC284
    	ld bc, #0x0003
    	ld hl, #line13
    	call cpct_drawStringM1_asm

    	;;play a note
	ld de, #0x002C
	call utility_piano_sound

    	;;wait 1 second
	ld bc, #0x0196
	call utility_wait

	;;-----------------------------------------------------------
	;;fourth line 
	ld de, #0xC324
    	ld bc, #0x0003
    	ld hl, #line14
    	call cpct_drawStringM1_asm

    	;;play a note
	ld de, #0x002D
	call utility_piano_sound

    	;;wait 1 second
	ld bc, #0x0196
	call utility_wait

	;;-----------------------------------------------------------
	;;fifth line 
	ld de, #0xC3C4
    	ld bc, #0x0003
    	ld hl, #line15
    	call cpct_drawStringM1_asm

    	;;play a note
	ld de, #0x002E
	call utility_piano_sound

    	;;wait 1 second
	ld bc, #0x0196
	call utility_wait

	;;-----------------------------------------------------------
	;;sixth line 
	ld de, #0xC464
    	ld bc, #0x0003
    	ld hl, #line16
    	call cpct_drawStringM1_asm

    	;;play a note
	ld de, #0x002F
	call utility_piano_sound

    	;;wait 1 second
	ld bc, #0x0196
	call utility_wait

	;;-----------------------------------------------------------
	;;seventh line 
	ld de, #0xC504
    	ld bc, #0x0003
    	ld hl, #line17
    	call cpct_drawStringM1_asm

    	;;play a note
	ld de, #0x0030
	call utility_piano_sound

    	;;wait 1 second
	ld bc, #0x0196
	call utility_wait

	;;-----------------------------------------------------------
	;;eighth line 
	ld de, #0xC5A4
    	ld bc, #0x0003
    	ld hl, #line18
    	call cpct_drawStringM1_asm

    	;;play a note
	ld de, #0x0031
	call utility_piano_sound

    	;;wait 1 second
	ld bc, #0x0196
	call utility_wait

	;;-----------------------------------------------------------
	;;ninth line 
	ld de, #0xC644
    	ld bc, #0x0003
    	ld hl, #line19
    	call cpct_drawStringM1_asm

    	;;play a note
	ld de, #0x0532
	call utility_piano_sound

    	;;wait 15 seconds
	ld bc, #0x1A96
	call utility_wait

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	;;erase screen
	call black_screen
	;;wait 1 second
	ld bc, #0x0296
	call utility_wait

	call draw_menu
ret 

deallocateMemory
;;======================================================================================
;; Data we can't destroy
;;======================================================================================

;;=============================================
;; Draws two lines 
;; INPUT: A - Color 
;; 	  DE - Start position
;; DESTROYS: Almost everything
;;=============================================
draw_two_lines:
	push de
	call utility_draw_line

	pop de 
	ld hl, #0x0800 
	add hl, de 
	ex de, hl 
	call utility_draw_line
ret


;;=============================================
;; Draws a bar
;; INPUT: HL - Starting pos
;; DESTROYS: Almost everything
;;=============================================
draw_bar:
	push hl 
	ex de, hl
	ld a, #0b11111111
	call draw_two_lines	;;draw two grey lines 

	pop hl 
	ld de, #0x1000 
	add hl, de 
	push hl 
	ex de, hl
	ld a, #0b11110000
	call draw_two_lines	;;draw two white lines

	pop hl 
	ld de, #0x1000 
	add hl, de 
	ex de, hl
	ld a, #0b11111111
	call draw_two_lines	;;draw two grey lines 
ret

;;=============================================
;; Draws a black screen
;; DESTROYS: Almost everything
;;=============================================
black_screen:
	ld hl, #0xC000
	ld a, #0x00
	ld (hl), a
	ld de, #0xC001
	ld bc, #0x4000
	ldir
ret

;;=============================================
;; Draws a black screen
;; DESTROYS: Almost everything
;;=============================================
black_screen1:
	ld hl, #0xC000
	ld a, #0x30
	ld (hl), a
	ld de, #0xC001
	ld bc, #0x4000
	ldir
ret

;;=============================================
;; Draws the end of the game
;; DESTROYS: Almost everything
;;=============================================
draw_end::
	ld l, #0x30
	call cpct_setVideoMemoryPage_asm

	;;when entering stop music
	call interruption_stopMusic
	call cpct_akp_stop_asm

	setBorder 58

	call black_screen1
	ld bc, #0296
	call utility_wait	;;wait a second 

	ld hl, #palette
	ld de, #4
	call cpct_setPalette_asm

	setBorder 54

	call black_screen

	ld c, #1
	call cpct_setVideoMode_asm

	ld bc, #0296
	call utility_wait	;;wait a second 

	;;reactivate sound
	ld de, #_powerup
	call cpct_akp_musicInit_asm	;;initiate song
	call interruption_playMusic

	;;wait 0,5 seconds
	ld bc, #0x0196
	call utility_wait

	;;draw bar
	ld hl, #0xD780
	call draw_bar

	;;draw bar
	ld hl, #0xC000
	call draw_bar

	;;wait 0,5 seconds
	ld bc, #0x0196
	call utility_wait

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;first line 
	ld de, #0xC144
    	ld hl, #line21

    	call draw_letters

	;;-----------------------------------------------------------
	;;second line 
	ld de, #0xC1E4
    	ld hl, #line22

    	call draw_letters

	;;-----------------------------------------------------------
	;;third line 
	ld de, #0xC284
    	ld hl, #line23

    	call draw_letters

	ld a, (get_pressedKeys0)
	or #0b00000001
	cp #0xFF
	jr nz, .-2

	;;-----------------------------------------------------------
	;;fifth line 
	ld de, #0xC3C4
    	ld hl, #line25

    	call draw_letters

	;;-----------------------------------------------------------
	;;sixth line 
	ld de, #0xC464
    	ld hl, #line26

    	call draw_letters

	;;-----------------------------------------------------------
	;;seventh line 
	ld de, #0xC504
    	ld hl, #line27

    	call draw_letters

	;;-----------------------------------------------------------
	;;eighth line 
	ld de, #0xC5A4
    	ld hl, #line28

    	call draw_letters

	;;-----------------------------------------------------------
	;;ninth line 
	ld de, #0xC644
    	ld hl, #line29

    	call draw_letters

    	;;infinite loop 
    	jr .-2

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ret

;;aux function for the above one
draw_letters:
	ld bc, #0x0003
	call cpct_drawStringM1_asm

	;;wait 1 second
	ld bc, #0x0196
	call utility_wait

ret


allocateMemory 0x370A

palette: .db #0x54, #0x40, #0x47, #0x4B

line21: .db #84,#104,#101,#32,#83,#80,#82,#73,#84,#69,#32,#104,#97,#115,#32,#98,#101
	.db #101,#110,#32,#100,#101,#115,#116,#114,#111,#121,#101,#100,#46,#32,#84,#104,#101,#00
line22: .db #119,#111,#114,#108,#100,#32,#105,#115,#32
	.db #115,#97,#102,#101,#32,#97,#103,#97,#105,#110,#46,#32,#65,#103,#101,#110,#116,#32,#48,#48,#54,#44,#121,#111,#117,#00
line23: .db #97,#114,#101,#32,#111,#117,#114,#32,#82,#73,#71,#72
	.db #84,#70,#85,#76,#32,#112,#114,#111,#116,#101,#99,#116,#111,#114,#46,#32,#84,#72,#65,#78,#75,#83,#33,#00
line25: .db #65,#103,#101,#110,#116,#32,#48,#48,#54,#44,#32,#121,#111,#117,#32,#97,#114,#101
	.db #32,#113,#117,#105,#116,#101,#32,#97,#32,#99,#111,#108,#108,#101,#99,#116,#111,#114,#33,#00
line26: .db #78,#111,#116,#32,#111,#110,#108,#121,#32,#104,#97,#118,#101,#32,#121,#111,#117,#32,#115,#97
	.db #118,#101,#100,#32,#116,#104,#101,#32,#119,#111,#114,#108,#100,#44,#32,#98,#117,#116,#00
line27: .db #121,#111,#117,#39,#118,#101,#32,#103,#111,#116,#32,#116,#111,#32,#100,#101
	.db #99,#105,#112,#104,#101,#114,#32,#116,#104,#101,#32,#104,#105,#100,#100,#101,#110,#00
line28: .db #109,#101,#115,#115,#97,#103,#101,#32,#34,#80,#72,#65,#78,#84,#73,#83,#34,#46,#00

deallocateMemory

line29: .db #71,#97,#109,#101,#32,#105,#110,#100,#117,#115,#116,#114,#121
	.db #32,#111,#119,#101,#115,#32,#121,#111,#117,#32,#111,#110,#101,#33,#00

