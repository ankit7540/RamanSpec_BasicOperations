// ---------------------------------------------------------

// To fit every row in a TA dataset to get the time0 value
//    maybe useful when corresponding OKE data is not available
//		and we want to get dispersion data from TA data


// arguments : 2D input TA data
//					threshold value for reliability of t0 value

//	output : 1D wave `disp_data ` which has t0 values


function get_dispersion_from_TA(inputTA, thresold_percent)
	wave inputTA						// 2D data
	variable thresold_percent	// error in t0 value (in %)
	
	variable numCols = dimsize(inputTA, 1)
	variable numRows = dimsize(inputTA, 0)
	
	variable i
	
	make /o /d /n=(numRows) disp_data
	wave out = disp_data 						// to keep t0 data from fit
	
	make /o /d /n=(numCols) tmp = 0
	
	for (i=0  ; i < numRows ; i=i+1 )
		
		tmp = inputTA[i][p]
		
		
		// define initial fit coef
		wave init = input_guess   // we can use a wave in this function 
		wave error = W_sigma
		
		duplicate /O /I init, init_current  // make a copy
		
		// fit 
		
		FuncFit /Q /H="000001"  double_exp_Gauss init_current tmp /D    // perform fit 
		variable t0_from_fit = init_current[4]
		
		
		variable t0_error = error[4]
		
		// compute relative error
		variable percent_error = (t0_error / t0_from_fit ) * 100  
		
		// conditional assignment
		if (percent_error < thresold_percent )
			out [i] = t0_from_fit
		else
			out [i] = nan
		endif	
			
		
 		print "\ti = ", i , "t0 = ", t0_from_fit, "\t(", percent_error,")"
		
		
	endfor 
	
	killwaves  /Z tmp 
	
end	
	
// ---------------------------------------------------------	