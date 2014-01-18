; had so many issues with performance on clearning the screen. 
;This code comes from http://www.lemon64.com/forum/viewtopic.php?t=44295&sid=6d34842f7743c7cba164fd4f08b18f4c


clear_screen    lda #$00 ; load accumulator with $00 
		        sta $fa  ; store acc in zero page location $fa (LSB) 
		        ldx #$04 ; load x register with $04 
		        stx $fb  ; store x in zero page location $fb (MSB) 
		        lda #$20 ; reset acc to $00 
		        ldy #$00 ; reset y to $00 
clrloop: 
		        sta ($fa),y ; Start of loop 1 to increment / points to LSB 
		        iny         ; increment LSB 
		        bne clrloop ; if y != 0 goto clrloop 
		                    ; loop 2 for MSB 
		        inx         ; increment x (MSB) 
		        stx $fb     ; store x (MSB) in zero page location $fb 
		        cpx #$08    ; if x != 8 
		        bne clrloop ; goto clrloop 

clear_sprites	lda #$00	
				sta $d015	; just do first one for now
		        
		        rts

; 		        ;jsr $e544	; kernal sub is way too slow, throws everything off in interrupt

color_screen 	ldy #$00
color_screen_loop: 
				sta $d800,y
			    sta $d900,y
			    sta $da00,y
			    sta $db00,y
			    dey
			    bne color_screen_loop
    			
    			rts