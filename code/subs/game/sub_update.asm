update_game

			; init memory
			; lda #sprite_frames_character
			; sta character_current_frame
			 
			; lda #sprite_pointer_character
			; sta screen_ram + $3f8 		
 
			; ; setup character sprite
			; lda #$01   ; enable Sprite#0
			; sta $d015 
			; lda #$01   ; set Multicolor mode for Sprite#0
			; sta $d01c
			; lda #$00   ; Sprite#0 has priority over background
			; sta $d01b
			 
			; lda #sprite_background_color 
			; sta $d021
			; lda #sprite_multicolor_1
			; sta $d025
			; lda #sprite_multicolor_2 
			; sta $d026
			; lda #sprite_charcter_color
			; sta $d027
			 
			; lda #$01    ; set X-Coord high bit (9th Bit)
			; sta $d010
			 
			; lda #$a0    ; set Sprite#0 positions with X/Y coords to
			; sta $d000   ; bottom border of screen on the outer right
			; lda #$a0   ; $d000 corresponds to X-Coord
			; sta $d001   ; $d001 corresponds to Y-Coord

			rts