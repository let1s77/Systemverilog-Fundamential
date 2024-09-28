module add16 (
    input  logic [15:0] a,      // Đầu vào 16 bit a
    input  logic [15:0] b,      // Đầu vào 16 bit b
    input  logic        cin,    // Đầu vào carry-in
    output logic [15:0] sum,    // Đầu ra 16 bit sum
    output logic        cout    // Đầu ra carry-out
);
    // Phép cộng với carry-in
    assign {cout, sum} = a + b + cin;
endmodule

module eq_n (
    input  logic [31:0] a,      // Đầu vào 32 bit a
    input  logic [31:0] b,      // Đầu vào 32 bit b
    output logic [31:0] sum     // Đầu ra 32 bit sum
);
    logic cout_lower;            // Biến lưu giá trị carry-out của adder thấp

    // Bộ cộng 16-bit cho các bit thấp (lower bits)
    add16 adder_lower (
        .a(a[15:0]),           // Đầu vào 16 bit thấp của a
        .b(b[15:0]),           // Đầu vào 16 bit thấp của b
        .cin(1'b0),            // Không có carry-in cho bộ cộng thấp
        .sum(sum[15:0]),       // Đầu ra sum cho 16 bit thấp
        .cout(cout_lower)      // Carry-out của bộ cộng thấp
    );

    // Bộ cộng 16-bit cho các bit cao (upper bits)
    add16 adder_upper (
        .a(a[31:16]),          // Đầu vào 16 bit cao của a
        .b(b[31:16]),          // Đầu vào 16 bit cao của b
        .cin(cout_lower),      // Carry-in từ bộ cộng thấp
        .sum(sum[31:16]),      // Đầu ra sum cho 16 bit cao
        .cout()                // Carry-out không được sử dụng
    );
endmodule
