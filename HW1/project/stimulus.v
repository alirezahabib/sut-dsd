module stimulus;
reg clk; reg reset; wire[4:0] q;

ripple_carry_counter r1(q, clk, reset);

initial clk = 1'b0;
always #5 clk = ~clk;

initial
begin
$monitor($time, " Output q = %d", q);
reset = 1'b1;
#10 reset = 1'b0;
#330
reset = 1'b1;
#10 reset = 1'b0;
#150;
reset = 1'b1;
#10 reset = 1'b0;
$stop;
end
endmodule
