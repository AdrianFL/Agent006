//-----------------------------LICENSE NOTICE-----------------------------------------------------
//  This file is part of Amstrad CPC videogame "Agent 006"
//  Copyright (C) 2017 APLSoft / Adrian Frances Lillo / Pablo Lopez Iborra / Luis Gonzalez Aracil
//  Copyright (C) 2015-2016 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU Lesser General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU Lesser General Public License for more details.
//
//  You should have received a copy of the GNU Lesser General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//-----------------------------LICENSE NOTICE-----------------------------------------------------


#include "tilesetBeach.h"
// Data created with Img2CPC - (c) Retroworks - 2007-2015

#include <cpctelera.h>
CPCT_ABSOLUTE_LOCATION_AREA(0x0F25);

u8* const tB_tileset[16] = { 
	tB_tilesetBeach_00, tB_tilesetBeach_01, tB_tilesetBeach_02, tB_tilesetBeach_03, tB_tilesetBeach_04, tB_tilesetBeach_05, tB_tilesetBeach_06, tB_tilesetBeach_07, tB_tilesetBeach_08, tB_tilesetBeach_09, tB_tilesetBeach_10, tB_tilesetBeach_11, tB_tilesetBeach_12, tB_tilesetBeach_13, tB_tilesetBeach_14, tB_tilesetBeach_15
};
// Tile tB_tilesetBeach_00: 4x4 pixels, 2x4 bytes.
const u8 tB_tilesetBeach_00[2 * 4] = {
	0x7f, 0x7f,
	0xbf, 0xbf,
	0x7f, 0x7f,
	0xbf, 0xbf
};

// Tile tB_tilesetBeach_01: 4x4 pixels, 2x4 bytes.
const u8 tB_tilesetBeach_01[2 * 4] = {
	0x0f, 0x0f,
	0x0f, 0x0f,
	0x7f, 0x7f,
	0xbf, 0xbf
};

// Tile tB_tilesetBeach_02: 4x4 pixels, 2x4 bytes.
const u8 tB_tilesetBeach_02[2 * 4] = {
	0x7f, 0x3f,
	0xbf, 0x3f,
	0x3f, 0x7e,
	0x3f, 0xfc
};

// Tile tB_tilesetBeach_03: 4x4 pixels, 2x4 bytes.
const u8 tB_tilesetBeach_03[2 * 4] = {
	0x7f, 0x7f,
	0x3f, 0xbf,
	0xbd, 0x7f,
	0xfc, 0x3f
};

// Tile tB_tilesetBeach_04: 4x4 pixels, 2x4 bytes.
const u8 tB_tilesetBeach_04[2 * 4] = {
	0x0c, 0x0c,
	0x0c, 0x0c,
	0x0c, 0x0c,
	0x0c, 0x0c
};

// Tile tB_tilesetBeach_05: 4x4 pixels, 2x4 bytes.
const u8 tB_tilesetBeach_05[2 * 4] = {
	0x7e, 0xfc,
	0x3f, 0xfc,
	0x3f, 0x7e,
	0xbf, 0x3f
};

// Tile tB_tilesetBeach_06: 4x4 pixels, 2x4 bytes.
const u8 tB_tilesetBeach_06[2 * 4] = {
	0xfc, 0xbd,
	0xfc, 0x3f,
	0xbd, 0x7f,
	0x3f, 0xbf
};

// Tile tB_tilesetBeach_07: 4x4 pixels, 2x4 bytes.
const u8 tB_tilesetBeach_07[2 * 4] = {
	0xfc, 0xbd,
	0xbd, 0x3f,
	0x3f, 0x7f,
	0x3f, 0xbf
};

// Tile tB_tilesetBeach_08: 4x4 pixels, 2x4 bytes.
const u8 tB_tilesetBeach_08[2 * 4] = {
	0xff, 0xff,
	0xff, 0xff,
	0xff, 0xff,
	0xff, 0xff
};

// Tile tB_tilesetBeach_09: 4x4 pixels, 2x4 bytes.
const u8 tB_tilesetBeach_09[2 * 4] = {
	0xfc, 0xfc,
	0xfc, 0xfc,
	0xfc, 0xfc,
	0xfc, 0xfc
};

// Tile tB_tilesetBeach_10: 4x4 pixels, 2x4 bytes.
const u8 tB_tilesetBeach_10[2 * 4] = {
	0x5f, 0x7f,
	0x1f, 0xbf,
	0x7f, 0x7f,
	0xbf, 0xbf
};

// Tile tB_tilesetBeach_11: 4x4 pixels, 2x4 bytes.
const u8 tB_tilesetBeach_11[2 * 4] = {
	0x7f, 0x2f,
	0xbf, 0xaf,
	0x7f, 0x7f,
	0xbf, 0xbf
};

// Tile tB_tilesetBeach_12: 4x4 pixels, 2x4 bytes.
const u8 tB_tilesetBeach_12[2 * 4] = {
	0xfc, 0xfc,
	0xfc, 0xfd,
	0xfd, 0xff,
	0xff, 0xff
};

// Tile tB_tilesetBeach_13: 4x4 pixels, 2x4 bytes.
const u8 tB_tilesetBeach_13[2 * 4] = {
	0xfc, 0xfc,
	0xfe, 0xfc,
	0xff, 0xfe,
	0xff, 0xff
};

// Tile tB_tilesetBeach_14: 4x4 pixels, 2x4 bytes.
const u8 tB_tilesetBeach_14[2 * 4] = {
	0x3f, 0x7f,
	0x3f, 0xbf,
	0x3f, 0x7f,
	0x3f, 0xbf
};

// Tile tB_tilesetBeach_15: 4x4 pixels, 2x4 bytes.
const u8 tB_tilesetBeach_15[2 * 4] = {
	0x7f, 0x3f,
	0xbf, 0x3f,
	0x7f, 0x3f,
	0xbf, 0x3f
};

CPCT_RELOCATABLE_AREA(0x0F25);