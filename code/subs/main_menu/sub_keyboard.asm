check_keyboard              

                        lda #%11111111  ; CIA#1 Port A set to output 
                        sta ddra             
                        lda #%00000000  ; CIA#1 Port B set to inputt
                        sta ddrb             
            
; check_runstop           lda #%0111111  ; select row 8
;                         sta pra 
;                         lda prb         ; load column information
;                         and #%10000000  ; test 'run/stop' key to exit 
;                         beq exit_to_basic

check_up	        lda #%11111101  ; select row 8
                        sta pra 
                        lda prb         ; load column information
                        and #%00000010  ; test 'space' key to exit 
                        beq select_start_game

check_down              lda #%11111101  ; select row 8
                        sta pra 
                        lda prb         ; load column information
                        and #%00100000  ; test 'space' key to exit 
                        beq select_about

check_return            lda #%11011110  ; select row 8
                        sta pra 
                        lda prb         ; load column information
                        and #%00000010  ; test 'run/stop' key to exit 
                        beq select_option
                        rts

select_option           lda menu_selected_option
                        cmp #$00
                        beq set_start_game
                        bne set_view_help
continue_select_option
                        rts

set_start_game          lda #$00
                        sta game_screen_first_load
                        lda #$01 ; set up var for screen @ game
                        sta current_screen
                        jmp continue_select_option

set_view_help           lda #$00
                        sta about_screen_first_load
                        lda #$02 ; set up var for screen @ help
                        sta current_screen
                        jmp continue_select_option

; exit_to_basic           lda #$00
;                         sta $d015        ; turn off all sprites
;                         jmp $ea81        ; jmp to regular interrupt routine
;                         rts