##-----------------------------LICENSE NOTICE------------------------------------
##  This file is part of CPCtelera: An Amstrad CPC Game Engine 
##  Copyright (C) 2016 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
##
##  This program is free software: you can redistribute it and/or modify
##  it under the terms of the GNU Lesser General Public License as published by
##  the Free Software Foundation, either version 3 of the License, or
##  (at your option) any later version.
##
##  This program is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU Lesser General Public License for more details.
##
##  You should have received a copy of the GNU Lesser General Public License
##  along with this program.  If not, see <http://www.gnu.org/licenses/>.
##------------------------------------------------------------------------------

############################################################################
##                        CPCTELERA ENGINE                                ##
##                 Automatic image conversion file                        ##
##------------------------------------------------------------------------##
## This file is intended for users to automate tilemap conversion from    ##
## original files (like Tiled .tmx) into C-arrays.                        ##
##                                                                        ##
## Macro used for conversion is TMX2C, which has up to 4 parameters:      ##
##  (1): TMX file to be converted to C array                              ##
##  (2): C identifier for the generated C array                           ##
##  (3): Output folder for C and H files generated (Default same folder)  ##
##  (4): Bits per item (1,2,4 or 6 to codify tilemap into a bitarray).    ##
##       Blanck for normal integer tilemap array (8 bits per item)        ##
##  (5): Aditional options (aditional modifiers for cpct_tmx2csv)         ##
##                                                                        ##
## Macro is used in this way (one line for each image to be converted):   ##
##  $(eval $(call TMX2C,(1),(2),(3),(4),(5)))                             ##
##                                                                        ##
## Important:                                                             ##
##  * Do NOT separate macro parameters with spaces, blanks or other chars.##
##    ANY character you put into a macro parameter will be passed to the  ##
##    macro. Therefore ...,src/sprites,... will represent "src/sprites"   ##
##    folder, whereas ...,  src/sprites,... means "  src/sprites" folder. ##
##  * You can omit parameters by leaving them empty.                      ##
##  * Parameters (4) and (5) are optional and generally not required.     ##
############################################################################

## Conversion Examples
##

## Convert img/tilemap.tmx to src/tilemap.c and src/tilemap.h
##		This file contains a tilemap created with Tiled that uses tiles
## in img/tiles.png. This macro will convert the tilemap into a C-array
## named g_tilemap, containing all the IDs of the tiles that are located 
## at each given location of the C-array. 
##

#$(eval $(call TMX2C,img/tilemap.tmx,g_tilemap,src/,4))

## Convert img/level0b.tmx to src/levels/level0b.c and src/levels/level0b.h
##		This file contains another tilemap created with Tiled. This macro 
## will convert the tilemap into a C bitarray of 4-bits per item. The array
## will be named g_level0_4bit. For each tile ID included into the final 
## bitarray, only 4 bits will be used. Therefore, each byte of the array 
## will contain 2 tile IDs.
##

#$(eval $(call TMX2C,img/level0b.tmx,g_level0_4bit,src/levels/,4))

##SKIES 
#$(eval $(call TMX2C,assets/maps/s_J_1.tmx,s_J_1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/s_F_1.tmx,s_F_1,src/levels/,4))
#
##GROUNDS
#$(eval $(call TMX2C,assets/maps/g_J_1.tmx,g_J_1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_F_1.tmx,g_F_1,src/levels/,4))

