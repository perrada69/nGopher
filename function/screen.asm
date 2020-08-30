;vstup:
; HL .... XY
; DE .... TEXT zakonceny 0 bytem
; A ..... atribut palety
print  ld (paleta + 1),a
		push de
		ld d,l
		ld e,160
		mul d,e
		ld a,h
		add a,a
		ld l,a
		ld h,0
		add hl,de
		ld de,$4000
		add hl,de
		pop de
print0
		ld a,(de)
		or a
		ret z
		ld (hl),a
		
paleta	ld a,0		
		inc hl
		inc de
		ld (hl),a
		inc hl
		jr print0




zobraz_nadpis
		ld hl,ngopher_nadpis
		ld de,#4000
		ld bc,80
nadpis111		
		ld a,(hl)
		ld (de),a
		inc de
		ld a,16
		ld (de),a
		inc de
		inc hl
		dec bc
		ld a,c
		or b
		jr nz,nadpis111
		ret

window
		ld (atr1+1),a
		ld (atr2+1),a
		ld (atr3+1),a
		ld (atr4+1),a
		ld (atr5+1),a
		ld (atr6+1),a
		ld (atr7+1),a
		ld (atr8+1),a
		ld (atr9+1),a

		ld e,l
		ld d,160
		mul d,e
		ld a,h
		add a,a
		ld l,a
		ld h,0
		add hl,de
		ld de,#4000
		add hl,de		;adresa v tilemode
window0	push hl		
		
		ld a,18
		ld (hl),a
		inc hl
atr1	ld (hl),0
		ld a,b
		ld (w5+1),a
		ld a,16
		inc hl
		
		
w2		ld (hl),a
		inc hl
atr2	ld (hl),0
		inc hl
		djnz w2
		ld a,19
		ld (hl),a
		inc hl

atr3	ld (hl),0
		ld de,160-1
		add hl,de
		
		ld (w3+1),hl	;uloz adresu
		pop hl
		ld de,160
		add hl,de
		ld (w4+1),hl

w3		ld hl,0	
		ld a,23
		ld (hl),a
		inc hl
atr4	ld (hl),0
		
		ld de,160-1
		add hl,de
		ld (w3+1),hl
w4		ld hl,0					;leva cast
		ld a,22
		ld (hl),a
		inc hl
atr5	ld (hl),0
		push hl
		inc hl
		ld a,(w5+1)
		ld b,a
cisti	ld 	(hl),0
		inc hl
atr6	ld (hl),0
		inc hl
		djnz cisti
		
		pop hl
		ld de,160-1
		add hl,de
		ld (w4+1),hl
		dec c
		ld a,c
		or a
		jr nz,w3
		
		ld a,21
		ld (hl),a
		inc hl
atr7	ld (hl),0
w5 		ld b,0		
		ld a,17
w6		inc hl
		ld (hl),a
		inc hl
atr8	ld (hl),0
		djnz w6
		inc hl
		ld a,20
		ld (hl),a
		inc hl
atr9	ld (hl),0
		ret
