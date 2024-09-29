// synthesis verilog_input_version verilog_2001
module eq_n (
    input [7:0] in,      // 8-bit input vector
    output reg [2:0] pos // 3-bit output representing the position of first '1'
);

    always @(*) begin
        casez (in)
            8'b00000001: pos = 3'd0;  // Bit 0 is 1
            8'b0000001?: pos = 3'd1;  // Bit 1 is 1
            8'b000001??: pos = 3'd2;  // Bit 2 is 1
            8'b00001???: pos = 3'd3;  // Bit 3 is 1
            8'b0001????: pos = 3'd4;  // Bit 4 is 1
            8'b001?????: pos = 3'd5;  // Bit 5 is 1
            8'b01??????: pos = 3'd6;  // Bit 6 is 1
            8'b1???????: pos = 3'd7;  // Bit 7 is 1
            default: pos = 3'd0;      // No bits are 1
        endcase
    end

endmodule