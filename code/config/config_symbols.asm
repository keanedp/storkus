

address_music = $1000 ; loading address for sid tune
address_sprites = $2000	  ;loading address for sprite - todo
address_game_tile = $2800	  ;loading address for sprite - todo
address_title_chars = $3000 ; load address for title character map
address_standard_chars = $3800 	; loading address for standard character map


; maps
address_level1_map = $4000
address_level1_map_length = 800

sid_init = $1000      ; init routine for music
sid_play = $1021      ; play music routine
pra = $dc00     ; CIA#1 (Port Register A)
prb = $dc01     ; CIA#1 (Port Register B)
ddra = $dc02     ; CIA#1 (Data Direction Register A)
ddrb = $dc03     ; CIA#1 (Data Direction Register B)
screen_ram = $0400

game_bg_color = $05
delay_animation_pointer   = $9e
sprite_frames_character = 10
sprite_pointer_character_right = address_sprites / $40
sprite_pointer_character_left = (address_sprites / $40) + 8
sprite_multicolor_1       = $00
sprite_multicolor_2       = $01
sprite_character_color    = $03

; global memory
menu_selected_option = $0900
current_screen = $0901
main_screen_first_load = $0902
game_screen_first_load = $0903
about_screen_first_load = $0904
score_one_digit = $0905
score_ten_digit = $0906
score_hundred_digit = $0907
score_thousand_digit = $0908
score_ten_thousand_digit = $0909
character_current_frame = $090a
is_character_moving_right = $090b
character_jump_index = $090c

screen_row_tbl_low:  !byte $00 
					 !byte $28 
					 !byte $50 
					 !byte $78 
					 !byte $a0 
					 !byte $c8 
					 !byte $f0 
					 !byte $18 
					 !byte $40 
					 !byte $68 
					 !byte $90 
					 !byte $b8 
					 !byte $e0 
					 !byte $08 
					 !byte $30 
					 !byte $58 
					 !byte $80 
					 !byte $a8 
					 !byte $d0 
					 !byte $f8 
					 !byte $20 
					 !byte $48 
					 !byte $70 
					 !byte $98 
					 !byte $c0 
					 !byte $e8 

screen_row_tbl_high: !byte $04 
					 !byte $04 
					 !byte $04 
					 !byte $04 
					 !byte $04 
					 !byte $04 
					 !byte $04 
					 !byte $05 
					 !byte $05 
					 !byte $05 
					 !byte $05 
					 !byte $05 
					 !byte $05 
					 !byte $06 
					 !byte $06 
					 !byte $06 
					 !byte $06 
					 !byte $06 
					 !byte $06 
					 !byte $06 
					 !byte $07 
					 !byte $07 
					 !byte $07 
					 !byte $07 
					 !byte $07 
					 !byte $07 
