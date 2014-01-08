check_keyboard              

                        lda #%11111111  ; CIA#1 Port A set to output 
                        sta ddra             
                        lda #%00000000  ; CIA#1 Port B set to inputt
                        sta ddrb             
            
check_runstop           lda #%0111111  ; select row 8
                        sta pra 
                        lda prb         ; load column information
                        and #%10000000  ; test 'run/stop' key to exit 
                        beq exit_to_basic

check_up	        lda #%11111101  ; select row 8
                        sta pra 
                        lda prb         ; load column information
                        and #%00000010  ; test 'space' key to exit 
                        beq select_easy

check_down              lda #%11111101  ; select row 8
                        sta pra 
                        lda prb         ; load column information
                        and #%00100000  ; test 'space' key to exit 
                        beq select_hard
                        rts

exit_to_basic           lda #$00
                        sta $d015        ; turn off all sprites
                        jmp $ea81        ; jmp to regular interrupt routine
                        rts