#pragma once
#include <gb/gb.h>
#include "Source.h"
//#include "Player.h"

void _draw(void);
void _playerDraw(void);
void _brickDraw(INT8 x, INT8 y, INT8 state, INT8 cnt);
void _stoneDraw(INT8 x, INT8 y, INT8 cnt);
void _bonusDraw(INT8 x, INT8 y, INT8 cnt, INT8 water)