module eq_n (
    input  logic [31:0] a,     // Đầu vào 32-bit a
    input  logic [31:0] b,     // Đầu vào 32-bit b
    output logic [31:0] sum    // Đầu ra 32-bit sum
);
    logic cout_lower;  // Carry-out từ bộ cộng 16 bit thấp

    // Bộ cộng 16 bit thấp (Lower 16-bit adder)
    add16 adder_lower (
        .a(a[15:0]),           // 16 bit thấp của a
        .b(b[15:0]),           // 16 bit thấp của b
        .cin(1'b0),            // Không có carry-in
        .sum(sum[15:0]),       // Kết quả sum cho 16 bit thấp
        .cout(cout_lower)      // Carry-out từ bộ cộng thấp
    );

    // Bộ cộng 16 bit cao (Upper 16-bit adder)
    add16 adder_upper (
        .a(a[31:16]),          // 16 bit cao của a
        .b(b[31:16]),          // 16 bit cao của b
        .cin(cout_lower),      // Carry-in từ carry-out của bộ cộng thấp
        .sum(sum[31:16]),      // Kết quả sum cho 16 bit cao
        .cout()                // Không cần dùng carry-out cuối cùng
    );
endmodule

module add16 (
    input  logic [15:0] a,  // Đầu vào 16-bit a
    input  logic [15:0] b,  // Đầu vào 16-bit b
    input  logic        cin, // Carry-in
    output logic [15:0] sum, // Đầu ra 16-bit sum
    output logic        cout // Carry-out
);
    logic [15:0] carry;      // Mảng lưu các giá trị carry

    // Bộ cộng bit thấp nhất (LSB)
    add1 adder0 (.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(carry[0]));

    // Sử dụng generate để khởi tạo 15 bộ cộng tiếp theo
    genvar i;
    generate
        for (i = 1; i < 16; i = i + 1) begin: my_block_name
            add1 adder (.a(a[i]), .b(b[i]), .cin(carry[i-1]), .sum(sum[i]), .cout(carry[i]));
        end
    endgenerate

    // Carry-out cuối cùng
    assign cout = carry[15];
endmodule

module add1 (
    input  logic a,         // 1-bit input a
    input  logic b,         // 1-bit input b
    input  logic cin,       // Carry-in
    output logic sum,       // Sum output
    output logic cout       // Carry-out
);
    // Logic cho phép cộng 1 bit
    assign {cout,sum} = a + b + cin;
endmodule
