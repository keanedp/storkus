write_score		ldx #$00
loop_score 		lda score,x
				sta $0442,x
				inx
				cpx #$07
				bne loop_score

				ldx #$30

				lda score_ten_thousand_digit
				clc 
                adc #$30 
			    sta $0449

				lda score_thousand_digit
				clc 
                adc #$30 
			    sta $044a

				lda score_hundred_digit
				clc 
                adc #$30 
			    sta $044b

			    lda score_ten_digit
				clc 
                adc #$30 
			    sta $044c

			    lda score_ten_digit
				clc 
                adc #$30 
			    sta $044d

			    ldx #$00
color_score
			    lda #$01 ; #$0e
			    sta $d842,x
			    inx
			    cpx #$0c
			    bne color_score

			    rts
