// synthesis verilog_input_version verilog_2001
module eq_n (
    input [3:0] sel,            // 4-bit selector for 16 inputs (0 to 15)
    input [3:0] data0,          // 4-bit data inputs
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
    output reg [3:0] out        // 4-bit output
);

    reg [3:0] data[0:15];       // Array to hold 16 data inputs

    // Generate block to assign each input to the corresponding array index
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : data_assign
            always @(*) begin
                case (i)
                    0: data[i] = data0;
                    1: data[i] = data1;
                    2: data[i] = data2;
                    3: data[i] = data3;
                    4: data[i] = data4;
                    5: data[i] = data5;
                    6: data[i] = data6;
                    7: data[i] = data7;
                    8: data[i] = data8;
                    9: data[i] = data9;
                    10: data[i] = data10;
                    11: data[i] = data11;
                    12: data[i] = data12;
                    13: data[i] = data13;
                    14: data[i] = data14;
                    15: data[i] = data15;
                endcase
            end
        end
    endgenerate

    // Logic to select the output based on sel
    always @(*) begin
        if (sel < 16)            // If sel is between 0 and 15
            out = data[sel];     // Select the corresponding data input
        else
            out = 4'b0000;       // Default output is 0 if sel is invalid
    end

endmodule