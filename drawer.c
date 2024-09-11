#include "inc/drawer.h"
#include "platform.h"
#include "xgpio.h"
#include "xparameters.h"
#include "xil_printf.h"

#define N_CIRCLES 32
#define N_RECTS 32
#define N_TRIANGLES 8
#define X_MAX 639
#define Y_MAX 479

struct circle circles[N_CIRCLES];
struct rect rects[N_RECTS];
struct triangle triangles[N_TRIANGLES];

XGpio out_instr, read_adr, write_adr, read, write, instr;

void init_xgpios() {
	XGpio_Initialize(&out_instr, XPAR_AXI_GPIO_0_DEVICE_ID);
	XGpio_Initialize(&read_adr, XPAR_AXI_GPIO_1_DEVICE_ID);
	XGpio_Initialize(&write_adr, XPAR_AXI_GPIO_2_DEVICE_ID);
	XGpio_Initialize(&read, XPAR_AXI_GPIO_3_DEVICE_ID);
	XGpio_Initialize(&write, XPAR_AXI_GPIO_4_DEVICE_ID);
	XGpio_Initialize(&instr, XPAR_AXI_GPIO_5_DEVICE_ID);
	// Data Direction Reg (input is 1, output is 0)
	XGpio_SetDataDirection(&out_instr, 1, 1);
	XGpio_SetDataDirection(&read_adr, 1, 0);
	XGpio_SetDataDirection(&write_adr, 1, 0);
	XGpio_SetDataDirection(&read, 1, 0);
	XGpio_SetDataDirection(&write, 1, 0);
	XGpio_SetDataDirection(&instr, 1, 0);
}

void init_drawer() {
	init_xgpios();

	XGpio_DiscreteWrite(&write, 1, 1);

	for (int i = 0; i < N_CIRCLES; i++) {
		circles[i].color = 0;
		circles[i].x = 0;
		circles[i].y = 0;
		circles[i].rad = 0;
		circles[i].on = false;
	}

	for (int i = 0; i < N_RECTS; i++) {
		rects[i].color = 0;
		rects[i].height = 0;
		rects[i].width = 0;
		rects[i].x = 0;
		rects[i].y = 0;
		rects[i].on = false;
	}

	for (int i = 0; i < N_TRIANGLES; i++) {
		triangles[i].x0 = 0;
		triangles[i].y0 = 0;
		triangles[i].x1 = 0;
		triangles[i].y1 = 0;
		triangles[i].x2 = 0;
		triangles[i].y2 = 0;
		triangles[i].color = 0;
		triangles[i].on = false;
	}
}

//////////////////////////////////////circles
void draw_circle(int index, int x, int y, int rad, int color) {
	if(index >= 0 && index < N_CIRCLES) {
		circles[index].color = color & 0xffffff;
		circles[index].on = true;
		circles[index].rad = rad;
		circles[index].x = x;
		circles[index].y = y;

		XGpio_DiscreteWrite(&write_adr, 1, index*2 + 32);
		XGpio_DiscreteWrite(&instr, 1, (rad<<20) | (y<<10) | x);

		XGpio_DiscreteWrite(&write_adr, 1, index*2 + 32 + 1);
		XGpio_DiscreteWrite(&instr, 1, (1<<24) | circles[index].color);
	}
}

void remove_circle(int index) {
	if(index >= 0 && index < N_CIRCLES) {
		circles[index].on = false;
		XGpio_DiscreteWrite(&write_adr, 1, index*2+32 + 1);
		XGpio_DiscreteWrite(&instr, 1, (0<<24) | circles[index].color);
	}
}

void show_circle(int index) {
	if(index >= 0 && index < N_CIRCLES) {
		circles[index].on = true;
		XGpio_DiscreteWrite(&write_adr, 1, index*2+32 + 1);
		XGpio_DiscreteWrite(&instr, 1, (1<<24) | circles[index].color);
	}
}

