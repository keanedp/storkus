inc_score_ones_digit      lda score_one_digit              ; load the lowest digit of the number
                          clc 
                          adc #$01                        ; add one
                          sta score_one_digit
                          cmp #$0A                        ; check if it overflowed, now equals 10
                          bne inc_done                    ; if there was no overflow, all done

inc_score_tens_digit      lda #$00
                          sta score_one_digit              ; wrap digit to 0
                          lda score_ten_digit              ; load the next digit
                          clc 
                          adc #$01                        ; add one, the carry from previous digit
                          sta score_ten_digit
                          cmp #$0A                        ; check if it overflowed, now equals 10
                          bne inc_done                    ; if there was no overflow, all done

inc_score_hundreds_digit  lda #$00
                          sta score_ten_digit              ; wrap digit to 0
                          lda score_hundred_digit           ; load the next digit
                          clc 
                          adc #$01                        ; add one, the carry from previous digit
                          sta score_hundred_digit
                          cmp #$0A
                          bne inc_done

inc_score_thounsands_digit  
                          lda #$00
                          sta score_hundred_digit              ; wrap digit to 0
                          lda score_thousand_digit           ; load the next digit
                          clc 
                          adc #$01                        ; add one, the carry from previous digit
                          sta score_thousand_digit
                          cmp #$0A
                          bne inc_done

inc_score_ten_thousand_digit  
                          lda #$00
                          sta score_thousand_digit              ; wrap digit to 0
                          lda score_ten_thousand_digit           ; load the next digit
                          clc 
                          adc #$01                        ; add one, the carry from previous digit
                          sta score_ten_thousand_digit

inc_done                  rts
