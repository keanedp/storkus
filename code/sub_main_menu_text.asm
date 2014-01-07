;============================================================
; write the two line of text to screen center
;============================================================

write_main_menu
setup_std_chars  lda #$1f      ; set chars location to $3800 for displaying the custom font
                 sta $d018      ; Bits 1-3 ($400+512bytes * low nibble value) of $d018 sets char location
                                ; $400 + $200*$0E = $3800
                 lda $d016      ; turn off multicolor for characters
                 and #$ef       ; by cleaing Bit#4 of $D016
                 sta $d016

  		           ldx #$00         ; init X-Register with $00
loop_text        lda main_menu_line1,x      ; read characters from line1 table of text...
                 sta $0450,x      ; ...and store in screen ram near the center
                 ; lda main_menu_title,x      ; read characters from line1 table of text...
                 ; sta $0540,x      ; ...and put 2 rows below line1

                 inx 
                 cpx #$28         ; finished when all 40 cols of a line are processed
                 bne loop_text    ; loop if we are not done yet

                 ldx #$00
loop_top_menu    lda main_menu_top,x   ; do top 5 lines...
                 sta $0630,x
                 inx
                 cpx #$c8
                 bne loop_top_menu

                 ldx #$00
loop_btm_menu    lda main_menu_btm,x   ; do bottom 5 lines...
                 sta $06f8,x
                 inx
                 cpx #$c8
                 bne loop_btm_menu

; this doesn't work, how the hell do you load multiple character maps!!!
; setup_title_chars lda #$1c
;                  ;;ora #$0f       ; set chars location to $3800 for displaying the custom font
;                  sta $d018      ; Bits 1-3 ($400+512bytes * low nibble value) of $d018 sets char location
;                                 ; $400 + $200*$0E = $3800
;                  lda $d016      ; turn off multicolor for characters
;                  and #$ef       ; by cleaing Bit#4 of $D016
;                  sta $d016

                 ldx #$00         ; init X-Register with $00
loop_title       lda main_menu_title,x      ; read characters from line1 table of text...
                 sta $0540,x      ; ...and put 2 rows below line1

                 inx 
                 cpx #$28         ; finished when all 40 cols of a line are processed
                 bne loop_title   ; loop if we are not done yet

                 rts