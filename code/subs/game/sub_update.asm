setup_game_scene

			; init memory
			ldx #$04; sprite_frames_character
			stx character_current_frame
			 
			lda #sprite_pointer_character
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
			 
			; lda #$01    ; set X-Coord high bit (9th Bit)
			; sta $d010
			 
			lda #$a8    ; set Sprite#0 positions with X/Y coords to
			sta $d000   ; bottom border of screen on the outer right
			lda #$e5   ; $d000 corresponds to X-Coord
			sta $d001   ; $d001 corresponds to Y-Coord

			rts

;======================
;	MOVE LEFT
;======================
move_left   lda $d000
			cmp #$18
			bcc handle_x_high_bit_left
			beq handle_x_high_bit_left
contine_handle_x_high_bit_left
			lda $d000
			clc
			sbc #$01
			sta $d000
			bcc set_x_low_bit
complete_move_left
			jmp finalize_move_left

handle_x_high_bit_left
			lda $d010
			cmp #$01
			beq contine_handle_x_high_bit_left
			jmp complete_move_left

set_x_low_bit
			clc
			lda #$00    ; set X-Coord high bit (9th Bit)
			sta $d010
			jmp complete_move_left

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
			adc #$01
			sta $d000
			bcs set_x_high_bit
complete_move_right 
			jsr animate_right
			jmp finalize_move_right

handle_x_high_bit_right
			lda $d010
			cmp #$00
			beq inc_right_x
			jmp complete_move_right

set_x_high_bit
			clc
			lda #$01    ; set X-Coord high bit (9th Bit)
			sta $d010
			jmp complete_move_right


;======================
;	ANIMATE
;======================
animate_right 
			lda character_current_frame
			cmp #$00
			bne dec_character_frame

reset_character_frames
			ldx #$04 ;sprite_frames_character
			stx character_current_frame
			lda #sprite_pointer_character
			sta screen_ram + $3f8 

dec_character_frame
			inc screen_ram + $3f8          ; increase current pointer position
			dec character_current_frame
	        rts
