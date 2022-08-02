module multiplexer(
    input [31:0] A,
    input [31:0] B,
    output [31:0] Y,
    input sel
    );

    always @(A or B or sel) begin
        case(sel)
            0: Y <= A;
            1: Y <= B;
        endcase
    end
endmodule