module convert(H, S, V, HSV_Result, R, G, B, clk, RGB_Result);
	input[31:0] R, G, B;
	input clk, RGB_Result;
	output[31:0] H, S, V;
	output reg HSV_Result;
	
	wire[31:0] Max, Min, Max12, s23, v23, s34, v34, R_G, G_B, B_R, t4, t5, t6, B_Rx43, t2, t3, G_Bx43, t1, R_Gx43, diff;
	wire Max_R, Max_G, Max_B, Max_R23, Max_G23, Max_B23, Max_R34, Max_G34, Max_B34;
	reg[31:0] h, s, v;
	reg[31:0] reg1 [7:0];
	reg[31:0] reg2 [7:0];
	reg[31:0] reg3 [7:0];
	reg[31:0] reg4 [7:0];
	reg reg11, reg22, reg33, reg44;
	
	
	always @ (posedge clk)
	begin
		reg1[0] <= R_G;
		reg1[1] <= G_B;
		reg1[2] <= B_R;
		reg1[3] <= Max;
		reg1[4] <= Min;
		reg1[5] <= R;
		reg1[6] <= G;
		reg1[7] <= B;
		reg11 <= RGB_Result;
			
		reg2[0] <= R_Gx43;
		reg2[1] <= G_Bx43;
		reg2[2] <= B_Rx43;
		reg2[3] <= diff;
		reg2[4] <= Max_R;
		reg2[5] <= Max_G;
		reg2[6] <= Max_B;
		reg2[7] <= Max12;
		reg22 <= reg11;
			
		reg3[0] <= t1;
		reg3[1] <= t2;
		reg3[2] <= t3;
		reg3[3] <= s23;
		reg3[4] <= v23;
		reg3[5] <= Max_R23;
		reg3[6] <= Max_G23;
		reg3[7] <= Max_B23;
		reg33 <= reg22;
			
		reg4[0] <= t4;
		reg4[1] <= t5; 
		reg4[2] <= t6; 
		reg4[3] <= s34;
		reg4[4] <= v34;
		reg4[5] <= Max_R34;
		reg4[6] <= Max_G34;
		reg4[7] <= Max_B34;
		reg44 <= reg33;
		
		if(reg44)
		begin
			v <= reg4[4];
			s <= reg4[3];
			h <= (reg4[5]) ? reg4[1] : ((reg4[6]) ? reg4[2] : reg4[0]);
			HSV_Result <= 1'b1;
		end
		else
		begin
			v <= 32'bZ;
			s <= 32'bZ;
			h <= 32'bZ;
			HSV_Result <= 1'b0;
		end
	end
	
	Find_Max_Min fmm(Max, Min, R_G, G_B, B_R, R, G, B);
	Reg1_Reg2 R12(R_Gx43, G_Bx43, B_Rx43, diff, Max_R, Max_G, Max_B, Max12, reg1[0], reg1[1], reg1[2], reg1[3], reg1[4], reg1[5], reg1[6], reg1[7]);
	Reg2_Reg3 R23(t1, t2, t3, s23, v23, Max_R23, Max_G23, Max_B23, reg2[0], reg2[1], reg2[2], reg2[3], reg2[7], reg2[4], reg2[5], reg2[6]);
	
	Reg3_Reg4 R34(t4, t5, t6, s34, v34, Max_R34, Max_G34, Max_B34, reg3[0], reg3[1], reg3[2], reg3[3], reg3[4], reg3[5], reg3[6], reg3[7]);
	
	assign V = v;
	assign S = s;
	assign H = h;
	
endmodule