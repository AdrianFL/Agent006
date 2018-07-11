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
#include <cpctelera.h>
CPCT_ABSOLUTE_LOCATION_AREA(0x35C0);

#include "tilesetJungle.h"
// Data created with Img2CPC - (c) Retroworks - 2007-2015
u8* const tJ_tileset[16] = { 
	tJ_tilesetJungle_00, tJ_tilesetJungle_01, tJ_tilesetJungle_02, tJ_tilesetJungle_03, tJ_tilesetJungle_04, tJ_tilesetJungle_05, tJ_tilesetJungle_06, tJ_tilesetJungle_07, tJ_tilesetJungle_08, tJ_tilesetJungle_09, tJ_tilesetJungle_10, tJ_tilesetJungle_11, tJ_tilesetJungle_12, tJ_tilesetJungle_13, tJ_tilesetJungle_14, tJ_tilesetJungle_15
};
// Tile tJ_tilesetJungle_00: 4x4 pixels, 2x4 bytes.
const u8 tJ_tilesetJungle_00[2 * 4] = {
	0x89, 0x89,
	0x46, 0x03,
	0x89, 0x42,
	0x03, 0xc0
};

// Tile tJ_tilesetJungle_01: 4x4 pixels, 2x4 bytes.
const u8 tJ_tilesetJungle_01[2 * 4] = {
	0x03, 0x89,
	0x03, 0x46,
	0x81, 0x03,
	0xc0, 0x03
};

// Tile tJ_tilesetJungle_02: 4x4 pixels, 2x4 bytes.
const u8 tJ_tilesetJungle_02[2 * 4] = {
	0x89, 0x89,
	0x46, 0x46,
	0x89, 0x89,
	0x46, 0x46
};

// Tile tJ_tilesetJungle_03: 4x4 pixels, 2x4 bytes.
const u8 tJ_tilesetJungle_03[2 * 4] = {
	0x3c, 0x3c,
	0x3c, 0x3c,
	0x83, 0x83,
	0x43, 0x43
};

// Tile tJ_tilesetJungle_04: 4x4 pixels, 2x4 bytes.
const u8 tJ_tilesetJungle_04[2 * 4] = {
	0x03, 0x89,
	0x03, 0x46,
	0x03, 0x89,
	0x03, 0x46
};

// Tile tJ_tilesetJungle_05: 4x4 pixels, 2x4 bytes.
const u8 tJ_tilesetJungle_05[2 * 4] = {
	0x89, 0x03,
	0x46, 0x03,
	0x89, 0x03,
	0x46, 0x03
};

// Tile tJ_tilesetJungle_06: 4x4 pixels, 2x4 bytes.
const u8 tJ_tilesetJungle_06[2 * 4] = {
	0xc0, 0x81,
	0xc0, 0x03,
	0x81, 0x03,
	0x03, 0x46
};

// Tile tJ_tilesetJungle_07: 4x4 pixels, 2x4 bytes.
const u8 tJ_tilesetJungle_07[2 * 4] = {
	0x42, 0xc0,
	0x03, 0xc0,
	0x89, 0x42,
	0x46, 0x03
};

// Tile tJ_tilesetJungle_08: 4x4 pixels, 2x4 bytes.
const u8 tJ_tilesetJungle_08[2 * 4] = {
	0x94, 0xc0,
	0x94, 0xc0,
	0x94, 0xc0,
	0x94, 0xc0
};

// Tile tJ_tilesetJungle_09: 4x4 pixels, 2x4 bytes.
const u8 tJ_tilesetJungle_09[2 * 4] = {
	0xc0, 0x68,
	0xc0, 0x68,
	0xc0, 0x68,
	0xc0, 0x68
};

// Tile tJ_tilesetJungle_10: 4x4 pixels, 2x4 bytes.
const u8 tJ_tilesetJungle_10[2 * 4] = {
	0xe8, 0xe8,
	0xd4, 0xd4,
	0xe8, 0xe8,
	0xd4, 0xd4
};

// Tile tJ_tilesetJungle_11: 4x4 pixels, 2x4 bytes.
const u8 tJ_tilesetJungle_11[2 * 4] = {
	0xc0, 0xc0,
	0xc0, 0xc0,
	0xc0, 0xc0,
	0xc0, 0xc0
};

// Tile tJ_tilesetJungle_12: 4x4 pixels, 2x4 bytes.
const u8 tJ_tilesetJungle_12[2 * 4] = {
	0xcc, 0x6c,
	0x46, 0x6c,
	0xcc, 0x6c,
	0x46, 0x6c
};

// Tile tJ_tilesetJungle_13: 4x4 pixels, 2x4 bytes.
const u8 tJ_tilesetJungle_13[2 * 4] = {
	0x9c, 0x89,
	0x9c, 0xcc,
	0x9c, 0x89,
	0x9c, 0xcc
};

// Tile tJ_tilesetJungle_14: 4x4 pixels, 2x4 bytes.
const u8 tJ_tilesetJungle_14[2 * 4] = {
	0xc0, 0xc0,
	0xc0, 0xd4,
	0xd4, 0xfc,
	0xfc, 0xfc
};

// Tile tJ_tilesetJungle_15: 4x4 pixels, 2x4 bytes.
const u8 tJ_tilesetJungle_15[2 * 4] = {
	0xc0, 0xc0,
	0xe8, 0xc0,
	0xfc, 0xe8,
	0xfc, 0xfc
};
CPCT_RELOCATABLE_AREA(0x35C0);