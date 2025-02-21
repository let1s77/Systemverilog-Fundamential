module shift_cell_tb;
    // ??nh ngh?a c�c t�n hi?u c?n thi?t cho testbench
    reg clk;
    reg L, E, R_in, w;
    reg [3:0] R;
    wire [3:0] Q;

    // Kh?i t?o m�-?un top_module
    top_module uut (
        .clk(clk),
        .w(w),
        .L(L),
        .E(E),
        .R(R),
        .Q(Q)
    );

    // Kh?i t?o xung clock
    always begin
        #5 clk = ~clk;  // T?o xung clock v?i chu k? 10 ??n v? th?i gian
    end

    // Quy tr�nh kh?i t?o t�n hi?u v� ki?m tra
    initial begin
        // Kh?i t?o t?t c? c�c t�n hi?u
        clk = 0;
        L = 0;
        E = 0;
        R_in = 0;
        w = 0;
        R = 4'b0000;

        // In ra ti�u ?? ki?m tra
        $display("Test 1: Ki?m tra thanh ghi d?ch v�ng");

        // Test 1: Ki?m tra ch? ?? Load (L=1) v� Shift (E=0)
        #10;
        L = 1; E = 0; R_in = 1; w = 0; R = 4'b1010;  // N?p gi� tr? t? R
        #10;
        L = 0; E = 0; // V� hi?u h�a Load v� Shift
        check_output(4'b1010);  // Ki?m tra gi� tr? output sau khi load

        // Test 2: Ki?m tra ch? ?? Shift (E=1) m� kh�ng n?p (L=0)
        #10;
        L = 0; E = 1; R_in = 0; w = 1; // D?ch thanh ghi v?i gi� tr? w = 1
        #10;
        L = 0; E = 0; // V� hi?u h�a Shift
        check_output(4'b0111);  // Ki?m tra gi� tr? output sau khi shift

        // Test 3: Ki?m tra v?i c�c t�n hi?u kh�c nhau
        #10;
        L = 1; E = 0; R_in = 0; w = 0; R = 4'b1100;  // N?p l?i gi� tr? t? R
        #10;
        L = 0; E = 1; // B?t ??u d?ch thanh ghi
        #10;
        check_output(4'b1110);  // Ki?m tra gi� tr? output sau khi shift

        #10;
        $stop;  // D?ng m� ph?ng
    end

    // Ki?m tra s? thay ??i c?a Q
    task check_output(input [3:0] expected);
        begin
            // ??m b?o r?ng gi� tr? Q sau m?i thay ??i t�n hi?u kh?p v?i gi� tr? k? v?ng
            if (Q !== expected) begin
                $display("Error: Expected Q = %b, but got Q = %b at time %t", expected, Q, $time);
              
            end else begin
                $display("Pass: Q = %b at time %t", Q, $time);
            end
        end
    endtask

    // Ki?m tra s? thay ??i c?a Q
    initial begin
        $monitor("At time %t, Q = %b", $time, Q);  // In ra gi� tr? Q t?i m?i th?i ?i?m
    end
endmodule
