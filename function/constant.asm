            DEFINE DISP_ADDRESS     $2000
            DEFINE SP_ADDRESS       $3D00
            OPT --zxnext=cspect
            
			DEFINE ORG_ADDRESS      $7000 + 128
            DEFINE TEST_CODE_PAGE   223         ; using the last page of 2MiB RAM (in emulator)
            DEFINE TILE_MAP_ADR     $4000           ; 80*32 = 2560 (10*256)
            DEFINE TILE_GFX_ADR     $6000;$5400           ; 128*32 = 4096
	
			DEFINE CFG_FILENAME     dspedge.defaultCfgFileName
    		STRUCT S_MARGINS        ; pixels of margin 0..31 (-1 = undefined margin)
L           BYTE    -1      ; left
R           BYTE    -1      ; right  
T           BYTE    -1      ; top
B           BYTE    -1      ; bottom
			ENDS
			STRUCT S_UI_DEFINITIONS
labelDot    WORD    0       ; address where to write display dot
cellAdr     WORD    0       ; address of big table cell on screen at [1,0] char inside
nextMode    BYTE    0
keyword     WORD    0       ; address of keyword used in the CFG file
			ENDS
			STRUCT S_MODE_EDGES
        ; current margins values (must be first four bytes of the structure)
cur         S_MARGINS
        ; original values (from file)
orig        S_MARGINS
        ; UI related config
ui          S_UI_DEFINITIONS
        ; internal flags and intermediate values
modified    BYTE    0       ; if this mode was modified in some way
leftT       BYTE    0       ; full tiles left
rightT      BYTE    0       ; full tiles right
midT        BYTE    0       ; amount of semi top/bottom tiles (w/o left/right corner tiles)
        ; bit masks to redraw gfx tile with Green/Background color (columns/rows in bits)
        ; preserve the order of offsets, they are processed in "++DE" way
maskLeftG   BYTE    0
maskLeftB   BYTE    0
maskRightG  BYTE    0
maskRightB  BYTE    0
maskTopG    BYTE    0
maskTopB    BYTE    0
maskBottomG BYTE    0
maskBottomB BYTE    0
    ENDS
    STRUCT S_STATE
timingIsUnlocked    BYTE    0
edge                BYTE    0   ; 0 left, 1 top, 2 right, 3 bottom (to align with chars)
lastCtrlKey         BYTE    0   ; save/reload/quit/hz/timing when waiting for confirm
debounceKey         BYTE    0
modified            BYTE    0   ; set if any of modes (even inactive) is modified
noFileFound         BYTE    0
esxErrorNo          BYTE    1
argsPtr             WORD    0
    ENDS
    STRUCT S_PRESERVE
        ; WORDs used, first byte is register number, second byte is preserved value
turbo_07            WORD    TURBO_CONTROL_NR_07
spr_ctrl_15         WORD    SPRITE_CONTROL_NR_15
transp_fallback_4A  WORD    TRANSPARENCY_FALLBACK_COL_NR_4A
tile_transp_4C      WORD    TILEMAP_TRANSPARENCY_I_NR_4C
ula_ctrl_68         WORD    ULA_CONTROL_NR_68
display_ctrl_69     WORD    DISPLAY_CONTROL_NR_69
tile_ctrl_6B        WORD    TILEMAP_CONTROL_NR_6B
tile_def_attr_6C    WORD    TILEMAP_DEFAULT_ATTR_NR_6C
tile_map_adr_6E     WORD    TILEMAP_BASE_ADR_NR_6E
tile_gfx_adr_6F     WORD    TILEMAP_GFX_ADR_NR_6F
tile_xofs_msb_2F    WORD    TILEMAP_XOFFSET_MSB_NR_2F
tile_xofs_lsb_30    WORD    TILEMAP_XOFFSET_LSB_NR_30
tile_yofs_31        WORD    TILEMAP_YOFFSET_NR_31
pal_ctrl_43         WORD    PALETTE_CONTROL_NR_43
pal_idx_40          WORD    PALETTE_INDEX_NR_40
mmu2_52             WORD    MMU2_4000_NR_52
mmu3_53             WORD    MMU3_6000_NR_53
    ; not preserving tilemode clip window coordinates, and tilemode palette
    ; (intentionally, not expecting anyone to need it, or not being able to fix it)
    ; (and subtle sub-states like half-written 9bit color to $44 -> will be lost too)
    ENDS
KEY_DEBOUNCE_WAIT   EQU     8
CHAR_DOT_RED        EQU     25
CHAR_DOT_YELLOW     EQU     26
CHAR_DOT_GREEN      EQU     27
CHAR_ARROW_L        EQU     28
CHAR_ARROW_T        EQU     29
CHAR_ARROW_R        EQU     30
CHAR_ARROW_B        EQU     31
;; some further constants, mostly machine/API related