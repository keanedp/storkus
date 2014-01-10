inc_score_ones_digit      lda scoreOneDigit              ; load the lowest digit of the number
                          clc 
                          adc #$01                        ; add one
                          sta scoreOneDigit
                          cmp #$0A                        ; check if it overflowed, now equals 10
                          bne inc_done                    ; if there was no overflow, all done

inc_score_tens_digit      lda #$00
                          sta scoreOneDigit              ; wrap digit to 0
                          lda scoreTenDigit              ; load the next digit
                          clc 
                          adc #$01                        ; add one, the carry from previous digit
                          sta scoreTenDigit
                          cmp #$0A                        ; check if it overflowed, now equals 10
                          bne inc_done                    ; if there was no overflow, all done

inc_score_hundreds_digit  lda #$00
                          sta scoreTenDigit              ; wrap digit to 0
                          lda scoreHundredDigit           ; load the next digit
                          clc 
                          adc #$01                        ; add one, the carry from previous digit
                          sta scoreHundredDigit
                          cmp #$0A
                          bne inc_done

inc_score_thounsands_digit  
                          lda #$00
                          sta scoreHundredDigit              ; wrap digit to 0
                          lda scoreThousandDigit           ; load the next digit
                          clc 
                          adc #$01                        ; add one, the carry from previous digit
                          sta scoreThousandDigit
                          cmp #$0A
                          bne inc_done

inc_score_ten_thousand_digit  
                          lda #$00
                          sta scoreThousandDigit              ; wrap digit to 0
                          lda scoreTenThousandDigit           ; load the next digit
                          clc 
                          adc #$01                        ; add one, the carry from previous digit
                          sta scoreTenThousandDigit

inc_done                  rts