void move_circle(int index, int x_diff, int y_diff) {
	if(index >= 0 && index < N_CIRCLES) {
//		if (circles[index].x + x_diff < circles[index].rad) {
//			circles[index].x = circles[index].rad;
//		} else if (circles[index].x + x_diff >= X_MAX - circles[index].rad) {
//			circles[index].x = X_MAX - circles[index].rad;
//		} else {
			circles[index].x = circles[index].x + x_diff;
//		}
//
//		if (circles[index].y + y_diff < circles[index].rad) {
//			circles[index].y = circles[index].rad;
//		} else if (circles[index].y + y_diff > Y_MAX - circles[index].rad ) {
//			circles[index].y = Y_MAX - circles[index].rad;
//		} else {
			circles[index].y = circles[index].y + y_diff;
//		}
		XGpio_DiscreteWrite(&write_adr, 1, index*2 + 32);
		XGpio_DiscreteWrite(&instr, 1, (circles[index].rad<<20) | (circles[index].y<<10) | circles[index].x);
	}
}
/////////////////////////////////////////////////////////rect
void draw_rect(int index, int x, int y, int width, int height, int color) {
	if(index >= 0 && index < N_RECTS) {
		rects[index].color = color & 0xffffff;
		rects[index].width = width;
		rects[index].height = height;
		rects[index].x = x;
		rects[index].y = y;
		rects[index].on = true;

		XGpio_DiscreteWrite(&write_adr, 1, index*3 + 96);
		XGpio_DiscreteWrite(&instr, 1, (y<<10) | x);

		XGpio_DiscreteWrite(&write_adr, 1, index*3 + 96 + 1);
		XGpio_DiscreteWrite(&instr, 1, (height<<10) | width);

		XGpio_DiscreteWrite(&write_adr, 1, index*3 + 96 + 2);
		XGpio_DiscreteWrite(&instr, 1, (1<<24) | rects[index].color);
	}
}

void remove_rect(int index) {
	if(index >= 0 && index < N_RECTS) {
		rects[index].on = false;
		XGpio_DiscreteWrite(&write_adr, 1, index*3 + 96 + 2);
		XGpio_DiscreteWrite(&instr, 1, (0<<24) | rects[index].color);
	}
}

void show_rect(int index) {
	if(index >= 0 && index < N_RECTS) {
		rects[index].on = true;
		XGpio_DiscreteWrite(&write_adr, 1, index*3 + 96 + 1);
		XGpio_DiscreteWrite(&instr, 1, (1<<24) | rects[index].color);
	}
}

void move_rect(int index, int x_diff, int y_diff) {
	if(index >= 0 && index < N_RECTS) {
		if (rects[index].x + x_diff < 0) {
			rects[index].x = 0;
		} else if (rects[index].x + rects[index].width + x_diff >= X_MAX) {
			rects[index].x = X_MAX - rects[index].width;
		} else {
			rects[index].x = rects[index].x + x_diff;
		}

		if (rects[index].y + y_diff < 0) {
			rects[index].y = 0;
		} else if (rects[index].y + rects[index].height + y_diff >= Y_MAX) {
			rects[index].y = Y_MAX - rects[index].height;
		} else {
			rects[index].y = rects[index].y + y_diff;
		}

		XGpio_DiscreteWrite(&write_adr, 1, index*3 + 96);
		XGpio_DiscreteWrite(&instr, 1, (rects[index].y<<10) | rects[index].x);
	}
}
//////////////////////////triangle

void draw_triangle(int index, int x0, int y0, int x1, int y1, int x2, int y2, int color) {
	if(index >= 0 && index < N_TRIANGLES) {
		triangles[index].color = color & 0xffffff;
		triangles[index].x0 = x0;
		triangles[index].y0 = y0;
		triangles[index].x1 = x1;
		triangles[index].y1 = y1;
		triangles[index].x2 = x2;
		triangles[index].y2 = y2;
		triangles[index].on = true;

		XGpio_DiscreteWrite(&write_adr, 1, index*4);
		XGpio_DiscreteWrite(&instr, 1, (y0<<10) | x0);

		XGpio_DiscreteWrite(&write_adr, 1, index*4 + 1);
		XGpio_DiscreteWrite(&instr, 1, (y1<<10) | x1);

		XGpio_DiscreteWrite(&write_adr, 1, index*4 + 2);
		XGpio_DiscreteWrite(&instr, 1, (y2<<10) | x2);

		XGpio_DiscreteWrite(&write_adr, 1, index*4 + 3);
		XGpio_DiscreteWrite(&instr, 1, (1<<24) | triangles[index].color);
	}
}

