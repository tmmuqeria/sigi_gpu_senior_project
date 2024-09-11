
/*
 *test it
 */

#include <stdio.h>
#include "platform.h"
#include "xgpio.h"
#include "xparameters.h"
#include "xil_printf.h"
#include "sleep.h"
#include "xuartps_hw.h"
/* #include "xil_printf.h"
 * print("Hello World\n\r");
 * */
#include "inc/drawer.h"
#include <ctype.h>  // for isxdigit()
#include "reading.h"
#include "fpga_games/pong.h"
//#include "fpga_games/breakout.h"


int main()
{
    init_platform(); //initialize the platform
    //play_breakout();
    play_pong();
    init_drawer();
//    XGpio out_instr, read_adr, write_adr, read, write, instr;
//    int adr, readd, writee, inst, out_inst, x, y, r;
//    // initialize axi gpio
//    XGpio_Initialize(&out_instr, XPAR_AXI_GPIO_0_DEVICE_ID);
//    XGpio_Initialize(&read_adr, XPAR_AXI_GPIO_1_DEVICE_ID);
//    XGpio_Initialize(&write_adr, XPAR_AXI_GPIO_2_DEVICE_ID);
//    XGpio_Initialize(&read, XPAR_AXI_GPIO_3_DEVICE_ID);
//    XGpio_Initialize(&write, XPAR_AXI_GPIO_4_DEVICE_ID);
//    XGpio_Initialize(&instr, XPAR_AXI_GPIO_5_DEVICE_ID);
//    //code
//    // Data Direction Reg (input is 1, output is 0)
//    XGpio_SetDataDirection(&out_instr, 1, 1);
//    XGpio_SetDataDirection(&read_adr, 1, 0);
//    XGpio_SetDataDirection(&write_adr, 1, 0);
//    XGpio_SetDataDirection(&read, 1, 0);
//    XGpio_SetDataDirection(&write, 1, 0);
//    XGpio_SetDataDirection(&instr, 1, 0);

    //////////
//    adr = 32;
//    readd = 1;
//    writee = 1;
//    inst = 0;
//    print("we are up\n");
//    XGpio_DiscreteWrite(&read_adr, 1, adr);
//    XGpio_DiscreteWrite(&write_adr, 1, adr);
//    XGpio_DiscreteWrite(&read, 1, readd);
//    XGpio_DiscreteWrite(&write, 1, writee);
//    XGpio_DiscreteWrite(&instr, 1, inst);
//    out_inst = XGpio_DiscreteRead(&out_instr, 1);
//    xil_printf("out_inst: %d\n", out_inst);
//
//    uint32_t circle_adr = 32;
//    uint32_t rad = 15;
//    uint32_t dir_x = 2;
//    uint32_t dir_y = 2;
//    x = 50;
//    y = 240;
//    inst = (rad <<  20) | (y << 10) | x;
//	XGpio_DiscreteWrite(&write_adr, 1, circle_adr);
//	XGpio_DiscreteWrite(&instr, 1, inst);
//
//	XGpio_DiscreteWrite(&write_adr, 1, circle_adr + 1);
//	XGpio_DiscreteWrite(&instr, 1, -1);
//
//
//
//
//	int p_width = 175;
//	int p_height = 8;
//	int p_x = 320 - (p_width>>1);
//	int p_y = 420;
//	int p_c = 0x130cfcf;
//	int p_adr = 96;
//
//	XGpio_DiscreteWrite(&write_adr, 1, p_adr);
//	XGpio_DiscreteWrite(&instr, 1, (p_y<<10) | p_x);
//	XGpio_DiscreteWrite(&write_adr, 1, p_adr+1);
//	XGpio_DiscreteWrite(&instr, 1, (p_height << 10) | p_width);
//	XGpio_DiscreteWrite(&write_adr, 1, p_adr+2);
//	XGpio_DiscreteWrite(&instr, 1, p_c);
//
//	int background_adr = 189;
//	int background_width = 639;
//	int background_height = 479;
//	int background_color = 0x10000FF;
//	int background_x = 0;
//	int background_y = 0;
//
//	XGpio_DiscreteWrite(&write_adr, 1, background_adr);
//	XGpio_DiscreteWrite(&instr, 1, (background_y<<10) | background_x);
//	XGpio_DiscreteWrite(&write_adr, 1, background_adr+1);
//	XGpio_DiscreteWrite(&instr, 1, (background_height << 10) | background_width);
//	XGpio_DiscreteWrite(&write_adr, 1, background_adr+2);
//	XGpio_DiscreteWrite(&instr, 1, background_color);

//////////////////
    draw_circle(0, 100, 100, 20, 0xffffff);
//    draw_rect(int index, int x, int y, int width, int height, int color)
    draw_rect(0, 300, 100, 100, 100, 0x0000ff);
    draw_rect(1, 350, 150, 100, 100, 0x00ff00);
    draw_rect(2, 400, 200, 100, 100, 0xff0000);
    draw_rect(3, 450, 250, 100, 100, 0x00ffff);
    draw_rect(4, 500, 300, 100, 100, 0xffff00);
    draw_rect(5, 550, 350, 100, 100, 0xff00ff);

    sleep(5);
    remove_rect(0);
    sleep(1);
    remove_rect(1);
    sleep(1);
    remove_rect(2);
    sleep(1);
    remove_rect(3);
    sleep(1);
    remove_rect(4);

    while(1) {
    	move_rect(5, -2, 0);
    	usleep(6000);


//    	if (x >= 639 - rad) {
//    		dir_x = -dir_x;
//    		x = 639 - rad;
//    	} else if (x <= rad) {
//    		dir_x = -dir_x;
//    		x = rad;
//    	}
//    	if (y >= 479 - rad) {
//    		dir_y = -dir_y;
//    		y = 479 - rad;
//    	} else if (y <= rad) {
//    		dir_y = -dir_y;
//    		y = rad;
//    	} else if(y == (p_y - rad) && (x >= (p_x) && x < (p_x + p_width+rad))) {
//    		dir_y = -dir_y;
//    	}
//
//    	usleep(6000);
//    	x = x + dir_x;
//    	y = y + dir_y;
//    	inst = (rad <<  20) | (y << 10) | x;
//    	XGpio_DiscreteWrite(&write_adr, 1, circle_adr);
//    	XGpio_DiscreteWrite(&instr, 1, inst);
//
//    	char key = read_key();
//    	int p_speed = 10;
//    	if (key == 'a') {
//    		p_x = p_x < p_speed ? 0 : p_x - p_speed;
//    		XGpio_DiscreteWrite(&write_adr, 1, p_adr);
//    		XGpio_DiscreteWrite(&instr, 1, (p_y<<10) | p_x);
//    	} else if (key == 'd') {
//    		p_x = p_x > 639-p_speed-p_width ? 639-p_width : p_x + p_speed;
//			XGpio_DiscreteWrite(&write_adr, 1, p_adr);
//			XGpio_DiscreteWrite(&instr, 1, (p_y<<10) | p_x);
//    	}
//////////////////////////////////////////////////////////////////

//    	print("\n enter adr: ");
//
//    	adr = readint_32bit();
//    	xil_printf(" %d\n",adr);
//    	//////////////
//    	if(adr<32) {
//			if(adr%4 == 3) {
//				print("\n enter color: ");
//				inst = readint_32bit_hex();
//				xil_printf(" %d\n",inst);
//				XGpio_DiscreteWrite(&write_adr,1,adr);
//				XGpio_DiscreteWrite(&instr,1,inst);
//
//			} else {
//				print("\n enter x: ");
//				x = readint_32bit();
//				xil_printf(" %d\n",x);
//				print("\n enter y: ");
//				y = readint_32bit();
//				xil_printf(" %d\n",y);
//				inst = (y <<10) + x;
//				xil_printf(" %d\n",inst);
//				XGpio_DiscreteWrite(&write_adr,1,adr);
//				XGpio_DiscreteWrite(&instr,1,inst);
//
//			}
//			/////////////////////////
//    	}else if(adr < 96) {
//    		if(adr%2==1){
//    			print("\n enter color: ");
//    			inst = readint_32bit_hex();
//   				xil_printf(" %d\n",inst);
//   				XGpio_DiscreteWrite(&write_adr,1,adr);
//   				XGpio_DiscreteWrite(&instr,1,inst);
//     		}else{
//    			print("\n enter x: ");
//    			x = readint_32bit();
//    			xil_printf(" %d\n",x);
//
//    			print("\n enter y: ");
//    			y = readint_32bit();
//    			xil_printf(" %d\n",y);
//
//    			print("\n enter r: ");
//    			r = readint_32bit();
//    			xil_printf(" %d\n",r);
//
//    			inst = (r<<20)+(y <<10) + x;
//    			xil_printf(" %d\n",inst);
//    			XGpio_DiscreteWrite(&write_adr,1,adr);
//    			XGpio_DiscreteWrite(&instr,1,inst);
//
//    		}
//    		//////////////////
//    	} else {
//    		print(">=96");
//    		if(adr%3==2) {
//    		   	print("\n enter color: ");
//     			inst = readint_32bit_hex();
//     			xil_printf(" %d\n",inst);
//    			XGpio_DiscreteWrite(&write_adr,1,adr);
//     			XGpio_DiscreteWrite(&instr,1,inst);
//       		}else if(adr%3==1){
//       			print("\n enter w: ");
//       			x = readint_32bit();
//       			xil_printf(" %d\n",x);
//
//       			print("\n enter h: ");
//    		    y = readint_32bit();
//    		    xil_printf(" %d\n",y);
//
//    		    inst = (y <<10) + x;
//    		    xil_printf(" %d\n",inst);
//    		    XGpio_DiscreteWrite(&write_adr,1,adr);
//    		    XGpio_DiscreteWrite(&instr,1,inst);
//
//    	 	}else{
//       			print("\n enter x: ");
//       			x = readint_32bit();
//       			xil_printf(" %d\n",x);
//
//       			print("\n enter y: ");
//    		    y = readint_32bit();
//    		    xil_printf(" %d\n",y);
//
//    		    inst = (y <<10) + x;
//    		    xil_printf(" %d\n",inst);
//    		    XGpio_DiscreteWrite(&write_adr,1,adr);
//    		    XGpio_DiscreteWrite(&instr,1,inst);
//
//    	 	}
//
//    	}


    }
////////////////////////////////
    cleanup_platform();
    return 0;
}
