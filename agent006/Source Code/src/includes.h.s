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
;; CPCTELERA PUBLIC FUNCTIONS
;;=========================================

;;CPCTelera Symbols
.include "macros.h.s"

.globl cpct_drawSolidBox_asm
.globl cpct_getScreenPtr_asm
.globl cpct_scanKeyboard_asm
.globl cpct_isKeyPressed_asm
.globl cpct_drawSprite_asm
.globl cpct_etm_drawTileBox2x4_asm
.globl cpct_etm_setTileset2x4_asm	
.globl cpct_drawSpriteMaskedAlignedTable_asm
.globl cpct_akp_stop_asm
.globl cpct_setVideoMemoryPage_asm
.globl cpct_drawStringM0_asm
.globl cpct_drawStringM1_asm
.globl cpct_scanKeyboard_f_asm
.globl cpct_isAnyKeyPressed_f_asm
.globl cpct_waitVSYNC_asm
.globl cpct_setPALColour_asm
.globl cpct_setPalette_asm
.globl cpct_setVideoMode_asm	


.globl cpct_akp_musicInit_asm
.globl cpct_akp_musicPlay_asm
.globl cpct_akp_stop_asm
.globl cpct_akp_SFXInit_asm
.globl cpct_akp_SFXPlay_asm
.globl cpct_akp_SFXStop_asm

.globl _playerMaskTable
.globl _song
.globl _SFX_shot

.globl get_pressedKeys0
.globl get_pressedKeys1

.globl change_musicStatus

.globl interruption_playMusic
.globl interruption_stopMusic
	