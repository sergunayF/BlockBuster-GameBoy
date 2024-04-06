#include <gb/gb.h>
#include <asm/sm83/types.h>
#include <stdio.h>
#include <rand.h>
#include <gbdk/console.h>


#include "sprites/Player.c"
#include "sprites/Brick.c"
#include "sprites/Stone.c"
#include "sprites/BG.c"
#include "sprites/HUD.c"
#include "sprites/Coin.c"
#include "sprites/Water.c"

#define fieldX 8
#define fieldY 4

#define grid 16
#define speed 8

INT16 field[fieldX][fieldY + 1];

UINT8 _countBrick = 5;
UINT8 _countStone = 2;
UINT8 _countCoin = 3;
UINT8 _countWater = 3;

typedef struct player {

	INT8 x;
	INT8 y;

	INT8 sprX;
	INT8 sprY;

	INT8 level;
	INT16 exp;
	INT16 water;

} player;

typedef struct bonus {

	UINT8 frame;
	UINT8 anim;

} bonus;

player _player = { 0, 0, 0, 0, 1, 0, 1000 };
bonus _bonus = { 0, 0 };

void _fieldInit(void) {

	for (INT8 i = 0; i < fieldX; i++) {
		for (INT8 j = 0; j < fieldY; j++) {
			field[i][j] = 0;
		}
	}

	for (INT8 i = 0; i < fieldX; i++) { field[i][4] = -1; }

}

void DrawUI(void);
void DrawWater(UINT8 cnt, UBYTE add);

void _movement(UINT8 _dir) {

	switch (_dir) {

	case 1:
		if (field[_player.x + 1][_player.y] == 0 && _player.x + 1 < fieldX) { _player.x += 1; return _movement(_dir); }
		if (field[_player.x + 1][_player.y] == 2 || field[_player.x + 1][_player.y] == 3) { field[_player.x + 1][_player.y] += 1; break; }
		if (field[_player.x + 1][_player.y] == 4) { field[_player.x + 1][_player.y] = 0; _countBrick += 1; _player.exp += 10;DrawUI(); break; }
		if (field[_player.x + 1][_player.y] == 5) { field[_player.x + 1][_player.y] = 0; _countCoin += 1; _player.exp += 30;DrawUI(); break; }
		if (field[_player.x + 1][_player.y] == 6) { field[_player.x + 1][_player.y] = 0; _countWater += 1; _player.water += 100; DrawWater((_player.water / 100) + 3, 1); break; }
		break;
	case 2:
		if (field[_player.x][_player.y + 1] == 0 && _player.y + 1 < fieldY) { _player.y += 1; return _movement(_dir); }
		if (field[_player.x][_player.y + 1] == 2 || field[_player.x][_player.y + 1] == 3) { field[_player.x][_player.y + 1] += 1; break; }
		if (field[_player.x][_player.y + 1] == 4) { field[_player.x][_player.y + 1] = 0; _countBrick += 1; _player.exp += 10; DrawUI(); break; }
		if (field[_player.x][_player.y + 1] == 5) { field[_player.x][_player.y + 1] = 0; _countCoin += 1; _player.exp += 30; DrawUI(); break; }
		if (field[_player.x][_player.y + 1] == 6) { field[_player.x][_player.y + 1] = 0; _countWater += 1; _player.water += 100; DrawWater((_player.water / 100) + 3, 1); break; }
		break;
	case 3:
		if (field[_player.x - 1][_player.y] == 0 && _player.x - 1 > -1) { _player.x -= 1; return _movement(_dir); }
		if (field[_player.x - 1][_player.y] == 2 || field[_player.x - 1][_player.y] == 3) { field[_player.x - 1][_player.y] += 1; break; }
		if (field[_player.x - 1][_player.y] == 4) { field[_player.x - 1][_player.y] = 0; _countBrick += 1; _player.exp += 10; DrawUI(); break; }
		if (field[_player.x - 1][_player.y] == 5) { field[_player.x - 1][_player.y] = 0; _countCoin += 1; _player.exp += 30; DrawUI(); break; }
		if (field[_player.x - 1][_player.y] == 6) { field[_player.x - 1][_player.y] = 0; _countWater += 1; _player.water += 100; DrawWater((_player.water / 100) + 3, 1); break; }
		break;
	case 4:
		if (field[_player.x][_player.y - 1] == 0 && _player.y - 1 > -1) { _player.y -= 1; return _movement(_dir); }
		if (field[_player.x][_player.y - 1] == 2 || field[_player.x][_player.y - 1] == 3) { field[_player.x][_player.y - 1] += 1; break; }
		if (field[_player.x][_player.y - 1] == 4) { field[_player.x][_player.y - 1] = 0; _countBrick += 1; _player.exp += 10; DrawUI(); break; }
		if (field[_player.x][_player.y - 1] == 5) { field[_player.x][_player.y - 1] = 0; _countCoin += 1; _player.exp += 30; DrawUI(); break; }
		if (field[_player.x][_player.y - 1] == 6) { field[_player.x][_player.y - 1] = 0; _countWater += 1; _player.water += 100; DrawWater((_player.water / 100) + 3, 1); break; }
		break;
	}
}

