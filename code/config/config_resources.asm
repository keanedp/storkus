; load sid music

* = address_music                         ; address to load the music data
!bin "resources/intro.sid",, $7c+2  ; remove header from sid and cut off original loading address 

* = address_standard_chars                     
!bin "resources/cholo_font.ctm",384,24   ; skip first 24 bytes which is CharPad format information 

*= address_title_chars
!bin "resources/rambo_font.ctm",384,24 