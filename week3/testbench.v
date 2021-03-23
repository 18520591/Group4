`timescale 1ns/1ps
module testbench;  
    reg clk, RGB_Result;
    reg[31:0] R, G, B;
    wire [31:0] H, S, V;
    wire HSV_Result; 
    integer f_id, f1_id;
    integer d;
    initial begin  
	f1_id = $fopen("/home/dat/MicrochipDesign/LAB1/rgb.txt", "r");
	f_id = $fopen("/home/dat/MicrochipDesign/LAB1/hsv.txt","w");
	d = 0;
	RGB_Result = 1;
	while (! $feof(f1_id))
	begin
		clk = 0;
		$fscanf(f1_id, "%b %b %b\n", R, G, B);
		#10
		clk = 1;
		#10
		if (d > 3)
		begin
			$fwrite(f_id, "%b\n%b\n%b\n", H, S, V);
			d = 4;
		end
		d = d + 1;
	end
	clk = 0;
	#10
	clk = 1;
	#10
	$fwrite(f_id, "%b\n%b\n%b\n", H, S, V);
	clk = 0;
	#10
	clk = 1;
	#10
	$fwrite(f_id, "%b\n%b\n%b\n", H, S, V);
	clk = 0;
	#10
	clk = 1;
	#10
	$fwrite(f_id, "%b\n%b\n%b\n", H, S, V);
	clk = 0;
	#10
	clk = 1;
	#10
	$fwrite(f_id, "%b\n%b\n%b\n", H, S, V);
	clk = 0;
	RGB_Result = 0;
	$fclose(f_id);
	$fclose(f1_id);
	#10
	$finish;
    end 
    convert Con(H, S, V, HSV_Result, R, G, B, clk, RGB_Result);
endmodule