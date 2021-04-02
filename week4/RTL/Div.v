module Div(OUT, InA, InB, En);
	input [31:0] InA, InB;
	input En;
	output [31:0] OUT;
	reg[31:0] Out;
	reg Sign;
	reg [7:0] Exponent_A, Exponent_B, Exponent, Exponent_Temp;
	reg [47:0] Fraction_Temp, Fraction_B, Fraction_A;
	reg [22:0] Fraction;
	
	always @(*)
	begin
	if (InA == 32'b0 && InB == 32'b0)
			Out = 32'bz;
	else 
		if (InA == 32'b0)
			Out = 32'b0;
		else 
			if (InB == 32'b0)
				Out = 32'bz;
			else
				begin
					Sign = InA[31] ^ InB[31];
					Exponent_A = InA[30:23];
					Exponent_B = InB[30:23];
					Fraction_A = {1'b1, InA[22:0], 24'b0};
					Fraction_B = {24'b0,1'b1, InB[22:0]};
					Exponent_Temp = (Exponent_A - 8'd127) - (Exponent_B - 8'd127) + 8'd127;
					Fraction_Temp = Fraction_A / Fraction_B;
				if (Fraction_Temp[23] == 1)
					begin
						Fraction = {Fraction_Temp[22:0]};
						Exponent = Exponent_Temp-1;
					end
					else
					begin
						Fraction = Fraction_Temp[23:1];
						Exponent = Exponent_Temp;
					end
					Out = (En) ? {Sign, Exponent, Fraction} : 32'dZ;
				end
	end
	assign OUT = (En) ? Out : 32'dZ;
endmodule