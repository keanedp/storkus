;============================================================
; write the two line of text to screen center
;============================================================

write_title
setup_title_char ;lda #$1c      ; set chars location to $3800 for displaying the custom font
                 ; sta $d018      ; Bits 1-3 ($400+512bytes * low nibble value) of $d018 sets char location
                 ;                ; $400 + $200*$0E = $3800
                 ; lda $d016      ; turn off multicolor for characters
                 ; and #$ef       ; by cleaing Bit#4 of $D016
                 ; sta $d016

                 ldx #$00         ; init X-Register with $00
loop_title       lda main_menu_title,x      ; read characters from line1 table of text...
                 sta $0450,x      ; ...and put 2 rows below line1

                 inx 
                 cpx #$28         ; finished when all 40 cols of a line are processed
                 bne loop_title   ; loop if we are not done yet

                 rts

write_main_menu
; setup_std_chars  lda #$1f      ; set chars location to $3800 for displaying the custom font
;                  sta $d018      ; Bits 1-3 ($400+512bytes * low nibble value) of $d018 sets char location
;                                 ; $400 + $200*$0E = $3800
;                  lda $d016      ; turn off multicolor for characters
;                  and #$ef       ; by cleaing Bit#4 of $D016
;                  sta $d016

  		           ldx #$00         ; init X-Register with $00
loop_text        lda main_menu_line1,x      ; read characters from line1 table of text...
                 sta $0540,x      ; ...and store in screen ram near the center
                 ; lda main_menu_title,x      ; read characters from line1 table of text...
                 ; sta $0540,x      ; ...and put 2 rows below line1

                 inx 
                 cpx #$28         ; finished when all 40 cols of a line are processed
                 bne loop_text    ; loop if we are not done yet

; this doesn't work, how the hell do you load multiple character maps!!!
; setup_title_menu lda #$1c
;                  ;;ora #$0f       ; set chars location to $3800 for displaying the custom font
;                  sta $d018      ; Bits 1-3 ($400+512bytes * low nibble value) of $d018 sets char location
;                                 ; $400 + $200*$0E = $3800
;                  lda $d016      ; turn off multicolor for characters
;                  and #$ef       ; by cleaing Bit#4 of $D016
;                  sta $d016

                 ldx #$00
loop_menu    lda main_menu,x   ; do top 5 lines...
                 sta $0630,x
                 inx
                 cpx #$50
                 bne loop_menu

select_dificulty lda selected_difficulty
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
                 sta selected_difficulty
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
                 sta selected_difficulty
                 rts
