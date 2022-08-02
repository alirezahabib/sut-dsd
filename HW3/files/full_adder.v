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
module full_adder(
    output s,
    output c_out,
    input c_in,
    input a,
    input b
    );

    wire w1, w2, w3;
    xor(w1, a, b);
    xor(s, w1, c_in);
 
    and(w3, w1, c_in);
    and(w2, a, b);
    or(c_out, w3, w2);
endmodule
