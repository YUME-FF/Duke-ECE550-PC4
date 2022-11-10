module clock_div4(clk, rst, out_clk);
  output reg out_clk;
  input clk;
  input rst;	
reg [1:0] div_cnt1;
	always@(posedge clk or negedge rst)
begin
	if(rst)
		div_cnt1<=2'b00;
	else
		div_cnt1<=div_cnt1+1'b1;
end
 
always@(posedge clk or negedge rst)
begin                                 
	if(rst)                          
		out_clk<=1'b0;
	else if(div_cnt1==2'b00 || div_cnt1==2'b10)
		out_clk<=~out_clk;
	else
		out_clk<=out_clk;
end
endmodule
