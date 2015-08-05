`timescale 1 ns / 1 ps

// UWAGA!!! to zdaje sie byc puki co bardzo wazne aby dobierac tak parametry
// aby: "matches_vector_cells" ; definiowany jako: "MATCH_WIDE-(MASK_SIZE-1)"
// byl jakas potega liczby 2 !!!!!

	module stereo_solver #
	(
		parameter MASK_SIZE = 3,
		parameter MATCH_WIDE = 16,
		parameter POSITION_BITS = 11
	)
	(	
		output wire [8-1 : 0] debug1,
		output wire [8-1 : 0] debug2,
		output wire [8-1 : 0] debug3,

		input wire  [8*(MASK_SIZE*MASK_SIZE)-1  : 0] flattern_mask,
		input wire [8*(MASK_SIZE*MATCH_WIDE)-1  : 0] flattern_match_array,
		input wire [POSITION_BITS-1 : 0] mask_position,
		input wire[POSITION_BITS-1 : 0] match_position,
		output wire [8-1  : 0] DISSPARITION
	);
		parameter mask_cells = MASK_SIZE * MASK_SIZE;

		genvar i,j,k;
		parameter matches_vector_cells = MATCH_WIDE-(MASK_SIZE-1);
		wire [13-1 : 0] matches_vector [matches_vector_cells-1 : 0];//13 od 255*25 = 6000 ponad wiec 2^13
		generate
			for(i=0; i<matches_vector_cells; i=i+1)begin//ten dziwny inkrementator to od tego ze krawedzie maski
// tutaj trzeba jakos w sparametryzowany sposob oznaczyc wlasciwa maske do zmatchowania;
				wire [8-1 : 0] match_mask [MASK_SIZE-1 : 0][MASK_SIZE-1 : 0];
				for(j=0; j<MASK_SIZE; j=j+1)begin
					for(k=0; k<MASK_SIZE; k=k+1)begin
						assign match_mask[j][k] = flattern_match_array[((k+i)*8+j*MATCH_WIDE*8)  +: 8];
					end
				end
//wyplaszczanie maski dowektora bitow w celu zmatchowania 
				wire [8*mask_cells-1 : 0] flattern_match_mask;
				for (j=0; j<MASK_SIZE; j=j+1) begin
					for(k=0; k<MASK_SIZE; k=k+1)begin
						assign flattern_match_mask[j*MASK_SIZE*8+k*8 +: 8] = match_mask[j][k];
					end
				end
////////////////////////////////////////////////////////////////////////////
				if (i==1)begin
					assign debug1 = match_mask[0][0];
					assign debug2 = match_mask[0][1];
				end

////////////////////////////////////////////////////////////
				matcher # 
				(
					.MATRIX_CELLS(mask_cells),
					.SUMMATION_STEPS_BITS(11)
				)
				gen_matcher (
					.flattern_maskA(flattern_mask),
					.flattern_maskB(flattern_match_mask),
					.match(matches_vector[i])
				);
			end
		endgenerate
//linia matches_vector obliczona, teraz wybieranie najmniejszego elementu
//do nastepnej czesci przechodza zmienne: "matches_vector" oraz "matches_vector_cells"
// suma ciągu geometrycznego o wyrazach calkowitych jest dlugoscia wektora: "sort_vec"

		parameter sort_vec_cells = matches_vector_cells*2-1;
		wire [8-1 : 0] sort_vec [sort_vec_cells-1 : 0];
		wire [8-1 : 0] sort_vec_cell [sort_vec_cells-1 : 0];

		generate
			for(i=0; i<matches_vector_cells; i=i+1)begin
				assign sort_vec[i] = matches_vector[i];
				assign sort_vec_cell[i] = i;
			end
			for(i=0; i<sort_vec_cells-1; i=i+2)begin
				localparam push_cell = i/2 + matches_vector_cells;
				assign sort_vec[push_cell] = (sort_vec[i] < sort_vec[i+1])? sort_vec[i] : sort_vec[i+1];
				assign sort_vec_cell[push_cell] = (sort_vec[i] < sort_vec[i+1])? sort_vec_cell[i] : sort_vec_cell[i+1];
			
			end
		endgenerate

		wire [8-1 : 0] min_of_vector;
		wire [8-1 : 0] min_of_vector_cell;
		assign min_of_vector = sort_vec [sort_vec_cells-1];
		assign min_of_vector_cell = sort_vec_cell [sort_vec_cells-1];
//wynik przechowywany jest w zmiennych: "min_of_vector" oraz "min_of_vector_cell"
//nareszcie obliczanie dysparycji

//niech bedzie tak ze numer dysparycji bedzie obliczany do srodka maski
// potem to bedzie trzeba sprawdzic na obrazku jak sie to zachowuje czy lepiej jest odnosic sie do srodka maski
// czy moze lepiej jest odnosic sie do do skrajneo lewego piksela maski oraz tablicy porównań

//hehehe

		wire  [8-1 : 0] dissparition;
		assign dissparition =( mask_position > (match_position + min_of_vector_cell))? mask_position - (match_position + min_of_vector_cell) : 8'b00000000;

		//w koncu wynik
		assign DISSPARITION = dissparition;
		
	endmodule




	module matcher #
	(
		parameter MASK_SIZE = 3,
		parameter MATRIX_CELLS = 9,
		parameter SUMMATION_STEPS_BITS = 11 //11 for max MASK_SIZE = 15;

	)
	(
		input wire  [8*MATRIX_CELLS-1 : 0] flattern_maskA,
		input wire  [8*MATRIX_CELLS-1 : 0] flattern_maskB,
		output wire [SUMMATION_STEPS_BITS-1 : 0] match

	);
	

	wire  [MASK_SIZE*MASK_SIZE-1 : 0] maskA [MATRIX_CELLS-1 : 0];
	wire  [MASK_SIZE*MASK_SIZE-1 : 0] maskB [MATRIX_CELLS-1 : 0];
//wypelnianie tablicy z wektora bitow
	genvar i;
	generate
		for(i=0; i<MATRIX_CELLS; i=i+1) begin
			assign maskA[i] = flattern_maskA [i*8 +: 8];

			assign maskB[i] = flattern_maskB [i*8 +: 8];
		end
	endgenerate

//roznicza po elementach
	wire [8-1 : 0] diff_per_element [MATRIX_CELLS-1 : 0];
	wire [SUMMATION_STEPS_BITS-1 : 0] summation_steps [MATRIX_CELLS-1 : 0];


	generate
		for (i=0; i<MATRIX_CELLS; i=i+1) begin
			assign diff_per_element[i] = (maskA[i]>maskB[i])? (maskA[i]-maskB[i]) : (maskB[i]-maskA[i]);
		end
	endgenerate
//suma wszystkich rorznic - wyjscie ukladu
	generate
		assign summation_steps[0] = diff_per_element[0] + diff_per_element[1];
		for (i=0; i<MATRIX_CELLS-2; i=i+1)begin
			assign summation_steps[i+1] = summation_steps[i] + diff_per_element[i+2];
		end
	endgenerate
	assign match = summation_steps[MATRIX_CELLS - 2];


	endmodule


