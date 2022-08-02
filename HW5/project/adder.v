// add two 32 bit numbers
// verilog behavioral
module adder(input [31:0] a, input [31:0] b, output [31:0] sum);
    always @(a, b) sum = a + b;
endmodule : adder