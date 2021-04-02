module convert(H, S, V, HSV_Result, R, G, B, clk, RGB_Result);
	input[31:0] R, G, B;
	input clk, RGB_Result;
	output[31:0] H, S, V;
	output reg HSV_Result;
	
	wire[31:0] Max, Min, Max12, s23, v23, s34, v34, R_G, G_B, B_R, t4, t5, t6, B_Rx43, G_Bx43, R_Gx43, diff, t1, t2, t3, r, g, b;
	wire Max_R23, Max_G23, Max_B23, Max_R34, Max_G34, Max_B34, Max_R, Max_G, Max_B;
	wire[8:0] Integer_S, Integer_V;
	wire[8:0] Integer_H [2:0];
	reg[31:0] h, s, v;
	reg[31:0] reg1 [7:0];
	reg[31:0] reg2 [7:0];
	reg[31:0] reg3 [7:0];
	reg[31:0] reg4 [7:0];
	reg reg11, reg22, reg33, reg44, reg24, reg25, reg26, reg35, reg36, reg37, reg45, reg46, reg47, reg00, reg55, reg56, reg57, reg58;
	reg[31:0] reg0 [2:0];
	reg[8:0] reg5 [4:0];

	
	always @ (posedge clk)
	begin

		reg00 <= RGB_Result;
		reg0[0] <= r;
		reg0[1] <= g;
		reg0[2] <= b;
	
		reg1[0] <= R_G;
		reg1[1] <= G_B;
		reg1[2] <= B_R;
		reg1[3] <= Max;
		reg1[4] <= Min;
		reg1[5] <= reg0[0];
		reg1[6] <= reg0[1];
		reg1[7] <= reg0[2];
		reg11 <= reg00;
			
		reg2[0] <= R_Gx43;
		reg2[1] <= G_Bx43;
		reg2[2] <= B_Rx43;
		reg2[3] <= diff;
		reg24 <= Max_R;
		reg25 <= Max_G;
		reg26 <= Max_B;
		reg2[7] <= Max12;
		reg22 <= reg11;
			
		reg3[0] <= t1;
		reg3[1] <= t2;
		reg3[2] <= t3;
		reg3[3] <= s23;
		reg3[4] <= v23;
		reg35 <= Max_R23;
		reg36 <= Max_G23;
		reg37 <= Max_B23;
		reg33 <= reg22;
			
		reg4[0] <= t4;
		reg4[1] <= t5; 
		reg4[2] <= t6; 
		reg4[3] <= s34;
		reg4[4] <= v34;
		reg45 <= Max_R34;
		reg46 <= Max_G34;
		reg47 <= Max_B34;
		reg44 <= reg33;


		reg55 <= reg44;
		reg5[0] <= Integer_H[0];
		reg5[1] <= Integer_H[1];
		reg5[2] <= Integer_H[2];
		reg5[3] <= Integer_S;
		reg5[4] <= Integer_V;
		reg56 <= reg45;
		reg57 <= reg46;
		reg58 <= reg47;
		
		if(reg55)
		begin
			v <= reg5[4];
			s <= reg5[3];
			h <= (reg56) ? reg5[1] : ((reg57) ? reg5[2] : reg5[0]);
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
	
	Find_Max_Min fmm(Max, Min, R_G, G_B, B_R, reg0[0], reg0[1], reg0[2], reg00);
	Reg1_Reg2 R12(R_Gx43, G_Bx43, B_Rx43, diff, Max_R, Max_G, Max_B, Max12, reg1[0], reg1[1], reg1[2], reg1[3], reg1[4], reg1[5], reg1[6], reg1[7], reg11);
	Reg2_Reg3 R23(t1, t2, t3, s23, v23, Max_R23, Max_G23, Max_B23, reg2[0], reg2[1], reg2[2], reg2[3], reg2[7], reg24, reg25, reg26, reg22);
	Reg3_Reg4 R34(t4, t5, t6, s34, v34, Max_R34, Max_G34, Max_B34, reg3[0], reg3[1], reg3[2], reg3[3], reg3[4], reg35, reg36, reg37, reg33);
	
	Integer_To_FloatingPoint I_T_F1(r, R, RGB_Result);
	Integer_To_FloatingPoint I_T_F2(g, G, RGB_Result);
	Integer_To_FloatingPoint I_T_F3(b, B, RGB_Result);
	FloatingPoint_to_Integer F_T_I1(reg4[0],Integer_H[0], reg44);
	FloatingPoint_to_Integer F_T_I2(reg4[1],Integer_H[1], reg44);
	FloatingPoint_to_Integer F_T_I3(reg4[2],Integer_H[2], reg44);
	FloatingPoint_to_Integer F_T_I4(reg4[4],Integer_V, reg44);
	FloatingPoint_to_Integer F_T_I5(reg4[3],Integer_S, reg44);	

	assign V = v;
	assign S = s;
	assign H = h;
	
endmodule
