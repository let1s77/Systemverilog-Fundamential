// synthesis verilog_input_version verilog_2001
module ic151( 
    input [2:0] sel,           // 3-bit selector
    input [3:0] data0,         // 4-bit data inputs
    input [3:0] data1,
    input [3:0] data2,
    input [3:0] data3,
    input [3:0] data4,
    input [3:0] data5,
    input [3:0] data6,
    input [3:0] data7,
    input E,
    output reg [3:0] out       // 4-bit output
);
    wire [3:0] temp;
    assign  temp = {E, sel}; // Combine E and sel to form a 4-bit selector

    always @(*) begin  // Combinational logic block
        case(temp)
            4'b0000: out = data0;    // If E=0, regardless of sel, choose data0
            4'b0001: out = data1;    // If E=1 and sel=000, choose data1
            4'b0010: out = data2;    // If E=1 and sel=001, choose data2
            4'b0011: out = data3;    // If E=1 and sel=010, choose data3
            4'b0100: out = data4;    // If E=1 and sel=011, choose data4
            4'b0101: out = data5;    // If E=1 and sel=100, choose data5
            4'b0110: out = data6;    // If E=1 and sel=101, choose data6
            4'b0111: out = data7;    // If E=1 and sel=110, choose data7
            // Add more cases if needed
            default: out = 4'b0000;   // Default output
        endcase
    end
endmodule

module eq_n(
    input x,                // Single bit input x
    input y,                // Single bit input y
    input z,                // Single bit input z
    input E,                // Enable signal
	 output x_show, y_show, z_show,
    output F                // Single bit output F
);
assign x_show = x;
assign y_show = y;
assign z_show = z;
    wire [2:0] sel;
    wire [3:0] mux_out;

    // Assign selector based on inputs x, y, z
    assign sel = {x, y, z};

    // Define data inputs based on F(x,y,z) = Σ(1,2,4,7)
    // F = 1 for minterms 1,2,4,7 and F = 0 otherwise
    assign I00 = 4'b0000; // m0: 0
    assign I01 = 4'b0001; // m1: 1
    assign I02 = 4'b0001; // m2: 1
    assign I03 = 4'b0000; // m3: 0
    assign I04 = 4'b0001; // m4: 1
    assign I05 = 4'b0000; // m5: 0
    assign I06 = 4'b0000; // m6: 0
    assign I07 = 4'b0001; // m7: 1

    // Instantiate the ic151 MUX
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
        .E(E),
        .out(mux_out)
    );

    // Assign F to be the LSB of the MUX output
    assign F = mux_out[0];
endmodule