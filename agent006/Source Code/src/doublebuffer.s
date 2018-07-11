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
;; FUNCTIONS RELATED WITH BUFFER MANAGEMENT
;;=================================================

;;=========================================
;; INCLUDE AREA
;;=========================================
.include "includes.h.s"

;;=========================================
;;=========================================
;; PRIVATE DATA
;;=========================================
;;=========================================
videoPtr: .dw #0x8000	;;current videoPtr location

;;=========================================
;;=========================================
;; PUBLIC FUNCTIONS
;;=========================================
;;=========================================

;;=========================================
;; Returns current video ptr in hl
;; DESTROYS: HL
;;=========================================
db_getVideoPtr::
	ld hl, (videoPtr)
ret

;;=========================================
;; Resets video ptr
;; DESTROYS: HL
;;=========================================
db_setVideoPtr80::
	ld a, #0x80
	ld (videoPtr+1),a
ret

;;=========================================
;; Resets video ptr
;; DESTROYS: HL
;;=========================================
db_setVideoPtrC0::
	ld a, #0xC0
	ld (videoPtr+1),a
ret

;;=========================================
;; Fills with 0 from 0x8000 to 0xC000
;; DESTROYS: HL; DE; BC
;;=========================================
db_initialize::
	ld hl, #0x8000
	ld de, #0x8001
	ld (hl), #00
	ld bc, #0x4000
	ldir
ret

;;=========================================
;; Fills with 0 from 0x8000 to 0xC000
;; DESTROYS: HL
;;=========================================
db_switchBuffers::

	;;constant
	modifier = .+1 ;;memory position of next data (0x20)

	ld l, #0x20
	call cpct_setVideoMemoryPage_asm	;;change the buffer
	ld hl, #modifier
	ld a, #0x10
	xor (hl) ;;change the 0x20  to 0x30
	ld (modifier), a

	ld hl,  #videoPtr+1
	ld a, #0x40
	xor (hl)
	ld (videoPtr+1), a	;;update video ptr value

ret

;;=========================================
;;=========================================
;; PRIVATE FUNCTIONS
;;=========================================
;;=========================================