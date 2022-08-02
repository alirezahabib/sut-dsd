`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:40:22 07/16/2022 
// Design Name: 
// Module Name:    sensor_memory 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module sensor_memory(
    input [7:0] temp,
    input [7:0] duration,
    input clock,
    input reset,
    output reg [7:0] average_temp,
    output latest_temp
    );

    reg [7:0] temps [0:199];
    reg [7:0] i;
    reg [15:0] sum;

    assign latest_temp = temps[0];

    always @(posedge clock) begin
        if (reset) begin
            average_temp = 0;
            for (i = 0; i < 200; i = i + 1) temps[i] = 0;
        end else begin
            for (i = 0; i < 199; i = i + 1) temps[i + 1] = temps[i];
            temps[0] = temp;
            sum = 0;
            for (i = 0; i < 200; i = i + 1) sum = sum + temps[i] * (i < duration);
            average_temp = sum / duration;
        end
    end
endmodule

