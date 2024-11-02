module bcd_fadd(
    input logic [3:0] a,          // Số BCD thứ nhất (4-bit)
    input logic [3:0] b,          // Số BCD thứ hai (4-bit)
    input logic cin,              // Tín hiệu carry-in
    output logic [3:0] sum,       // Tổng BCD (4-bit)
    output logic cout             // Tín hiệu carry-out
);

    logic [4:0] temp_sum;         // Tổng tạm thời 5-bit để kiểm tra BCD overflow

    always_comb begin
        // Bước 1: Cộng hai chữ số BCD và carry-in
        temp_sum = a + b + cin;

        // Bước 2: Kiểm tra nếu tổng vượt quá 9 (lớn hơn 4-bit BCD)
        if (temp_sum > 9) begin
            // Tổng không hợp lệ trong BCD -> cộng thêm 6 và bật carry-out
            sum = temp_sum + 4'b0110; // Thêm 6 để điều chỉnh
            cout = 1;                 // Carry-out = 1 khi tổng lớn hơn 9
        end else begin
            // Tổng hợp lệ trong BCD, không cần điều chỉnh
            sum = temp_sum[3:0];
            cout = 0;                 // Không có carry-out
        end
    end

endmodule
module eq_n	(
    input logic [399:0] a,       // Số BCD thứ nhất (100 chữ số, mỗi chữ số 4-bit)
    input logic [399:0] b,       // Số BCD thứ hai (100 chữ số, mỗi chữ số 4-bit)
    input logic cin,             // Tín hiệu carry-in đầu vào
    output logic cout,           // Tín hiệu carry-out cuối cùng
    output logic [399:0] sum     // Kết quả tổng (100 chữ số BCD, mỗi chữ số 4-bit)
);

    logic [99:0] carry;          // Các tín hiệu carry giữa các chữ số

    // Instantiation của 100 bcd_fadd cho 100 chữ số BCD
    genvar i;
    generate
        for (i = 0; i < 100; i++) begin : bcd_adders
            if (i == 0) begin
                // Bộ cộng BCD đầu tiên, sử dụng carry-in đầu vào `cin`
                bcd_fadd u_bcd_fadd (
                    .a(a[3:0]),                    // Số BCD đầu tiên (chữ số đầu tiên)
                    .b(b[3:0]),                    // Số BCD thứ hai (chữ số đầu tiên)
                    .cin(cin),                     // Carry-in từ input
                    .sum(sum[3:0]),                // Kết quả tổng của chữ số đầu tiên
                    .cout(carry[0])                // Carry-out cho chữ số tiếp theo
                );
            end else begin
                // Các bộ cộng BCD tiếp theo, sử dụng carry-out từ bộ cộng trước đó
                bcd_fadd u_bcd_fadd (
                    .a(a[i*4 + 3 : i*4]),         // Số BCD đầu tiên (chữ số thứ i)
                    .b(b[i*4 + 3 : i*4]),         // Số BCD thứ hai (chữ số thứ i)
                    .cin(carry[i-1]),             // Carry-in từ chữ số trước đó
                    .sum(sum[i*4 + 3 : i*4]),     // Kết quả tổng của chữ số thứ i
                    .cout(carry[i])               // Carry-out cho chữ số tiếp theo
                );
            end
        end
    endgenerate

    // Tín hiệu carry-out cuối cùng từ bộ cộng chữ số thứ 100
    assign cout = carry[99];

endmodule
