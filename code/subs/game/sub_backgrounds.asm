draw_level1_bg	
				
				; start at $04a0 on the screen and do the next 20 lines
				; lda #$05
				ldx #$00
level1_bg_loop	
				; need to load the map, then loop over each tile while getting the character
				lda $a000,x	; first 210
				sta $04a0,x

				lda $a0d2,x	; second 210
				sta $0572,x
				
				lda $a1a4,x
				sta $0644,x ; third 210
				
				lda $a276,x
				sta $0716,x ; third 210
				
				inx
				cpx #$d2
				bne level1_bg_loop

				rts
