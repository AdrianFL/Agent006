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
## This file is intended for users to automate image conversion from JPG, ##
## PNG, GIF, etc. into C-arrays.                                          ##
##                                                                        ##
## Macro used for conversion is IMG2SPRITES, which has up to 9 parameters:##
##  (1): Image file to be converted into C sprite (PNG, JPG, GIF, etc)    ##
##  (2): Graphics mode (0,1,2) for the generated C sprite                 ##
##  (3): Prefix to add to all C-identifiers generated                     ##
##  (4): Width in pixels of each sprite/tile/etc that will be generated   ##
##  (5): Height in pixels of each sprite/tile/etc that will be generated  ##
##  (6): Firmware palette used to convert the image file into C values    ##
##  (7): (mask / tileset /)                                               ##
##     - "mask":    generate interlaced mask for all sprites converted    ##
##     - "tileset": generate a tileset array with pointers to all sprites ##
##  (8): Output subfolder for generated .C/.H files (in project folder)   ##
##  (9): (hwpalette)                                                      ##
##     - "hwpalette": output palette array with hardware colour values    ##
## (10): Aditional options (you can use this to pass aditional modifiers  ##
##       to cpct_img2tileset)                                             ##
##                                                                        ##
## Macro is used in this way (one line for each image to be converted):   ##
##  $(eval $(call IMG2SPRITES,(1),(2),(3),(4),(5),(6),(7),(8),(9), (10))) ##
##                                                                        ##
## Important:                                                             ##
##  * Do NOT separate macro parameters with spaces, blanks or other chars.##
##    ANY character you put into a macro parameter will be passed to the  ##
##    macro. Therefore ...,src/sprites,... will represent "src/sprites"   ##
##    folder, whereas ...,  src/sprites,... means "  src/sprites" folder. ##
##                                                                        ##
##  * You can omit parameters but leaving them empty. Therefore, if you   ##
##  wanted to specify an output folder but do not want your sprites to    ##
##  have mask and/or tileset, you may omit parameter (7) leaving it empty ##
##     $(eval $(call IMG2SPRITES,imgs/1.png,0,g,4,8,$(PAL),,src/))        ##
############################################################################

## Example firmware palette definition as variable in cpct_img2tileset format

# PALETTE={0 1 3 4 7 9 10 12 13 16 19 20 21 24 25 26}

#PALETTE={4 1 2 3 0 6 9 11 12 13 15 16 20 21 24 26}
#
#PALETTE1={0 13 16 26}
#
### Example image conversion
###    This example would convert img/example.png into src/example.{c|h} files.
###    A C-array called pre_example[24*12*2] would be generated with the definition
###    of the image example.png in mode 0 screen pixel format, with interlaced mask.
###    The palette used for conversion is given through the PALETTE variable and
###    a pre_palette[16] array will be generated with the 16 palette colours as 
###	  hardware colour values.
#
##$(eval $(call IMG2SPRITES,img/example.png,0,pre,24,12,$(PALETTE),mask,src/,hwpalette))
#
##PLAYER
#$(eval $(call IMG2SPRITES,assets/sprites/player_up.png,0,sprite,10,16,$(PALETTE),,src/sprites,hwpalette))
#$(eval $(call IMG2SPRITES,assets/sprites/player_down.png,0,sprite,10,11,$(PALETTE),,src/sprites,))
#$(eval $(call IMG2SPRITES,assets/sprites/player_kneel.png,0,sprite,10,15,$(PALETTE),,src/sprites,))
#
##ENEMIES
#$(eval $(call IMG2SPRITES,assets/sprites/turret.png,0,sprite,10,20,$(PALETTE),,src/sprites,))
#$(eval $(call IMG2SPRITES,assets/sprites/obstacle.png,0,sprite,10,20,$(PALETTE),,src/sprites,))
#$(eval $(call IMG2SPRITES,assets/sprites/soldier.png,0,sprite,10,30,$(PALETTE),,src/sprites,))
#
##COLLECTABLES
#$(eval $(call IMG2SPRITES,assets/sprites/phantisdinamic.png,0,sprite,8,16,$(PALETTE),,src/sprites,))
#$(eval $(call IMG2SPRITES,assets/sprites/powerups.png,0,sprite,8,16,$(PALETTE),,src/sprites,))
#
##INTRO
#$(eval $(call IMG2SPRITES,assets/sprites/006.png,1,sprite,200,40,$(PALETTE1),,src/sprites,hwpalette1))
#$(eval $(call IMG2SPRITES,assets/sprites/APLSOFT.png,0,sprite,20,32,$(PALETTE),,src/sprites,))
#
##TILESETS
#$(eval $(call IMG2SPRITES,assets/sprites/tilesetIntroBeach.png,0,tInB,4,4,$(PALETTE),tileset,src/sprites,))
#$(eval $(call IMG2SPRITES,assets/sprites/tilesetBeach.png,0,tB,4,4,$(PALETTE),tileset,src/sprites,))
#$(eval $(call IMG2SPRITES,assets/sprites/tilesetBeachJungle.png,0,tB2J,4,4,$(PALETTE),tileset,src/sprites,))
#$(eval $(call IMG2SPRITES,assets/sprites/tilesetJungle.png,0,tJ,4,4,$(PALETTE),tileset,src/sprites,))
#$(eval $(call IMG2SPRITES,assets/sprites/tilesetJungleFactory.png,0,tJ2F,4,4,$(PALETTE),tileset,src/sprites,))
#$(eval $(call IMG2SPRITES,assets/sprites/tilesetFactory.png,0,tF,4,4,$(PALETTE),tileset,src/sprites,))
#
##CHECKPOINT
#$(eval $(call IMG2SPRITES,assets/sprites/checkpoint.png,0,sprite,6,14,$(PALETTE),,src/sprites,))
