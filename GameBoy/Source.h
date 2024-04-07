#pragma once
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

//Related to "Source.c" :
INT16 field[fieldX][fieldY + 1];
void _fieldInit(void);
UINT32 power(UINT8 num, UINT8 pow);

//========================================================================
//Related to "Draw.c" :
UINT8 _countBrick = 5;
UINT8 _countStone = 2;
UINT8 _countCoin = 3;
UINT8 _countWater = 3;

typedef struct bonus {

	UINT8 frame;
	UINT8 anim;

} bonus;

bonus _bonus = { 0, 0 };

//========================================================================
//Related to "Player.c" :
typedef struct player {

	INT8 x;
	INT8 y;

	INT8 sprX;
	INT8 sprY;

	INT8 level;
	INT16 exp;
	INT16 water;

} player;

player _player = { 0, 0, 0, 0, 1, 0, 1000 };

