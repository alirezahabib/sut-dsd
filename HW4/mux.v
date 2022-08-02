module mux(
	input [3:0] i,
	input [1:0] s,
	output out
	);

	wire [1:0] sn;
	wire [3:0] y;
	
	not #(1) n0 (sn[0], s[0]);
	not #(1) n1 (sn[1], s[1]);
	
	and #(6) a0 (y[0], i[0], sn[1], sn[0]);
	and #(6) a1 (y[1], i[1], sn[1], s[0]);
	and #(6) a2 (y[2], i[2], s[1], sn[0]);
	and #(6) a3 (y[3], i[3], s[1], s[0]);
	
	or #(8) o (out, y[0], y[1], y[2], y[3]);
endmodule