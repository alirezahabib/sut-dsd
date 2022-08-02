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
module full_adder_delay_fast(
    output s,
    output c_out,
    input c_in,
    input a,
    input b
    );

    wire w1, w2, w3;
    xor #4 (s, a, b, c_in);
 
    and #2 (w1, a, b);
    and #2 (w2, a, c_in);
	 and #2 (w3, b, c_in);
    or #2 (c_out, w1, w2, w3);
endmodule
