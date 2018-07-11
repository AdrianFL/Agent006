;;=================================================
;; THIS FILE CONTAINS INTERRUPTION RELATED 
;; FUNCTIONS AND IT IS PRESENT UNIQUELY AS AN 
;; INCLUDE IN MAIN.S
;; HERE WE STORE THE isr FUNCTION FOR THE MAIN
;;=================================================


;;=========================================
;; INCLUDE AREA
;;=========================================
.include "keyboard/keyboard.s"	 ;;Keyboard definitions
.include "includes.h.s"

;;=========================================
;;=========================================
;; PRIVATE DATA
;;=========================================
;;=========================================
counter: 	.db #8	;;update music every frame
counter_k: 	.db #1	;;update user input every 0,1 s
music_status: .db #1

pressed_keys0: 	.db #0x00
;; W		10000000 - 128
;; A		01000000 - 64
;; S		00100000 - 32
;; D		00010000 - 16
;; Up arrow	00001000 - 8
;; Left arrow	00000100 - 4
;; Down arrow	00000010 - 2
;; Right arrow 	00000001 - 1

pressed_keys1: 	.db #0x00
;; Space	10000000 - 128
;; Number 1	01000000 - 64
;; Number 2	00100000 - 32
;; Number 3	00010000 - 16
;; Joy_Fire1	00001000 - 8
;; Mute		00000100 - 4
;; Unknown	00000010 - 2
;; Unknown 	00000001 - 1

music: .db 0x00 	;;play music or not

interruptionCount: .db 0x00 	;;number of interrupts since last frame
;;=========================================
;;=========================================
;; PUBLIC FUNCTIONS
;;=========================================
;;=========================================

;;=========================================
;; Changes the state of music
;; DESTROYS: A
;;=========================================
change_musicStatus::
	ld a, (music_status)
	xor #1
	ld (music_status), a
	cp #0
	call z, cpct_akp_stop_asm
ret

;;=========================================
;; Puts pressed keys in A
;; DESTROYS: A
;;=========================================
get_pressedKeys0::
	ld a, (pressed_keys0)
ret

;;=========================================
;; Puts pressed keys in A
;; DESTROYS: A
;;=========================================
get_pressedKeys1::
	ld a, (pressed_keys1)
ret

;;=========================================
;; Interrupts music play
;; DESTROYS: A
;;=========================================
interruption_stopMusic::
	ld a, #00 
	ld (music), a
ret 

;;=========================================
;; Activates music play
;; DESTROYS: A
;;=========================================
interruption_playMusic::
	ld a, #01 
	ld (music), a
ret 

;;=========================================
;;=========================================
;; PRIVATE FUNCTIONS
;;=========================================
;;=========================================
isr: ;;(interrupt service routine)

	call play_music
	call check_input
	
	;;Update interruption count
	ld a, (interruptionCount)
	inc a 
	ld (interruptionCount), a

ret

;;=============================================
;; Plays the music and resets counter
;;=============================================
play_music:
	;;check if music is activated
	ld a, (music_status)
	dec a
	ret nz

	;;save all the alternative registers to be modified
	ex af, af' ;;exchange AF with AF'
	exx ;;exchange BC, DE, HL with its alternative registers
	push af 
	push bc 
	push de 
	push hl
	push iy
	;;if we draw a sprite, we need to save those values

	;;decrase de counter and save new value
	ld a, (counter)
	dec a	
	ld (counter), a
	jr nz,  return

		;;if music no activated, skip play 

		ld a, (music)
		dec a 
		jr nz, skip_play

		;;if value is 0, call music a save new counter value
		call cpct_akp_musicPlay_asm 

		skip_play:
		ld a, #8
		ld (counter), a

	return:
	;;retrieve all modified registers
	pop iy 
	pop hl
	pop de 
	pop bc
	pop af 
	ex af, af'
	exx
ret

