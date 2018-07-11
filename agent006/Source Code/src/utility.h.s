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
;; FUNCTIONS THAT CAN BE COMMON TO VARIOUS MODULES
;;=================================================
.globl utility_update_tiles
.globl utility_update_tiles2
.globl utility_update_tiles_obs
.globl utility_checkCollision
.globl utility_object_draw_masked
.globl utility_object_draw
.globl utility_object_erase
.globl utility_player_erase
.globl utility_object_erase2
.globl utility_object_erase3
.globl utility_setcheckpoint
.globl utility_resetGame
.globl utility_advanceAnimation
.globl utility_initializePosition
.globl utility_updatePosition
.globl utility_update_tiles_obstacle
.globl utility_update_tiles_obstacle2
.globl utility_update_tiles_obstacle3
.globl utility_updatePosition_obstacle
.globl utility_obstacle_erase
.globl utility_obstacle_erase2
.globl utility_shot_sound
.globl utility_piano_sound
.globl utility_draw_line
.globl utility_wait
.globl utility_objectMap_update
.globl utility_obstacleMap_update
.globl utility_screenPtr
.globl utility_updatePosition1