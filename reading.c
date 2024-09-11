/*
 * reading.c
 *
 *  Created on: Sep 10, 2024
 *      Author: Shan
 */
#include "reading.h"
#include <ctype.h>  // for isxdigit()

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "sleep.h"
#include "xuartps_hw.h"


uint8_t read_key() {
	if (XUartPs_IsReceiveData(STDIN_BASEADDRESS)) {
		return XUartPs_ReadReg(STDIN_BASEADDRESS, XUARTPS_FIFO_OFFSET);
	}
	return 0;
}

int hex_char_to_int(char c) {
    if (c >= '0' && c <= '9') {
        return c - '0';
    } else if (c >= 'a' && c <= 'f') {
        return 10 + (c - 'a');
    } else if (c >= 'A' && c <= 'F') {
        return 10 + (c - 'A');
    }
    return -1;  // Return error for non-hex characters
}

int readint_32bit_hex() {
    char8 c;
    int result = 0;

    // Continue reading characters until a newline or non-hex character
    while (1) {
        c = inbyte();
        if (c == '\n' || c == '\r') {
            break;  // End input when newline or carriage return is encountered
        }

        if (isxdigit(c)) {  // Ensure the character is a valid hexadecimal digit
            result = (result << 4) + hex_char_to_int(c);  // Shift and accumulate hex value
        } else {
            break;  // Exit if a non-hexadecimal character is encountered
        }
    }

    return result;
}


int readint_32bit() {
    char8 c;
    int result = 0;
    int is_negative = 0;

    // Read the first character to check for a negative sign
    c = inbyte();

    // Check if the number is negative
    if (c == '-') {
        is_negative = 1;
        c = inbyte();  // Read the next character
    }

    // Continue reading characters until a newline or non-digit character
    while (c != '\n' && c != '\r') {  // Assume '\n' or '\r' as end of input
        if (isdigit(c)) {  // Ensure the character is a digit
            result = result * 10 + (c - '0');  // Convert ASCII character to integer and accumulate
        } else {
            break;  // Exit if a non-digit character is encountered
        }
        c = inbyte();  // Read the next character
    }

    // If the number was negative, apply the sign
    if (is_negative) {
        result = -result;
    }

    return result;
}


