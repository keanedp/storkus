clear_screen    ldx #$00     ; set X to zero (black color code)
		        stx $d021    ; set background color
		        ldx #$04
		        stx $d020    ; set border color
		        
		        ;jsr $e544	; kernal sub is way too slow, throws everything off in interrupt

		        ldx #$00
clear:	lda #$20
				sta $0400,x
		        sta $0500,x
		        sta $0600,x
		        sta $0700,x
		        lda #$08     ; set foreground to black in Color Ram 
			    sta $d800,x  
			    sta $d900,x
			    sta $da00,x
			    sta $dae8,x
		        inx
		        bne clear

		        rts
