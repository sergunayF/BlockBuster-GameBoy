#include "Source.h"
#include "Draw.h"
#include "Player.h"
#include "GUI.h"



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

	InitWaterIndicator();

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
	return 0;
}
