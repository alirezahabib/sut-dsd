`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:47:51 05/07/2022 
// Design Name: 
// Module Name:    full_adder 
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
module full_adder_delay(
    output s,
    output c_out,
    input c_in,
    input a,
    input b
    );

    wire w1, w2, w3;
    xor #4 (w1, a, b);
    xor #4 (s, w1, c_in);
 
    and #2 (w3, w1, c_in);
    and #2 (w2, a, b);
    or #2 (c_out, w3, w2);
endmodule
