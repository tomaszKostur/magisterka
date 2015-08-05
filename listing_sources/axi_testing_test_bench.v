`timescale 1 ns / 1 ps

	module axi_testing_test_bench
	(
	);
	reg [11-1:0] data_vector [matrix_cells*2-1 +1 : 0];

	//start debug signals
	initial begin
		data_vector[0] = 5;
		data_vector[1] = 1;
		data_vector[2] = 1;
		data_vector[3] = 1;
		data_vector[4] = 1;
		data_vector[5] = 1;
		data_vector[6] = 1;
		data_vector[7] = 1;
		data_vector[8] = 1;
		data_vector[9] = 1;
		data_vector[10] = 1;
		data_vector[11] = 1;
		data_vector[12] = 1;
		data_vector[13] = 1;
		data_vector[14] = 1;
		data_vector[15] = 1;
		data_vector[16] = 1;
		data_vector[17] = 1;
	end
	
	
    parameter MASK_SIZE = 3;
    parameter matrix_cells = MASK_SIZE * MASK_SIZE;

	wire [8-1 : 0] mask_left [matrix_cells -1 : 0];
	wire [8-1 : 0] mask_right [matrix_cells -1 : 0];
	genvar i;
	generate
		for (i=0 ; i<matrix_cells ; i=i+1)begin
			assign mask_left[i] = data_vector[i];
			assign mask_right[i] = data_vector[i+matrix_cells];
		end
	endgenerate



	//combinational per element substraction (diffrence_per_element is result)
	wire [8-1 : 0] diffrence_per_element [matrix_cells -1 : 0];
//	genvar i; // no needed in axi full other code
	generate
		for ( i=0; i<matrix_cells; i = i+1)begin
			assign diffrence_per_element[i] = (mask_left[i]>mask_right[i])? mask_left[i] - mask_right[i] : mask_right[i] - mask_left[i];
		end
	endgenerate
	//combinational sum

	parameter summation_steps_bits = 11 ;// 11 bits for max MAX_SIZE = 15
	wire [summation_steps_bits -1 : 0] summation_steps [matrix_cells-2 : 0];
	generate
		assign summation_steps[0] = diffrence_per_element[0] + diffrence_per_element[1];
		for (i=0; i<matrix_cells-2; i=i+1) begin
			assign summation_steps[i+1] = summation_steps[i] + diffrence_per_element[i+2];
		end
	endgenerate
	wire [summation_steps_bits-1 : 0] diffrence_sum;
	assign diffrence_sum = summation_steps[matrix_cells - 2];
	
	
	
	
	//end debug signals
//	parameter MASK_SIZE = 3;
//	parameter matrix_cells = MASK_SIZE * MASK_SIZE;



//	//my data vector

//	wire [8-1 : 0] mask_left [matrix_cells -1 : 0];
//	wire [8-1 : 0] mask_right [matrix_cells -1 : 0];

//	genvar i; // no needed in axi full other code
//	generate
//		for (i=0 ; i<matrix_cells ; i=i+1)begin
//			assign mask_left[i] = data_vector[i];
//			assign mask_right[i] = data_vector[i+matrix_cells];
////`			assign data_vector[matrix_cells*2] = diffrence_sum;
//		end
//	endgenerate








////combinational per element substraction (diffrence_per_element is result)
//	wire [8-1 : 0] diffrence_per_element [matrix_cells -1 : 0];

//	generate
//		for ( i=0; i<matrix_cells; i = i+1)begin
//			assign diffrence_per_element[i] = (mask_left[i]>mask_right[i])? mask_left[i] - mask_right[i] : mask_right[i] - mask_left[i];
//		end
//	endgenerate
//	//combinational sum

//	parameter summation_steps_bits = 11 ;// 11 bits for max MAX_SIZE = 15
//	wire [summation_steps_bits -1 : 0] summation_steps [matrix_cells-2 : 0];
//	generate
//		assign summation_steps[0] = diffrence_per_element[0] + diffrence_per_element[1];
//		for (i=0; i<matrix_cells-2; i=i+1) begin
//			assign summation_steps[i+1] = summation_steps[i] + diffrence_per_element[i+2];
//		end
//	endgenerate
//	wire [summation_steps_bits-1 : 0] diffrence_sum;
//	assign diffrence_sum = summation_steps[matrix_cells - 2];

//	//filling mask_left and mask_right matrixes
	


	endmodule

