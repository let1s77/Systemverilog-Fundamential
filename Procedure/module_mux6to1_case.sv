// synthesis verilog_input_version verilog_2001
module eq_n( 
    input [2:0] sel,           // 3-bit selector
    input [3:0] data0,         // 4-bit data inputs
    input [3:0] data1,
    input [3:0] data2,
    input [3:0] data3,
    input [3:0] data4,
    input [3:0] data5,
    output reg [3:0] out       // 4-bit output
);

    always @(*) begin  // Combinational logic block
        case(sel)
            3'b000: out = data0;    // If sel is 0, choose data0
            3'b001: out = data1;    // If sel is 1, choose data1
            3'b010: out = data2;    // If sel is 2, choose data2
            3'b011: out = data3;    // If sel is 3, choose data3
            3'b100: out = data4;    // If sel is 4, choose data4
            3'b101: out = data5;    // If sel is 5, choose data5
            default: out = 4'b0000; // If sel is outside 0-5, output 0
        endcase
    end

endmodule