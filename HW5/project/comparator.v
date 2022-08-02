module comparator (
    input [31:0] a,
    input [31:0] b,
    output reg greater,
    output reg equal,
    output reg less
);
  always @(a,b) begin
    if (a > b) begin
      greater = 1;
      equal = 0;
      less = 0;
    end else if (a == b) begin
      greater = 0;
      equal = 1;
      less = 0;
    end else begin
      greater = 0;
      equal = 0;
      less = 1;
    end
  end
endmodule
