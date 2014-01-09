;============================================================
;    some initialization and interrupt redirect setup
;============================================================
main_loop
           ;sei         ; set interrupt disable flag

           lda current_screen
           cmp #$00
           beq init_main_screen

continue_main_loop
           jmp *                ; infinite loop


;============================================================
;    init screens
;============================================================

init_main_screen
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
           jmp continue_main_loop

;============================================================
;    custom interrupt routine
;============================================================

irq        ; lda #$04 ; color test
           ; sta $d020
           ; sta $d021

           lda current_screen
           cmp #$00

           jsr check_keyboard
           jsr set_title_char_set
           jsr play_music	  ; jump to play music routine
           jsr color_title      ; jump to color cycling routine

           lda #<irq2   ; point IRQ Vector to our custom irq routine
           ldx #>irq2
           sta $314    ; store in $314/$315
           stx $315   

           lda #80    ; trigger first interrupt at row 80
           sta $d012

           dec $d019        ; acknowledge IRQ / clear register for next interrupt
           jmp $ea81        ; return to kernel interrupt routine

irq2       ;lda #$08  ; color test
           ;sta $d020
           ;sta $d021
           jsr set_default_char_set
           jsr color_remainder

           lda #<irq   ; point IRQ Vector to our custom irq routine
           ldx #>irq
           sta $314    ; store in $314/$315
           stx $315   

           lda #0    ; trigger first interrupt at row 0
           sta $d012

           dec $d019        ; acknowledge IRQ / clear register for next interrupt
           jmp $ea81 