
module cordic_R (
	areset,
	clk,
	en,
	q,
	r,
	x,
	y);	

	input		areset;
	input		clk;
	input	[0:0]	en;
	output	[25:0]	q;
	output	[24:0]	r;
	input	[23:0]	x;
	input	[23:0]	y;
endmodule
