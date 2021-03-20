module rgb_to_hsv(r, g, b, h, s, v, clk);
	input clk;
	input[15:0] r, g, b;
	output reg[15:0] h, s, v;
	reg[15:0] max, min, diff, temp;
	always @ (posedge clk)
	begin
		max = r > g ? r : g;
		max = max > b ? max : b;
		min = r > g ? g : r;
		min = min > b ? b : min;
		diff = max - min;
		v = 100*max/255;
		if(max == 0)
			s = 0;
		else
			s = 100*diff/max;
		if(max == min)
			h = 0;
		else if (max == r)
		begin
			temp = g > b ? g-b : b-g;
			h = 60*temp/diff;
		end
		else if (max == g)
		begin
			temp = b > r ? b-r : r-b;
			h = 85 + 60*temp/diff;
		end
		else
		begin
			temp = r > g ? r-g : g-r;
			h = 171 + 60*temp/diff;
		end
	end
endmodule