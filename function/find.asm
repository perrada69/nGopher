
;HL ... adresa vystupu
;DE ... adresa retezce, ktery
;       hledame zakončený nulou
;Vystup ... HL adresa

FIND
         ld   (DEFAULT+1),de
         ld   (ADR+1),hl
ADR      ld   hl,0
         ld   a,(de)
         cp   (hl)
         jr   z,SOUHLAS

         ld   a,(hl)
         cp   255
         ret  z
DEFAULT  ld   de,0
         inc  hl
         ld   (ADR+1),hl
         jr   ADR
SOUHLAS
         inc  de
         inc  hl
         ld   (ADR+1),hl
         ld   a,(de)
         cp   0
         ret  z

         jr   ADR