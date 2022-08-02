// or gate behavioral model verilog
module or_gate(
    input a[31:0],
    output c
);
    integer i;

    always @(a) begin
        c <= a[0];
        for (i=1; i<32; i=i+1) begin
            c <= c | a[i];
        end
    end
endmodule