`timescale 1ns/1ps
module testbench;  
    reg clk;
    reg[15:0] r, g, b;
    wire [15:0] h, s, v; 
    integer f_id, f1_id;
    initial begin  
	f1_id = $fopen("/home/dat/MicrochipDesign/LAB1/rgb.txt", "r");
	f_id = $fopen("/home/dat/MicrochipDesign/LAB1/hsv.txt","w");
	while (! $feof(f1_id))
	begin
		clk <= 0;
		$fscanf(f1_id, "%d %d %d\n", r, g, b);
		#10
		clk <= 1;
		#10
		$fwrite(f_id, "%d\n%d\n%d\n", h, s, v);
	end
	#10	
	$fclose(f_id);
	$fclose(f1_id);
	#10
	$finish;
    end 
    rgb_to_hsv rgb_hsv(r, g, b, h, s, v, clk);
endmodule