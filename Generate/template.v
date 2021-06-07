module featuremap_template #(
    parameter bias = {{bias}};
    parameter data_width = 32;
    parameter img_heigh = 112;
    parameter img_width = 112;
)
(
    clk, 
    reset,
    valid_in,
    data_in1,
    data_in2,
    data_in3,
    data_out,
    valid_out,
    done
);

    input clk, reset, valid_in;
    input [data_width-1:0] data_in1, data_in2, data_in3;

    output valid_out, done;
    output [data_width-1:0] data_out;

    wire [data_width-1:0] data_out1, data_out2, data_out3;
    wire valid_out_1, valid_out_2, valid_out_3;
    
conv2D3x3 #(
    {{w0_1}},
	{{w1_1}},
	{{w2_1}},
	{{w3_1}},
	{{w4_1}},
	{{w5_1}},
    {{w6_1}},
    {{w7_1}},
    {{w8_1}},
    data_width,
    img_heigh,
    img_width
)
conv2D_ins1 
(
    clk,
	reset,
	valid_in,
	data_in_1,
	valid_out_1,
	done_1,
	data_out_1
)

conv2D3x3 #(
    {{w0_2}},
	{{w1_2}},
	{{w2_2}},
	{{w3_2}},
	{{w4_2}},
	{{w5_2}},
    {{w6_2}},
    {{w7_2}},
    {{w8_2}},
    data_width,
    img_heigh,
    img_width
)
conv2D_ins2 
(
    clk,
	reset,
	valid_in,
	data_in_2,
	valid_out_2,
	done_2,
	data_out_2
)

conv2D3x3 #(
    {{w0_3}},
	{{w1_3}},
	{{w2_3}},
	{{w3_3}},
	{{w4_3}},
	{{w5_3}},
    {{w6_3}},
    {{w7_3}},
    {{w8_3}},
    data_width,
    img_heigh,
    img_width
)
conv2D_ins3
(
    clk,
	reset,
	valid_in,
	data_in_3,
	valid_out_3,
	done_3,
	data_out_3
)

fp_adder_4 fp_adder_4_ins(clk,reset,valid_out_1,data_out_1,data_out_2,data_out_3,data_out,valid_out_add, bias);

counter #(data_width, img_heigh, img_width) counter_ins(clk, reset, valid_out, done);

assign valid_out = valid_out_1;

endmodule