void remove_triangle(int index) {
	if(index >= 0 && index < N_TRIANGLES) {
		triangles[index].on = false;
		XGpio_DiscreteWrite(&write_adr, 1, index*4 + 3);
		XGpio_DiscreteWrite(&instr, 1, (0<<24) | triangles[index].color);
	}
}

void show_triangle(int index) {
	if(index >= 0 && index < N_RECTS) {
		rects[index].on = true;
		XGpio_DiscreteWrite(&write_adr, 1, index*4 + 3);
		XGpio_DiscreteWrite(&instr, 1, (1<<24) | triangles[index].color);
	}
}

void move_triangle(int index, int x_diff, int y_diff) {
	if(index >= 0 && index < N_TRIANGLES) {
		if ((triangles[index].x0 + x_diff <= 0)
				||(triangles[index].x1 + x_diff <= 0)||
				(triangles[index].x2 + x_diff <= 0)) {

		} else if (((triangles[index].x0 + x_diff >= X_MAX)
				||(triangles[index].x1 + x_diff >= X_MAX)||
				(triangles[index].x2 + x_diff >= X_MAX))) {

		} else {
			triangles[index].x0 = triangles[index].x0 + x_diff;
			triangles[index].x1 = triangles[index].x1 + x_diff;
			triangles[index].x2 = triangles[index].x2 + x_diff;
		}

		if ((triangles[index].y0 + y_diff <= 0)
			||(triangles[index].y1 + y_diff <= 0)||
			(triangles[index].y2 + y_diff <= 0)) {

		} else if (((triangles[index].y0 + y_diff >= Y_MAX)
			||(triangles[index].y1 + y_diff >= Y_MAX)||
			(triangles[index].y2 + y_diff >= Y_MAX))) {

		} else {
			triangles[index].y0 = triangles[index].y0 + y_diff;
			triangles[index].y1 = triangles[index].y1 + y_diff;
			triangles[index].y2 = triangles[index].y2 + y_diff;
		}

		XGpio_DiscreteWrite(&write_adr, 1, index*4);
		XGpio_DiscreteWrite(&instr, 1, (triangles[index].y0<<10) | triangles[index].x0);

		XGpio_DiscreteWrite(&write_adr, 1, index*4 + 1);
		XGpio_DiscreteWrite(&instr, 1, (triangles[index].y1<<10) | triangles[index].x1);

		XGpio_DiscreteWrite(&write_adr, 1, index*4 + 2);
		XGpio_DiscreteWrite(&instr, 1, (triangles[index].y2<<10) | triangles[index].x2);
	}
}
	/////////////////////////
	int get_rect_at(int x, int y){
		for (int i = 0; i < N_RECTS; i++) {

			if(rects[i].on == true){

				if((x >= rects[i].x && x <= rects[i].x + rects[i].width)&&
				   (y >= rects[i].y && y <= rects[i].y + rects[i].height)){
					return i;
				}
			}

		}
		return -1;
	}

	int get_circle_x(int index) {
		return (circles[index].x);
	}

	int get_circle_y(int index) {
		return circles[index].y;
	}

	int get_circle_r(int index) {
		return circles[index].rad;
	}

	int rect_contains_xy(int index, int x, int y){
		if(rects[index].on){
			if((rects[index].x >= x && x <= rects[index].x + rects[index].width) &&
				(rects[index].y >= y && y <= rects[index].y + rects[index].height)){
				return 1;

			}

		}
		return 0;
	}

