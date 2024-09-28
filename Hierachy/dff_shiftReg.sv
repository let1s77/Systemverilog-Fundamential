// Khai báo module my_dff (D flip-flop)
module my_dff (
    input wire clk,   // Tín hiệu xung clock
    input wire d,     // Tín hiệu đầu vào d
    output reg q      // Tín hiệu đầu ra q
);
    always @(posedge clk) begin
        q <= d; // Lưu giá trị d vào q khi có cạnh lên của clk
    end
endmodule

// Module chính top_module
module eq_n (
    input wire clk,   // Tín hiệu clock
    input wire d,     // Tín hiệu đầu vào d
    output wire q     // Tín hiệu đầu ra q
);

    // Tạo các dây kết nối giữa các flip-flop
    wire q1, q2;

    // Khởi tạo 3 module my_dff và kết nối chúng
    my_dff dff1 (
        .clk(clk),   // Nối tín hiệu clock
        .d(d),       // Nối đầu vào d từ top_module
        .q(q1)       // Đầu ra của flip-flop đầu tiên
    );

    my_dff dff2 (
        .clk(clk),   // Nối tín hiệu clock
        .d(q1),      // Đầu vào là đầu ra của flip-flop trước đó
        .q(q2)       // Đầu ra của flip-flop thứ hai
    );

    my_dff dff3 (
        .clk(clk),   // Nối tín hiệu clock
        .d(q2),      // Đầu vào là đầu ra của flip-flop thứ hai
        .q(q)        // Đầu ra cuối cùng của top_module
    );
endmodule