void _playerDraw(void) {

	set_sprite_tile(0, 0);
	move_sprite(0, 8 + grid + _player.sprX, 16 + (grid * 4) + _player.sprY);
	set_sprite_tile(1, 2);
	move_sprite(1, 8 + grid + _player.sprX + 8, 16 + (grid * 4) + _player.sprY);

}

void _brickDraw(INT8 x, INT8 y, INT8 state, INT8 cnt) {
	
	switch (state) {

	case 2:
		for (UINT8 i = cnt - 2; i < 10; i += 2) {
			set_sprite_tile(2 + i, 4);
			move_sprite(2 + i, 8 + grid + (x * 16), 16 + (grid * 4) + y * 16);
			set_sprite_tile(3 + i, 6);
			move_sprite(3 + i, 8 + grid + (x * 16) + 8, 16 + (grid * 4) + y * 16);
			continue;
		}
		break;

	case 3:
		for (UINT8 i = cnt - 2; i < 10; i += 2) {
			set_sprite_tile(2 + i, 8);
			move_sprite(2 + i, 8 + grid + (x * 16), 16 + (grid * 4) + y * 16);
			set_sprite_tile(3 + i, 10);
			move_sprite(3 + i, 8 + grid + (x * 16) + 8, 16 + (grid * 4) + y * 16);
			continue;
		}
		break;

	case 4:
		for (UINT8 i = cnt - 2; i < 10; i += 2) {
			set_sprite_tile(2 + i, 12);
			move_sprite(2 + i, 8 + grid + (x * 16), 16 + (grid * 4) + y * 16);
			set_sprite_tile(3 + i, 14);
			move_sprite(3 + i, 8 + grid + (x * 16) + 8, 16 + (grid * 4) + y * 16);
			continue;
		}
		break;
	}
}

void _stoneDraw(INT8 x, INT8 y, INT8 cnt) {

	for (UINT8 i = cnt - 2; i < 4; i += 2) {
		set_sprite_tile(12 + i, 16);
		move_sprite(12 + i, 8 + grid + (x * 16), 16 + (grid * 4) + y * 16);
		set_sprite_tile(13 + i, 18);
		move_sprite(13 + i, 8 + grid + (x * 16) + 8, 16 + (grid * 4) + y * 16);
		continue;
	}
}

void _bonusDraw(INT8 x, INT8 y, INT8 cnt, INT8 water) {

	for (UINT8 i = cnt - 1; i < 3; i++) {

		if (water != 0) { set_sprite_tile(16 + i + water, 28); }
		else { set_sprite_tile(16 + i + water, 20 + _bonus.frame); }
		
		move_sprite(16 + i + water, 12 + grid + (x * 16), 16 + (grid * 4) + y * 16);
		continue;
	}
}

void _control(void) {

	switch (joypad()) {

	case J_LEFT: _movement(3); waitpadup(); break;
	case J_RIGHT: _movement(1); waitpadup(); break;
	case J_DOWN: _movement(2); waitpadup(); break;
	case J_UP: _movement(4); waitpadup(); break;

	}
}

void _smoothMove(void) {

	if (_player.sprX < _player.x * grid) {
		_player.sprX += speed;
	}

	if (_player.sprX > _player.x * grid) {
		_player.sprX -= speed;
	}

	if (_player.sprY < _player.y * grid) {
		_player.sprY += speed;
	}

	if (_player.sprY > _player.y * grid) {
		_player.sprY -= speed;
	}
}

