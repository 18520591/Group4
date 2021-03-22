module BEQ(out, InA, InB);
	input [31:0] InA, InB;
	output reg out;
	
	wire Sign_A, Sign_B;
	wire [7:0] Exponent_A, Exponent_B;
	wire [22:0] Fraction_A, Fraction_B;
	
	assign Sign_A = InA[31];
	assign Sign_B = InB[31];
	assign Exponent_A = InA[30:23];
	assign Exponent_B = InB[30:23];
	assign Fraction_A = InA[22:0];
	assign Fraction_B = InB[22:0];
	
	always @ (*)
	begin
		if(Sign_A > Sign_B )
			out <= 1'b0;
		else if(Sign_A < Sign_B)
			out <= 1'b1;
		else
		begin
			if (Exponent_A > Exponent_B)
				out <= 1'b1;
			else if (Exponent_A < Exponent_B)
				out <= 1'b0;
			else
			begin
				if(Fraction_A > Fraction_B)
					out <= 1'b1;
				else
					out <= 1'b0;
			end
		end
	end
endmodule
