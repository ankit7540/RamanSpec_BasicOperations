//-----------------------------------------------------------------------------
// To get the average of 2D input wave.

//  this function accepts a 2D wave as the argument

function do_average(input)
	wave input

	variable nRows
	variable nCols
	variable i

	nRows=dimsize(input, 0)
	nCols=dimsize(input, 1)


	string name=nameofwave (input)

	string new_name
	sprintf new_name, "%s_avg",name
	printf "\t%s\t%g\t%g\r" new_name, nRows, nCols

	make /o/d /n=(nRows) $new_name
	wave output=$new_name

	make /o/d /n=(nRows) temp=0

	for (i=0 ; i<nCols ;  i=i+1)
		temp=temp+input [p][(i)]
	endfor

	output=temp / nCols

	killwaves /Z temp

end


//-----------------------------------------------------------------------------

//	Select multiple waves in the data-browser and then use the command in the
//	command window to use the function.
//	Please edit the code to suit your needs.


function  averall ()

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

	print "\tNumber of waves: ", index

	for (i=0; i<index; i=i+1)
	 	nameV = getbrowserselection(i)
	 	//print i, namev
		wave selected=$nameV

	 	cols		=	dimsize (selected, 1)

	 	if (cols>1)
	 		do_average(selected)
	 	else
 		printf "\t%s is 1D. Skipping.\r", NameOfWave(selected)
	 	endif

	endfor

	printf "\tWaves processed : %g \r", index

end

//-----------------------------------------------------------------------------
