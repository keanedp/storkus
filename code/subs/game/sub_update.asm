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
            
            ; test jump up

            inc character_jump_index
            dec $d001
            dec $d001
            jmp complete_jump

jump_down	jmp test_down_collision
can_jump_down

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
start_jump	; test down if that's the direction we are going, else test up...
			ldx character_jump_index
			cpx #$00
			bne complete_start_jump
			inc character_jump_index
complete_start_jump
			jmp finalize_jump

;======================
;	MOVE LEFT
;======================
move_left   jmp test_left_collision
can_move_left
			lda $d000
			cmp #$18
			bcc handle_x_high_bit_left
			beq handle_x_high_bit_left
contine_handle_x_high_bit_left
			lda $d000
			sec
			sbc #$02
			sta $d000
			bcc set_x_low_bit
complete_move_left
			jsr animate_left
			jmp finalize_move_left

handle_x_high_bit_left
			lda $d010
			cmp #$01
			beq contine_handle_x_high_bit_left

			jmp complete_move_left

set_x_low_bit
			sec
			lda #$00    ; set X-Coord high bit (9th Bit)
			sta $d010
			jmp complete_move_left

;======================
;	MOVE RIGHT
;======================
move_right  jmp test_right_collision
can_move_right
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

load_y_row_into_fa_zero_page
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

			rts

; ======================
;	TEST LEFT COLLISION
; ======================
test_left_collision
			jsr load_y_row_into_fa_zero_page

			; figure out x pos and add to y
			lda $d000

			ldx $d010	; is x bit set high?
			cpx #$01
			beq left_collision_shift

			sec
			sbc #$18	; x offset for visible screen (18, but we will use 16 as check - 2 positions to left...)
left_collision_shift
			lsr
			lsr
			lsr

			cmp #$00
			beq test_carry_left
test_carry_left
			ldx $d010	; is x bit set high?
			cpx #$01
			bne continue_test_left
			clc
			adc #$1d ; add 31 characters onto a position
continue_test_left
			clc
			; adc #80
			; bcc test_left
			; inc $fb	; adding 80 to get bottom left corner of sprite, if carry set then inc 
test_left
			tay

			; lda #$03		; test post by displaying different character
			; sta ($fa),y

			; test top left pos - 2 pixels
			lda ($fa),y
			cmp #$1f	; if not space then stop movement ----- I THINK THIS IS WRONG, SHOULDN'T IT BE USING #$20 IN THE MAP ????????????
			bne cancel_left_movement
			; ; else

			; test bottom left pos - 2 pixels
			tya
			clc
			adc #80
			bcc test_bottom_left
			inc $fb	; adding 80 to get bottom left corner of sprite, if carry set then inc 
test_bottom_left
			tay

			; lda #$03
			; sta ($fa),y

			lda ($fa),y
			cmp #$1f	; if not space then stop movement ----- I THINK THIS IS WRONG, SHOULDN'T IT BE USING #$20 IN THE MAP ????????????
			bne cancel_left_movement

			jmp can_move_left

cancel_left_movement
			jmp finalize_move_left

; ======================
;	TEST RIGHT COLLISION
; ======================
test_right_collision
			jsr load_y_row_into_fa_zero_page

			; figure out x pos and add to y
			lda $d000
			; sec
			; sbc #$00	; x offset for visible screen (18, but we will use 1a as check + 2 positions to left...)
			lsr
			lsr
			lsr

			cmp #$00
			beq test_carry_right
test_carry_right
			ldx $d010	; is x bit set high?
			cpx #$01
			bne continue_test_right
			adc #$1f ; add 31 characters onto a position

continue_test_right
			; adc #2

			tay

			; lda #$03		; test post by displaying different character
			; sta ($fa),y

			; test top left pos - 2 pixels
			lda ($fa),y
			cmp #$1f	; if not space then stop movement ----- I THINK THIS IS WRONG, SHOULDN'T IT BE USING #$20 IN THE MAP ????????????
			bne cancel_right_movement
			; ; else

			; test bottom left pos - 2 pixels
			tya
			clc
			adc #80
			bcc test_bottom_right
			inc $fb	; adding 80 to get bottom left corner of sprite, if carry set then inc 
test_bottom_right
			tay

			; lda #$03
			; sta ($fa),y

			lda ($fa),y
			cmp #$1f	; if not space then stop movement ----- I THINK THIS IS WRONG, SHOULDN'T IT BE USING #$20 IN THE MAP ????????????
			bne cancel_right_movement

			jmp can_move_right

cancel_right_movement
			jmp finalize_move_right

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

; ======================
;	TEST DOWN COLLISION
; ======================
test_down_collision
			jsr load_y_row_into_fa_zero_page

			; figure out x pos and add to y
			lda $d000
			sec
			sbc #$18	; x offset for visible screen (18, but we will use 16 as check - 2 positions to left...)
			lsr
			lsr
			lsr

			cmp #$00
			beq test_carry_down_x
test_carry_down_x
			ldx $d010	; is x bit set high?
			cpx #$01
			bne continue_test_down
			clc
			adc #$1f ; add 31 characters onto a position
continue_test_down
			;tay

			; lda #$03		; test post by displaying different character
			; sta ($fa),y

			; test top left pos - 2 pixels
			; lda ($fa),Y
			; cmp #$1f	; if not space then stop movement ----- I THINK THIS IS WRONG, SHOULDN'T IT BE USING #$20 IN THE MAP ????????????
			; bne cancel_jump_movement
			; ; else

			; test bottom left pos - 2 pixels
			;tya
			clc
			adc #121
			bcc test_bottom_left_jump_down
			inc $fb	; adding 80 to get bottom left corner of sprite, if carry set then inc 
test_bottom_left_jump_down
			tay

			; lda #$03
			; sta ($fa),y

			lda ($fa),y
			cmp #$1f	; if not space then stop movement ----- I THINK THIS IS WRONG, SHOULDN'T IT BE USING #$20 IN THE MAP ????????????
			beq perform_jump_down

			lda #$00
			sta character_jump_index

			inc $d001
			inc $d001
			jmp cancel_jump_movement

cancel_jump_movement
			jmp finalize_jump

perform_jump_down
			jmp can_jump_down

handle_fall
			lda character_jump_index
			cmp #$00
			bne complete_fall

			jsr load_y_row_into_fa_zero_page

			; figure out x pos and add to y
			lda $d000
			; sec
			; sbc #$18	; x offset for visible screen (18, but we will use 16 as check - 2 positions to left...)
			lsr
			lsr
			lsr

			cmp #$00
			beq test_carry_fall_x
test_carry_fall_x
			ldx $d010	; is x bit set high?
			cpx #$01
			bne continue_test_fall
			clc
			adc #$1f ; add 31 characters onto a position
continue_test_fall
			clc
			adc #118
			bcc test_bottom_fall_right
			inc $fb	; adding 80 to get bottom left corner of sprite, if carry set then inc 
test_bottom_fall_right
			tay

			; lda #$06
			; sta ($fa),y

			lda ($fa),y
			cmp #$1f	; if not space then fall on y axis
			bne complete_fall

			tya
			clc
			adc #2
			bcc test_bottom_fall_left
			inc $fb	; adding 80 to get bottom left corner of sprite, if carry set then inc 
test_bottom_fall_left
			tay

			; lda #$06
			; sta ($fa),y

			lda ($fa),y
			cmp #$1f	; if not space then fall on y axis
			bne complete_fall

			inc $d001
			inc $d001
			inc $d001
			inc $d001
complete_fall
			rts
