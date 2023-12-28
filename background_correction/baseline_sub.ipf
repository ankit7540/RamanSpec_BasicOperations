

// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------

// subtracting a constant background from one input spectra  (1D)
//   the constant number to subtract is obtained by
//	taking average from start to end points defined by the user
//		in the input spectra


function   subtract_constant_bckg (input, pnt_start, pnt_end)
	wave input				// 1D wave
	variable pnt_start
	variable pnt_end

	variable nRows =  dimsize(input, 0)
	variable nSet = pnt_end - pnt_start
	variable i

	// create temporary wave
	make /d /FREE /n=(nSet) temp

	for (i=0 ;  i< nSet; i=i+1)
		temp [i] = input [pnt_start] + i
	endfor

	variable sumWave = cmn_WaveSum(temp)
	variable avg =  sumWave/nSet
	print avg
	string output
	sprintf output, "%s_sub", nameofwave(input)
	make /d /o /n=(nRows) $output = input - avg

	killwaves /Z temp

end

// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------

// subtracting a constant background from selected spectra in the
//	data browser, where
//  the constant number to subtract is obtained by
//	taking average from start to end points defined by the user
//	in the input spectra

// the output spectra withthe name <original>_sub
//   are created in the same folder as the original wave

function subtract_baseline_from_selected (pnt_start, pnt_end)
	variable  pnt_start  // start point (in pixel, i.e. point index)
	variable  pnt_end   // end point (in pixel, i.e. point index)
					   //  start point < end point is assumed

	string name
 	variable index // for initial count of waves
 	variable i
 	variable cols

	// get list of spectra from selection the browser
	string cdf =getdatafolder(1)
	printf "\tPresent folder : %s\r" cdf

	// Count the number of files
	do
		name  = getbrowserselection(index)
		if (strlen(name ) == 0)
			break
		endif
 		index += 1
	while(1)

	print "\tNumber of selected waves: ", index

	// process each 1D spectra
	for (i=0; i<index; i=i+1)
	 	name = getbrowserselection(i)
	 	//print i, namev
		wave selected=$name

	 	cols	 = dimsize (selected, 1)

	 	if (cols<1)
	 		subtract_constant_bckg ( selected, pnt_start, pnt_end)
	 	else
 		printf "\t%s is 2D. Skipping.\r", NameOfWave(selected)
	 	endif

	endfor

	printf "\tWaves processed : %g \r", index

end
// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
