module Integer_To_FloatingPoint(Out, In, En);
	input[7:0] In;
	input En;
	output[31:0] Out;
	wire[3:0] Length_Input;
	wire[7:0] Exponent;
	wire[22:0] Fraction;
	wire[31:0] Fraction_Temp;
	
	assign Out = (En) ? {1'b0, Exponent, Fraction} : 32'dZ;
	assign Length_Input = (In[7]) ? 4'd8 :
									((In[6]) ? 4'd7 :
									((In[5]) ? 4'd6 :
									((In[4]) ? 4'd5 :
									((In[3]) ? 4'd4 :
									((In[2]) ? 4'd3 :
									((In[1]) ? 4'd2 :
									((In[0]) ? 4'd1 : 4'd0)))))));			
	assign Exponent = (Length_Input == 4'd0) ? 8'd0 : (127 + Length_Input - 1);
	assign Fraction_Temp = 23'd0 + {In, 23'd0};
	assign Fraction = (Length_Input == 4'd0) ? 23'd0 : Fraction_Temp[Length_Input-1 +: 23];

endmodule