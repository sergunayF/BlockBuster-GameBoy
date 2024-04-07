#include "Draw.h"



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



