module Reg3_Reg4(t4, t5, t6, s34, v34, Max_R34, Max_G34, Max_B34, t1, t2, t3, s23, v23, Max_R23, Max_G23, Max_B23, En);
	input[31:0] t1, t2, t3, s23, v23;
	input Max_R23, Max_G23, Max_B23, En;
	output[31:0] t4, t5, t6, s34, v34;
	output Max_R34, Max_G34, Max_B34;

	Add a1(t4, t1, 32'b01000011001010110000000000000000, En);
	assign t5 = t2;
	Add a2(t6, t3, 32'b01000010101010100000000000000000, En);
	Mul m1(v34, v23, 32'b01000010110010000000000000000000, En);
	Mul m2(s34, s23, 32'b01000010110010000000000000000000, En);
	assign Max_R34 = Max_R23;
	assign Max_G34 = Max_G23;
	assign Max_B34 = Max_B23;
	
endmodule
