#include "GUI.h"

void DrawUI(void) {
	for (UINT8 i = 0; i < 4; i++) {
		UINT16 mod = ((_player.exp / power(10, i)) % 10) + 20;
		set_bkg_tiles(9 - i, 3, 1, 1, &mod);
		UINT16 needmod = (((((_player.level - 1) * 400) + 300) / power(10, i)) % 10) + 20;
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
	set_bkg_tiles(cnt + 1, 6, 1, 1, &tmp);
}

void InitWaterIndicator(void) {
	for (UINT8 i = 0; i < 11; i++) {
		UINT32 mod = 30;
		set_bkg_tiles(2 + i, 6, 1, 1, &mod);
	}
}