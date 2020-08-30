	        DEVICE ZXSPECTRUMNEXT
            OPT reset --zxnext --syntax=abfw              
            slot 4

CHARS         equ  15616-256              
mystak        equ  24575         ;ar bi trary value picked to be be low
                                ;BFE0h and above 4000h
staksto       equ  24575         ;some where to put BA SIC's stack
                                ;pointer

                                ;last value out put to 7FFDh
port1         equ  #7FFD         ;ad dress of ROM/RAM switch ing port
                                ;in I/O map
catbuff       equ  #A000         ;some where for DOS to put its catalog
dos_catalog   equ  #011E         ;the DOS routine to call
            include "function/constant.asm"
ReadNextReg:
    ; reads nextreg in A into A (does modify currently selected NextReg on I/O port)
			push    bc
			ld      bc,#243B
			out     (c),a
			inc     b       ; bc = TBBLUE_REGISTER_ACCESS_P_253B
			in      a,(c)   ; read desired NextReg state
			pop     bc
			ret
            

            org $7000 + 128
START       call tilemap_init           ;nastav tilemap - textový mód, fonty...

            call zobraz_nadpis

		    ld hl, 5 *256 + 5
            ld bc,65 * 256 + 4
		    ld a,16
		    call window
            
            
            ld hl,8*256+6
            ld a,16
            ld de,nazev
            call print
                
            
            
            ld hl,8*256+8
            ld a,16
            ld de,popis1
            call print
                
            ld hl,58*256+9
            ld a,32
            ld de,cancel
            call print
                
            
            
            di : halt


            include "function/tilemap.asm"
            include "function/texts.asm"
            include "function/find.asm"
            include "function/hl2dec.asm"

            include "function/screen.asm"

;export do NEX
              CSPECTMAP player.map
              savenex open "nGopher.nex",START,START-1
              savenex core 2,0,0
              savenex auto
              savenex close


