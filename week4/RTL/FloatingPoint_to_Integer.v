module FloatingPoint_to_Integer(Float,Integer, En);
	input [31:0] Float;
	input En;
	output [8:0] Integer;
	wire [23:0] Integer_Value;
	wire [7:0] e_value;

	assign Integer = (En) ? Integer_Value[8:0] : 9'dZ;
	assign e_value = 8'b00010111-(Float[30:23]-8'b01111111);
	assign Integer_Value[23:0] = {1'b1,Float[22:0]}>>e_value;
endmodule
