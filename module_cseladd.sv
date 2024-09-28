// Module add16: Cộng hai số 16-bit với carry-in và carry-out
module add16(
    input [15:0] a,
    input [15:0] b,
    input cin,
    output [15:0] sum,
    output cout
);
    assign {cout, sum} = a + b + cin; // Thực hiện phép cộng với cin
endmodule

// Module top_module: Cộng hai số 32-bit sử dụng hai module add16
module eq_n(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire cout_lower, cout_upper;    // Đầu ra carry của phần 16-bit thấp và cao
    wire [15:0] sum_lower, sum_upper0, sum_upper1;

    // Cộng phần 16-bit thấp (a[15:0], b[15:0])
    add16 lower_adder(
        .a(a[15:0]),
        .b(b[15:0]),
        .cin(1'b0),
        .sum(sum_lower),
        .cout(cout_lower)
    );

    // Cộng phần 16-bit cao với cin = 0
    add16 upper_adder0(
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(1'b0),
        .sum(sum_upper0),
        .cout(cout_upper)
    );

    // Cộng phần 16-bit cao với cin = 1
    add16 upper_adder1(
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(1'b1),
        .sum(sum_upper1),
        .cout(cout_upper)
    );

    // Lựa chọn phần 16-bit cao dựa trên cout_lower
    always @(*) begin
        case (cout_lower)
            1'b0: sum[31:16] = sum_upper0; // Nếu cout_lower là 0, chọn sum_upper0
            1'b1: sum[31:16] = sum_upper1; // Nếu cout_lower là 1, chọn sum_upper1
        endcase
    end

    // Gán phần 16-bit thấp cho sum
    assign sum[15:0] = sum_lower;
    
endmodule