module Reg1_Reg2(R_Gx43, G_Bx43, B_Rx43, diff, Max_R, Max_G, Max_B, Max12, R_G, G_B, B_R, Max, Min, R, G, B);
	input[31:0] R_G, G_B, B_R, Max, Min, R, G, B;
	output[31:0] R_Gx43, G_Bx43, B_Rx43, diff, Max12;
	output Max_R, Max_G, Max_B;

	Mul m1(R_Gx43, {1'b0, R_G[30:0]}, 32'b01000010001011000000000000000000);
	Mul m2(G_Bx43, {1'b0, G_B[30:0]}, 32'b01000010001011000000000000000000);
	Mul m3(B_Rx43, {1'b0, B_R[30:0]}, 32'b01000010001011000000000000000000);

	Sub s1(diff, Max, Min);
	assign Max_R = (Max == R) ? 1 : 0;
	assign Max_G = (Max == G) ? 1 : 0;
	assign Max_B = (Max == B) ? 1 : 0;
	assign Max12 = Max; 
endmodule