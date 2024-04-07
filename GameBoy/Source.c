#include "Source.h"

//Assistance functions

void _fieldInit(void) {

	for (INT8 i = 0; i < fieldX; i++) {
		for (INT8 j = 0; j < fieldY; j++) {
			field[i][j] = 0;
		}
	}

	for (INT8 i = 0; i < fieldX; i++) { field[i][4] = -1; }

}

UINT32 power(UINT8 num, UINT8 pow) {
	UINT32 result = 1;
	for (UINT8 i = 0; i < pow; i++) {
		result *= num;
	}
	return result;
}