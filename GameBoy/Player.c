#include "Player.h"


void _movement(UINT8 _dir) {

	switch (_dir) {

	case 1:
		if (field[_player.x + 1][_player.y] == 0 && _player.x + 1 < fieldX) { _player.x += 1; return _movement(_dir); }
		if (field[_player.x + 1][_player.y] == 2 || field[_player.x + 1][_player.y] == 3) { field[_player.x + 1][_player.y] += 1; break; }
		if (field[_player.x + 1][_player.y] == 4) { field[_player.x + 1][_player.y] = 0; _countBrick += 1; _player.exp += 10; DrawUI(); break; }
		if (field[_player.x + 1][_player.y] == 5) { field[_player.x + 1][_player.y] = 0; _countCoin += 1; _player.exp += 30; DrawUI(); break; }
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