/*
 * DXBall.c
 *
 * Created: 22-Oct-15 4:27:35 PM
 *  Author: Zubaer & Mazhar
 *  sudo avrdude -c usbasp -p m32 -u -U flash:w:DXBall.hex
 */

#define F_CPU 1000000UL
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#define LIFE 3
#define WELCOME 0
#define GAME_OVER 1
#define R 16
#define C 16
#define MAXLVL 2
#define SCRDELAY 120
#define leftSensor 0
#define THRESHOLD 3

volatile int8_t current_level, is_paused, barL, barR, dx, dy, life_remaining,
		pos_x, pos_y, tmr_cntr, doIncrease;

const int8_t velocity[MAXLVL] = { 2, 2, 1 };
const int16_t constantPattern[MAXLVL + 2][16] =
		{
				{ 0x0000, 0x0000, 0x0004, 0x007C, 0x0000, 0x1B04, 0x047C,
						0x1B00, 0x003C, 0x0E50, 0x113C, 0x1F00, 0x0028, 0x0054,
						0x007C, 0x0000 }, { 0x152C, 0x1550, 0x1F7C, 0x0000,
						0x1F54, 0x0854, 0x1F7C, 0x0000, 0x0F78, 0x140C, 0x0F78,
						0x0000, 0x1738, 0x1144, 0x0E38, 0x0000 }, { 0x0100,
						0x1F00, 0x0000, 0x1500, 0x1F00, 0x0000, 0x1E02, 0x037E,
						0x1E22, 0x0000, 0x1500, 0x1F00, 0x0000, 0x0100, 0x1F00,
						0x0000 }, { 0x0100, 0x1F00, 0x0000, 0x1500, 0x1F00,
						0x0000, 0x1E74, 0x0354, 0x1E5C, 0x0000, 0x1500, 0x1F00,
						0x0000, 0x0100, 0x1F00, 0x0000 }/*, { 0x0100, 0x1F00,
						0x0000, 0x1500, 0x1F00, 0x0000, 0x1E7C, 0x0354, 0x1E54,
						0x0000, 0x1500, 0x1F00, 0x0000, 0x0100, 0x1F00, 0x0000 }*/ };
const int16_t pattern[MAXLVL][R] = { { 0b0000000000000000, 0b0000000000000000,
		0b0000000000000000, 0b0000000000000000, 0b1111111111111111,
		0b0111111111111110, 0b0011111111111100, 0b0001111111111000,
		0b0000111111110000, 0b0000011111100000, 0b0000000000000000,
		0b0000000000000000, 0b0000000000000000, 0b0000000000000000,
		0b0000000000000000, 0b0000000000000000 }, { 0b0000000000000000,
		0b0000000000000000, 0b0000111111110000, 0b0000000000000000,
		0b1111000000001111, 0b0000000000000000, 0b0000111111110000,
		0b0000000000000000, 0b1111001111001111, 0b0000000000000000,
		0b0000000000000000, 0b0000111111110000, 0b0000000000000000,
		0b0000000000000000, 0b0000000000000000, 0b0000000000000000 }/*, {
		0b0000000000000000, 0b0000000000000000, 0b1001001111001001,
		0b1001001111001001, 0b1111001111001111, 0b1001001111001001,
		0b1001001111001001, 0b1001001111001001, 0b1111001111001111,
		0b1001001111001001, 0b1001001111001001, 0b1001001111001001,
		0b1001001111001001, 0b1111001111001111, 0b0000000000000000,
		0b0000000000000000 }*/ };
volatile int16_t board[C];

uint16_t readSensor(uint8_t ch) {

	ADMUX |= ch;
	ADCSRA |= (1 << ADSC);
	while (ADCSRA & (1 << ADSC))
		;
	return (ADC);
}

void drawColumn(int8_t c, uint16_t pattern) {
	if (c < 8) {
		PORTC = 1 << 3;
		PORTC |= (c & 0x07);
	} else {
		c = c - 8;
		PORTC = 1 << 4;
		PORTC |= (c & 0x07);
	}
	int8_t halfPattern = pattern;
	PORTB = halfPattern;
	halfPattern = pattern >> 8;
	PORTD = halfPattern;
}

void Show(int8_t source) {

	int8_t i, j, brick_remaining = 0;
	if (source < MAXLVL + 2) {
		for (i = 0; i < C; i++) {
			drawColumn(i, constantPattern[source][i]);
			_delay_ms(1);
		}
	} else {

		for (i = 0; i < life_remaining; i++) {
			board[i] |= 0x8000;
		}
		for (; i < LIFE; i++) {
			board[i] &= 0x7FFF;
		}

		for (i = 0; i < C; i++) {
			for (j = 0; j < R; j++) {
				if (board[i] & (1 << j)) {
					brick_remaining++;
				}
			}
			drawColumn(i, board[C - i - 1]);
			_delay_loop_1(100);
		}

		if (brick_remaining - life_remaining - 5 <= -2 && pos_y>1) {
			doIncrease = 1;
		} else {
			doIncrease = 0 ;
		}
	}
}