#INTROS
#$(eval $(call TMX2C,assets/maps/i_IB_1.tmx,i_IB_1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/i_B2J_1.tmx,i_B2J_1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/i_B2J_2.tmx,i_B2J_2,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/i_J2F_1.tmx,i_J2F_1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/i_J2F_2.tmx,i_J2F_2,src/levels/,4))
#
#
##BEACH SKIES
#$(eval $(call TMX2C,assets/maps/s_B_0.tmx,s_B_0,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/s_B_N1.tmx,s_B_N1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/s_B_N2.tmx,s_B_N2,src/levels/,4))
##$(eval $(call TMX2C,assets/maps/s_B_N3.tmx,s_B_N3,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/s_B_T1.tmx,s_B_T1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/s_B_T2.tmx,s_B_T2,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/s_B_TC1.tmx,s_B_TC1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/s_B_TC2.tmx,s_B_TC2,src/levels/,4))
#
#
##BEACH GROUNDS
#$(eval $(call TMX2C,assets/maps/g_B_1.tmx,g_B_1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_B_2.tmx,g_B_2,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_B_2T1.tmx,g_B_2T1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_B_2T2.tmx,g_B_2T2,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_B_3.tmx,g_B_3,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_B_3T1.tmx,g_B_3T1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_B_3T2.tmx,g_B_3T2,src/levels/,4))
##$(eval $(call TMX2C,assets/maps/g_B_4.tmx,g_B_4,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_B_4T1.tmx,g_B_4T1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_B_4T2.tmx,g_B_4T2,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_B_5.tmx,g_B_5,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_B_5T1.tmx,g_B_5T1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_B_5T2.tmx,g_B_5T2,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_B_6T1.tmx,g_B_6T1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_B_6T2.tmx,g_B_6T2,src/levels/,4))
#
##JUNGLE SKIES
#$(eval $(call TMX2C,assets/maps/s_J_0.tmx,s_J_0,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/s_J_N1.tmx,s_J_N1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/s_J_N2.tmx,s_J_N2,src/levels/,4))
##$(eval $(call TMX2C,assets/maps/s_J_N3.tmx,s_J_N3,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/s_J_T1.tmx,s_J_T1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/s_J_T2.tmx,s_J_T2,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/s_J_TC1.tmx,s_J_TC1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/s_J_TC2.tmx,s_J_TC2,src/levels/,4))
#
##JUNGLE GROUNDS
#$(eval $(call TMX2C,assets/maps/g_J_1.tmx,g_J_1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_J_2.tmx,g_J_2,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_J_2T1.tmx,g_J_2T1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_J_2T2.tmx,g_J_2T2,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_J_3.tmx,g_J_3,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_J_3T1.tmx,g_J_3T1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_J_3T2.tmx,g_J_3T2,src/levels/,4))
##$(eval $(call TMX2C,assets/maps/g_J_4.tmx,g_J_4,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_J_4T1.tmx,g_J_4T1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_J_4T2.tmx,g_J_4T2,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_J_5.tmx,g_J_5,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_J_5T1.tmx,g_J_5T1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_J_5T2.tmx,g_J_5T2,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_J_6T1.tmx,g_J_6T1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_J_6T2.tmx,g_J_6T2,src/levels/,4))
#
##FACTORY SKIES
#$(eval $(call TMX2C,assets/maps/s_F_0.tmx,s_F_0,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/s_F_N1.tmx,s_F_N1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/s_F_N2.tmx,s_F_N2,src/levels/,4))
##$(eval $(call TMX2C,assets/maps/s_F_N3.tmx,s_F_N3,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/s_F_T1.tmx,s_F_T1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/s_F_T2.tmx,s_F_T2,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/s_F_TC1.tmx,s_F_TC1,src/levels/,4))
##$(eval $(call TMX2C,assets/maps/s_F_TC2.tmx,s_F_TC2,src/levels/,4))
#
##FACTORY GROUNDS
#$(eval $(call TMX2C,assets/maps/g_F_1.tmx,g_F_1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_F_2.tmx,g_F_2,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_F_2T1.tmx,g_F_2T1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_F_2T2.tmx,g_F_2T2,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_F_3.tmx,g_F_3,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_F_3T1.tmx,g_F_3T1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_F_3T2.tmx,g_F_3T2,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_F_4.tmx,g_F_4,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_F_4T1.tmx,g_F_4T1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_F_4T2.tmx,g_F_4T2,src/levels/,4))
##$(eval $(call TMX2C,assets/maps/g_F_5.tmx,g_F_5,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_F_5T1.tmx,g_F_5T1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_F_5T2.tmx,g_F_5T2,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_F_6T1.tmx,g_F_6T1,src/levels/,4))
#$(eval $(call TMX2C,assets/maps/g_F_6T2.tmx,g_F_6T2,src/levels/,4))
#