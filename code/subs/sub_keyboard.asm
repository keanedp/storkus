check_global_keyboard   lda #%11111111  ; CIA#1 Port A set to output 
                        sta ddra             
                        lda #%00000000  ; CIA#1 Port B set to input
                        sta ddrb

check_run_stop          lda #%01111111  ; select row 8
                        sta pra 
                        lda prb         ; load column information
                        and #%10000000  ; test 'run/stop' key to exit 
                        beq exit_to_menu
                        jmp continue_from_global_keyboard

exit_to_menu		    lda current_screen ; check what screen we are on...
						cmp #01
						beq nav_to_main
						cmp #02
						beq nav_to_main
						jmp continue_from_global_keyboard

nav_to_main				lda #$00
						sta main_screen_first_load
						lda #$00
						sta current_screen
						jmp continue_from_global_keyboard
