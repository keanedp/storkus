;============================================================
;    some initialization and interrupt redirect setup
;============================================================
main_loop
           sei         ; set interrupt disable flag

           jsr clear_screen     ; clear the screen
           jsr write_title  ; write lines of text
           jsr write_main_menu
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

irq        lda current_screen
           cmp #$00
           beq handle_main_menu_irq
           lda current_screen
           cmp #$01
           beq handle_help_irq

handle_help_irq
           jsr clear_screen
           jsr play_music

           dec $d019
           jmp $ea81

handle_main_menu_irq
           jmp main_menu_irq_1

main_menu_irq_1
           dec $d019        ; acknowledge IRQ / clear register for next interrupt
           jsr check_keyboard
           jsr set_title_char_set
           jsr play_music   ; jump to play music routine
           jsr color_title      ; jump to color cycling routine

           lda #<main_menu_irq_2   ; point IRQ Vector to our custom irq routine
           ldx #>main_menu_irq_2
           sta $314    ; store in $314/$315
           stx $315   

           lda #80    ; trigger first interrupt at row 80
           sta $d012

           jmp $ea81        ; return to kernel interrupt routine

main_menu_irq_2
           dec $d019        ; acknowledge IRQ / clear register for next interrupt
           jsr set_default_char_set
           jsr color_remainder

           lda #<irq   ; point IRQ Vector to our custom irq routine
           ldx #>irq
           sta $314    ; store in $314/$315
           stx $315   

           lda #0    ; trigger first interrupt at row 0
           sta $d012

           jmp $ea81
