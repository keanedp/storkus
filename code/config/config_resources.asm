; load sid music

* = address_music                         ; address to load the music data
!bin "resources/intro.sid",, $7c+2  ; remove header from sid and cut off original loading address 

* = address_sprites                  
!bin "resources/character.spr",1024,3 

* = address_standard_chars                     
!bin "resources/cholo_font.ctm",760,24   ; skip first 24 bytes which is CharPad format information 

*= address_title_chars
!bin "resources/blade_runner_font.ctm",504,24 