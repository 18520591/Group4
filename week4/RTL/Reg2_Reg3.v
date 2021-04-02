module Reg2_Reg3(t1, t2, t3, s23, v23, Max_R23, Max_G23, Max_B23, R_Gx43, G_Bx43, B_Rx43, diff, Max12, Max_R12, Max_G12, Max_B12, En);
	input[31:0] R_Gx43, G_Bx43, B_Rx43, diff, Max12;
	input Max_R12, Max_G12, Max_B12, En;
	output[31:0] t1, t2, t3, s23, v23;
	output Max_R23, Max_G23, Max_B23;
	wire[31:0] m1, m2, m3, m4;
	
	Div d1(m2, R_Gx43, diff, En);
	Div d2(m3, G_Bx43, diff, En);
	Div d3(m4, B_Rx43, diff, En);
	assign t1 = (diff == 32'd0) ? 32'd0 : m2;
	assign t2 = (diff == 32'd0) ? 32'd0 : m3;
	assign t3 = (diff == 32'd0) ? 32'd0 : m4;
	assign Max_R23 = Max_R12;
	assign Max_G23 = Max_G12;
	assign Max_B23 = Max_B12;
	Div d4(v23, Max12, 32'b01000011011111110000000000000000, En);
	Div d5(m1, diff, Max12, En);
	assign s23 = (Max12 == 32'd0) ? 32'd0 : m1;
	
endmodule
