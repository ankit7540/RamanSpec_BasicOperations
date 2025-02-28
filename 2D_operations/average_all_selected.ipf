//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------

//	Select multiple 1D waves in the data-browser and then use the command in the
//	command window to use the function.


function  average_all_selected1D ()

	string nameV
 	variable index // for initial count of waves
 	variable i
 	variable cols

	string cdf =getdatafolder(1)
	printf "\tPresent folder : %s\r" cdf
	
	variable nRows

	// Count the number of files
	do
		nameV  = getbrowserselection(index)
		
		if (strlen(nameV ) == 0)
			break
		endif
 		index += 1
	while(1)
	
	nameV  = getbrowserselection(0)
	wave selected=$nameV
	nRows = dimsize(selected, 0)		// assumed that all 1D waves have same dimension !
	print "\tNumber of waves: ", index
	print "\tNumber of rows: ", nRows
	
	make /o /d /n=(nRows) temp =0 

	for (i=0; i<index; i=i+1)
	 	nameV = getbrowserselection(i)
	 	//print i, namev
		wave selected=$nameV

	 		temp = temp + selected

	endfor
	
		make /o /d /n=(nRows) out_averaged = temp / index

	printf "\tWaves processed : %g \r", index
	
	killwaves /Z temp

end

//-----------------------------------------------------------------------------