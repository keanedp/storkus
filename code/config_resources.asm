; load sid music

* = address_music                         ; address to load the music data
!bin "resources/jeff_donald.sid",, $7c+2  ; remove header from sid and cut off original loading address 

* = address_chars                     
!bin "resources/blade_runner_font.ctm",384,24   ; skip first 24 bytes which is CharPad format information 