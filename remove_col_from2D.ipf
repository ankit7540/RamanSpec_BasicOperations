
// -----------------------------------------------------------------------------------------

// To delete one column (specified via col_index) from a 2D wave 
// Only removes if the original number of columns is more than 3 in the
// 	2D wave.

// This operates on a single 2D wave 

// returns the original modified wave 
function remove_col_from_2D (input2D, col_index)
	wave input2D
	variable col_index
	
	variable nCols
	nCols = dimsize (input2D, 1)
	
	// only if nCols > cutoff operation is done
	// edit cutoff for control of how small 2D waves are edited
	variable cutoff =3
	
	if (nCols > cutoff) 
		printf "\t    Removing col %g from %s \r", col_index, nameofwave(input2D)
		DeletePoints/M=1 col_index ,1, input2D	// delete col operation
		// delete 1 column along axis=1 which is col
	else
		printf "\t    Not touching %s, nCols = %g \r",  nameofwave(input2D), nCols			 	
	endif
end	

// -----------------------------------------------------------------------------------------

// To remove a column from multiple 2D wave 

function  remove1col_from_selected_2D ( col_index )

	variable col_index
	string nameV 
 	variable index // for initial count of waves
 	variable i
 	variable cols
 	
	string cdf =getdatafolder(1)
	printf "\tPresent folder : %s\r" cdf
	
	// Count the number of files
	do
		nameV  = getbrowserselection(index)
		if (strlen(nameV ) == 0)
			break
		endif
 		index += 1
	while(1)
	
	print "\tNumber of selected waves: ", index	

	for (i=0; i<index; i=i+1)
	 	nameV = getbrowserselection(i)
		wave selected=$nameV
			 
	 	cols		=	dimsize (selected, 1) 
	
	 	if (cols>1)
	 		remove_col_from_2D ( selected , col_index)
	 	else
 			printf "\t%s is 1D. Skipping.\r", NameOfWave(selected)
	 	endif
	
	endfor 

	printf "\tWaves processed : %g \r", index

end 

//----------------------------------------------------------------------------------------------------------------
