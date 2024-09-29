// synthesis verilog_input_version verilog_2001
module eq_n (
    input [3:0] in,         // 4-bit input vector
    output reg [1:0] pos    // 2-bit output to represent the position
);

    always @(*) begin       // Combinational logic block
        case (1'b1)         // Check for the first bit that's high
            in[3]: pos = 2'b11;  // If bit 3 is high, output 3
            in[2]: pos = 2'b10;  // If bit 2 is high, output 2
            in[1]: pos = 2'b01;  // If bit 1 is high, output 1
            in[0]: pos = 2'b00;  // If bit 0 is high, output 0
            default: pos = 2'b00; // If no bits are high, output 0
        endcase
    end

endmodule