void restart(int incr,int refresh) {

	int8_t i, j;
	int16_t cnt;
	current_level = (current_level + incr) % MAXLVL ;
	for (cnt = 0; cnt < SCRDELAY; cnt++) {
		Show(current_level + 2);
	}

	if (refresh == 1) { // the board will be refreshed
		for (i = 0; i < C; i++) {
			board[i] = 0x0000;
		}

		for (i = 0; i < R; i++) {
			for (j = 0; j < C; j++) {
				if ((pattern[current_level][i] & (1 << j)) != 0) {
					board[j] |= 1 << (C - i);
				}
			}
		}
	}

	dx = 1 ;
	dy = 1 ;
	pos_x = C / 2;
	pos_y = 1;
	barL = C / 2 - 2;
	barR = C / 2 + 1;
	for (i = barL; i <= barR; i++) {
		board[i] |= 0x0001;
	}
	board[pos_x] |= (1 << pos_y);
}


ISR(TIMER1_OVF_vect) {
	if(PINC & (1<<5)){
		goto _return ;
	}
	tmr_cntr++;
	int8_t done = 1,i;
	if (tmr_cntr == velocity[current_level]) {
		int16_t temp;
		int16_t leftRange = 0;
		for (i = 0; i < THRESHOLD; i++) {
			temp = readSensor(leftSensor);
			/*if (temp > leftRange) {
				leftRange = temp;
			}*/
			leftRange += temp;
		}

		int16_t centerPos = (leftRange/(30*THRESHOLD)) - 10;
		if (centerPos < 2) {
			centerPos = 2;
		}
		if (centerPos > 14) {
			centerPos = 14;
		}
		for (i = barL; i <= barR; i++) {
			board[i] &= 0xFFFE;
		}
		barL = centerPos - 2;
		barR = centerPos + 1;
		for (i = barL; i <= barR; i++) {
			board[i] |= 0x0001;
		}
		while (done) {
			tmr_cntr = 0;
			int8_t prev_dx = dx;
			int8_t prev_dy = dy;
			int8_t next_x = pos_x + dx;
			int8_t next_y = pos_y + dy;

			if ((next_x < C && next_x >= 0
					&& (board[next_x] & (1 << pos_y)) != 0) || next_x >= C
					|| next_x < 0) {
				dx = dx * (-1);
			}

			if ((next_y < R - 1 && next_y >= 0
					&& (board[pos_x] & (1 << next_y)) != 0) || next_y >= R - 1
					|| next_y < 0) {
				dy = dy * (-1);
			}

			if (((next_x < C && next_x >= 0 && next_y < R - 1 && next_y >= 0
					&& (board[next_x] & (1 << next_y)) != 0)
					|| ((next_x >= C || next_x < 0)
							&& (next_y >= R - 1 && next_y < 0)))
					&& prev_dx == dx && prev_dy == dy) {
				dx = dx * (-1);
				dy = dy * (-1);
			}

			if (prev_dx != dx || prev_dy != dy) {
				if (next_x < C && next_x >= 0) {
					board[next_x] &= ~(1 << pos_y);
				}
				if (next_y < R - 1 && next_y >= 0) {
					board[pos_x] &= ~(1 << (next_y));
				}
				if (next_x < C && next_y >= 0 && next_y < R - 1
						&& next_y >= 0) {
					board[next_x] &= ~(1 << (next_y));
				}
			}

			if (board[pos_x + dx] & (1 << (pos_y + dy))) {
				board[pos_x + dx] &= ~(1 << (pos_y + dy));
				dx *= -1;
				dy *= -1;
			} else {
				done = 0;
			}
			board[pos_x] &= ~(1 << pos_y);
			pos_x = pos_x + dx;
			pos_y = pos_y + dy;
			board[pos_x] |= (1 << pos_y);
		}
		if (pos_y == 0) {
			//life_remaining-- ;
			if (life_remaining == 0) {
				while (1) {
					Show(GAME_OVER);
				}
			}
			restart(0,0);
		}
	}
	_return: ;
}

int main(void) {

	DDRB = 0xFF;
	DDRC = 0b11011111;
	DDRD = 0xFF;

	TCCR1A = 0x00;
	TCCR1B = 0x01;

	TIMSK = 0x04;

	ADMUX = (1 << REFS0);
	ADCSRA = (1 << ADEN) | (1 << ADPS2) | (1 << ADPS1) | (1 << ADPS0);

	MCUCSR = (1 << JTD);
	MCUCSR = (1 << JTD);

	int16_t cnt;
	current_level = 0;
	tmr_cntr = 0;

	life_remaining = LIFE;
	/*
	for (cnt = 0; cnt < SCRDELAY; cnt++) {
		Show(WELCOME);
	}
	*/
	restart(0,1);
	sei();

	while (1) {
		doIncrease = 0;

		Show(100);
		if (doIncrease == 1) {
			restart(1,1);
		}
	}
	cli();

	return 0;
}
