

address_music = $1000 ; loading address for sid tune
;address_sprites = $2000	  ;loading address for sprite - todo
address_standard_chars = $3800 	; loading address for standard character map
address_title_chars = $3000 ; load address for title character map

sid_init = $1000      ; init routine for music
sid_play = $1021      ; play music routine
pra = $dc00     ; CIA#1 (Port Register A)
prb = $dc01     ; CIA#1 (Port Register B)
ddra = $dc02     ; CIA#1 (Data Direction Register A)
ddrb = $dc03     ; CIA#1 (Data Direction Register B)


; global memory
selected_difficulty = $0900
current_screen = $0901

lda #$00
sta selected_difficulty
sta current_screen