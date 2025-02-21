module shift_cell (
    input clk, L, E, 
    input R_in, Q_prev, w, 
    output reg Q
);
    wire mux1_out, mux2_out;
    
    // Multiplexer ??u ti�n: Ch?n gi?a gi� tr? n?p R_in ho?c gi� tr? t? ph?n t? tr??c
    assign mux1_out = L ? R_in : Q_prev;  

    // Multiplexer th? hai: Ch?n gi?a w ho?c ??u ra c?a multiplexer ??u ti�n
    assign mux2_out = E ? w : mux1_out;  

    // D Flip-Flop: C?p nh?t gi� tr? t?i c?nh l�n c?a xung clock
    always @(posedge clk)
        Q <= mux2_out;  

endmodule

    parameter N = 4;  // ??nh ngh?a s? bit c?a thanh ghi
module top_module (
    input clk,
    input w, L, E,     // w: d? li?u v�o, L: Load enable, E: Shift enable
    input [N-1:0] R,     // 4-bit R (m� ph?ng cho 4 FFs)
    output [N-1:0] Q     // ??u ra c?a thanh ghi d?ch v�ng
);


    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : shift_register
            if (i == 0) begin
                // � ??u ti�n: L?y Q_prev t? � cu?i c�ng (d?ch v�ng)
                shift_cell U0 (
                    .clk(clk), .L(L), .E(E), 
                    .R_in(R[i]), .Q_prev(Q[N-1]), .w(w), 
                    .Q(Q[i])
                );
            end else begin
                // C�c � c�n l?i
                shift_cell Ui (
                    .clk(clk), .L(L), .E(E), 
                    .R_in(R[i]), .Q_prev(Q[i-1]), .w(w), 
                    .Q(Q[i])
                );
            end
        end
    endgenerate
endmodule