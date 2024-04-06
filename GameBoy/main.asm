;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.3.2 #14228 (MINGW64)
;--------------------------------------------------------
	.module main
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _power
	.globl __draw
	.globl __spawn
	.globl __smoothMove
	.globl __control
	.globl __bonusDraw
	.globl __stoneDraw
	.globl __brickDraw
	.globl __playerDraw
	.globl __movement
	.globl __fieldInit
	.globl _rand
	.globl _initrand
	.globl _set_sprite_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _waitpadup
	.globl _joypad
	.globl __bonus
	.globl __player
	.globl __countWater
	.globl __countCoin
	.globl __countStone
	.globl __countBrick
	.globl _Water
	.globl _Coin
	.globl _HUD
	.globl _BG
	.globl _Stone
	.globl _Brick
	.globl _Player
	.globl _field
	.globl _DrawUI
	.globl _DrawWater
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_field::
	.ds 80
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_Player::
	.ds 64
_Brick::
	.ds 192
_Stone::
	.ds 64
_BG::
	.ds 360
_HUD::
	.ds 496
_Coin::
	.ds 128
_Water::
	.ds 32
__countBrick::
	.ds 1
__countStone::
	.ds 1
__countCoin::
	.ds 1
__countWater::
	.ds 1
__player::
	.ds 9
