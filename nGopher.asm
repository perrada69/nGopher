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

ReadNextReg:
    ; reads nextreg in A into A (does modify currently selected NextReg on I/O port)
			push    bc
			ld      bc,#243B
			out     (c),a
			inc     b       ; bc = TBBLUE_REGISTER_ACCESS_P_253B
			in      a,(c)   ; read desired NextReg state
			pop     bc
			ret
            

            org 28000
start       

            ret