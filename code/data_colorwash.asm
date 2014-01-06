; color data table
; first 9 rows (40 bytes) are used for the color washer
; on start the gradient is done by byte 40 is mirroed in byte 1, byte 39 in byte 2 etc... 

color        !byte $07,$07,$07,$07,$03 
             !byte $03,$03,$03,$04,$04 
             !byte $04,$04,$06,$06,$06 
             !byte $06,$0e,$0e,$0e,$0e 
             !byte $06,$06,$06,$06,$04 
             !byte $04,$04,$04,$03,$03 
             !byte $03,$03,$04,$04,$04 
             !byte $04,$07,$07,$07,$07 

color2        !byte $07,$07,$07,$07,$03 
             !byte $03,$03,$03,$04,$04 
             !byte $04,$04,$06,$06,$06 
             !byte $06,$0e,$0e,$0e,$0e 
             !byte $06,$06,$06,$06,$04 
             !byte $04,$04,$04,$03,$03 
             !byte $03,$03,$04,$04,$04 
             !byte $04,$07,$07,$07,$07 