__bonus::
	.ds 2
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;main.c:53: void _fieldInit(void) {
;	---------------------------------
; Function _fieldInit
; ---------------------------------
__fieldInit::
	add	sp, #-3
;main.c:55: for (INT8 i = 0; i < fieldX; i++) {
	ldhl	sp,	#2
	ld	(hl), #0x00
00108$:
	ldhl	sp,	#2
	ld	a, (hl)
	xor	a, #0x80
	sub	a, #0x88
	jr	NC, 00102$
;main.c:56: for (INT8 j = 0; j < fieldY; j++) {
	ld	c, (hl)
	ld	a, c
	rlca
	sbc	a, a
	ld	b, a
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	bc,#_field
	add	hl,bc
	inc	sp
	inc	sp
	push	hl
	ld	c, #0x00
00105$:
	ld	a, c
	xor	a, #0x80
	sub	a, #0x84
	jr	NC, 00109$
;main.c:57: field[i][j] = 0;
	ld	a, c
	add	a, a
	ld	e, a
	ld	d, #0x00
	pop	hl
	push	hl
	add	hl, de
	ld	e, l
	ld	d, h
	xor	a, a
	ld	(de), a
	inc	de
	ld	(de), a
;main.c:56: for (INT8 j = 0; j < fieldY; j++) {
	inc	c
	jr	00105$
00109$:
;main.c:55: for (INT8 i = 0; i < fieldX; i++) {
	ldhl	sp,	#2
	inc	(hl)
	jr	00108$
00102$:
;main.c:61: for (INT8 i = 0; i < fieldX; i++) { field[i][4] = -1; }
	ld	c, #0x00
00111$:
	ld	a, c
	xor	a, #0x80
	sub	a, #0x88
	jr	NC, 00113$
	ld	a, c
	rlca
	sbc	a, a
	ld	b, a
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	de, #_field
	add	hl, de
	ld	de, #0x0008
	add	hl, de
	ld	a, #0xff
	ld	(hl+), a
	ld	(hl), #0xff
	inc	c
	jr	00111$
00113$:
;main.c:63: }
	add	sp, #3
	ret
;main.c:68: void _movement(UINT8 _dir) {
;	---------------------------------
; Function _movement
; ---------------------------------
__movement::
	add	sp, #-6
;main.c:70: switch (_dir) {
	ld	c, a
	dec	a
	jr	Z, 00101$
	ld	a,c
	cp	a,#0x02
	jp	Z,00114$
	cp	a,#0x03
	jp	Z,00127$
	sub	a, #0x04
	jp	Z,00140$
	jp	00154$
;main.c:72: case 1:
00101$:
;main.c:73: if (field[_player.x + 1][_player.y] == 0 && _player.x + 1 < fieldX) { _player.x += 1; return _movement(_dir); }
	ld	a, (#__player + 0)
	inc	a
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	ld	a, l
	add	a, #<(_field)
	ld	e, a
	ld	a, h
	adc	a, #>(_field)
	ld	d, a
	ld	a, (#__player + 1)
	add	a, a
	ld	b, a
	ld	l, b
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#2
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	a, (#__player + 0)
	ldhl	sp,#4
	ld	(hl+), a
	inc	a
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	or	a, (hl)
	jr	NZ, 00103$
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, d
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	ld	a, l
	sub	a, #0x08
	ld	a, h
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC, 00103$
	ld	de, #__player
	ldhl	sp,	#5
	ld	a, (hl)
	ld	(de), a
	ld	a, c
	call	__movement
	jp	00154$
00103$:
;main.c:74: if (field[_player.x + 1][_player.y] == 2 || field[_player.x + 1][_player.y] == 3) { field[_player.x + 1][_player.y] += 1; break; }
	ldhl	sp,	#5
	ld	e, (hl)
	ld	a, e
	rlca
	sbc	a, a
	ld	d, a
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	ld	de, #_field
	add	hl, de
	ld	a, l
	add	a, b
	ld	c, a
	ld	a, h
	adc	a, #0x00
	ld	b, a
	ld	l, c
	ld	h, b
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	sub	a, #0x02
	or	a, h
	jr	Z, 00105$
	ld	a, l
	sub	a, #0x03
	or	a, h
	jr	NZ, 00106$
00105$:
	inc	hl
	ld	e, l
	ld	d, h
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
	jp	00154$
00106$:
;main.c:75: if (field[_player.x + 1][_player.y] == 4) { field[_player.x + 1][_player.y] = 0; _countBrick += 1; _player.exp += 10;DrawUI(); break; }
	ld	a, l
	sub	a, #0x04
	or	a,h
	jr	NZ, 00109$
	ld	(bc), a
	inc	bc
	ld	(bc), a
	ld	hl, #__countBrick
	inc	(hl)
	ld	a, (hl)
	ld	hl, #(__player + 5)
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #0x000a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #(__player + 5)
	ld	(hl), c
	inc	hl
	ld	(hl), b
	call	_DrawUI
	jp	00154$
00109$:
;main.c:76: if (field[_player.x + 1][_player.y] == 5) { field[_player.x + 1][_player.y] = 0; _countCoin += 1; _player.exp += 30;DrawUI(); break; }
	ld	a, l
	sub	a, #0x05
	or	a,h
	jr	NZ, 00111$
	ld	(bc), a
	inc	bc
	ld	(bc), a
	ld	hl, #__countCoin
	inc	(hl)
	ld	a, (hl)
	ld	hl, #(__player + 5)
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #0x001e
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #(__player + 5)
	ld	(hl), c
	inc	hl
	ld	(hl), b
	call	_DrawUI
	jp	00154$
00111$:
;main.c:77: if (field[_player.x + 1][_player.y] == 6) { field[_player.x + 1][_player.y] = 0; _countWater += 1; _player.water += 100; DrawWater((_player.water / 100) + 3, 1); break; }
	ld	a, l
	sub	a, #0x06
	or	a,h
	jp	NZ,00154$
	ld	(bc), a
	inc	bc
	ld	(bc), a
	ld	hl, #__countWater
	inc	(hl)
	ld	bc, #__player + 7
	ld	l, c
	ld	h, b
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
	add	a, #0x64
	ld	e, a
	ld	a, h
	adc	a, #0x00
	ld	d, a
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
	ld	bc, #0x0064
	call	__divsint
	inc	c
	inc	c
	inc	c
	ld	e, #0x01
	ld	a, c
	call	_DrawWater
	jp	00154$
;main.c:79: case 2:
00114$:
;main.c:80: if (field[_player.x][_player.y + 1] == 0 && _player.y + 1 < fieldY) { _player.y += 1; return _movement(_dir); }
	ld	a, (#__player + 0)
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_field
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ld	hl, #(__player + 1)
	ld	b, (hl)
	ld	a, b
	inc	a
	ldhl	sp,	#2
	ld	(hl+), a
	add	a, a
	ld	(hl), a
	pop	de
	push	de
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	inc	de
	ld	a, (de)
	or	a, l
	jr	NZ, 00116$
	ld	a, b
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	rlca
	sbc	a, a
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	ld	a, l
	sub	a, #0x04
	ld	a, h
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC, 00116$
	ld	de, #(__player + 1)
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(de), a
	ld	a, c
	call	__movement
	jp	00154$
00116$:
;main.c:81: if (field[_player.x][_player.y + 1] == 2 || field[_player.x][_player.y + 1] == 3) { field[_player.x][_player.y + 1] += 1; break; }
	ld	a, (#__player + 0)
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	bc,#_field
	add	hl,bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#3
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	c,l
	ld	b,h
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	sub	a, #0x02
	or	a, h
	jr	Z, 00118$
	ld	a, l
	sub	a, #0x03
	or	a, h
	jr	NZ, 00119$
00118$:
	inc	hl
	ld	e, l
	ld	d, h
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
	jp	00154$
00119$:
;main.c:82: if (field[_player.x][_player.y + 1] == 4) { field[_player.x][_player.y + 1] = 0; _countBrick += 1; _player.exp += 10; DrawUI(); break; }
	ld	a, l
	sub	a, #0x04
	or	a,h
	jr	NZ, 00122$
	ld	(bc), a
	inc	bc
	ld	(bc), a
	ld	hl, #__countBrick
	inc	(hl)
	ld	a, (hl)
	ld	hl, #(__player + 5)
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #0x000a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #(__player + 5)
	ld	(hl), c
	inc	hl
	ld	(hl), b
	call	_DrawUI
	jp	00154$
00122$:
;main.c:83: if (field[_player.x][_player.y + 1] == 5) { field[_player.x][_player.y + 1] = 0; _countCoin += 1; _player.exp += 30; DrawUI(); break; }
	ld	a, l
	sub	a, #0x05
	or	a,h
	jr	NZ, 00124$
	ld	(bc), a
	inc	bc
	ld	(bc), a
	ld	hl, #__countCoin
	inc	(hl)
	ld	a, (hl)
	ld	hl, #(__player + 5)
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #0x001e
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #(__player + 5)
	ld	(hl), c
	inc	hl
	ld	(hl), b
	call	_DrawUI
	jp	00154$
00124$:
;main.c:84: if (field[_player.x][_player.y + 1] == 6) { field[_player.x][_player.y + 1] = 0; _countWater += 1; _player.water += 100; DrawWater((_player.water / 100) + 3, 1); break; }
	ld	a, l
	sub	a, #0x06
	or	a,h
	jp	NZ,00154$
	ld	(bc), a
	inc	bc
	ld	(bc), a
	ld	hl, #__countWater
	inc	(hl)
	ld	bc, #__player + 7
	ld	l, c
	ld	h, b
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
	add	a, #0x64
	ld	e, a
	ld	a, h
	adc	a, #0x00
	ld	d, a
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
	ld	bc, #0x0064
	call	__divsint
	inc	c
	inc	c
	inc	c
	ld	e, #0x01
	ld	a, c
	call	_DrawWater
	jp	00154$
;main.c:86: case 3:
00127$:
;main.c:87: if (field[_player.x - 1][_player.y] == 0 && _player.x - 1 > -1) { _player.x -= 1; return _movement(_dir); }
	ld	a, (#__player + 0)
	dec	a
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	ld	a, l
	add	a, #<(_field)
	ld	e, a
	ld	a, h
	adc	a, #>(_field)
	ld	d, a
	ld	a, (#__player + 1)
	add	a, a
	ld	b, a
	ld	l, b
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#2
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	a, (#__player + 0)
	ldhl	sp,#4
	ld	(hl+), a
	dec	a
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	or	a, (hl)
	jr	NZ, 00129$
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	e, a
	rlca
	sbc	a, a
	ld	l, e
	ld	h, a
	dec	hl
	ld	e, h
	ld	a,#0xff
	ld	d,a
	cp	a, l
	sbc	a, h
	bit	7, e
	jr	Z, 00374$
	bit	7, d
	jr	NZ, 00375$
	cp	a, a
	jr	00375$
00374$:
	bit	7, d
	jr	Z, 00375$
	scf
00375$:
	jr	NC, 00129$
	ld	de, #__player
	ldhl	sp,	#5
	ld	a, (hl)
	ld	(de), a
	ld	a, c
	call	__movement
	jp	00154$
00129$:
;main.c:88: if (field[_player.x - 1][_player.y] == 2 || field[_player.x - 1][_player.y] == 3) { field[_player.x - 1][_player.y] += 1; break; }
	ldhl	sp,	#5
	ld	e, (hl)
	ld	a, e
	rlca
	sbc	a, a
	ld	d, a
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	ld	de, #_field
	add	hl, de
	ld	a, l
	add	a, b
	ld	c, a
	ld	a, h
	adc	a, #0x00
	ld	b, a
	ld	l, c
	ld	h, b
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	sub	a, #0x02
	or	a, h
	jr	Z, 00131$
	ld	a, l
	sub	a, #0x03
	or	a, h
	jr	NZ, 00132$
00131$:
	inc	hl
	ld	e, l
	ld	d, h
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
	jp	00154$
00132$:
;main.c:89: if (field[_player.x - 1][_player.y] == 4) { field[_player.x - 1][_player.y] = 0; _countBrick += 1; _player.exp += 10; DrawUI(); break; }
	ld	a, l
	sub	a, #0x04
	or	a,h
	jr	NZ, 00135$
	ld	(bc), a
	inc	bc
	ld	(bc), a
	ld	hl, #__countBrick
	inc	(hl)
	ld	a, (hl)
	ld	hl, #(__player + 5)
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #0x000a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #(__player + 5)
	ld	(hl), c
	inc	hl
	ld	(hl), b
	call	_DrawUI
	jp	00154$
00135$:
;main.c:90: if (field[_player.x - 1][_player.y] == 5) { field[_player.x - 1][_player.y] = 0; _countCoin += 1; _player.exp += 30; DrawUI(); break; }
	ld	a, l
	sub	a, #0x05
	or	a,h
	jr	NZ, 00137$
	ld	(bc), a
	inc	bc
	ld	(bc), a
	ld	hl, #__countCoin
	inc	(hl)
	ld	a, (hl)
	ld	hl, #(__player + 5)
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #0x001e
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #(__player + 5)
	ld	(hl), c
	inc	hl
	ld	(hl), b
	call	_DrawUI
	jp	00154$
00137$:
;main.c:91: if (field[_player.x - 1][_player.y] == 6) { field[_player.x - 1][_player.y] = 0; _countWater += 1; _player.water += 100; DrawWater((_player.water / 100) + 3, 1); break; }
	ld	a, l
	sub	a, #0x06
	or	a,h
	jp	NZ,00154$
	ld	(bc), a
	inc	bc
	ld	(bc), a
	ld	hl, #__countWater
	inc	(hl)
	ld	bc, #__player + 7
	ld	l, c
	ld	h, b
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
	add	a, #0x64
	ld	e, a
	ld	a, h
	adc	a, #0x00
	ld	d, a
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
	ld	bc, #0x0064
	call	__divsint
	inc	c
	inc	c
	inc	c
	ld	e, #0x01
	ld	a, c
	call	_DrawWater
	jp	00154$
;main.c:93: case 4:
00140$:
;main.c:94: if (field[_player.x][_player.y - 1] == 0 && _player.y - 1 > -1) { _player.y -= 1; return _movement(_dir); }
	ld	a, (#__player + 0)
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_field
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ld	a, (#(__player + 1) + 0)
	ldhl	sp,#2
	ld	(hl), a
	ld	a, (hl+)
	dec	a
	ld	b, a
	add	a, a
	ld	(hl), a
	pop	de
	push	de
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	inc	de
	ld	a, (de)
	or	a, l
	jr	NZ, 00142$
	ldhl	sp,	#2
	ld	a, (hl)
	ld	e, a
	rlca
	sbc	a, a
	ld	l, e
	ld	h, a
	dec	hl
	ld	e, h
	ld	a,#0xff
	ld	d,a
	cp	a, l
	sbc	a, h
	bit	7, e
	jr	Z, 00385$
	bit	7, d
	jr	NZ, 00386$
	cp	a, a
	jr	00386$
00385$:
	bit	7, d
	jr	Z, 00386$
	scf
00386$:
	jr	NC, 00142$
	ld	hl, #(__player + 1)
	ld	(hl), b
	ld	a, c
	call	__movement
	jp	00154$
00142$:
;main.c:95: if (field[_player.x][_player.y - 1] == 2 || field[_player.x][_player.y - 1] == 3) { field[_player.x][_player.y - 1] += 1; break; }
	ld	a, (#__player + 0)
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	bc,#_field
	add	hl,bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#3
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	c,l
	ld	b,h
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	sub	a, #0x02
	or	a, h
	jr	Z, 00144$
	ld	a, l
	sub	a, #0x03
	or	a, h
	jr	NZ, 00145$
00144$:
	inc	hl
	ld	e, l
	ld	d, h
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
	jr	00154$
00145$:
;main.c:96: if (field[_player.x][_player.y - 1] == 4) { field[_player.x][_player.y - 1] = 0; _countBrick += 1; _player.exp += 10; DrawUI(); break; }
	ld	a, l
	sub	a, #0x04
	or	a,h
	jr	NZ, 00148$
	ld	(bc), a
	inc	bc
	ld	(bc), a
	ld	hl, #__countBrick
	inc	(hl)
	ld	a, (hl)
	ld	hl, #(__player + 5)
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #0x000a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #(__player + 5)
	ld	(hl), c
	inc	hl
	ld	(hl), b
	call	_DrawUI
	jr	00154$
00148$:
;main.c:97: if (field[_player.x][_player.y - 1] == 5) { field[_player.x][_player.y - 1] = 0; _countCoin += 1; _player.exp += 30; DrawUI(); break; }
	ld	a, l
	sub	a, #0x05
	or	a,h
	jr	NZ, 00150$
	ld	(bc), a
	inc	bc
	ld	(bc), a
	ld	hl, #__countCoin
	inc	(hl)
	ld	a, (hl)
	ld	hl, #(__player + 5)
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #0x001e
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #(__player + 5)
	ld	(hl), c
	inc	hl
	ld	(hl), b
	call	_DrawUI
	jr	00154$
00150$:
;main.c:98: if (field[_player.x][_player.y - 1] == 6) { field[_player.x][_player.y - 1] = 0; _countWater += 1; _player.water += 100; DrawWater((_player.water / 100) + 3, 1); break; }
	ld	a, l
	sub	a, #0x06
	or	a,h
	jr	NZ, 00154$
	ld	(bc), a
	inc	bc
	ld	(bc), a
	ld	hl, #__countWater
	inc	(hl)
	ld	bc, #__player + 7
	ld	l, c
	ld	h, b
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
	add	a, #0x64
	ld	e, a
	ld	a, h
	adc	a, #0x00
	ld	d, a
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
	ld	bc, #0x0064
	call	__divsint
	inc	c
	inc	c
	inc	c
	ld	e, #0x01
	ld	a, c
	call	_DrawWater
;main.c:100: }
00154$:
;main.c:101: }
	add	sp, #6
	ret
;main.c:103: void _playerDraw(void) {
;	---------------------------------
; Function _playerDraw
; ---------------------------------
__playerDraw::
;c:\gbdk\include\gb\gb.h:1804: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
;main.c:106: move_sprite(0, 8 + grid + _player.sprX, 16 + (grid * 4) + _player.sprY);
	ld	a, (#(__player + 3) + 0)
	add	a, #0x50
	ld	d, a
	ld	bc, #__player + 2
	ld	a, (bc)
	add	a, #0x18
	ld	e, a
;c:\gbdk\include\gb\gb.h:1877: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;c:\gbdk\include\gb\gb.h:1878: itm->y=y, itm->x=x;
	ld	a, d
	ld	(hl+), a
	ld	(hl), e
;c:\gbdk\include\gb\gb.h:1804: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x02
;main.c:108: move_sprite(1, 8 + grid + _player.sprX + 8, 16 + (grid * 4) + _player.sprY);
	ld	a, (#(__player + 3) + 0)
	add	a, #0x50
	ld	e, a
	ld	a, (bc)
	add	a, #0x20
	ld	c, a
;c:\gbdk\include\gb\gb.h:1877: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 4)
;c:\gbdk\include\gb\gb.h:1878: itm->y=y, itm->x=x;
	ld	a, e
	ld	(hl+), a
	ld	(hl), c
;main.c:108: move_sprite(1, 8 + grid + _player.sprX + 8, 16 + (grid * 4) + _player.sprY);
;main.c:110: }
	ret
;main.c:112: void _brickDraw(INT8 x, INT8 y, INT8 state, INT8 cnt) {
;	---------------------------------
; Function _brickDraw
; ---------------------------------
__brickDraw::
	add	sp, #-5
	ld	b, a
	ld	a, e
;main.c:117: for (UINT8 i = cnt - 2; i < 10; i += 2) {
	ldhl	sp,	#8
	ld	c, (hl)
	dec	c
	dec	c
	swap	a
	and	a, #0xf0
	push	af
	ld	a, b
	swap	a
	and	a, #0xf0
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	pop	af
	add	a, #0x50
	ld	b, a
	ld	a, l
	add	a, #0x18
	ld	e, a
	ld	a, l
	add	a, #0x20
	ld	d, a
;main.c:114: switch (state) {
	ldhl	sp,	#7
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00101$
	ldhl	sp,	#7
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00104$
	ldhl	sp,	#7
	ld	a, (hl)
	sub	a, #0x04
	jp	Z,00107$
	jp	00129$
;main.c:116: case 2:
00101$:
;main.c:117: for (UINT8 i = cnt - 2; i < 10; i += 2) {
	ldhl	sp,	#1
	ld	a, b
	ld	(hl+), a
	ld	a, b
	ld	(hl+), a
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
00124$:
	ld	a, c
	sub	a, #0x0a
	jp	NC, 00129$
;main.c:118: set_sprite_tile(2 + i, 4);
	ld	b,c
	inc	c
	inc	c
	ld	e, c
;c:\gbdk\include\gb\gb.h:1804: shadow_OAM[nb].tile=tile;
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, e
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), #0x04
;main.c:119: move_sprite(2 + i, 8 + grid + (x * 16), 16 + (grid * 4) + y * 16);
	ld	e, c
;c:\gbdk\include\gb\gb.h:1877: OAM_item_t * itm = &shadow_OAM[nb];
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, e
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
;c:\gbdk\include\gb\gb.h:1878: itm->y=y, itm->x=x;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;main.c:120: set_sprite_tile(3 + i, 6);
	inc	b
	inc	b
	inc	b
	ld	e, b
;c:\gbdk\include\gb\gb.h:1804: shadow_OAM[nb].tile=tile;
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, e
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), #0x06
;main.c:121: move_sprite(3 + i, 8 + grid + (x * 16) + 8, 16 + (grid * 4) + y * 16);
;c:\gbdk\include\gb\gb.h:1877: OAM_item_t * itm = &shadow_OAM[nb];
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, b
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
;c:\gbdk\include\gb\gb.h:1878: itm->y=y, itm->x=x;
	ldhl	sp,	#1
	ld	a, (hl)
	ld	(de), a
	inc	de
	ldhl	sp,	#4
	ld	a, (hl)
	ld	(de), a
;main.c:117: for (UINT8 i = cnt - 2; i < 10; i += 2) {
	jr	00124$
;main.c:126: case 3:
00104$:
;main.c:127: for (UINT8 i = cnt - 2; i < 10; i += 2) {
	ldhl	sp,	#0
	ld	a, b
	ld	(hl+), a
	ld	a, b
	ld	(hl+), a
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
00126$:
;main.c:128: set_sprite_tile(2 + i, 8);
	ld	a,c
	cp	a,#0x0a
	jp	NC,00129$
	add	a, #0x02
	ldhl	sp,	#4
	ld	(hl), a
;c:\gbdk\include\gb\gb.h:1804: shadow_OAM[nb].tile=tile;
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), #0x08
;main.c:129: move_sprite(2 + i, 8 + grid + (x * 16), 16 + (grid * 4) + y * 16);
	ldhl	sp,	#4
;c:\gbdk\include\gb\gb.h:1877: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
;c:\gbdk\include\gb\gb.h:1878: itm->y=y, itm->x=x;
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;main.c:130: set_sprite_tile(3 + i, 10);
	inc	c
	inc	c
	inc	c
;c:\gbdk\include\gb\gb.h:1804: shadow_OAM[nb].tile=tile;
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), #0x0a
;main.c:131: move_sprite(3 + i, 8 + grid + (x * 16) + 8, 16 + (grid * 4) + y * 16);
;c:\gbdk\include\gb\gb.h:1877: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+0
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, c
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	c, l
	ld	b, h
;c:\gbdk\include\gb\gb.h:1878: itm->y=y, itm->x=x;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#3
;main.c:127: for (UINT8 i = cnt - 2; i < 10; i += 2) {
	ld	a, (hl+)
	ld	(bc), a
	ld	c, (hl)
	jr	00126$
;main.c:136: case 4:
00107$:
;main.c:137: for (UINT8 i = cnt - 2; i < 10; i += 2) {
	ldhl	sp,	#1
	ld	a, b
	ld	(hl+), a
	ld	a, b
	ld	(hl+), a
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
00128$:
	ld	a, c
	sub	a, #0x0a
	jr	NC, 00129$
;main.c:138: set_sprite_tile(2 + i, 12);
	ld	b,c
	inc	c
	inc	c
	ld	e, c
;c:\gbdk\include\gb\gb.h:1804: shadow_OAM[nb].tile=tile;
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, e
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), #0x0c
;main.c:139: move_sprite(2 + i, 8 + grid + (x * 16), 16 + (grid * 4) + y * 16);
	ld	e, c
;c:\gbdk\include\gb\gb.h:1877: OAM_item_t * itm = &shadow_OAM[nb];
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, e
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
;c:\gbdk\include\gb\gb.h:1878: itm->y=y, itm->x=x;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;main.c:140: set_sprite_tile(3 + i, 14);
	inc	b
	inc	b
	inc	b
	ld	e, b
;c:\gbdk\include\gb\gb.h:1804: shadow_OAM[nb].tile=tile;
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, e
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), #0x0e
;main.c:141: move_sprite(3 + i, 8 + grid + (x * 16) + 8, 16 + (grid * 4) + y * 16);
;c:\gbdk\include\gb\gb.h:1877: OAM_item_t * itm = &shadow_OAM[nb];
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, b
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
;c:\gbdk\include\gb\gb.h:1878: itm->y=y, itm->x=x;
	ldhl	sp,	#1
	ld	a, (hl)
	ld	(de), a
	inc	de
	ldhl	sp,	#4
	ld	a, (hl)
	ld	(de), a
;main.c:137: for (UINT8 i = cnt - 2; i < 10; i += 2) {
	jr	00128$
;main.c:145: }
00129$:
;main.c:146: }
	add	sp, #5
	pop	hl
	pop	af
	jp	(hl)
;main.c:148: void _stoneDraw(INT8 x, INT8 y, INT8 cnt) {
;	---------------------------------
; Function _stoneDraw
; ---------------------------------
__stoneDraw::
	add	sp, #-3
	ld	c, a
	ld	a, e
;main.c:150: for (UINT8 i = cnt - 2; i < 4; i += 2) {
	ldhl	sp,	#5
	ld	e, (hl)
	dec	e
	dec	e
	swap	a
	and	a, #0xf0
	add	a, #0x50
	ld	d, a
	ldhl	sp,	#0
	ld	a, d
	ld	(hl+), a
	ld	a, c
	swap	a
	and	a, #0xf0
	ld	c, a
	add	a, #0x18
	ld	(hl+), a
	ld	a, c
	add	a, #0x20
	ld	(hl), a
00108$:
	ld	a, e
	sub	a, #0x04
	jr	NC, 00109$
;main.c:151: set_sprite_tile(12 + i, 16);
	ld	a, e
	add	a, #0x0c
	ld	c, a
;c:\gbdk\include\gb\gb.h:1804: shadow_OAM[nb].tile=tile;
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	pop	de
	ld	(hl), #0x10
;main.c:152: move_sprite(12 + i, 8 + grid + (x * 16), 16 + (grid * 4) + y * 16);
;c:\gbdk\include\gb\gb.h:1877: OAM_item_t * itm = &shadow_OAM[nb];
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, c
	add	hl, hl
	add	hl, hl
	ld	bc, #_shadow_OAM
	add	hl, bc
	ld	c, l
	ld	b, h
;c:\gbdk\include\gb\gb.h:1878: itm->y=y, itm->x=x;
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;main.c:153: set_sprite_tile(13 + i, 18);
	ld	a, e
	add	a, #0x0d
	ld	c, a
;c:\gbdk\include\gb\gb.h:1804: shadow_OAM[nb].tile=tile;
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	pop	de
	ld	(hl), #0x12
;main.c:154: move_sprite(13 + i, 8 + grid + (x * 16) + 8, 16 + (grid * 4) + y * 16);
;c:\gbdk\include\gb\gb.h:1877: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	bc, #_shadow_OAM
	add	hl, bc
;c:\gbdk\include\gb\gb.h:1878: itm->y=y, itm->x=x;
	ld	a, d
	ld	(hl+), a
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(bc), a
;main.c:150: for (UINT8 i = cnt - 2; i < 4; i += 2) {
	inc	e
	inc	e
	jr	00108$
00109$:
;main.c:157: }
	add	sp, #3
	pop	hl
	inc	sp
	jp	(hl)
;main.c:159: void _bonusDraw(INT8 x, INT8 y, INT8 cnt, INT8 water) {
;	---------------------------------
; Function _bonusDraw
; ---------------------------------
__bonusDraw::
	add	sp, #-8
	ld	c, a
;main.c:161: for (UINT8 i = cnt - 1; i < 3; i++) {
	ldhl	sp,	#10
	ld	a, (hl)
	dec	a
	ldhl	sp,	#7
	ld	(hl), a
	ld	a, e
	swap	a
	and	a, #0xf0
	add	a, #0x50
	ldhl	sp,	#0
	ld	(hl+), a
	ld	a, c
	swap	a
	and	a, #0xf0
	add	a, #0x1c
	ld	(hl), a
00110$:
	ldhl	sp,	#7
	ld	a, (hl)
	sub	a, #0x03
	jp	NC, 00111$
;main.c:163: if (water != 0) { set_sprite_tile(16 + i + water, 28); }
	ld	a, (hl-)
	ld	(hl), a
	ld	a, (hl)
	add	a, #0x10
	ld	(hl), a
	ld	a, (hl)
	ldhl	sp,	#11
	add	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
	ldhl	sp,	#6
	ld	c, (hl)
;c:\gbdk\include\gb\gb.h:1804: shadow_OAM[nb].tile=tile;
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, c
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), #0x1c
;main.c:163: if (water != 0) { set_sprite_tile(16 + i + water, 28); }
	jr	00103$
00102$:
;main.c:164: else { set_sprite_tile(16 + i + water, 20 + _bonus.frame); }
	ld	a, (#__bonus + 0)
	add	a, #0x14
	ldhl	sp,	#2
	ld	(hl), a
;c:\gbdk\include\gb\gb.h:1804: shadow_OAM[nb].tile=tile;
	ldhl	sp,	#6
	ld	a, (hl-)
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x02
00135$:
	ldhl	sp,	#5
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00135$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(de), a
;main.c:164: else { set_sprite_tile(16 + i + water, 20 + _bonus.frame); }
00103$:
;main.c:166: move_sprite(16 + i + water, 12 + grid + (x * 16), 16 + (grid * 4) + y * 16);
	ldhl	sp,	#7
	ld	a, (hl-)
	add	a, #0x10
	ld	(hl), a
	ld	a, (hl)
	ldhl	sp,	#11
	add	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
;c:\gbdk\include\gb\gb.h:1877: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+0
	ld	a, (hl-)
	ld	e, a
	ld	d, #0x00
	sla	e
	rl	d
	sla	e
	rl	d
	ld	a, e
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
;c:\gbdk\include\gb\gb.h:1878: itm->y=y, itm->x=x;
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;main.c:161: for (UINT8 i = cnt - 1; i < 3; i++) {
	ldhl	sp,	#7
	inc	(hl)
	jp	00110$
00111$:
;main.c:169: }
	add	sp, #8
	pop	hl
	pop	af
	jp	(hl)
;main.c:171: void _control(void) {
;	---------------------------------
; Function _control
; ---------------------------------
__control::
;main.c:173: switch (joypad()) {
	call	_joypad
	cp	a, #0x01
	jr	Z, 00102$
	cp	a, #0x02
	jr	Z, 00101$
	cp	a, #0x04
	jr	Z, 00104$
	sub	a, #0x08
	jr	Z, 00103$
	ret
;main.c:175: case J_LEFT: _movement(3); waitpadup(); break;
00101$:
	ld	a, #0x03
	call	__movement
	jp	_waitpadup
;main.c:176: case J_RIGHT: _movement(1); waitpadup(); break;
00102$:
	ld	a, #0x01
	call	__movement
	jp	_waitpadup
;main.c:177: case J_DOWN: _movement(2); waitpadup(); break;
00103$:
	ld	a, #0x02
	call	__movement
	jp	_waitpadup
;main.c:178: case J_UP: _movement(4); waitpadup(); break;
00104$:
	ld	a, #0x04
	call	__movement
;main.c:180: }
;main.c:181: }
	jp	_waitpadup
;main.c:183: void _smoothMove(void) {
;	---------------------------------
; Function _smoothMove
; ---------------------------------
__smoothMove::
	add	sp, #-3
;main.c:185: if (_player.sprX < _player.x * grid) {
	ld	a, (#(__player + 2) + 0)
	ldhl	sp,	#0
	ld	(hl), a
	ld	a, (#__player + 0)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	rlca
	sbc	a, a
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	(hl+), a
	rlca
	sbc	a, a
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00139$
	bit	7, d
	jr	NZ, 00140$
	cp	a, a
	jr	00140$
00139$:
	bit	7, d
	jr	Z, 00140$
	scf
00140$:
	jr	NC, 00102$
;main.c:186: _player.sprX += speed;
	ldhl	sp,	#0
	ld	a, (hl)
	add	a, #0x08
	ld	(#(__player + 2)),a
00102$:
;main.c:185: if (_player.sprX < _player.x * grid) {
	ld	a, (#(__player + 2) + 0)
	ldhl	sp,	#0
	ld	(hl), a
;main.c:189: if (_player.sprX > _player.x * grid) {
	ld	a, (#__player + 0)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	rlca
	sbc	a, a
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	(hl+), a
	rlca
	sbc	a, a
	ld	(hl-), a
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00141$
	bit	7, d
	jr	NZ, 00142$
	cp	a, a
	jr	00142$
00141$:
	bit	7, d
	jr	Z, 00142$
	scf
00142$:
	jr	NC, 00104$
;main.c:190: _player.sprX -= speed;
	ldhl	sp,	#0
	ld	a, (hl)
	add	a, #0xf8
	ld	(#(__player + 2)),a
00104$:
;main.c:193: if (_player.sprY < _player.y * grid) {
	ld	a, (#(__player + 3) + 0)
	ldhl	sp,	#0
	ld	(hl), a
	ld	a, (#(__player + 1) + 0)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	rlca
	sbc	a, a
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	(hl+), a
	rlca
	sbc	a, a
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00143$
	bit	7, d
	jr	NZ, 00144$
	cp	a, a
	jr	00144$
00143$:
	bit	7, d
	jr	Z, 00144$
	scf
00144$:
	jr	NC, 00106$
;main.c:194: _player.sprY += speed;
	ldhl	sp,	#0
	ld	a, (hl)
	add	a, #0x08
	ld	(#(__player + 3)),a
00106$:
;main.c:193: if (_player.sprY < _player.y * grid) {
	ld	a, (#(__player + 3) + 0)
	ldhl	sp,	#0
	ld	(hl), a
;main.c:197: if (_player.sprY > _player.y * grid) {
	ld	a, (#(__player + 1) + 0)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	rlca
	sbc	a, a
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	(hl+), a
	rlca
	sbc	a, a
	ld	(hl-), a
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00145$
	bit	7, d
	jr	NZ, 00146$
	cp	a, a
	jr	00146$
00145$:
	bit	7, d
	jr	Z, 00146$
	scf
00146$:
	jr	NC, 00109$
;main.c:198: _player.sprY -= speed;
	ldhl	sp,	#0
	ld	a, (hl)
	add	a, #0xf8
	ld	(#(__player + 3)),a
00109$:
;main.c:200: }
	add	sp, #3
	ret
;main.c:202: void _spawn(UINT8 _block) {
;	---------------------------------
; Function _spawn
; ---------------------------------
__spawn::
	add	sp, #-4
	ldhl	sp,	#3
	ld	(hl), a
;main.c:204: UINT8 x = ((UINT8)rand()) % fieldX;
	call	_rand
	ld	a, e
	and	a, #0x07
	ldhl	sp,	#0
	ld	(hl), a
;main.c:205: UINT8 y = ((UINT8)rand()) % fieldY;
	call	_rand
	ld	a, e
	and	a, #0x03
	ldhl	sp,	#1
	ld	(hl), a
;main.c:206: UINT8 state = ((UINT8)rand()) % 3;
	call	_rand
	ld	d, #0x00
	ld	bc, #0x0003
	call	__modsint
	ldhl	sp,	#2
;main.c:208: if (_block != 2) state = 0;
	ld	a, c
	ld	(hl+), a
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00102$
	ldhl	sp,	#2
	ld	(hl), #0x00
00102$:
;main.c:210: if (field[x][y] == 0 && x != (UINT8)_player.x && y != (UINT8)_player.y) field[x][y] = _block + state;
	ld	bc, #_field+0
	ldhl	sp,	#0
	ld	e, (hl)
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#1
	ld	a, (hl)
	add	a, a
	add	a, c
	ld	c, a
	ld	a, #0x00
	adc	a, b
	ld	b, a
	ld	l, c
	ld	h, b
	inc	hl
	ld	a,	(hl-)
	ld	l, (hl)
;	spillPairReg hl
	or	a, l
	jr	NZ, 00104$
	ld	a, (#__player + 0)
	ld	e, a
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, e
	jr	Z, 00104$
	ld	a, (#(__player + 1) + 0)
	ld	e, a
	ldhl	sp,	#1
	ld	a, (hl)
	sub	a, e
	jr	Z, 00104$
	ldhl	sp,	#3
	ld	a, (hl-)
	ld	e, a
	ld	d, #0x00
	ld	a, (hl-)
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
	jr	00108$
00104$:
;main.c:211: else _spawn(_block);
	ldhl	sp,	#3
	ld	a, (hl)
	call	__spawn
00108$:
;main.c:212: }
	add	sp, #4
	ret
;main.c:214: void _draw(void) {
;	---------------------------------
; Function _draw
; ---------------------------------
__draw::
	add	sp, #-12
;main.c:216: UINT8 _cntBrick = 0;
	ldhl	sp,	#0
;main.c:217: UINT8 _cntStone = 0;
	xor	a, a
	ld	(hl+), a
;main.c:218: UINT8 _cntCoin = 0;
	xor	a, a
	ld	(hl+), a
;main.c:219: UINT8 _cntWater = 0;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;main.c:221: for (INT8 i = 0; i < fieldY; i++) {
	ldhl	sp,	#9
	ld	(hl), #0x00
00119$:
	ldhl	sp,	#9
	ld	a, (hl)
	xor	a, #0x80
	sub	a, #0x84
	jp	NC, 00121$
;main.c:222: for (INT8 j = 0; j < fieldX; j++) {
	ld	a, (hl)
	add	a, a
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#10
	ld	(hl), #0x00
00116$:
	ldhl	sp,	#10
	ld	a, (hl)
	xor	a, #0x80
	sub	a, #0x88
	jp	NC, 00120$
;main.c:224: if (field[j][i] == 6) { _cntWater += 1; _bonusDraw(j, i, _cntWater, 3); }
	ld	c, (hl)
	ld	a, c
	rlca
	sbc	a, a
	ld	b, a
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	bc,#_field
	add	hl,bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#4
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	a, c
	sub	a, #0x06
	or	a, b
	jr	NZ, 00102$
	ldhl	sp,	#3
	inc	(hl)
	ld	a, #0x03
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
	call	__bonusDraw
00102$:
;main.c:225: if (field[j][i] == 5) { _cntCoin += 1; _bonusDraw(j, i, _cntCoin, 0); }
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	a, c
	sub	a, #0x05
	or	a, b
	jr	NZ, 00129$
	ldhl	sp,	#2
	inc	(hl)
	xor	a, a
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
	call	__bonusDraw
;main.c:226: for (UINT8 c = 2; c < 5; c++) { if (field[j][i] == c) { _cntBrick += 2; _brickDraw(j, i, c, _cntBrick); } }
00129$:
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#11
	ld	(hl), #0x02
00113$:
	ldhl	sp,	#11
	ld	a, (hl)
	sub	a, #0x05
	jr	NC, 00107$
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#7
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#11
	ld	e, (hl)
	ld	d, #0x00
	ldhl	sp,	#7
	ld	a, (hl)
	sub	a, e
	jr	NZ, 00114$
	inc	hl
	ld	a, (hl)
	sub	a, d
	jr	NZ, 00114$
	ldhl	sp,	#0
	ld	a, (hl)
	add	a, #0x02
	ld	(hl), a
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#14
	ld	a, (hl-)
	dec	hl
	push	af
	inc	sp
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
	call	__brickDraw
	pop	bc
00114$:
	ldhl	sp,	#11
	inc	(hl)
	jr	00113$
00107$:
;main.c:227: if (field[j][i] == 1) { _cntStone += 2; _stoneDraw(j, i, _cntStone); }
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	a, c
	dec	a
	or	a, b
	jr	NZ, 00117$
	ldhl	sp,	#1
	ld	a, (hl)
	add	a, #0x02
	ld	(hl), a
	push	af
	inc	sp
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
	call	__stoneDraw
00117$:
;main.c:222: for (INT8 j = 0; j < fieldX; j++) {
	ldhl	sp,	#10
	inc	(hl)
	jp	00116$
00120$:
;main.c:221: for (INT8 i = 0; i < fieldY; i++) {
	ldhl	sp,	#9
	inc	(hl)
	jp	00119$
00121$:
;main.c:231: }
	add	sp, #12
	ret
;main.c:233: UINT32 power(UINT8 num,UINT8 pow) {
;	---------------------------------
; Function power
; ---------------------------------
_power::
	add	sp, #-5
	ld	c, a
	ldhl	sp,	#4
	ld	(hl), e
;main.c:234: UINT32 result = 1;
	ldhl	sp,	#0
	ld	a, #0x01
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), a
;main.c:235: for (UINT8 i = 0; i < pow; i++) {
	ld	b, #0x00
00103$:
	ld	a, b
	ldhl	sp,	#4
	sub	a, (hl)
	jr	NC, 00101$
;main.c:236: result *= num;
	ld	e, c
	ld	d, #0x00
	ld	hl, #0x0000
	push	bc
	push	hl
	push	de
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;main.c:235: for (UINT8 i = 0; i < pow; i++) {
	call	__mullong
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl+), a
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	pop	bc
	inc	b
	jr	00103$
00101$:
;main.c:238: return result;
	pop	bc
	push	bc
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;main.c:239: }
	add	sp, #5
	ret
;main.c:241: void DrawUI(void) {
;	---------------------------------
; Function DrawUI
; ---------------------------------
_DrawUI::
	add	sp, #-10
;main.c:242: for (UINT8 i = 0; i < 4; i++) {
	ldhl	sp,	#9
	ld	(hl), #0x00
00103$:
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, #0x04
	jp	NC, 00101$
;main.c:243: UINT16 mod = ((_player.exp / power(10, i)) % 10) + 20;
	ld	hl, #(__player + 5)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ldhl	sp,	#11
	ld	e, (hl)
	ld	a, #0x0a
	call	_power
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl+), a
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	pop	bc
	ld	a, b
	rlca
	sbc	a, a
	ld	e, a
	ld	d, a
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	call	__divulong
	ld	hl, #0x0000
	push	hl
	ld	l, #0x0a
	push	hl
	call	__modulong
	ld	hl, #0x0014
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
;main.c:244: set_bkg_tiles(9-i, 3, 1, 1, &mod);
	ldhl	sp,	#4
	ld	c, l
	ld	b, h
	ldhl	sp,	#9
	ld	a, (hl-)
	ld	(hl), a
	ld	a, #0x09
	sub	a, (hl)
	push	bc
	ld	h, #0x01
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x01
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x03
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;main.c:245: UINT16 needmod = (((((_player.level-1) * 400)+300) / power(10, i)) % 10) + 20;
	ld	a, (#(__player + 4) + 0)
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	dec	bc
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	bc,#0x012c
	add	hl,bc
	push	hl
	ldhl	sp,	#11
	ld	e, (hl)
	ld	a, #0x0a
	call	_power
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl+), a
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	pop	bc
	ld	a, b
	rlca
	sbc	a, a
	ld	e, a
	ld	d, a
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	call	__divulong
	ld	hl, #0x0000
	push	hl
	ld	l, #0x0a
	push	hl
	call	__modulong
	ld	hl, #0x0014
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
;main.c:246: set_bkg_tiles(14 - i, 3, 1, 1, &needmod);
	ld	(hl+), a
	ld	a, #0x0e
	sub	a, (hl)
	ld	(hl), a
	ld	hl, #6
	add	hl, sp
	push	hl
	ld	hl, #0x101
	push	hl
	ld	a, #0x03
	push	af
	inc	sp
	ldhl	sp,	#13
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;main.c:242: for (UINT8 i = 0; i < 4; i++) {
	ldhl	sp,	#9
	inc	(hl)
	jp	00103$
00101$:
;main.c:248: UINT8 lvl = (_player.level + 20);
	ld	a, (#(__player + 4) + 0)
	add	a, #0x14
	ldhl	sp,	#7
	ld	(hl), a
;main.c:249: set_bkg_tiles(8, 1, 1, 1, &lvl);
	ld	hl, #7
	add	hl, sp
	push	hl
	ld	hl, #0x101
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	ld	a, #0x08
	push	af
	inc	sp
	call	_set_bkg_tiles
;main.c:250: }
	add	sp, #16
	ret
;main.c:252: void DrawWater(UINT8 cnt, UBYTE add) {
;	---------------------------------
; Function DrawWater
; ---------------------------------
_DrawWater::
	dec	sp
	ld	b, a
;main.c:253: if (cnt > 11) return;
	ld	a, #0x0b
	sub	a, b
	jr	C, 00106$
;main.c:255: if (add) {
	ld	a, e
	or	a, a
	jr	Z, 00104$
;main.c:256: tmp = 30;
	ldhl	sp,	#0
	ld	(hl), #0x1e
;main.c:257: set_bkg_tiles(cnt, 6, 1, 1, &tmp);
	ld	hl, #0
	add	hl, sp
	push	hl
	ld	hl, #0x101
	push	hl
	ld	a, #0x06
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
	jr	00105$
00104$:
;main.c:260: tmp = 0;
	ldhl	sp,	#0
	ld	(hl), #0x00
00105$:
;main.c:261: set_bkg_tiles(cnt+1, 6, 1, 1,&tmp );
	ld	hl, #0
	add	hl, sp
	ld	a, b
	inc	a
	push	hl
	ld	h, #0x01
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x01
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x06
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
00106$:
;main.c:262: }
	inc	sp
	ret
;main.c:263: int main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-7
;main.c:265: _fieldInit();
	call	__fieldInit
;main.c:267: SPRITES_8x16;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x04
	ldh	(_LCDC_REG + 0), a
;main.c:269: set_sprite_data(0, 4, Player);
	ld	de, #_Player
	push	de
	ld	hl, #0x400
	push	hl
	call	_set_sprite_data
	add	sp, #4
;main.c:270: set_sprite_data(4, 12, Brick);
	ld	de, #_Brick
	push	de
	ld	hl, #0xc04
	push	hl
	call	_set_sprite_data
	add	sp, #4
;main.c:271: set_sprite_data(16, 4, Stone);
	ld	de, #_Stone
	push	de
	ld	hl, #0x410
	push	hl
	call	_set_sprite_data
	add	sp, #4
;main.c:272: set_sprite_data(20, 8, Coin);
	ld	de, #_Coin
	push	de
	ld	hl, #0x814
	push	hl
	call	_set_sprite_data
	add	sp, #4
;main.c:273: set_sprite_data(28, 2, Water);
	ld	de, #_Water
	push	de
	ld	hl, #0x21c
	push	hl
	call	_set_sprite_data
	add	sp, #4
;main.c:275: set_bkg_data(0, 31, HUD);
	ld	de, #_HUD
	push	de
	ld	hl, #0x1f00
	push	hl
	call	_set_bkg_data
	add	sp, #4
;main.c:276: set_bkg_tiles(0, 0, 20, 18, BG);
	ld	de, #_BG
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;main.c:278: initrand(0);
	ld	de, #0x0000
	push	de
	call	_initrand
	pop	hl
;main.c:282: while (_countStone > 0) { _spawn(1); _countStone -= 1; }
00101$:
	ld	a, (#__countStone)
	or	a, a
	jr	Z, 00104$
	ld	a, #0x01
	call	__spawn
	ld	hl, #__countStone
	dec	(hl)
	ld	a, (hl)
	jr	00101$
;main.c:283: while (_countBrick > 0) { _spawn(2); _countBrick -= 1; }
00104$:
	ld	a, (#__countBrick)
	or	a, a
	jr	Z, 00107$
	ld	a, #0x02
	call	__spawn
	ld	hl, #__countBrick
	dec	(hl)
	ld	a, (hl)
	jr	00104$
;main.c:284: while (_countCoin > 0) { _spawn(5); _countCoin -= 1; }
00107$:
	ld	a, (#__countCoin)
	or	a, a
	jr	Z, 00110$
	ld	a, #0x05
	call	__spawn
	ld	hl, #__countCoin
	dec	(hl)
	ld	a, (hl)
	jr	00107$
;main.c:285: while (_countWater > 0) { _spawn(6); _countWater -= 1; }
00110$:
	ld	a, (#__countWater)
	or	a, a
	jr	Z, 00112$
	ld	a, #0x06
	call	__spawn
	ld	hl, #__countWater
	dec	(hl)
	ld	a, (hl)
	jr	00110$
00112$:
;main.c:287: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;main.c:288: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:289: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;main.c:291: DrawUI();
	call	_DrawUI
;main.c:293: for (UINT8 i = 0; i < 11; i++) {
	ld	c, #0x00
00139$:
	ld	a, c
	sub	a, #0x0b
	jr	NC, 00136$
;main.c:294: UINT32 mod = 30;
	ldhl	sp,	#2
	ld	a, #0x1e
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), a
;main.c:295: set_bkg_tiles(2 + i, 6, 1, 1, &mod);
	ldhl	sp,	#2
	ld	e, l
	ld	d, h
	ld	a, c
	add	a, #0x02
	push	de
	ld	h, #0x01
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x01
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x06
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;main.c:293: for (UINT8 i = 0; i < 11; i++) {
	inc	c
	jr	00139$
;main.c:298: while (1) {
00136$:
;main.c:300: if (_player.sprX == _player.x * grid && _player.sprY == _player.y * grid) { _control(); }
	ld	hl, #__player + 2
	ld	c, (hl)
	ld	a, (#__player + 0)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	rlca
	sbc	a, a
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a, c
	rlca
	sbc	a, a
	ld	b, a
	ld	a, l
	sub	a, c
	jr	NZ, 00115$
	ld	a, h
	sub	a, b
	jr	NZ, 00115$
	ld	hl, #__player + 3
	ld	c, (hl)
	ld	a, (#(__player + 1) + 0)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	rlca
	sbc	a, a
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a, c
	rlca
	sbc	a, a
	ld	b, a
	ld	a, l
	sub	a, c
	jr	NZ, 00115$
	ld	a, h
	sub	a, b
	jr	NZ, 00115$
	call	__control
00115$:
;main.c:302: if (_countStone > 0) { _spawn(1); _countStone -= 1; }
	ld	a, (#__countStone)
	or	a, a
	jr	Z, 00118$
	ld	a, #0x01
	call	__spawn
	ld	hl, #__countStone
	dec	(hl)
	ld	a, (hl)
00118$:
;main.c:303: if (_countBrick > 0) { _spawn(2); _countBrick -= 1; }
	ld	a, (#__countBrick)
	or	a, a
	jr	Z, 00120$
	ld	a, #0x02
	call	__spawn
	ld	hl, #__countBrick
	dec	(hl)
	ld	a, (hl)
00120$:
;main.c:304: if (_countCoin > 0) { _spawn(5); _countCoin -= 1; }
	ld	a, (#__countCoin)
	or	a, a
	jr	Z, 00122$
	ld	a, #0x05
	call	__spawn
	ld	hl, #__countCoin
	dec	(hl)
	ld	a, (hl)
00122$:
;main.c:305: if (_countWater > 0) { _spawn(6); _countWater -= 1; }
	ld	a, (#__countWater)
	or	a, a
	jr	Z, 00124$
	ld	a, #0x06
	call	__spawn
	ld	hl, #__countWater
	dec	(hl)
	ld	a, (hl)
00124$:
;main.c:307: _playerDraw();
	call	__playerDraw
;main.c:308: _smoothMove();
	call	__smoothMove
;main.c:309: _draw();
	call	__draw
;main.c:311: _bonus.anim++;
	ld	a, (#(__bonus + 1) + 0)
	inc	a
	ld	(#(__bonus + 1)),a
;main.c:312: _player.water-=2;
	ld	hl, #(__player + 7)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	de, #0x0002
	ld	a, c
	sub	a, e
	ld	e, a
	ld	a, b
	sbc	a, d
	ldhl	sp,	#1
	ld	(hl-), a
	ld	(hl), e
	ld	de, #(__player + 7)
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;main.c:313: if (_player.water % 100 == 0) {
	ld	bc, #0x0064
	pop	de
	push	de
	call	__modsint
	ld	a, b
	or	a, c
	jr	NZ, 00126$
;main.c:314: DrawWater((_player.water/100)+3,0);
	ld	hl, #(__player + 7)
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
	ld	e, a
	ld	bc, #0x0064
	ld	d, h
	call	__divsint
	inc	c
	inc	c
	inc	c
	ld	e, #0x00
	ld	a, c
	call	_DrawWater
00126$:
;main.c:316: if (_player.exp >= ((_player.level - 1) * 400) + 300) _player.level++;
	ld	hl, #(__player + 5)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (#(__player + 4) + 0)
	ldhl	sp,#6
	ld	(hl), a
	ld	a, (hl)
	ld	e, a
	rlca
	sbc	a, a
	ld	l, e
	ld	h, a
	dec	hl
	ld	e, l
	ld	d, h
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	de, #0x012c
	add	hl, de
	ld	e, h
	ld	d, b
	ld	a, c
	sub	a, l
	ld	a, b
	sbc	a, h
	bit	7, e
	jr	Z, 00302$
	bit	7, d
	jr	NZ, 00303$
	cp	a, a
	jr	00303$
00302$:
	bit	7, d
	jr	Z, 00303$
	scf
00303$:
	jr	C, 00128$
	ldhl	sp,	#6
	ld	a, (hl)
	inc	a
	ld	(#(__player + 4)),a
00128$:
;main.c:317: if (_player.water > 1000) _player.water = 1000;
	ld	hl, #(__player + 7)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	e, b
	ld	d, #0x03
	ld	a, #0xe8
	cp	a, c
	ld	a, #0x03
	sbc	a, b
	bit	7, e
	jr	Z, 00304$
	bit	7, d
	jr	NZ, 00305$
	cp	a, a
	jr	00305$
00304$:
	bit	7, d
	jr	Z, 00305$
	scf
00305$:
	jr	NC, 00130$
	ld	hl, #(__player + 7)
	ld	a, #0xe8
	ld	(hl+), a
	ld	(hl), #0x03
00130$:
;main.c:318: if (_bonus.anim >= 8) { _bonus.frame += 2; _bonus.anim = 0; }
	ld	a, (#(__bonus + 1) + 0)
	sub	a, #0x08
	jr	C, 00132$
	ld	a, (#__bonus + 0)
	add	a, #0x02
	ld	(#__bonus),a
	ld	hl, #(__bonus + 1)
	ld	(hl), #0x00
00132$:
;main.c:319: if (_bonus.frame > 6) _bonus.frame = 0;
	ld	hl, #__bonus
	ld	c, (hl)
	ld	a, #0x06
	sub	a, c
	jr	NC, 00134$
	ld	hl, #__bonus
	ld	(hl), #0x00
00134$:
;main.c:321: wait_vbl_done();
	call	_wait_vbl_done
	jp	00136$
;main.c:323: }
	add	sp, #7
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__Player:
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xbe	; 190
	.db #0xff	; 255
	.db #0x8c	; 140
	.db #0xff	; 255
	.db #0x8c	; 140
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x87	; 135
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x7d	; 125
	.db #0xff	; 255
	.db #0x31	; 49	'1'
	.db #0xff	; 255
	.db #0x31	; 49	'1'
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xe1	; 225
	.db #0xff	; 255
	.db #0xc1	; 193
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0xfc	; 252
	.db #0xfc	; 252
__xinit__Brick:
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0x88	; 136
	.db #0xf7	; 247
	.db #0x88	; 136
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xfb	; 251
	.db #0x84	; 132
	.db #0xfb	; 251
	.db #0x84	; 132
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0x88	; 136
	.db #0xf7	; 247
	.db #0x88	; 136
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xfb	; 251
	.db #0x84	; 132
	.db #0xfb	; 251
	.db #0x84	; 132
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xfd	; 253
	.db #0x82	; 130
	.db #0xfd	; 253
	.db #0x82	; 130
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0x41	; 65	'A'
	.db #0xbf	; 191
	.db #0x41	; 65	'A'
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xdf	; 223
	.db #0x21	; 33
	.db #0xdf	; 223
	.db #0x21	; 33
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0x41	; 65	'A'
	.db #0xbf	; 191
	.db #0x41	; 65	'A'
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xef	; 239
	.db #0x11	; 17
	.db #0xef	; 239
	.db #0x11	; 17
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xdf	; 223
	.db #0x21	; 33
	.db #0xdf	; 223
	.db #0x21	; 33
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0x88	; 136
	.db #0xf7	; 247
	.db #0xc8	; 200
	.db #0xc0	; 192
	.db #0xff	; 255
	.db #0x3b	; 59
	.db #0x24	; 36
	.db #0x1b	; 27
	.db #0x14	; 20
	.db #0xf8	; 248
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0x8c	; 140
	.db #0xf7	; 247
	.db #0x88	; 136
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xfb	; 251
	.db #0x86	; 134
	.db #0xff	; 255
	.db #0x8c	; 140
	.db #0xb8	; 184
	.db #0xff	; 255
	.db #0xef	; 239
	.db #0xe8	; 232
	.db #0x0f	; 15
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0x41	; 65	'A'
	.db #0xbf	; 191
	.db #0x47	; 71	'G'
	.db #0x0f	; 15
	.db #0xff	; 255
	.db #0xd0	; 208
	.db #0x30	; 48	'0'
	.db #0xef	; 239
	.db #0x2f	; 47
	.db #0x51	; 81	'Q'
	.db #0xdf	; 223
	.db #0xff	; 255
	.db #0x61	; 97	'a'
	.db #0xbf	; 191
	.db #0xc1	; 193
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xef	; 239
	.db #0x13	; 19
	.db #0xec	; 236
	.db #0x1c	; 28
	.db #0x18	; 24
	.db #0xf8	; 248
	.db #0xf0	; 240
	.db #0x30	; 48	'0'
	.db #0xe0	; 224
	.db #0x60	; 96
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xf6	; 246
	.db #0x8a	; 138
	.db #0xf4	; 244
	.db #0x8c	; 140
	.db #0xc5	; 197
	.db #0xfd	; 253
	.db #0x3d	; 61
	.db #0x25	; 37
	.db #0x1d	; 29
	.db #0x15	; 21
	.db #0xed	; 237
	.db #0xfd	; 253
	.db #0xf7	; 247
	.db #0x8a	; 138
	.db #0xff	; 255
	.db #0xfb	; 251
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x84	; 132
	.db #0x99	; 153
	.db #0xff	; 255
	.db #0xef	; 239
	.db #0xa9	; 169
	.db #0xcf	; 207
	.db #0xc9	; 201
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xc1	; 193
	.db #0xbf	; 191
	.db #0xc7	; 199
	.db #0x8f	; 143
	.db #0xff	; 255
	.db #0xd0	; 208
	.db #0x30	; 48	'0'
	.db #0xe7	; 231
	.db #0x27	; 39
	.db #0x7d	; 125
	.db #0xff	; 255
	.db #0xb9	; 185
	.db #0x59	; 89	'Y'
	.db #0xa1	; 161
	.db #0x41	; 65	'A'
	.db #0xc1	; 193
	.db #0xff	; 255
	.db #0xaf	; 175
	.db #0xb7	; 183
	.db #0xaf	; 175
	.db #0xbf	; 191
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0xc0	; 192
	.db #0xc0	; 192
__xinit__Stone:
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xdf	; 223
	.db #0xe0	; 224
	.db #0xef	; 239
	.db #0xd0	; 208
	.db #0xff	; 255
	.db #0xcf	; 207
	.db #0xff	; 255
	.db #0xcf	; 207
	.db #0xfc	; 252
	.db #0xcf	; 207
	.db #0xfc	; 252
	.db #0xcf	; 207
	.db #0xfc	; 252
	.db #0xcf	; 207
	.db #0xfc	; 252
	.db #0xcf	; 207
	.db #0xff	; 255
	.db #0xcf	; 207
	.db #0xff	; 255
	.db #0xcf	; 207
	.db #0xef	; 239
	.db #0xd0	; 208
	.db #0xdf	; 223
	.db #0xe0	; 224
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfb	; 251
	.db #0x07	; 7
	.db #0xf7	; 247
	.db #0x0b	; 11
	.db #0xff	; 255
	.db #0xf3	; 243
	.db #0xff	; 255
	.db #0xf3	; 243
	.db #0x3f	; 63
	.db #0xf3	; 243
	.db #0x3f	; 63
	.db #0xf3	; 243
	.db #0x3f	; 63
	.db #0xf3	; 243
	.db #0x3f	; 63
	.db #0xf3	; 243
	.db #0xff	; 255
	.db #0xf3	; 243
	.db #0xff	; 255
	.db #0xf3	; 243
	.db #0xf7	; 247
	.db #0x0b	; 11
	.db #0xfb	; 251
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
__xinit__BG:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x13	; 19
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x09	; 9
	.db #0x02	; 2
	.db #0x0a	; 10
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0b	; 11
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0b	; 11
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0b	; 11
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0b	; 11
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0b	; 11
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0b	; 11
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0b	; 11
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0b	; 11
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x12	; 18
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
__xinit__HUD:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x2c	; 44
	.db #0x32	; 50	'2'
	.db #0x32	; 50	'2'
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x2c	; 44
	.db #0x32	; 50	'2'
	.db #0x32	; 50	'2'
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x32	; 50	'2'
	.db #0x32	; 50	'2'
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0xff	; 255
__xinit__Coin:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0xa9	; 169
	.db #0x81	; 129
	.db #0xfd	; 253
	.db #0x81	; 129
	.db #0xa3	; 163
	.db #0x81	; 129
	.db #0xbd	; 189
	.db #0x81	; 129
	.db #0xa3	; 163
	.db #0x81	; 129
	.db #0xfd	; 253
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x6a	; 106	'j'
	.db #0x42	; 66	'B'
	.db #0x7a	; 122	'z'
	.db #0x42	; 66	'B'
	.db #0x66	; 102	'f'
	.db #0x42	; 66	'B'
	.db #0x7a	; 122	'z'
	.db #0x42	; 66	'B'
	.db #0x66	; 102	'f'
	.db #0x42	; 66	'B'
	.db #0x7a	; 122	'z'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x24	; 36
	.db #0x3c	; 60
	.db #0x24	; 36
	.db #0x3c	; 60
	.db #0x24	; 36
	.db #0x3c	; 60
	.db #0x24	; 36
	.db #0x3c	; 60
	.db #0x24	; 36
	.db #0x3c	; 60
	.db #0x24	; 36
	.db #0x3c	; 60
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
__xinit__Water:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x24	; 36
	.db #0x3c	; 60
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
__xinit___countBrick:
	.db #0x05	; 5
__xinit___countStone:
	.db #0x02	; 2
__xinit___countCoin:
	.db #0x03	; 3
__xinit___countWater:
	.db #0x03	; 3
__xinit___player:
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0x01	;  1
	.dw #0x0000
	.dw #0x03e8
__xinit___bonus:
	.db #0x00	; 0
	.db #0x00	; 0
	.area _CABS (ABS)
