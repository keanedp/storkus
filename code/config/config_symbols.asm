

address_music = $1000 ; loading address for sid tune
address_sprites = $2000	  ;loading address for sprite - todo
address_standard_chars = $3800 	; loading address for standard character map
address_title_chars = $3000 ; load address for title character map

sid_init = $1000      ; init routine for music
sid_play = $1021      ; play music routine
pra = $dc00     ; CIA#1 (Port Register A)
prb = $dc01     ; CIA#1 (Port Register B)
ddra = $dc02     ; CIA#1 (Data Direction Register A)
ddrb = $dc03     ; CIA#1 (Data Direction Register B)
screen_ram = $0400

game_bg_color = $0b
character_current_frame = $fb
delay_animation_pointer   = $9e
sprite_frames_character = $04
sprite_pointer_character = address_sprites / $40
sprite_multicolor_1       = $03
sprite_multicolor_2       = $01
sprite_character_color         = $00

; global memory
menu_selected_option = $0900
current_screen = $0901
main_screen_first_load = $0902
game_screen_first_load = $0903
about_screen_first_load = $0904
scoreOneDigit = $0905
scoreTenDigit = $0906
scoreHundredDigit = $0907
scoreThousandDigit = $0908
scoreTenThousandDigit = $0909

lda #$00
sta menu_selected_option
sta current_screen
sta main_screen_first_load
sta game_screen_first_load
sta about_screen_first_load
sta scoreOneDigit
sta scoreTenDigit
sta scoreHundredDigit
sta scoreThousandDigit
sta scoreTenThousandDigit