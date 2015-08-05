`timescale 1 ns / 1 ps

module stereo_solver_test_bench
	(
	);
// clock generation for test bench	
	reg clk = 0;

	always begin
	#5 clk = !clk;	
	end
	

	reg test_reg = 8;

	always @ (posedge clk) begin
		test_reg <= test_reg -1;
	end
// e[MaEnd of clock generation of test bench

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//test bench for stereo solver module

	parameter MASK_SIZE = 5;
	parameter MATCH_WIDE = 18;
	parameter POSITION_BITS = 8;

	reg [8-1 : 0] mask [MASK_SIZE*MASK_SIZE-1 : 0];
	reg [8-1 : 0] match_array [MASK_SIZE*MATCH_WIDE-1 : 0];
	reg [POSITION_BITS-1 : 0] mask_position = 15;
	reg [POSITION_BITS-1 : 0] match_position = 0;
	wire [8-1 : 0] DISSPARITION;

	initial begin
		mask[0 ] = 1;		
		mask[1 ] = 0;		
		mask[2 ] = 0;
		mask[3 ] = 0;
		mask[4 ] = 0;

		mask[5 ] = 0;		
		mask[6 ] = 5;		
		mask[7 ] = 0;
		mask[8 ] = 0;
		mask[9 ] = 0;

		mask[10] = 0;		
		mask[11] = 0;		
		mask[12] = 4;		
		mask[13] = 0;
		mask[14] = 0;

		mask[15] = 0;
		mask[16] = 0;
		mask[17] = 0;
		mask[18] = 6;
		mask[19] = 0;

		mask[20] = 0;
		mask[21] = 0;
		mask[22] = 0;
		mask[23] = 0;
		mask[24] = 8;

		match_array[0 ] = 0;
		match_array[1 ] = 1;
		match_array[2 ] = 0;
		match_array[3 ] = 0;
		match_array[4 ] = 0;
		match_array[5 ] = 0;
		match_array[6 ] = 0;
		match_array[7 ] = 0;
		match_array[8 ] = 0;
		match_array[9 ] = 0;
		match_array[10] = 0;
		match_array[11] = 0;
		match_array[12] = 0;
		match_array[13] = 0;
		match_array[14] = 0;
		match_array[15] = 0;
		match_array[16] = 0;
		match_array[17] = 0;


		match_array[18] = 0;
		match_array[19] = 0;
		match_array[20] = 5;
		match_array[21] = 0;
		match_array[22] = 0;
		match_array[23] = 0;
		match_array[24] = 0;
		match_array[25] = 0;
		match_array[26] = 0;
		match_array[27] = 0;
		match_array[28] = 0;
		match_array[29] = 0;
		match_array[30] = 0;
		match_array[31] = 0;
		match_array[32] = 0;
		match_array[33] = 0;
		match_array[34] = 0;
		match_array[35] = 0;


		match_array[36] = 0;
		match_array[37] = 0;
		match_array[38] = 0;
		match_array[39] = 4;
		match_array[40] = 0;
		match_array[41] = 0;
		match_array[42] = 0;
		match_array[43] = 0;
		match_array[44] = 0;
		match_array[45] = 0;
		match_array[46] = 0;
		match_array[47] = 0;
		match_array[48] = 0;
		match_array[49] = 0;
		match_array[50] = 0;
		match_array[51] = 0;
		match_array[52] = 0;
		match_array[53] = 0;

		match_array[54] = 0;
		match_array[55] = 0;
		match_array[56] = 0;
		match_array[57] = 0;
		match_array[58] = 6;
		match_array[59] = 0;
		match_array[60] = 0;
		match_array[61] = 0;
		match_array[62] = 0;
		match_array[63] = 0;
		match_array[64] = 0;
		match_array[65] = 0;
		match_array[66] = 0;
		match_array[67] = 0;
		match_array[68] = 0;
		match_array[69] = 0;
		match_array[70] = 0;
		match_array[71] = 0;

		match_array[72] = 0;
		match_array[73] = 0;
		match_array[74] = 0;
		match_array[75] = 0;
		match_array[76] = 0;
		match_array[77] = 8;
		match_array[78] = 0;
		match_array[79] = 0;
		match_array[80] = 0;
		match_array[81] = 0;
		match_array[82] = 0;
		match_array[83] = 0;
		match_array[84] = 0;
		match_array[85] = 0;
		match_array[86] = 0;
		match_array[87] = 0;
		match_array[88] = 0;
		match_array[89] = 0;

	end

	wire [8*MASK_SIZE*MASK_SIZE-1 : 0] flattern_mask;
	wire [8*MASK_SIZE*MATCH_WIDE-1 :0] flattern_match_array;
	genvar i;
	generate
		for(i=0; i<MASK_SIZE*MASK_SIZE; i=i+1)begin
			assign flattern_mask[i*8 +: 8] = mask[i];
		end

		for(i=0; i<MASK_SIZE*MATCH_WIDE; i=i+1)begin
			assign flattern_match_array[i*8 +: 8] = match_array [i];
		end
	endgenerate

	stereo_solver # 
	(
		.MASK_SIZE(MASK_SIZE),
		.MATCH_WIDE(MATCH_WIDE),
		.POSITION_BITS(POSITION_BITS)
	)
	hehehe(
		.flattern_mask         (flattern_mask),
		.flattern_match_array  (flattern_match_array),
		.mask_position         (mask_position),
		.match_position        (match_position),
		.DISSPARITION           (DISSPARITION)
	);


// larger test witch mask size 3 and match wide 18

//	parameter MASK_SIZE = 3;
//	parameter MATCH_WIDE = 18;
//	parameter POSITION_BITS = 11;
//
//	reg [8-1 : 0] mask [MASK_SIZE*MASK_SIZE-1 : 0];
//	reg [8-1 : 0] match_array [MASK_SIZE*MATCH_WIDE-1 : 0];
//	reg [POSITION_BITS-1 : 0] mask_position = 15;
//	reg [POSITION_BITS-1 : 0] match_position = 0;
//	wire [8-1 : 0] DISSPARITION;
//
//	initial begin
//		mask[0] = 1;		
//		mask[1] = 0;		
//		mask[2] = 0;
//
//		mask[3] = 0;		
//		mask[4] = 5;		
//		mask[5] = 0;
//
//		mask[6] = 0;		
//		mask[7] = 0;		
//		mask[8] = 4;		
//		
//		match_array[0 ] = 0;
//		match_array[1 ] = 1;
//		match_array[2 ] = 0;
//		match_array[3 ] = 0;
//		match_array[4 ] = 0;
//		match_array[5 ] = 0;
//		match_array[6 ] = 0;
//		match_array[7 ] = 0;
//		match_array[8 ] = 0;
//		match_array[9 ] = 0;
//		match_array[10] = 0;
//		match_array[11] = 0;
//		match_array[12] = 0;
//		match_array[13] = 0;
//		match_array[14] = 0;
//		match_array[15] = 0;
//		match_array[16] = 0;
//		match_array[17] = 0;
//
//
//		match_array[18] = 0;
//		match_array[19] = 0;
//		match_array[20] = 5;
//		match_array[21] = 0;
//		match_array[22] = 0;
//		match_array[23] = 0;
//		match_array[24] = 0;
//		match_array[25] = 0;
//		match_array[26] = 0;
//		match_array[27] = 0;
//		match_array[28] = 0;
//		match_array[29] = 0;
//		match_array[30] = 0;
//		match_array[31] = 0;
//		match_array[32] = 0;
//		match_array[33] = 0;
//		match_array[34] = 0;
//		match_array[35] = 0;
//
//
//		match_array[36] = 0;
//		match_array[37] = 0;
//		match_array[38] = 0;
//		match_array[39] = 0;
//		match_array[40] = 4;
//		match_array[41] = 0;
//		match_array[42] = 0;
//		match_array[43] = 0;
//		match_array[44] = 0;
//		match_array[45] = 0;
//		match_array[46] = 0;
//		match_array[47] = 0;
//		match_array[48] = 0;
//		match_array[49] = 0;
//		match_array[50] = 0;
//		match_array[51] = 0;
//		match_array[52] = 0;
//		match_array[53] = 0;
//
//	end
//
//	wire [8*MASK_SIZE*MASK_SIZE-1 : 0] flattern_mask;
//	wire [8*MASK_SIZE*MATCH_WIDE-1 :0] flattern_match_array;
//	genvar i;
//	generate
//		for(i=0; i<MASK_SIZE*MASK_SIZE; i=i+1)begin
//			assign flattern_mask[i*8 +: 8] = mask[i];
//		end
//
//		for(i=0; i<MASK_SIZE*MATCH_WIDE; i=i+1)begin
//			assign flattern_match_array[i*8 +: 8] = match_array [i];
//		end
//	endgenerate
//
//	stereo_solver # 
//	(
//		.MASK_SIZE(MASK_SIZE),
//		.MATCH_WIDE(MATCH_WIDE),
//		.POSITION_BITS(POSITION_BITS)
//	)
//	hehehe(
//		.flattern_mask         (flattern_mask),
//		.flattern_match_array  (flattern_match_array),
//		.mask_position         (mask_position),
//		.match_position        (match_position),
//		.DISSPARITION           (DISSPARITION)
//	);


/////////////////////////////////////////////////////////////////////////////////////////
// simpliest test bench for 4 match wide and 3 mask size

//	parameter MASK_SIZE = 3;
//	parameter MATCH_WIDE = 4;
//	parameter POSITION_BITS = 11;
//
//	reg [8-1 : 0] mask [MASK_SIZE*MASK_SIZE-1 : 0];
//	reg [8-1 : 0] match_array [MASK_SIZE*MATCH_WIDE-1 : 0];
//	reg [POSITION_BITS-1 : 0] mask_position = 3;
//	reg [POSITION_BITS-1 : 0] match_position = 0;
//	wire [8-1 : 0] DISSPARITION;
//
//	initial begin
//		mask[0] = 1;		
//		mask[1] = 0;		
//		mask[2] = 0;
//
//		mask[3] = 0;		
//		mask[4] = 5;		
//		mask[5] = 0;
//
//		mask[6] = 0;		
//		mask[7] = 0;		
//		mask[8] = 4;		
//		
//		match_array[0] = 0;
//		match_array[1] = 1;
//		match_array[2] = 0;
//		match_array[3] = 0;
//
//		match_array[4] = 0;
//		match_array[5] = 0;
//		match_array[6] = 5;
//		match_array[7] = 0;
//		
//		match_array[8] = 0;
//		match_array[9] = 0;
//		match_array[10] = 0;
//		match_array[11] = 4;
//
//	end
//
//	wire [8*MASK_SIZE*MASK_SIZE-1 : 0] flattern_mask;
//	wire [8*MASK_SIZE*MATCH_WIDE-1 :0] flattern_match_array;
//	genvar i;
//	generate
//		for(i=0; i<MASK_SIZE*MASK_SIZE; i=i+1)begin
//			assign flattern_mask[i*8 +: 8] = mask[i];
//		end
//
//		for(i=0; i<MASK_SIZE*MATCH_WIDE; i=i+1)begin
//			assign flattern_match_array[i*8 +: 8] = match_array [i];
//		end
//	endgenerate
//
//	stereo_solver # 
//	(
//		.MASK_SIZE(MASK_SIZE),
//		.MATCH_WIDE(MATCH_WIDE),
//		.POSITION_BITS(POSITION_BITS)
//	)
//	hehehe(
//		.flattern_mask         (flattern_mask),
//		.flattern_match_array  (flattern_match_array),
//		.mask_position         (mask_position),
//		.match_position        (match_position),
//		.DISSPARITION           (DISSPARITION)
//	);
//

//end of test bench for stereo solver module

//////////////////////////////////////////////////////////////////////////////////////////////////////

//test bench for choosing min vector element

//	parameter vector_cells = 16;
//	reg [8-1 : 0] vector [vector_cells-1 : 0];
//	
//	initial begin
//
//		vector[0 ] = 5 ;
//		vector[1 ] = 5 ;
//		vector[2 ] = 5 ;
//		vector[3 ] = 5 ;
//		vector[4 ] = 4 ;
//		vector[5 ] = 5 ;
//		vector[6 ] = 6 ;
//		vector[7 ] = 7 ;
//		vector[8 ] = 8 ;
//		vector[9 ] = 3 ;
//		vector[10] = 10;
//		vector[11] = 11;
//		vector[12] = 12;
//		vector[13] = 13;
//		vector[14] = 14;
//		vector[15] = 15;
//
//	end
//	
//	parameter sort_vec_cells = vector_cells*2-1;
//	wire [8-1 : 0] sort_vec [sort_vec_cells-1 : 0];
//	wire [8-1 : 0] sort_vec_cell [sort_vec_cells-1 : 0];
//	genvar i;
//	generate
//		for(i=0; i<vector_cells; i=i+1)begin
//			assign sort_vec[i] = vector[i];
//			assign sort_vec_cell[i] = i;
//		end
//		for(i=0; i<sort_vec_cells; i=i+2)begin
//			localparam push_cell = i/2+vector_cells;
//			assign sort_vec[push_cell] = (sort_vec[i] < sort_vec[i+1])? sort_vec[i] : sort_vec[i+1];
//			assign sort_vec_cell[push_cell] = (sort_vec[i] < sort_vec[i+1])? sort_vec_cell[i] : sort_vec_cell[i+1];
//		end
//	endgenerate
//	
//	wire [8-1 : 0] min_of_vector;
//	wire [8-1 : 0] min_of_vector_cell;
//	assign min_of_vector = sort_vec [sort_vec_cells-1];
//	assign min_of_vector_cell = sort_vec_cell [sort_vec_cells-1];

//end of test bench for choosing min vector element

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//test_bench for matcher modulei

//	parameter MASK_SIZE = 3;
//	parameter matrix_cells = MASK_SIZE * MASK_SIZE;
//
//
//	reg [8-1 : 0] maskL [matrix_cells-1 : 0];
//	reg [8-1 : 0] maskR [matrix_cells-1 : 0];
//	wire [9-1:0] match_result;
//
//	initial begin
//
//		maskL[0] = 1;
//		maskL[1] = 2;
//		maskL[2] = 3;
//		maskL[3] = 0;
//		maskL[4] = 0;
//		maskL[5] = 0;
//		maskL[6] = 0;
//		maskL[7] = 0;
//		maskL[8] = 7;
//
//		maskR[0] = 5;
//		maskR[1] = 2;
//		maskR[2] = 1;
//		maskR[3] = 0;
//		maskR[4] = 0;
//		maskR[5] = 0;
//		maskR[6] = 0;
//		maskR[7] = 0;
//		maskR[8] = 7;
//
//	end
//
//	wire [8*matrix_cells-1 : 0] flattern_maskL;
//	wire [8*matrix_cells-1 : 0] flattern_maskR;
//	genvar i;
//	generate
//		for(i=0; i<matrix_cells; i=i+1)begin
//			assign flattern_maskL [i*8 +: 8] = maskL[i];
//		end
//		
//		for(i=0; i<matrix_cells; i=i+1)begin
//         	   assign flattern_maskR [i*8 +: 8] = maskR[i];
//     		end
//	endgenerate
//	
//
//	matcher #
//	(
//		.MATRIX_CELLS(matrix_cells),
//		.SUMMATION_STEPS_BITS(10)
//	)
//	hehehe(
//		.flattern_maskA(flattern_maskL),
//		.flattern_maskB(flattern_maskR),
//		.match(match_result)
//	);


//end test_bench for mather module

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

endmodule
