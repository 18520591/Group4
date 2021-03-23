module Find_Max_Min(max, min, R_G, G_B, B_R, r, g, b);
	input[31:0] r, g, b;
	output[31:0] max, min, R_G, G_B, B_R;
	
	wire[31:0] t, t1, t2, t3, t4;
	
	Sub s1(t, r, g);
	assign t1 = t[31] ? g : r;
	assign t2 = t[31] ? r : g;
	Sub s2(t3, t1, b);
	Sub s3(t4, t2, b);
	assign max = t3[31] ? b : t1;
	assign min = t4[31] ? t2 : b;
	assign R_G = t;
	Sub s4(G_B, g, b);
	Sub s5(B_R, b, r);
	
endmodule