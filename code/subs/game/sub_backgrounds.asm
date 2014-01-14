draw_level1_bg	lda #<address_tiles 	; setup zero page for tiles
				sta $fc
				lda #>address_tiles 
				sta $fd

				lda #<address_level1_map
				sta $fe
				lda #>address_level1_map
				sta $ff
				
				; start at $04a0 on the screen and do the next 20 lines
				lda #$05
				ldx #$00
level1_bg_loop	sta $04a0,x
				sta $0568,x
				sta $0630,x
				sta $06f8,x
				inx
				cpx #$f0
				bne level1_bg_loop

				rts
