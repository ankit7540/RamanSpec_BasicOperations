// *************************************************************

// Function to merge 1D waves to a 2D wave while doing white light 
//	calibration on each 1D wave in a loop


function merge1D_to_2D( prefix, starting_index, last_index , WLwave, FN )

string prefix				// string prefix for series of 1D waves
variable starting_index	// first index
variable last_index		// last index
wave WLwave 			// Normalized white light wave
string FN				// newfoldername

string wname
variable i
variable rows
variable cols

// to get the number of rows
sprintf  wname, "%s%g",prefix, starting_index
wave inpwave = $wname
rows=dimsize(inpwave,0)

// to get the number of cols
cols= last_index - starting_index + 1

// make a 2D wave
make /o /n=(rows,cols) output=0
wave result=output

make /o /n=(rows) temp=0
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