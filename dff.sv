module dff(d,clk,q,qb);
input d,clk;
output reg q,qb;

always @(posedge clk) begin 
	q <= d;
end
assign qb = ~q;
endmodule 