/*
 * pong.c
 *
 *  Created on: Sep 10, 2024
 *      Author: Shan
 */
#include "fpga_games/pong.h"
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

int ball_initial_x = width / 2;
int ball_initial_y = height / 2;
int ball_r = 16;
int ball_c = 0xd00bff;
int ball_speed_x = 1;
int ball_speed_y = 1;

const int padle_height = 100;
const int padle_width = 15;
int padle_initial_y = height/2 - padle_height/2;
int padle_x0 = 2*padle_width;
int padle_x1 = width-3*padle_width;
int padle_c = 0xff0fff;


void play_pong(){

	init_drawer();
	draw_rect(31, 0, 0, width, height, background_C); //background

	draw_circle(0, ball_initial_x, ball_initial_y, ball_r, ball_c);
	draw_rect(0, padle_x0, padle_initial_y, padle_width, padle_height, padle_c);
	draw_rect(1, padle_x1, padle_initial_y, padle_width, padle_height, padle_c);
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
	   	}

	   	if (y >= height - ball_r) {

	   		ball_speed_y = -1;
	   		y = height - ball_r;
	   	} else if (y <= ball_r) {

	   		ball_speed_y = 1;
	   		y = ball_r;
	   	} else if(get_rect_at(x - ball_r, y) == 0) {
	   		ball_speed_x = 1;
	   	} else if(get_rect_at(x + ball_r, y) == 1) {
	   		ball_speed_x = -1;
	   	}

	   	move_circle(0, ball_speed_x, ball_speed_y);
	   	usleep(6000);
	   	char key = read_key();
//	   	int p_speed = 10;
	   	if (key == 'w') {
	   		move_rect(0,0,-5);

  	    } else if (key == 's') {
  	    	move_rect(0,0,5);
     	} else if (key == 'i') {
     		move_rect(1,0,-5);
     	} else if (key == 'k') {
     		move_rect(1,0,5);
     	}

	}
	return;

}

