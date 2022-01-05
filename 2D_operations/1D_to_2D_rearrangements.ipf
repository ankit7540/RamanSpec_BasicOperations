// *************************************************************

// Function to merge 1D waves to a 2D wave while usng a broadband white light spectra for
// intensity correction	operation on each 1D wave in a loop (division by white light spectra)

// Example
// merge1D_to_2D( "data_", 0, 5 , white_light, "output_folder" )
//	This will process 1D waves as, data_0, data_1,...,data_5

// creates the output in a new folder 

function merge1D_to_2D( prefix, starting_index, last_index , WLwave, FN )

string prefix				// string prefix for series of 1D waves
variable starting_index	// first index
variable last_index		// last index
wave WLwave 			// Normalized white light wave
string FN				// newfoldername (string)

string wname
variable i
variable rows
variable cols

// get the number of rows
sprintf  wname, "%s%g",prefix, starting_index
wave inpwave = $wname
rows=dimsize(inpwave,0)

// get the number of cols
cols= last_index - starting_index + 1

// make a 2D wave
make /o /n=(rows,cols) output
wave result=output

make /o /n=(rows) temp
wave temp=temp


for ( i=starting_index ; i < (last_index+1) ; i=i+1 )
	sprintf  wname, "%s%g",prefix, i
	//print wname	
	
	wave inpwave = $wname
	
	// operation for white light calibration
	temp = inpwave / WLwave
	
	// place inside a 2D wave
	result[][ ( i - starting_index) ]=temp[p]
endfor

setdatafolder root:
newdatafolder /o /S $FN 	// will make new folder and set is as present folder
duplicate /o result, output_2D
killwaves /Z temp, result // remove temporary waves
end

// *************************************************************
// *************************************************************



// To split a 1D wave to sections which are then placed along the
// columns of the output 2 D wave 

//		(extra rows of 1D which do not fit in a column are not put in
//		 in the 2D data, i.e.  1D [106 rows] -> 2D [10x10], 6 rows of 
//		 data not in 2D)

	
// RETURNS :  2D wave (returns a wave ref to output wave)
	
function /WAVE split1D_to_2D (input, length)
	wave input		// 1d wave
	variable length 	// length of the section ( == rows of 2D output)
	
	variable nRows = dimsize (input,0)
	variable divn = (nRows/length)
	variable nCols = floor (divn)  // number of columns in the 2D output
	
	make /o /d /n=(length, nCols) out
	variable i, j
	make /o /FREE /n=(length) temp
	
	for (i=0 ; i<nCols ; i=i+1)	
	
		for (j=0 ; j< length ; j=j+1)	
			temp [j] = input [ j + i*length ]
			//print ( j + i*length)
		endfor			
             //print "--"	
	 	out [][i] = temp[p]
		
	endfor
	
	return	out 

end		

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
