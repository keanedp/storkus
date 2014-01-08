;============================================================
; color washer routine
;============================================================

color_main_screen  
colwash_line1      lda color+$00      ; load the current first color from table
                   sta color+$28      ; store in in last position of table to reset the cycle
                   ldx #$00           ; init X with zero

loop_line1         lda color+1,x      ; Start cycle by fetching next color in the table...
                   sta color,x        ; ...and store it in the current active position.
                   sta $d850,x        ; put into Color Ram
                   inx                ; increment X-Register
                   cpx #$28           ; have we done 40 iterations yet?
                   bne loop_line1         ; if no, continue

colwash_line2      lda color2+$28     ; load current last color from second table
                   sta color2+$00     ; store in in first position of table to reset the cycle
                   ldx #$28
loop_line2         lda color2-1,x     ; Start cycle by fetching previous color in the table...
                   sta color2,x       ; ...and store it in the current active position.
                   sta $d940,x        ; put into Color Ram
                   dex                ; decrease iterator
                   bne loop_line2         ; if x not zero yet, continue

                   ldx #$00
color_menu_menu    lda #$05
                   sta $da30,x  ; top half (5 rows)
                   sta $daf8,x  ; bottom half (5 rows)
                   inx
                   cpx #$c8
                   bne color_menu_menu

                   rts          ; return from subroutine