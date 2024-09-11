`timescale 1ns / 1ps

module triangle_rasterization(
    input [15:0] top_x, top_y, // Top point of the triangle
    input [15:0] mid_x, mid_y, // Middle point of the triangle
    input [15:0] bot_x, bot_y, // Bottom point of the triangle
    input start,               // Start signal
    input clk,                 // Clock signal
    output reg done,           // Done signal
    output reg [15:0] x, y     // Output point coordinates
);

    reg [15:0] current_x, current_y; // Current point being processed
    reg [15:0] x_start, x_end;       // Start and end x coordinates for the current scanline
    reg [15:0] delta_x1, delta_x2;   // Delta x for edges
    reg [15:0] y_min, y_max;         // Minimum and maximum y coordinates for the triangle
    reg [15:0] x1, x2;               // Temporary x coordinates for interpolation
    reg [31:0] acc1, acc2;           // Accumulators for interpolation
    reg [31:0] step1, step2;         // Step sizes for interpolation
    reg processing;                  // Flag to indicate processing state

    // State machine states
    localparam IDLE = 2'b00;
    localparam SCANLINE = 2'b01;
    localparam FINISH = 2'b10;

    reg [1:0] state; // Register to hold the current state

    always @(posedge clk) begin
        if (start && !processing) begin
            // Start the rasterization process
            processing <= 1;
            state <= IDLE;
            done <= 0;
        end else if (processing) begin
            case (state)
                IDLE: begin
                    // Initialize the rasterization process
                    y_min <= bot_y;
                    y_max <= top_y;

                    current_y <= bot_y;
                    x1 <= bot_x;
                    x2 <= bot_x;

                    delta_x1 <= (top_x - bot_x) / (top_y - bot_y);
                    delta_x2 <= (mid_x - bot_x) / (mid_y - bot_y);

                    acc1 <= 0;
                    acc2 <= 0;
                    step1 <= (top_x - bot_x) << 16 / (top_y - bot_y);
                    step2 <= (mid_x - bot_x) << 16 / (mid_y - bot_y);

                    state <= SCANLINE;
                end

                SCANLINE: begin
                    // Output points for the current scanline
                    if (current_y <= y_max) begin
                        if (current_y == mid_y) begin
                            // Switch to the second edge after reaching mid_y
                            delta_x2 <= (top_x - mid_x) / (top_y - mid_y);
                            step2 <= (top_x - mid_x) << 16 / (top_y - mid_y);
                            acc2 <= 0;
                            x2 <= mid_x;
                        end

                        // Calculate the x start and end for the scanline
                        x_start <= x1;
                        x_end <= x2;

                        // Output points between x_start and x_end
                        for (current_x = x_start; current_x <= x_end; current_x = current_x + 1) begin
                            x <= current_x;
                            y <= current_y;
                        end

                        // Update the x interpolation values
                        x1 <= x1 + delta_x1;
                        x2 <= x2 + delta_x2;
                        acc1 <= acc1 + step1;
                        acc2 <= acc2 + step2;

                        // Move to the next scanline
                        current_y <= current_y + 1;
                    end else begin
                        // Move to the FINISH state when done
                        state <= FINISH;
                    end
                end

                FINISH: begin
                    done <= 1;
                    state <= IDLE;
                    processing <= 0; // Reset processing flag
                end
            endcase
        end
    end

endmodule
