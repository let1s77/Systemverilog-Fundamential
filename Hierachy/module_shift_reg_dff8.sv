// Module my_dff8 (D flip-flop 8-bit)
module my_dff8 (
    input wire clk,         // Tín hiệu xung clock
    input wire [7:0] d,     // Tín hiệu đầu vào d (8-bit)
    output reg [7:0] q      // Tín hiệu đầu ra q (8-bit)
);
    always @(posedge clk) begin
        q <= d; // Lưu giá trị d vào q khi có cạnh lên của clk
    end
endmodule

// Module chính top_module
module eq_n (
    input wire clk,           // Tín hiệu clock
    input wire [7:0] d,       // Tín hiệu đầu vào d (8-bit)
    input wire [1:0] sel,     // Tín hiệu chọn sel (2-bit)
    output reg [7:0] q        // Tín hiệu đầu ra q (8-bit)
);

    // Tạo các dây kết nối giữa các flip-flop
    wire [7:0] q1, q2, q3;

    // Khởi tạo 3 module my_dff8 và kết nối chúng
    my_dff8 dff1 (
        .clk(clk),   // Nối tín hiệu clock
        .d(d),       // Nối đầu vào d từ top_module
        .q(q1)       // Đầu ra của flip-flop đầu tiên
    );

    my_dff8 dff2 (
        .clk(clk),   // Nối tín hiệu clock
        .d(q1),      // Đầu vào là đầu ra của flip-flop trước đó
        .q(q2)       // Đầu ra của flip-flop thứ hai
    );

    my_dff8 dff3 (
        .clk(clk),   // Nối tín hiệu clock
        .d(q2),      // Đầu vào là đầu ra của flip-flop thứ hai
        .q(q3)       // Đầu ra của flip-flop thứ ba
    );

    // Bộ chuyển mạch (multiplexer) 4-to-1
    always @(*) begin
        case(sel)
            2'b00: q = d;    // Giá trị đầu vào d
            2'b01: q = q1;   // Đầu ra của flip-flop đầu tiên
            2'b10: q = q2;   // Đầu ra của flip-flop thứ hai
            2'b11: q = q3;   // Đầu ra của flip-flop thứ ba
        endcase
    end
endmodule
