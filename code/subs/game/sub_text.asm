write_score		ldx #$00
loop_score 		lda score,x
				sta $0442,x
				inx
				cpx #$07
				bne loop_score

				ldx #$30

				lda scoreTenThousandDigit
				clc 
                adc #$30 
			    sta $0449

				lda scoreThousandDigit
				clc 
                adc #$30 
			    sta $044a

				lda scoreHundredDigit
				clc 
                adc #$30 
			    sta $044b

			    lda scoreTenDigit
				clc 
                adc #$30 
			    sta $044c

			    lda scoreOneDigit
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
