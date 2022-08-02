module JKFF(q, j, k, clk, reset);

output q;
input j, k, clk, reset;
reg q;

always @(posedge reset or negedge clk)
	if (reset)
		q = 1'b0;
	else
		if (j && k)
			q = ~q;
		else if (j && ~k)
			q = 1'b1;
		else if (k && ~j)
			q = 1'b0;
		// else do nothing (j = k = 0)
endmodule

