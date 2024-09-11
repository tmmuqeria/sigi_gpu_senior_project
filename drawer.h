#ifndef __DRAWER_H
#define __DRAWER_H

#define bool unsigned char
#define true 1
#define false 0



void init_drawer();
////////////circle
struct circle {
	int x;
	int y;
	int rad;
	int color;
	bool on;
};
void draw_circle(int index, int x, int y, int rad, int color);
void remove_circle(int index);
void show_circle(int index);
void move_circle(int index, int x_diff, int y_diff);
//////////////rect
struct rect {
	int x;
	int y;
	int width;
	int height;
	int color;
	bool on;
};

void draw_rect(int index, int x, int y, int width, int height, int color);
void remove_rect(int index);
void show_rect(int index);
void move_rect(int index, int x_diff, int y_diff);
/////////////////////triangle
struct triangle {
	int x0;
	int y0;
	int x1;
	int y1;
	int x2;
	int y2;
	int color;
	bool on;
};

void draw_triangle(int index, int x0, int y0, int x1, int y1, int x2, int y2, int color);
void remove_triangle(int index);
void show_triangle(int index);
void move_triangle(int index, int x_diff, int y_diff);

///////// get
int get_rect_at(int x, int y);
int get_circle_x(int index);
int get_circle_y(int index);
int get_circle_r(int index);
int rect_contains_xy(int index, int x, int y);

#endif
