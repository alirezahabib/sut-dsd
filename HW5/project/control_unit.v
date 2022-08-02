// control_unit for our ASM
module control_unit(
    input reset, clk, START, OR_R1, CMP_L_R1,
    output reg L_R1, L_R2, L_R3, L_R4, L_SUM, Dec_R1, Sel_R1, Sel_R2, R_SUM, S_READY, R_READY
    );

    reg [1:0] p_state, n_state;
    localparam [1:0] init = 2'b00, cmp = 2'b01, mul = 2'b10, cmp2 = 2'b11;

    always @(p_state or START or OR_R1 or CMP_L_R1) begin
        n_state = init;
        case (p_state)
            init: begin
                if (START) begin
                    n_state <= cmp;
                    Sel_R1 <= 1'b0;
                    Sel_R2 <= 1'b0;
                    L_R1 <= 1'b1;
                    L_R2 <= 1'b1;
                    L_R3 <= 1'b1;
                    S_READY <= 1'b0; R_READY <= 1'b1;
                    R_SUM <= 1'b1;
                end
            end
            cmp: begin
                n_state <= mul;
                if (CMP_L_R1) begin
                    L_R1 <= 1'b1;
                    L_R2 <= 1'b1;
                    Sel_R1 <= 1'b1;
                    Sel_R2 <= 1'b1;
                end
            end
            mul: begin
                if (OR_R1) begin
                    n_state <= mul;
                    Dec_R1 <= 1'b1;
                    L_SUM <= 1'b1;
                end else n_state <= cmp2;
            end
            cmp2: begin
                n_state <= init;
                L_R4 <= 1'b1;
                S_READY <= 1'b1; R_READY <= 1'b0;
            end
        endcase
    end

    always @(posedge clk) begin
        if (reset) p_state <= init;
        else p_state <= n_state;
    end
endmodule : control_unit
