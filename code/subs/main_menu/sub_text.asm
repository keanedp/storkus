;============================================================
; write the two line of text to screen center
;============================================================

write_title
setup_title_char ldx #$00         ; init X-Register with $00
loop_title       lda main_menu_title,x      ; read characters from line1 table of text...
                 sta $0450,x      ; ...and put 2 rows below line1

                 inx 
                 cpx #$28         ; finished when all 40 cols of a line are processed
                 bne loop_title   ; loop if we are not done yet

                 rts

write_main       ldx #$00         ; init X-Register with $00
loop_copyright   lda main_menu_line1,x      ; read characters from line1 table of text...
                 sta $0540,x      ; ...and store in screen ram near the center

                 inx 
                 cpx #$28         ; finished when all 40 cols of a line are processed
                 bne loop_copyright    ; loop if we are not done yet

                 ldx #$00         ; init X-Register with $00
loop_programmer  lda main_menu_line2,x      ; read characters from line1 table of text...
                 sta $0590,x      ; ...and store in screen ram near the center

                 inx 
                 cpx #$28         ; finished when all 40 cols of a line are processed
                 bne loop_programmer    ; loop if we are not done yet

;                  ldx #$1d
;                  ldy #$00
; add_cw_year      lda main_menu_cw_year,y
;                  sta $0540,x
;                  inx
;                  iny
;                  cpx #$28
;                  bne add_cw_year

                 ldx #$00
loop_menu        lda main_menu,x   ; do top 5 lines...
                 sta $0630,x
                 inx
                 cpx #$50
                 bne loop_menu

select_dificulty lda menu_selected_option
                 cmp #$00
                 beq select_easy
                 bne select_hard
                 rts

select_easy      ldx #$0d
                 ; reset hard to space
                 lda #$20
                 sta $0658,x
                 ; select easy with '*' char
                 lda #$2a
                 sta $0630,x
                 ; save currently selected difficulty
                 lda #$00
                 sta menu_selected_option
                 rts 

select_hard      ldx #$0d
                 ; reset easy to space
                 lda #$20
                 sta $0630,x
                 ; select hard with '*' char
                 lda #$2a
                 sta $0658,x
                 ; save currently selected difficulty
                 lda #$01
                 sta menu_selected_option
                 rts
