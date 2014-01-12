;============================================================
;    some initialization and interrupt redirect setup
;============================================================
main_loop
           sei         ; set interrupt disable flag

           lda #$01
           sta is_character_moving_right

           ; jsr clear_screen
           jsr sid_init     ; init music routine now

           ldy #$7f    ; $7f = %01111111
           sty $dc0d   ; Turn off CIAs Timer interrupts ($7f = %01111111)
           sty $dd0d   ; Turn off CIAs Timer interrupts ($7f = %01111111)
           lda $dc0d   ; by reading $dc0d and $dd0d we cancel all CIA-IRQs in queue/unprocessed
           lda $dd0d   ; by reading $dc0d and $dd0d we cancel all CIA-IRQs in queue/unprocessed
          
           lda #$01    ; Set Interrupt Request Mask...
           sta $d01a   ; ...we want IRQ by Rasterbeam (%00000001)

           lda $d011   ; Bit#0 of $d011 indicates if we have passed line 255 on the screen
           and #$7f    ; it is basically the 9th Bit for $d012
           sta $d011   ; we need to make sure it is set to zero for our intro.

           lda #<irq   ; point IRQ Vector to our custom irq routine
           ldx #>irq 
           sta $314    ; store in $314/$315
           stx $315   

           lda #$00    ; trigger first interrupt at row zero
           sta $d012

           cli                  ; clear interrupt disable flag
           jmp *                ; infinite loop

;============================================================
;    custom interrupt routine
;============================================================

irq        jmp check_global_keyboard

continue_from_global_keyboard
           
           lda current_screen
           cmp #$00
           beq handle_main_menu_irq_1
           lda current_screen
           cmp #$01
           beq handle_play_irq_1
           cmp #$02
           beq handle_help_irq_1
complete_irq
           dec $d019
           jmp $ea81

handle_play_irq_1
           lda game_screen_first_load
           cmp #$00
           beq handle_game_first_load

           jsr play_music
           ;jsr inc_score_tens_digit
           jsr check_in_game_keyboard
           jsr write_score

           jmp complete_irq

handle_help_irq_1
            lda about_screen_first_load
            cmp #$00
            beq handle_about_first_load

           jsr play_music

           jmp complete_irq

handle_main_menu_irq_1
           ; we need to check if ran single time, if not then clear screen and don't add second interupt
           ; this is because clearing screen and setting up everything else takes took much time
           lda main_screen_first_load
           cmp #$00
           beq handle_main_menu_first_load

           jsr check_keyboard
           jsr set_title_char_set
           jsr play_music   ; jump to play music routine
           jsr color_title      ; jump to color cycling routine

           lda #<handle_main_menu_irq_2   ; point IRQ Vector to our custom irq routine
           ldx #>handle_main_menu_irq_2
           sta $314    ; store in $314/$315
           stx $315   

           lda #80    ; trigger first interrupt at row 80
           sta $d012

           jmp complete_irq

handle_main_menu_first_load
           ; set main menu first load to #$01, don't forget to set back to zero when exiting the game a bout about
           lda #$01
           sta main_screen_first_load

           ldx #$00
           stx $d021
           ldx #$0a
           stx $d020

           jsr clear_screen
           jsr write_title
           jsr write_main
           jsr play_music

           jmp complete_irq

handle_game_first_load
           ; set main menu first load to #$01, don't forget to set back to zero when exiting the game a bout about
           lda #$01
           sta game_screen_first_load

           ldx #game_bg_color
           stx $d021
           ldx #$0a
           stx $d020

           jsr clear_screen
           jsr play_music
           jsr setup_game_scene

           jmp complete_irq

handle_about_first_load
           lda #$01
           sta about_screen_first_load

           ldx #$00
           stx $d021
           ldx #$0a
           stx $d020

           jsr clear_screen
           jsr play_music

           jmp complete_irq

handle_main_menu_irq_2
           jsr set_default_char_set
           jsr color_main_screen

           lda #<irq   ; point IRQ Vector to our custom irq routine
           ldx #>irq
           sta $314    ; store in $314/$315
           stx $315   

           lda #0    ; trigger first interrupt at row 0
           sta $d012

           jmp complete_irq
