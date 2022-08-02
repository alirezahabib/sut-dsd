`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   05:57:40 05/07/2022
// Design Name:   carry_ripple_adder
// Module Name:   C:/HW3_99109393/carry_ripple_adder_tb.v
// Project Name:  HW3_99109393
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: carry_ripple_adder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module carry_ripple_adder_tb;

	// Inputs
	reg c_in;
	reg [3:0] A;
	reg [3:0] B;

	// Outputs
	wire [3:0] S;
	wire c_out;

	// Instantiate the Unit Under Test (UUT)
	carry_ripple_adder uut (
		.S(S), 
		.c_out(c_out), 
		.c_in(c_in), 
		.A(A), 
		.B(B)
	);

	initial begin
		// Initialize Inputs
		c_in = 0;
		A = 0;
		B = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		for (int i=0; i<16; i=i+1) begin
		    for (int j=0; j<16; j=j+1) begin
			     c_in = 0;
			     A = i;
				  B = j;
				  if (S == i + j) begin
				      $display("Test passed, %d + %d = %d", i, j, S);
				  end else begin
						$display("Test failed, %d + %d != %d", i, j, S);
				  end
				  
				  c_in = 1;
				  if (S == i + j + 1) begin
				      $display("Test passed, %d + %d + 1 = %d", i, j, S);
				  end else begin
						$display("Test failed, %d + %d + 1 != %d", i, j, S);
				  end
			 end
      end
		A = 1;
		B = 1;
		#10
		A = 2;
		#10;
		A = 10;
		B = 12;

	end
      
endmodule

