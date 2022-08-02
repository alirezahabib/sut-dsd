
module counter_tb();
reg clk,reset,up_down,load;
reg [3:0] data;
wire [3:0] count;
always #5 clk = ~clk;
 counter UUT (.clk(clk),.reset(reset),.up_down(up_down),.load(load),.data(data),.count(count));
initial
begin
$monitor("%d", data);
clk = 0;
reset = 0;
up_down = 0;
load = 0;
data = 4'b0;
#20;
reset = 1;
#20;
reset = 0;
#210;
up_down = 1;
#190;
reset = 1;
#10;
reset = 0;
#50;
data = 4'b1010;
load = 1;
#20;
load = 0;
#100;
$stop;

end
endmodule

