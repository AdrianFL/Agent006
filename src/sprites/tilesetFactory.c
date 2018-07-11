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
CPCT_ABSOLUTE_LOCATION_AREA(0x3475);

#include "tilesetFactory.h"
// Data created with Img2CPC - (c) Retroworks - 2007-2015
u8* const tF_tileset[16] = { 
	tF_tilesetFactory_00, tF_tilesetFactory_01, tF_tilesetFactory_02, tF_tilesetFactory_03, tF_tilesetFactory_04, tF_tilesetFactory_05, tF_tilesetFactory_06, tF_tilesetFactory_07, tF_tilesetFactory_08, tF_tilesetFactory_09, tF_tilesetFactory_10, tF_tilesetFactory_11, tF_tilesetFactory_12, tF_tilesetFactory_13, tF_tilesetFactory_14, tF_tilesetFactory_15
};
// Tile tF_tilesetFactory_00: 4x4 pixels, 2x4 bytes.
const u8 tF_tilesetFactory_00[2 * 4] = {
	0x30, 0x30,
	0x30, 0x74,
	0x30, 0xfc,
	0x30, 0xb8
};

// Tile tF_tilesetFactory_01: 4x4 pixels, 2x4 bytes.
const u8 tF_tilesetFactory_01[2 * 4] = {
	0x30, 0x30,
	0xfc, 0x30,
	0x74, 0xb8,
	0x30, 0xb8
};

// Tile tF_tilesetFactory_02: 4x4 pixels, 2x4 bytes.
const u8 tF_tilesetFactory_02[2 * 4] = {
	0x30, 0x30,
	0x71, 0xb2,
	0x71, 0xb2,
	0x30, 0x30
};

// Tile tF_tilesetFactory_03: 4x4 pixels, 2x4 bytes.
const u8 tF_tilesetFactory_03[2 * 4] = {
	0xf0, 0xf0,
	0xf0, 0xf0,
	0xf0, 0xf0,
	0xf0, 0xf0
};

// Tile tF_tilesetFactory_04: 4x4 pixels, 2x4 bytes.
const u8 tF_tilesetFactory_04[2 * 4] = {
	0x30, 0xb8,
	0x30, 0xb8,
	0x30, 0xb8,
	0x30, 0xb8
};

// Tile tF_tilesetFactory_05: 4x4 pixels, 2x4 bytes.
const u8 tF_tilesetFactory_05[2 * 4] = {
	0x30, 0x30,
	0xfc, 0xfc,
	0x30, 0x30,
	0x30, 0x30
};

// Tile tF_tilesetFactory_06: 4x4 pixels, 2x4 bytes.
const u8 tF_tilesetFactory_06[2 * 4] = {
	0x30, 0x70,
	0x30, 0xf0,
	0x70, 0xf0,
	0xf0, 0xf0
};

// Tile tF_tilesetFactory_07: 4x4 pixels, 2x4 bytes.
const u8 tF_tilesetFactory_07[2 * 4] = {
	0xb0, 0x30,
	0xf0, 0x30,
	0xf0, 0xb0,
	0xf0, 0xf0
};

// Tile tF_tilesetFactory_08: 4x4 pixels, 2x4 bytes.
const u8 tF_tilesetFactory_08[2 * 4] = {
	0x30, 0xfc,
	0x30, 0x74,
	0x30, 0x30,
	0x30, 0x30
};

// Tile tF_tilesetFactory_09: 4x4 pixels, 2x4 bytes.
const u8 tF_tilesetFactory_09[2 * 4] = {
	0x74, 0xb8,
	0xfc, 0x30,
	0x30, 0x30,
	0x30, 0x30
};

// Tile tF_tilesetFactory_10: 4x4 pixels, 2x4 bytes.
const u8 tF_tilesetFactory_10[2 * 4] = {
	0xf0, 0xf0,
	0x70, 0xf0,
	0x30, 0xf0,
	0x30, 0x70
};

// Tile tF_tilesetFactory_11: 4x4 pixels, 2x4 bytes.
const u8 tF_tilesetFactory_11[2 * 4] = {
	0xf0, 0xf0,
	0xf0, 0xb0,
	0xf0, 0x30,
	0xb0, 0x30
};

// Tile tF_tilesetFactory_12: 4x4 pixels, 2x4 bytes.
const u8 tF_tilesetFactory_12[2 * 4] = {
	0x30, 0x30,
	0x30, 0x30,
	0x30, 0x30,
	0x30, 0x30
};

// Tile tF_tilesetFactory_13: 4x4 pixels, 2x4 bytes.
const u8 tF_tilesetFactory_13[2 * 4] = {
	0x0f, 0x0f,
	0x0f, 0x0f,
	0x0f, 0x0f,
	0x0f, 0x0f
};

// Tile tF_tilesetFactory_14: 4x4 pixels, 2x4 bytes.
const u8 tF_tilesetFactory_14[2 * 4] = {
	0x30, 0x30,
	0x35, 0x30,
	0x35, 0x30,
	0x30, 0x30
};

// Tile tF_tilesetFactory_15: 4x4 pixels, 2x4 bytes.
const u8 tF_tilesetFactory_15[2 * 4] = {
	0x30, 0x30,
	0x30, 0x1a,
	0x30, 0x1a,
	0x30, 0x30
};

CPCT_RELOCATABLE_AREA(0x3475);