module ic138(
input [2:0] sel,
input G1,G2a,G2b,
output [7:0] Y);

logic [5:0] temp;
assign temp = {G1,G2a,G2b,sel};

always @(*) begin
case(temp) 
6'b100000: Y = 8'b1111_1110;
6'b100001: Y = 8'b1111_1101;
6'b100010: Y = 8'b1111_1011;
6'b100011: Y = 8'b1111_0111;
6'b100100: Y = 8'b1110_1111;
6'b100101: Y = 8'b1101_1111;
6'b100110: Y = 8'b1011_1111;
6'b100111: Y = 8'b0111_1110;
default: Y = 8'b0000_0000;
		endcase
	end
endmodule

module top_module(
input x,y,z,
output x_show, y_show, z_show,f);

wire [7:0] tmp;
wire [2:0] sel;

assign x_show = x, y_show = y, z_show = z;
 assign f = ~(tmp[0] & tmp[2] & tmp[5] & tmp[7]); // sigma = 0,2,5,7 dua len bia r rut gon
 //vi ngo ra tich cuc thap các ngõ ra được chọn sẽ là 0
assign sel ={x,y,z};

ic138 ic1(
.sel(sel),
.G1(1),
.G2a(0),
.G2b(0),
.Y(tmp) );
endmodule 






