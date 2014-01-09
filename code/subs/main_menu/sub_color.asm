;============================================================
; color washer routine
;============================================================

color_title              lda color+$00      ; load the current first color from table
                         sta color+$28      ; store in in last position of table to reset the cycle
                         ldx #$00           ; init X with zero

loop_color_title         lda color+1,x      ; Start cycle by fetching next color in the table...
                         sta color,x        ; ...and store it in the current active position.
                         sta $d850,x        ; put into Color Ram
                         inx                ; increment X-Register
                         cpx #$28           ; have we done 40 iterations yet?
                         bne loop_color_title         ; if no, continue
                         rts

; color_copyright          lda color2+$28     ; load current last color from second table
;                          sta color2+$00     ; store in in first position of table to reset the cycle
;                          ldx #$28
; loop_color_copyright     lda color2-1,x     ; Start cycle by fetching previous color in the table...
;                          sta color2,x       ; ...and store it in the current active position.
;                          sta $d940,x        ; put into Color Ram
;                          dex                ; decrease iterator
;                          bne loop_color_copyright         ; if x not zero yet, continue

color_main_screen
color_copyright          ldx #$00
loop_color_copyright     lda #$0e
                         sta $d940,x
                         inx
                         cpx #$28
                         bne loop_color_copyright

                         ldx #$00
color_menu_menu          lda #$04
                         sta $da30,x
                         sta $daf8,x
                         inx
                         cpx #$c8
                         bne color_menu_menu

                         rts          ; return from subroutine