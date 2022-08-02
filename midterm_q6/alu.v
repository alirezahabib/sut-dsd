`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company:       Sharif University of Technology
// Engineer:      Alireza Habibzadeh - 99109393
// 
// Create Date:    05:24:35 05/29/2022 
// Design Name: 
// Module Name:    alu 
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

module alu(
    input Clock,
    input Reset,
    input Data_in,
    output reg Data_out
    );

    parameter n = 2;
    localparam [1:0] sum_op = 2'b10, sub_op = 2'b01, mul_op = 2'b11, div_op = 2'b00;
    localparam [1:0] status1 = 2'b00, status2 = 2'b01, data1 = 2'b10, data2 = 2'b11;
    
	reg [1:0] state;
    reg [n-1:0] A, B;
    reg [2*n - 1:0] C;
    reg [1:0] opcode;
    integer i;
	 
	wire [2*n-1:0] calc = opcode == sum_op ? A + B :
	                        opcode == sub_op ? A - B :
	                            opcode == mul_op ? A * B : A / B; // implicit assignment 

    always @(negedge Clock or posedge Reset) begin
        if (Reset) begin
            A <= 0;
            B <= 0;
            C <= 0;
            i <= 0;
            opcode <= 0;
			Data_out <= 0;
			state <= status1;
        end else begin
            case (state)
                status1: begin
				    C <= calc;
                    opcode[1] <= Data_in;
					Data_out <= ^calc; // parity
					state <= status2;
                end
                status2: begin
                    opcode[0] <= Data_in;
					Data_out <= ~|C; // all zero?
					state <= data1;
                end
                data1: begin
                    Data_out <= C[2*n - 1 - i];
                    A[n - 1 - i] <= Data_in;
                    if (i == n - 1) begin
                        state <= data2;
                        i <= 0;
                    end else i <= i + 1;
                end
                data2: begin
                    Data_out <= C[n - 1 - i];
                    B[n - 1 - i] <= Data_in;
                    if (i == n - 1) begin
                        state <= status1;
                        i <= 0;
                    end else i <= i + 1;
                end
            endcase
        end
    end
endmodule
