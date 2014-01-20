setup_game_scene
			ldx #07; sprite_frames_character
			stx character_current_frame
			 
			lda #sprite_pointer_character_right
			sta screen_ram + $3f8 		
 
			; setup character sprite
			lda #$01   ; enable Sprite#0
			sta $d015 
			lda #$01   ; set Multicolor mode for Sprite#0
			sta $d01c
			lda #$00   ; Sprite#0 has priority over background
			sta $d01b
			 
			lda #game_bg_color 
			sta $d021
			lda #sprite_multicolor_1
			sta $d025
			lda #sprite_multicolor_2 
			sta $d026
			lda #sprite_character_color
			sta $d027
			 
			lda #$a8    ; set Sprite#0 positions with X/Y coords to
			sta $d000   ; bottom border of screen on the outer right
			lda #$d7   ; $d000 corresponds to X-Coord
			sta $d001   ; $d001 corresponds to Y-Coord
			rts

; check for jump, if currently jumping then increment y
update_charecter
            ldx character_jump_index
            cpx #$00
            beq complete_jump

            cpx #$29
            beq reset_jump_positon

            cpx #$15
            bcs jump_down
            
            inc character_jump_index
            dec $d001
            dec $d001
            jmp complete_jump
jump_down
			inc character_jump_index
			inc $d001
			inc $d001
complete_jump
			rts

reset_jump_positon
			lda #$00
			sta character_jump_index
			jmp complete_jump

;======================
;	JUMP
;======================
start_jump	ldx character_jump_index
			cpx #$00
			bne complete_start_jump
			inc character_jump_index
complete_start_jump
			jmp finalize_jump

;======================
;	MOVE LEFT
;======================
move_left   jsr test_left_collision
			jmp finalize_move_left
; 			lda $d000
; 			cmp #$18
; 			bcc handle_x_high_bit_left
; 			beq handle_x_high_bit_left
; contine_handle_x_high_bit_left
; 			lda $d000
; 			sec
; 			sbc #$02
; 			sta $d000
; 			bcc set_x_low_bit
; complete_move_left
; 			jsr animate_left
; 			jmp finalize_move_left

; handle_x_high_bit_left
; 			lda $d010
; 			cmp #$01
; 			beq contine_handle_x_high_bit_left
; 			jmp complete_move_left

; set_x_low_bit
; 			sec
; 			lda #$00    ; set X-Coord high bit (9th Bit)
; 			sta $d010
			; jmp complete_move_left

;======================
;	MOVE RIGHT
;======================
move_right  
			lda $d000
			cmp #$3f
			bcc inc_right_x
			lda $d010
			cmp #$01
			beq complete_move_right
inc_right_x
			lda $d000
			clc
			adc #$02
			sta $d000
			bcs set_x_high_bit
complete_move_right 
			jsr animate_right
			jmp finalize_move_right

set_x_high_bit
			clc
			lda #$01    ; set X-Coord high bit (9th Bit)
			sta $d010
			jmp complete_move_right


;======================
;	ANIMATE RIGHT
;======================
animate_right 
			lda is_character_moving_right
			cmp #$00
			beq reset_character_frames_right

			lda character_current_frame
			cmp #$00
			bne dec_character_frame_right

reset_character_frames_right
			lda #$01
			sta is_character_moving_right

			ldx #07 ;sprite_frames_character
			stx character_current_frame
			lda #sprite_pointer_character_right
			sta screen_ram + $3f8 

dec_character_frame_right
			inc screen_ram + $3f8          ; increase current pointer position
			dec character_current_frame
	        rts

; ======================
;	TEST LEFT COLLISION
; ======================
test_left_collision
			; load x pos and divide by 8 - todo check for high bit on sprite 1, this is dumb right now...
			; lda $d000
			; lsr
			; lsr
			; lsr
			; sta $fb

			; y value, use this to get memory address to start from....
			lda $d001
			sec
			sbc #$32	; y offset for visible screen
			lsr
			lsr
			lsr
			tay
			; todo check for high bit..., it set then add value to 31?
			lda screen_row_tbl_low,y
			sta $fa
			lda screen_row_tbl_high,y
			sta $fb

			ldy #$00	; todo remove this and use x add y offset

			; figure out x pos and add to y
			lda $d000
			sec
			sbc #$18	; x offset for visible screen
			lsr
			lsr
			lsr
			tay
test_pos
			lda #$03
			sta ($fa),y
			rts
;


;======================
;	ANIMATE
;======================
animate_left
			lda is_character_moving_right
			cmp #$01
			beq reset_character_frames_left

			lda character_current_frame
			cmp #$00
			bne dec_character_frame_left

reset_character_frames_left
			lda #$00
			sta is_character_moving_right

			ldx #07 ;sprite_frames_character
			stx character_current_frame
			lda #sprite_pointer_character_left
			sta screen_ram + $3f8 

dec_character_frame_left
			inc screen_ram + $3f8          ; increase current pointer position
			dec character_current_frame
	        rts
