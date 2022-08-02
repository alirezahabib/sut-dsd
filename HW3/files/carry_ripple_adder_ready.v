`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:47:57 05/07/2022 
// Design Name: 
// Module Name:    carry_ripple_adder 
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
module carry_ripple_adder_ready(
    output [3:0] S,
    output c_out,
	 output ready,
    input c_in,
    input [3:0] A,
    input [3:0] B
    );
	 
    wire [2:0] C;
    full_adder_delay fa0(S[0], C[0], c_in, A[0], B[0]);
    full_adder_delay fa1(S[1], C[1], C[0], A[1], B[1]);
    full_adder_delay fa2(S[2], C[2], C[1], A[2], B[2]);
    full_adder_delay fa3(S[3], c_out, C[2], A[3], B[3]);
	 
	 always @(A or B)begin
		ready = 1'b0;
		#32 ready = 1'b1;
	 end
	 
endmodule
