module ripple_carry_counter(q, clk, reset);

output [4:0] q;
input clk, reset;

TFF tff0(q[0], clk, reset);
TFF tff1(q[1], q[0], reset);
TFF tff2(q[2], q[1], reset);
TFF tff3(q[3], q[2], reset);
TFF tff4(q[4], q[3], reset);

endmodule