check_in_game_keyboard  lda #%11111111  ; CIA#1 Port A set to output 
                        sta ddra             
                        lda #%00000000  ; CIA#1 Port B set to input
                        sta ddrb

check_a_left            lda #%11111101
                        sta pra 
                        lda prb         ; load column information
                        and #%00000100  ; test a key
                        beq jump_to_move_left
finalize_move_left

check_d_right           lda #%11111011
                        sta pra 
                        lda prb         ; load column information
                        and #%00000100  ; test d key
                        beq jump_to_move_right
finalize_move_right

check_space_jump        lda #%01111111
                        sta pra 
                        lda prb         ; load column information
                        and #%00010000  ; test space key
                        beq jump_to_perform_jump
complete_jump

                        jmp continue_from_in_game_keyboard

jump_to_move_left	jmp move_left

jump_to_move_right	jmp move_right

jump_to_perform_jump    jmp start_jump

continue_from_in_game_keyboard
			rts