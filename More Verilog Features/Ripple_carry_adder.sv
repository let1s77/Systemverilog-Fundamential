module fulladder(
    input logic X, Y, Ci,    // Các tín hiệu đầu vào X, Y và carry-in
    output logic S, Co       // Các tín hiệu đầu ra sum và carry-out
);
    logic w1, w2, w3;

    // Structural code cho một bộ cộng full adder 1-bit
    assign w1 = X ^ Y;
    assign S = w1 ^ Ci;
    assign w2 = w1 & Ci;
    assign w3 = X & Y;
    assign Co = w2 | w3;

endmodule
module top_module(
    input logic [3:0] X, Y,   // Hai đầu vào 4-bit
    output logic [3:0] S,     // Đầu ra tổng 4-bit
    output logic Co           // Tín hiệu carry-out cuối cùng
);
    logic w1, w2, w3;

    // Khởi tạo 4 bộ cộng full adders 1-bit trong SystemVerilog
    fulladder u1(.X(X[0]), .Y(Y[0]), .Ci(1'b0), .S(S[0]), .Co(w1));
    fulladder u2(.X(X[1]), .Y(Y[1]), .Ci(w1), .S(S[1]), .Co(w2));
    fulladder u3(.X(X[2]), .Y(Y[2]), .Ci(w2), .S(S[2]), .Co(w3));
    fulladder u4(.X(X[3]), .Y(Y[3]), .Ci(w3), .S(S[3]), .Co(Co));

endmodule
