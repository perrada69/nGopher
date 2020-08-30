;Vstup: HL ... cislo
;Vystup v DECBUF máme napsané číslo z HL
HLTODEC  ld   de,DECBUF
         ld   (DIGIT31+1),de
         ld   de,10
         call DIGIT
DECIMAL1 ld   de,1

DIGIT    ld   a,"0"-1
DIGIT2   inc  a
         or   a
         sbc  hl,de
         jr   nc,DIGIT2
         add  hl,de
         cp   "9"+1
         jr   c,DIGIT3
DIGIT3   push hl
DIGIT31  ld   hl,DECBUF
         ld   (hl),a
         inc  hl
         ld   (DIGIT31+1),hl
         pop  hl
         
         
DECBUF   defs 5         