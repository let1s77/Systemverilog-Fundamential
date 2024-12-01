// synthesis verilog_input_version verilog_2001 
module ic151( 
    input [3:0] sel,           // 4-bit selector
    input [3:0] data0,         // 4-bit data inputs
    input [3:0] data1,
    input [3:0] data2,
    input [3:0] data3,
    input [3:0] data4,
    input [3:0] data5,
    input [3:0] data6,
    input [3:0] data7,
    input [3:0] data8,
    input [3:0] data9,
    input [3:0] data10,
    input [3:0] data11,
    input [3:0] data12,
    input [3:0] data13,
    input [3:0] data14,
    input [3:0] data15,
    input E,
    output reg [3:0] out       // 4-bit output
);
    wire [4:0] temp;
    assign  temp = {E, sel};   // Combine E and sel to form a 5-bit selector

    always @(*) begin          // Combinational logic block
        case(temp)
            5'b00000: out = data0;    // If E=0, regardless of sel, choose data0
            5'b00001: out = data1;    // If E=1 and sel=0000, choose data1
            5'b00010: out = data2;    // If E=1 and sel=0001, choose data2
            5'b00011: out = data3;
            5'b00100: out = data4;
            5'b00101: out = data5;
            5'b00110: out = data6;
            5'b00111: out = data7;
            5'b01000: out = data8;
            5'b01001: out = data9;
            5'b01010: out = data10;
            5'b01011: out = data11;
            5'b01100: out = data12;
            5'b01101: out = data13;
            5'b01110: out = data14;
            5'b01111: out = data15;
            default: out = 4'b0000;   // Default output
        endcase
    end
endmodule

module top_module(
    input x,                // Single bit input x
    input y,                // Single bit input y
    input z,                // Single bit input z
    input w,                // Single bit input w
    input E,                // Enable signal
    output x_show, y_show, z_show, w_show,
    output F                // Single bit output F
);
assign x_show = x;
assign y_show = y;
assign z_show = z;
assign w_show = w;

    wire [3:0] sel;
    wire [3:0] mux_out;

    // Assign selector based on inputs x, y, z, w
    assign sel = {x, y, z, w};

    // Define data inputs based on F(x,y,z,w) = Σ(2,5,7,9,12,13)
    // F = 1 for minterms 2,5,7,9,12,13 and F = 0 otherwise
    assign I00 = 4'b0000; // m0: 0
    assign I01 = 4'b0000; // m1: 0
    assign I02 = 4'b0001; // m2: 1
    assign I03 = 4'b0000; // m3: 0
    assign I04 = 4'b0000; // m4: 0
    assign I05 = 4'b0001; // m5: 1
    assign I06 = 4'b0000; // m6: 0
    assign I07 = 4'b0001; // m7: 1
    assign I08 = 4'b0000; // m8: 0
    assign I09 = 4'b0001; // m9: 1
    assign I10 = 4'b0000; // m10: 0
    assign I11 = 4'b0000; // m11: 0
    assign I12 = 4'b0001; // m12: 1
    assign I13 = 4'b0001; // m13: 1
    assign I14 = 4'b0000; // m14: 0
    assign I15 = 4'b0000; // m15: 0

    // Instantiate the ic151 MUX with 16 data inputs
    ic151 ic151_0 (
        .sel(sel),
        .data0(I00),
        .data1(I01),
        .data2(I02),
        .data3(I03),
        .data4(I04),
        .data5(I05),
        .data6(I06),
        .data7(I07),
        .data8(I08),
        .data9(I09),
        .data10(I10),
        .data11(I11),
        .data12(I12),
        .data13(I13),
        .data14(I14),
        .data15(I15),
        .E(E),
        .out(mux_out)
    );

    // Assign F to be the LSB of the MUX output
    assign F = mux_out[0];
endmodule
