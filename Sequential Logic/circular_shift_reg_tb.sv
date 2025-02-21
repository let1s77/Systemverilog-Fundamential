module shift_cell_tb;
    // ??nh ngh?a các tín hi?u c?n thi?t cho testbench
    reg clk;
    reg L, E, R_in, w;
    reg [3:0] R;
    wire [3:0] Q;

    // Kh?i t?o mô-?un top_module
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

    // Quy trình kh?i t?o tín hi?u và ki?m tra
    initial begin
        // Kh?i t?o t?t c? các tín hi?u
        clk = 0;
        L = 0;
        E = 0;
        R_in = 0;
        w = 0;
        R = 4'b0000;

        // In ra tiêu ?? ki?m tra
        $display("Test 1: Ki?m tra thanh ghi d?ch vòng");

        // Test 1: Ki?m tra ch? ?? Load (L=1) và Shift (E=0)
        #10;
        L = 1; E = 0; R_in = 1; w = 0; R = 4'b1010;  // N?p giá tr? t? R
        #10;
        L = 0; E = 0; // Vô hi?u hóa Load và Shift
        check_output(4'b1010);  // Ki?m tra giá tr? output sau khi load

        // Test 2: Ki?m tra ch? ?? Shift (E=1) mà không n?p (L=0)
        #10;
        L = 0; E = 1; R_in = 0; w = 1; // D?ch thanh ghi v?i giá tr? w = 1
        #10;
        L = 0; E = 0; // Vô hi?u hóa Shift
        check_output(4'b0111);  // Ki?m tra giá tr? output sau khi shift

        // Test 3: Ki?m tra v?i các tín hi?u khác nhau
        #10;
        L = 1; E = 0; R_in = 0; w = 0; R = 4'b1100;  // N?p l?i giá tr? t? R
        #10;
        L = 0; E = 1; // B?t ??u d?ch thanh ghi
        #10;
        check_output(4'b1110);  // Ki?m tra giá tr? output sau khi shift

        #10;
        $stop;  // D?ng mô ph?ng
    end

    // Ki?m tra s? thay ??i c?a Q
    task check_output(input [3:0] expected);
        begin
            // ??m b?o r?ng giá tr? Q sau m?i thay ??i tín hi?u kh?p v?i giá tr? k? v?ng
            if (Q !== expected) begin
                $display("Error: Expected Q = %b, but got Q = %b at time %t", expected, Q, $time);
              
            end else begin
                $display("Pass: Q = %b at time %t", Q, $time);
            end
        end
    endtask

    // Ki?m tra s? thay ??i c?a Q
    initial begin
        $monitor("At time %t, Q = %b", $time, Q);  // In ra giá tr? Q t?i m?i th?i ?i?m
    end
endmodule
