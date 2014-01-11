;============================================================
; Storkus, demo app
; Code by Daniel Keane
;
; Created with Dustlayer, see http://dustlayer.com for build info
;
; Thanks to actraiser/Dustlayer, for intitial project template
;
;============================================================

;============================================================
; index file which loads all source code and resource files
;============================================================

;============================================================
;    specify output file
;============================================================

!cpu 6502
!to "build/storkus.prg",cbm    ; output file

;============================================================
; BASIC loader with start address $c000
;============================================================

* = $0801                               ; BASIC start address (#2049)
!byte $0d,$08,$dc,$07,$9e,$20,$34,$39   ; BASIC loader to start at $c000...
!byte $31,$35,$32,$00,$00,$00           ; puts BASIC line 2012 SYS 49152
* = $c000     				            ; start address for 6502 code

;============================================================
;  Main routine with IRQ setup and custom IRQ routine
;============================================================

!source "code/main.asm"

;============================================================
;    setup and init symbols we use in the code
;============================================================

!source "code/config/config_symbols.asm"

;============================================================
; tables and strings of data 
;============================================================

!source "code/data/main_menu/data_text.asm"
!source "code/data/data_colorwash.asm"

;============================================================
; one-time initialization routines
;============================================================

!source "code/subs/sub_clear_screen.asm"
!source "code/subs/main_menu/sub_text.asm"

;============================================================
;    subroutines called during custom IRQ
;============================================================

!source "code/subs/main_menu/sub_charset.asm"
!source "code/subs/main_menu/sub_keyboard.asm"
!source "code/subs/sub_keyboard.asm"
!source "code/subs/main_menu/sub_color.asm"
!source "code/subs/sub_music.asm"
!source "code/subs/game/sub_text.asm"
!source "code/subs/game/sub_score.asm"
!source "code/subs/game/sub_update.asm"

;============================================================
; load resource files (for this small intro its just the sid)
;============================================================

!source "code/config/config_resources.asm"

