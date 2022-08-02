`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       Sharif University of Technology
// Engineer:      Alireza Habibzadeh - 99109393
//
// Create Date:   05:25:11 05/29/2022
// Design Name:   alu
// Module Name:   C:/dsd_midterm_q6_99109393/alu_tb.v
// Project Name:  dsd_midterm_q6_99109393
// Target Device:  
// Tool versions:  
// Description: 
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module alu_tb;

	// Inputs
	reg Clock;
	reg Reset;
	reg Data_in;

	// Outputs
	wire Data_out;

	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.Clock(Clock), 
		.Reset(Reset), 
		.Data_in(Data_in), 
		.Data_out(Data_out)
	);
	
	always #10 Clock = ~Clock;

	initial begin
		// Initialize Inputs
		Clock = 0;
		Reset = 0;
		Data_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		Reset = 1;
		#10 Reset = 0;
		#5 Data_in = 1;
		#10 Data_in = 0;
		#20 Data_in = 1;
		#40 Data_in = 0;
		#20 Data_in = 1;
		#20 Data_in = 0;
		#40 Data_in = 1;
		#220;
		$finish;
	end
      
endmodule

