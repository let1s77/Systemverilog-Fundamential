module shift_cell (
    input clk, L, E, 
    input R_in, Q_prev, w, 
    output reg Q
);
    wire mux1_out, mux2_out;
    
    // Multiplexer ??u tiên: Ch?n gi?a giá tr? n?p R_in ho?c giá tr? t? ph?n t? tr??c
    assign mux1_out = L ? R_in : Q_prev;  

    // Multiplexer th? hai: Ch?n gi?a w ho?c ??u ra c?a multiplexer ??u tiên
    assign mux2_out = E ? w : mux1_out;  

    // D Flip-Flop: C?p nh?t giá tr? t?i c?nh lên c?a xung clock
    always @(posedge clk)
        Q <= mux2_out;  

endmodule

    parameter N = 4;  // ??nh ngh?a s? bit c?a thanh ghi
module top_module (
    input clk,
    input w, L, E,     // w: d? li?u vào, L: Load enable, E: Shift enable
    input [N-1:0] R,     // 4-bit R (mô ph?ng cho 4 FFs)
    output [N-1:0] Q     // ??u ra c?a thanh ghi d?ch vòng
);


    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : shift_register
            if (i == 0) begin
                // Ô ??u tiên: L?y Q_prev t? ô cu?i cùng (d?ch vòng)
                shift_cell U0 (
                    .clk(clk), .L(L), .E(E), 
                    .R_in(R[i]), .Q_prev(Q[N-1]), .w(w), 
                    .Q(Q[i])
                );
            end else begin
                // Các ô còn l?i
                shift_cell Ui (
                    .clk(clk), .L(L), .E(E), 
                    .R_in(R[i]), .Q_prev(Q[i-1]), .w(w), 
                    .Q(Q[i])
                );
            end
        end
    endgenerate
endmodule