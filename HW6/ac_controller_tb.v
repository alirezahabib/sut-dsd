`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:41:30 07/16/2022
// Design Name:   ac_controller
// Module Name:   C:/HW6_99109393/ac_controller_tb.v
// Project Name:  HW6_99109393
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ac_controller
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ac_controller_tb;

	// Inputs
	reg [7:0] set_point;
    reg clock;
    reg reset;
    reg [3:0] subcommand;
    reg subcommand_enable;
    reg [7:0] sensor1;
    reg [7:0] sensor2;

	// Outputs
	wire fan;
    wire fan_high;
    wire ac;
    wire [7:0] subcommand_out;

    // subcommands (from ac_controller.v)
    parameter reset_memory = 4'b0000, latest1 = 4'b1000, latest2 = 4'b1100;
    parameter ma20_1 = 4'b1001, ma40_1 = 4'b1010, ma60_1 = 4'b1011;
    parameter ma20_2 = 4'b1101, ma40_2 = 4'b1110, ma60_2 = 4'b1111;

	// Instantiate the Unit Under Test (UUT)
	ac_controller uut (
		.set_point(set_point),
        .clock(clock),
        .reset(reset),
        .subcommand(subcommand),
        .subcommand_enable(subcommand_enable),
        .sensor1(sensor1),
        .sensor2(sensor2),
        .fan(fan),
        .fan_high(fan_high),
        .ac(ac),
        .subcommand_out(subcommand_out)
	);

	always #10 clock = ~clock;

	initial begin
		// Initialize Inputs
		set_point = 0;
        clock = 0;
        reset = 0;
        subcommand = 0;
        subcommand_enable = 0;
        sensor1 = 0;
        sensor2 = 0;

		// Wait 100 ns for global reset to finish
		#100 reset = 1;
		#100 reset = 0;
		#50;

		// Logic test
        sensor1 = 70;
        sensor2 = 80;
        set_point = 50; // ac mode
        #100;
        sensor1 = 40;
        sensor2 = 40; // off
        #100;
        sensor1 = 80;
        sensor2 = 82;
        set_point = 81; // slow fan mode
        #200;
        sensor1 = 80;
        sensor2 = 90;
        set_point = 81; // high fan mode
        #200;

        sensor1 = 10;
        sensor2 = 20;

        // subcommands test
        subcommand_enable = 1;
        #10 subcommand = latest1;
        #10 subcommand = latest2;
        #10 subcommand = ma20_1;
        #10 subcommand = ma40_1;
        #10 subcommand = ma60_1;
        #10 subcommand = ma20_2;
        #10 subcommand = ma40_2;
        #10 subcommand = ma60_2;
        #10 subcommand = reset_memory;
        #10;
	    $finish;
	end
endmodule

