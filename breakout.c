/*
 * breakout.c
 *
 *  Created on: Sep 10, 2024
 *      Author: Shan
 */
#include "fpga_games/breakout.h"
#include <stdio.h>
#include "platform.h"
#include "xgpio.h"
#include "xparameters.h"
#include "xil_printf.h"
#include "sleep.h"
#include "xuartps_hw.h"
#include <ctype.h>  // for isxdigit()
#include "reading.h"
#include "inc/drawer.h"


const int width = 640;
const int height = 480;
const int background_C = 0x00FFFF;

const int padle_height = 15;
const int padle_width = 100;
int padle_y = height - padle_height*3;
int padle_initial_x = width/2-padle_width/2;
int padle_c = 0xfcff00;

const int ball_r = 16;
int ball_initial_x = width / 2;
int ball_initial_y = height - ball_r*3;
int ball_c = 0xdddbdf;
int ball_speed_x = 1;
int ball_speed_y = 1;

const int brick_height = 30;
const int brick_width = 60;
int brick_y = height/2 - 3*brick_height;
int brick_x0 = width/2 - brick_width - 1;
int brick_x1 = width/2 + 1;
int brick_c = 0xdffb22;

void play_breakout(){

	init_drawer();
	draw_rect(31, 0, 0, width, height, background_C); //background

	draw_circle(0, ball_initial_x, ball_initial_y, ball_r, ball_c);

	draw_rect(0, padle_initial_x, padle_y, padle_width, padle_height, padle_c);
	draw_rect(1, brick_x0, brick_y, brick_width,brick_height,brick_c);
	draw_rect(2, brick_x1, brick_y, brick_width,brick_height,brick_c);

	int x, y;

	while(1) {
		x = get_circle_x(0);
		y = get_circle_y(0);

		if (x >= width - ball_r) {
			ball_speed_x = -1;
			//break;
		} else if (x <= ball_r) {
			ball_speed_x = 1;
			//break;
	   	} else if (get_rect_at(x - ball_r,y) != -1){
	   		ball_speed_x = 1;
	   		remove_rect(get_rect_at(x-ball_r,y));

	   	} else if (get_rect_at(x + ball_r,y) != -1){
	   		ball_speed_x = -1;
	   		remove_rect(get_rect_at(x + ball_r,y));

	   	}

	   	if (y >= height - ball_r) {
	   		ball_speed_y = -1;
	   	} else if (y <= ball_r) {
	   		ball_speed_y = 1;
	   	} else if(get_rect_at(x, y - ball_r) != -1) {
	   		ball_speed_y = 1;
	   		remove_rect(get_rect_at(x, y - ball_r));
	   	} else if(get_rect_at(x, y + ball_r) != -1) {
	   		ball_speed_y = -1;
	   		remove_rect(get_rect_at(x, y + ball_r));
	   	}

	   	move_circle(0, ball_speed_x, ball_speed_y);
	   	usleep(6000);
	   	char key = read_key();
//	   	int p_speed = 10;
	   	if (key == 'a') {
	   		move_rect(0,-5,0);

  	    } else if (key == 'd') {
  	    	move_rect(0,5,0);
     	}

	}

}











