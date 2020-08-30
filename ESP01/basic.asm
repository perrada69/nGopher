;zjitovani jesti mame data
;NZ .... data pripravene na
;        cteni
;Z ..... data nejsou pripravene
CHECK    ld   bc,TX
         in   a,(c)
         bit  0,a
         ret


;hl ... adresa prikazu ukončený byty 13,10
;
; Např. cmd1  defb "AT+CIPMUX=0",13,10
;
;
SEND
         ld   bc,TX
SEND0
         in   a,(c)
         bit  1,a
         jr   nz,SEND0

         ld   a,(hl)
         out  (c),a

         inc  hl

         cp   10
         jr   nz,SEND
         ret


; Vstup: DE ... očekávaná odpověď, po které skončí načítání
;
; Např. 
; F_OK
;         defb 10
;         defm "OK"
;         defb 0
READ     ei
         ld   (CMP+1),de
         ld   (CMP2+1),de
         ld   de,0
READ0    call CHECK
POK
         jr   z,READ0
         ld   hl,(R0+1)
         ld   bc,RX

         in   a,(c)

         ld   (hl),a
         inc  hl
         ld   (R0+1),hl
CMP      ld   hl,0
POR      cp   (hl)
         jr   z,DALSI

ERR1T    ld   hl,F_ERROR
         cp   (hl)
         jr   z,DALSI_E

         ld   hl,F_ERROR
         ld   (ERR1T+1),hl

CMP2     ld   hl,0
         ld   (CMP+1),hl
         jr   READ0

DALSI_E  inc  hl
         ld   (ERR1T+1),hl
         ld   a,(hl)
         or   a

         jr   nz,CMP2

         ld   hl,F_ERROR
         ld   (ERR1T+1),hl

         ld   a,2
         out  (254),a
         cpl
         ret


;smazani bufferu WiFi modulu
CLEAR
         ld   hl,16384
         ld   bc,RX
CLEAN    in   a,(c)
         dec  hl
         ld   a,l
         or   h
         jr   nz,CLEAN
         ret
;Odeslání příkazu
;
; Vstup: HL ... definice příkazu
;        DE ... očekáváná odpověď (např. F_OK)
;
;
EXECUTE  ld   (COMMAND+1),de
         call SEND

COMMAND  ld   de,0
         call READOK

         ld   hl,OUTPUT
         ld   de,F_ERROR
         call FIND
         ld   a,(hl)
         cp   255
         jp   nz,ERROR

         ret

F_BR     defm "<br>"
         defb 0
F_OK
         defb 10
         defm "OK"
         defb 0

F_ERROR  defm "ERROR", 0
          