void _spawn(UINT8 _block) {

	UINT8 x = ((UINT8)rand()) % fieldX;
	UINT8 y = ((UINT8)rand()) % fieldY;
	UINT8 state = ((UINT8)rand()) % 3;

	if (_block != 2) state = 0;

	if (field[x][y] == 0 && x != (UINT8)_player.x && y != (UINT8)_player.y) field[x][y] = _block + state;
	else _spawn(_block);
}

void _draw(void) {

	UINT8 _cntBrick = 0;
	UINT8 _cntStone = 0;
	UINT8 _cntCoin = 0;
	UINT8 _cntWater = 0;

	for (INT8 i = 0; i < fieldY; i++) {
		for (INT8 j = 0; j < fieldX; j++) {

			if (field[j][i] == 6) { _cntWater += 1; _bonusDraw(j, i, _cntWater, 3); }
			if (field[j][i] == 5) { _cntCoin += 1; _bonusDraw(j, i, _cntCoin, 0); }
			for (UINT8 c = 2; c < 5; c++) { if (field[j][i] == c) { _cntBrick += 2; _brickDraw(j, i, c, _cntBrick); } }
			if (field[j][i] == 1) { _cntStone += 2; _stoneDraw(j, i, _cntStone); }

		}
	}
}

UINT32 power(UINT8 num,UINT8 pow) {
	UINT32 result = 1;
	for (UINT8 i = 0; i < pow; i++) {
		result *= num;
	}
	return result;
}

void DrawUI(void) {
	for (UINT8 i = 0; i < 4; i++) {
		UINT16 mod = ((_player.exp / power(10, i)) % 10) + 20;
		set_bkg_tiles(9-i, 3, 1, 1, &mod);
		UINT16 needmod = (((((_player.level-1) * 400)+300) / power(10, i)) % 10) + 20;
		set_bkg_tiles(14 - i, 3, 1, 1, &needmod);
	}
	UINT8 lvl = (_player.level + 20);
	set_bkg_tiles(8, 1, 1, 1, &lvl);
}

void DrawWater(UINT8 cnt, UBYTE add) {
	if (cnt > 11) return;
	UINT8 tmp;
	if (add) {
		tmp = 30;
		set_bkg_tiles(cnt, 6, 1, 1, &tmp);
	}
	else
		tmp = 0;
		set_bkg_tiles(cnt+1, 6, 1, 1,&tmp );
}
int main(void) {

	_fieldInit();

	SPRITES_8x16;

	set_sprite_data(0, 4, Player);
	set_sprite_data(4, 12, Brick);
	set_sprite_data(16, 4, Stone);
	set_sprite_data(20, 8, Coin);
	set_sprite_data(28, 2, Water);

	set_bkg_data(0, 31, HUD);
	set_bkg_tiles(0, 0, 20, 18, BG);

	initrand(0);



	while (_countStone > 0) { _spawn(1); _countStone -= 1; }
	while (_countBrick > 0) { _spawn(2); _countBrick -= 1; }
	while (_countCoin > 0) { _spawn(5); _countCoin -= 1; }
	while (_countWater > 0) { _spawn(6); _countWater -= 1; }

	SHOW_BKG;
	SHOW_SPRITES;
	DISPLAY_ON;

	DrawUI();

	for (UINT8 i = 0; i < 11; i++) {
		UINT32 mod = 30;
		set_bkg_tiles(2 + i, 6, 1, 1, &mod);
	}

	while (1) {

		if (_player.sprX == _player.x * grid && _player.sprY == _player.y * grid) { _control(); }

		if (_countStone > 0) { _spawn(1); _countStone -= 1; }
		if (_countBrick > 0) { _spawn(2); _countBrick -= 1; }
		if (_countCoin > 0) { _spawn(5); _countCoin -= 1; }
		if (_countWater > 0) { _spawn(6); _countWater -= 1; }

		_playerDraw();
		_smoothMove();
		_draw();

		_bonus.anim++;
		_player.water-=2;
		if (_player.water % 100 == 0) {
			DrawWater((_player.water/100)+3,0);
		}
		if (_player.exp >= ((_player.level - 1) * 400) + 300) _player.level++;
		if (_player.water > 1000) _player.water = 1000;
		if (_bonus.anim >= 8) { _bonus.frame += 2; _bonus.anim = 0; }
		if (_bonus.frame > 6) _bonus.frame = 0;

		wait_vbl_done();
	}
}