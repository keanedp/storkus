draw_level1_bg	lda #$00
				sta $fb
				lda #$40
				sta $fc

				lda #$d2
				sta $fd
				lda #$40
				sta $fe
				
				; start at $04a0 on the screen and do the next 20 lines
				; lda #$05
				ldy #$00
				; lda #$01
level1_bg_loop_top	
				; need to load the map, then loop over each tile while getting the character
				lda ($fb),y	; first 210
				sta $0478,y

				lda ($fd),y	; second 210
				sta $054a,y
				
				lda $41a4,y
				sta $061c,y ; third 210
				
				lda $4276,y
				sta $06ee,y ; third 210
				
				iny
				cpy #$fa
				bne level1_bg_loop_top

 
; 	ldx #0 
; loop1 
; 	lda $4000,x
; 	sta $0478,x 
; 	inx 
; 	bne loop1 
; loop2 
; 	lda $40ff
; 	sta $0577,x 
; 	inx 
; 	bne loop2 
	; loop3 
	; sta $600,x 
	; inx 
	; bne loop3 
	; loop4 
	; sta $700,x 
	; inx 
	; bne loop4

				rts
