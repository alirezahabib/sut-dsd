module TFF(q, clk, reset);

output q;
input clk, reset;
reg t = 1'b1;

JKFF jkff0(q, t, t, clk, reset);

endmodule