;;=============================================
;; Checks user input
;;=============================================
check_input:

	;;check how many time happens before checking
	ld a, (counter_k)
	dec a 
	jr z, continue

		ld (counter_k), a ;;decrease counter value and exit
		ret

	continue:
	ld a, #12		;;update once every 2 frames
	ld (counter_k), a	;;reset counter	

	;;scan which keys are pressed
	call cpct_scanKeyboard_asm

	;;Check for every key in pressed_keys0 and update info

	;;W
	ld 	hl, #Key_W			;;HL = Key_W
	call 	cpct_isKeyPressed_asm		;;Check if d is pressed	
	ld a, (pressed_keys0)		;;load pressed_keys0			
	jr z, not_pressed_1
		;;if pressed
	pressed_1:
		or #128	;;if w is 0, put to 1, everything else unchanged
		jr continue_1
	not_pressed_1:
		ld hl, #Joy0_Up
		call cpct_isKeyPressed_asm
		ld a, (pressed_keys0)
		jr nz, pressed_1
		and #127 ;;if not pressed, w to 0 and everything else unchanged
	continue_1:
		ld (pressed_keys0), a

	;;A
	ld 	hl, #Key_A			;;HL = Key_A
	call 	cpct_isKeyPressed_asm		;;Check if d is pressed	
	ld a, (pressed_keys0)		;;load pressed_keys0			
	jr z, not_pressed_2
		;;if pressed
	pressed_2:
		or #64	;;if a is 0, put to 1, everything else unchanged
		jr continue_2
	not_pressed_2:
		ld hl, #Joy0_Left
		call cpct_isKeyPressed_asm
		ld a, (pressed_keys0)
		jr nz, pressed_2
		and #191 ;;if not pressed, a to 0 and everything else unchanged
	continue_2:
		ld (pressed_keys0), a

	;;S
	ld 	hl, #Key_S			;;HL = Key_S
	call 	cpct_isKeyPressed_asm		;;Check if d is pressed	
	ld a, (pressed_keys0)		;;load pressed_keys0			
	jr z, not_pressed_3
		;;if pressed
	pressed_3:
		or #32	;;if s is 0, put to 1, everything else unchanged
		jr continue_3
	not_pressed_3:
		ld hl, #Joy0_Down
		call cpct_isKeyPressed_asm
		ld a, (pressed_keys0)
		jr nz, pressed_3
		and #223 ;;if not pressed, s to 0 and everything else unchanged
	continue_3:
		ld (pressed_keys0), a

	;;D
	ld 	hl, #Key_D			;;HL = Key_D
	call 	cpct_isKeyPressed_asm		;;Check if d is pressed	
	ld a, (pressed_keys0)		;;load pressed_keys0			
	jr z, not_pressed_4
		;;if pressed
	pressed_4:
		or #16	;;if d is 0, put to 1, everything else unchanged
		jr continue_4
	not_pressed_4:
		ld hl, #Joy0_Right
		call cpct_isKeyPressed_asm
		ld a, (pressed_keys0)
		jr nz, pressed_4
		and #239 ;;if not pressed, d to 0 and everything else unchanged
	continue_4:
		ld (pressed_keys0), a

	;;Cursor Up CU
	ld 	hl, #Key_I		;;HL = Key_I
	call 	cpct_isKeyPressed_asm		;;Check if cu is pressed	
	ld a, (pressed_keys0)		;;load pressed_keys0			
	jr z, not_pressed_5
		;;if pressed
	pressed_5:
		or #8	;;if cu is 0, put to 1, everything else unchanged
		jr continue_5
	not_pressed_5:
		ld hl, #Joy0_Up
		call cpct_isKeyPressed_asm
		ld a, (pressed_keys0)
		jr nz, pressed_5
		and #247 ;;if not pressed, cu to 0 and everything else unchanged
	continue_5:
		ld (pressed_keys0), a

	;;Cursor Left CL
	ld 	hl, #Key_J		;;HL = Key_J
	call 	cpct_isKeyPressed_asm		;;Check if cl is pressed	
	ld a, (pressed_keys0)		;;load pressed_keys0			
	jr z, not_pressed_6
		;;if pressed
	pressed_6:
		or #4	;;if cl is 0, put to 1, everything else unchanged
		jr continue_6
	not_pressed_6:
		ld hl, #Joy0_Left
		call cpct_isKeyPressed_asm
		ld a, (pressed_keys0)
		jr nz, pressed_6
		and #251 ;;if not pressed, cl to 0 and everything else unchanged
	continue_6:
		ld (pressed_keys0), a

	;;Cursor Down CD
	ld 	hl, #Key_K	;;HL = Key_K
	call 	cpct_isKeyPressed_asm		;;Check if cd is pressed	
	ld a, (pressed_keys0)		;;load pressed_keys0			
	jr z, not_pressed_7
		;;if pressed
	pressed_7:
		or #2	;;if cd is 0, put to 1, everything else unchanged
		jr continue_7
	not_pressed_7:
		ld hl, #Joy0_Down
		call cpct_isKeyPressed_asm
		ld a, (pressed_keys0)
		jr nz, pressed_7
		and #253 ;;if not pressed, cd to 0 and everything else unchanged
	continue_7:
		ld (pressed_keys0), a

	;;Cursor Right CR
	ld 	hl, #Key_L	;;HL = Key_L
	call 	cpct_isKeyPressed_asm		;;Check if cr is pressed	
	ld a, (pressed_keys0)		;;load pressed_keys0			
	jr z, not_pressed_8
		;;if pressed
	pressed_8:
		or #1	;;if cr is 0, put to 1, everything else unchanged
		jr continue_8
	not_pressed_8:
		ld hl, #Joy0_Right
		call cpct_isKeyPressed_asm
		ld a, (pressed_keys0)
		jr nz, pressed_8
		and #254 ;;if not pressed, cr to 0 and everything else unchanged
	continue_8:
		ld (pressed_keys0), a

	;;Check for every key in pressed_keys1 and update info

	;;Space
	ld 	hl, #Key_Space		;;HL = Key_Space
	call 	cpct_isKeyPressed_asm		;;Check if sp is pressed	
	ld a, (pressed_keys1)		;;load pressed_keys0			
	jr z, not_pressed_9
		;;if pressed
	pressed_9:
		or #128	;;if sp is 0, put to 1, everything else unchanged
		jr continue_9
	not_pressed_9:
		ld hl, #Joy0_Fire1
		call cpct_isKeyPressed_asm
		ld a, (pressed_keys1)
		jr nz, pressed_9
		and #127 ;;if not pressed, sp to 0 and everything else unchanged
	continue_9:
		ld (pressed_keys1), a


	;;Number 1
	ld 	hl, #Key_1		;;HL = Key_1
	call 	cpct_isKeyPressed_asm		;;Check if sp is pressed	
	ld a, (pressed_keys1)		;;load pressed_keys0			
	jr z, not_pressed_10
		;;if pressed
		or #64	;;if sp is 0, put to 1, everything else unchanged
		jr continue_10
	not_pressed_10:
		and #191 ;;if not pressed, sp to 0 and everything else unchanged
	continue_10:
		ld (pressed_keys1), a

	;;Number 2
	ld 	hl, #Key_2		;;HL = Key_2
	call 	cpct_isKeyPressed_asm		;;Check if sp is pressed	
	ld a, (pressed_keys1)		;;load pressed_keys0			
	jr z, not_pressed_11
		;;if pressed
		or #32	;;if sp is 0, put to 1, everything else unchanged
		jr continue_11
	not_pressed_11:
		and #223 ;;if not pressed, sp to 0 and everything else unchanged
	continue_11:
		ld (pressed_keys1), a

	;;Number 3
	ld 	hl, #Key_3		;;HL = Key_3
	call 	cpct_isKeyPressed_asm		;;Check if sp is pressed	
	ld a, (pressed_keys1)		;;load pressed_keys0			
	jr z, not_pressed_12
		;;if pressed
		or #16	;;if sp is 0, put to 1, everything else unchanged
		jr continue_12
	not_pressed_12:
		and #239 ;;if not pressed, sp to 0 and everything else unchanged
	continue_12:
		ld (pressed_keys1), a

	;;Joy0_Fire1
	ld 	hl, #Joy0_Fire1		;;HL = Joy0_Fire2
	call 	cpct_isKeyPressed_asm		;;Check if sp is pressed	
	ld a, (pressed_keys1)		;;load pressed_keys0			
	jr z, not_pressed_13
		;;if pressed
		or #8	;;if sp is 0, put to 1, everything else unchanged
		jr continue_13
	not_pressed_13:
		and #247 ;;if not pressed, sp to 0 and everything else unchanged
	continue_13:
		ld (pressed_keys1), a
	;;M -Mute
	ld 	hl, #Key_M	;;HL = Joy0_Fire2
	call 	cpct_isKeyPressed_asm		;;Check if sp is pressed	
	ld a, (pressed_keys1)		;;load pressed_keys0			
	jr z, not_pressed_14
		;;if pressed
		or #4	;;if sp is 0, put to 1, everything else unchanged
		jr continue_14
	not_pressed_14:
		and #251 ;;if not pressed, sp to 0 and everything else unchanged
	continue_14:
		ld (pressed_keys1), a

ret

;;=============================================
;; Check if we extend frame
;;=============================================
check_frame:

	ld a, (interruptionCount)
	cp #16
	ld b, a
	ld a, #00
	ld (interruptionCount), a	;;reset interruptionCount
	ret p ;;if more than 6 interruptions happened 

	ld a, b 
	cp #8
	jp p, one_frame
		ld bc, #0x0106
		call utility_wait ;;wait before next vsync

	one_frame:
	ld bc, #0x0106
	call utility_wait ;;wait before next vsync

	ld a, #00
	ld (interruptionCount), a	;;reset interruptionCount

ret