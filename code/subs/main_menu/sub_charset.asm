set_title_char_set	 lda #$1c      ; set chars location to $3800 for displaying the custom font
		             sta $d018      ; Bits 1-3 ($400+512bytes * low nibble value) of $d018 sets char location
		                          ; $400 + $200*$0E = $3800
		             lda $d016      ; turn off multicolor for characters
		             and #$ef       ; by cleaing Bit#4 of $D016
		             sta $d016

		             rts

set_default_char_set lda #$1f      ; set chars location to $3800 for displaying the custom font
			         sta $d018      ; Bits 1-3 ($400+512bytes * low nibble value) of $d018 sets char location
			                          ; $400 + $200*$0E = $3800
			         lda $d016      ; turn off multicolor for characters
			         and #$ef       ; by cleaing Bit#4 of $D016
			         sta $d016

			         rts

set_level1_bg_char_set		 
					 lda #$1b      ; set chars location to $3800 for displaying the custom font
			         sta $d018      ; Bits 1-3 ($400+512bytes * low nibble value) of $d018 sets char location

			         lda #$1b
			         sta $d011

			         lda #$18      ; turn on multicolor for characters 
			         sta $d016

			         lda #$0a
			         sta $d022

			         lda #$08
 					 sta $d023

			         rts