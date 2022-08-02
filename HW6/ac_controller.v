`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:36:50 07/16/2022 
// Design Name: 
// Module Name:    ac_controller 
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
module ac_controller(
    input [7:0] set_point,
    input clock,
    input reset,
    input [3:0] subcommand,
    input subcommand_enable,
    input [7:0] sensor1,
    input [7:0] sensor2,
    output reg fan,
    output reg fan_high,
    output reg ac,
    output reg [7:0] subcommand_out
    );

    // subcommands
    parameter reset_memory = 4'b0000, latest1 = 4'b1000, latest2 = 4'b1100;
    parameter ma20_1 = 4'b1001, ma40_1 = 4'b1010, ma60_1 = 4'b1011;
    parameter ma20_2 = 4'b1101, ma40_2 = 4'b1110, ma60_2 = 4'b1111;

    reg [7:0] duration;
    wire [7:0] average_temp1, average_temp2, latest_temp1, latest_temp2;
    wire memory_reset = reset | subcommand_enable & subcommand == reset_memory;

    sensor_memory memory_1(
        .temp(sensor1),
        .duration(duration),
        .clock(clock),
        .reset(memory_reset),
        .average_temp(average_temp1),
        .latest_temp(latest_temp1)
    );

    sensor_memory memory_2(
        .temp(sensor2),
        .duration(duration),
        .clock(clock),
        .reset(memory_reset),
        .average_temp(average_temp2),
        .latest_temp(latest_temp2)
    );

    always @(posedge clock) begin
        if (reset) begin
            fan = 0;
            fan_high = 0;
            ac = 0;
            subcommand_out = 0;
            // memory modules are reseted by reset signal asynchronously
        end else if (subcommand_enable) begin
            case (subcommand)
                latest1: subcommand_out = latest_temp1;
                latest2: subcommand_out = latest_temp2;
                ma20_1: begin
                    duration = 20;
                    subcommand_out = average_temp1;
                end
                ma40_1: begin
                    duration = 40;
                    subcommand_out = average_temp1;
                end
                ma60_1: begin
                    duration = 60;
                    subcommand_out = average_temp1;
                end
                ma20_2: begin
                    duration = 20;
                    subcommand_out = average_temp2;
                end
                ma40_2: begin
                    duration = 40;
                    subcommand_out = average_temp2;
                end
                ma60_2: begin
                    duration = 60;
                    subcommand_out = average_temp2;
                end
            endcase
        end else begin
            duration = 60;
            if (set_point > average_temp2) begin
                fan = 0;
                ac = 0;
            end else if (set_point < average_temp1 & set_point < average_temp2) begin
                fan = 1;
                fan_high = 1;
                ac = 1;
            end else if (set_point > average_temp1 & set_point < average_temp2) begin
                fan = 1;
                ac = 0;
                if (average_temp2 - average_temp1 > 3) fan_high = 1;
                else fan_high = 0;
            end
        end
    end
endmodule
