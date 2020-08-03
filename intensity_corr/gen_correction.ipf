#pragma TextEncoding = "UTF-8"
#pragma rtGlobals=3		// Use modern global access method and strict wave access.



// -------------------------------------------------------------------------------
// -------------------------------------------------------------------------------

// Main function
// Example :
//    gen_C0_C1 ( x_wavenumber, 632.8 , root:whitelight  ,   670 , startpnt=0, endpnt=1275  )
//                  wave        laser_nm   wave             pixel   start_and_end_of_fit

function gen_C0_C1 ( ramanshift , laser_nm , wl_wave ,   norm_pnt , [ startPnt, endPnt ] )

	wave ramanshift		// relative
	variable laser_nm		// laser wavelength, nm
	wave wl_wave			// white_light spectra, unnormalized, 1D or 2D
	variable norm_pnt		// normalization index, pnt
	
	variable startPnt, endPnt	// supply these as a=x1, b=x2
	
	variable nPnts = dimsize(ramanshift, 0)
	variable mid = nPnts/2
	
	
	// initialization
	killwaves /Z  W_coef, W_ParamConfidenceInterval, W_sigma, fit
	
	// generate the C0 correction
	gen_C0(ramanshift ,   norm_pnt)
	wave C0
	
	// wl spectra (check averaging)
	variable nCols_wl = dimsize(wl_wave,1)
	if (nCols_wl > 1)
		print "\twl_wave is 2D. Averaging.\r"
		do_average_custom(wl_wave)
		string newWave= nameofwave(wl_wave)+"_avg"
		printf "\tAveraged wave : %s\r", newWave
		wave wl_wave = $newWave
	endif	
	
	// wl spectra (normalization)
	make /d /o /n=(nPnts) wl_norm = wl_wave/ wavemax(wl_wave)
	wl_norm=wl_norm*C0
	wave wl_norm
	
	// wl spectra (subset)
	if (startPnt== nan && endPnt ==nan)
		print "\tSubset parameters not supplied. Working with full wave.\r"
		
		gen_C1(ramanshift, laser_nm ,  wl_norm ,  norm_pnt)
		
	else	
		print "\tStartPnt and endPnt are supplied\r"
	
		gen_C1_subset(ramanshift, laser_nm ,  wl_norm ,   norm_pnt , startPnt, endPnt)
		
		
	endif
	
	wave C0
	wave C1
	
	make /d /o /n=(nPnts) intensity_corr = (C0/C1)
	
	printf "\n\tintensity_corr generated. Done. This is (C0/C1)\r"
	
		
	
	// cleanup
	killwaves  /Z abs_wavenumber_subset, wl_norm_subset,  W_coef, fit, coefs

end


// -------------------------------------------------------------------------------
// -------------------------------------------------------------------------------

function gen_C0(ramanshift ,   norm_pnt)

	wave ramanshift		// relative
	variable norm_pnt		// normalization index, pnt
	
	variable nPnts = dimsize(ramanshift, 0)
	variable mid = nPnts/2
	

	make   /FREE /o /n=(nPnts-1) wavenumber_spacing =0
	wavenumber_spacing = ramanshift [p] -  ramanshift [p+1]	
	
	make /d /o /n=(nPnts-1) waveum_corr = ( wavenumber_spacing / wavenumber_spacing [ norm_pnt ])
	make /FREE /d /n=(nPnts-1) xax=p
	// ------------------------	
	CurveFit /Q  poly 3,  waveum_corr /X=xax  
	wave W_coef
	variable val_plus1_pnt =   poly(W_coef, nPnts-1 ) 
	//print val_plus1_pnt
	
	InsertPoints (nPnts-1),1, waveum_corr
	waveum_corr [nPnts-1] = val_plus1_pnt
	
	duplicate /O waveum_corr, C0
	
	killwaves /Z wavenum_corr


end

// -------------------------------------------------------------------------------
// -------------------------------------------------------------------------------

function gen_C1(ramanshift, laser_nm ,  wl_input   norm_pnt)

	wave ramanshift		// relative
	variable laser_nm		// laser wavelength (nm)
	wave wl_input		// normalized wl wave with C0 multiplied
	variable norm_pnt		// normalization index, pnt
	
	variable nPnts = dimsize(ramanshift, 0)
	variable mid = nPnts/2
	

	// cleanup from prev run
	killwindow /Z genC0C1	
	
	// make abs_wavenumber, for xaxis
	
	make /o /d /n=(nPnts) abs_wavenumber = ((1e7/laser_nm)-ramanshift)*100
	make /o /d /n=2 coefs
	
	// defining initial coefs
	coefs[0] = 0.856e-18
	coefs[1] = 2659 // 0.856e-18
	
		
	Display /K=1 wl_input vs abs_wavenumber
	FuncFit photons_per_unit_wavenum_abs coefs wl_input /X=abs_wavenumber 
	
	printf "\tFit coef:%5.6e, %5.6e",coefs[0],coefs[1]
	
	make /o /d /n=(nPnts) fit = photons_per_unit_wavenum_abs(coefs,abs_wavenumber)
	appendtograph fit vs abs_wavenumber
	
	// generate C1
	make /o /d /n=(nPnts) C1 = wl_input / fit
	
	
	if (waveexists(C1) && coefs[1]< 5000 )
		return 1
	endif		


end
	 
// -------------------------------------------------------------------------------
// -------------------------------------------------------------------------------	

function gen_C1_subset (ramanshift, laser_nm ,  wl_input  , norm_pnt , startPnt, endPnt )

	wave ramanshift		// relative
	variable laser_nm		// laser wavelength (nm)
	wave wl_input		// normalized wl wave with C0 multiplied
	variable norm_pnt		// normalization index, pnt
	variable startPnt, endPnt
	
	variable nPnts = dimsize(ramanshift, 0)
	variable mid = nPnts/2
	
	// cleanup from prev run
	killwindow /Z genC0C1
	
	// make abs_wavenumber, for xaxis
	
	make /o /d /n=(nPnts) abs_wavenumber = ((1e7/laser_nm)-ramanshift)*100
	make /o /d /n=2 coefs
	
	// defining initial coefs
	coefs[0] = 0.856e-18
	coefs[1] = 2659 // 0.856e-18
	
	
	choose_subset( wl_input, startPnt, endPnt)
	choose_subset( abs_wavenumber, startPnt, endPnt)
	
	wave abs_wavenumberSS = abs_wavenumber_subset
	string newWave = nameofwave(wl_input)+"_subset"
	wave wl_inputSS	= $newWave
		
	Display /N=genC0C1 /K=1 wl_input vs abs_wavenumber
	FuncFit photons_per_unit_wavenum_abs coefs wl_inputSS /X=abs_wavenumberSS 
	
	printf "\tFit coef:%5.6e, %5.6e",coefs[0],coefs[1]
	
	make /o /d /n=(nPnts) fit = photons_per_unit_wavenum_abs(coefs,abs_wavenumber)
	appendtograph fit vs abs_wavenumber
	
	ModifyGraph /W=genC0C1 grid=1,mirror=1,axThick=1.2,lblPosMode(bottom)=2,lblMargin(bottom)=2,gridHair=1,manTick(left)={0,0.1,0,1},manMinor(left)={3,2},manTick(bottom)={0,0.02,6,2},manMinor(bottom)={3,2},gridRGB(left)=(13107,13107,13107),gridRGB(bottom)=(17476,17476,17476);DelayUpdate
	Label /W=genC0C1 left "Intensity";DelayUpdate
	Label /W=genC0C1 bottom "Wavenumber / m\\S-1"
	ModifyGraph /W=genC0C1 fSize=25
	ModifyGraph /W=genC0C1 rgb(fit)=(0,0,65535)
	ModifyGraph /W=genC0C1 lsize=2
	SetAxis /W=genC0C1  left 0,*
	
	// generate C1
	make /o /d /n=(nPnts) C1 = wl_input / fit
	
	if (waveexists(C1) && coefs[1]< 5000 )
	
	
	
		return 1
	endif	
	

end
	 


// -------------------------------------------------------------------------------
// -------------------------------------------------------------------------------	 

Function photons_per_unit_wavenum_abs(w0,w) : FitFunc
	Wave w0
	Variable w

	//CurveFitDialog/ These comments were created by the Curve Fitting dialog. Altering them will
	//CurveFitDialog/ make the function less convenient to work with in the Curve Fitting dialog.
	//CurveFitDialog/ Equation:
	//CurveFitDialog/ f(w) = a0*599584916*w^2/(exp(0.1438776877e-1*w/T)-1)
	//CurveFitDialog/ End of Equation
	//CurveFitDialog/ Independent Variables 1
	//CurveFitDialog/ w
	//CurveFitDialog/ Coefficients 2
	//CurveFitDialog/ w0[0] = a0
	//CurveFitDialog/ w0[1] = T

	return w0[0]*599584916*w^2/(exp(0.1438776877e-1*w/w0[1])-1)
End

// -------------------------------------------------------------------------------
// -------------------------------------------------------------------------------
	
function do_average_custom(input)
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

// -------------------------------------------------------------------------------
// -------------------------------------------------------------------------------	

// function which selects a part of the 1D wave 
//		and makes a new wave with '_subset' appended to name
//		as the output wave

function choose_subset(input, startP, endP)
	wave input
	variable startP
	variable endP
	variable i
	string newName
	
	sprintf newName, "%s_subset", nameofwave(input)
	
	variable nPnt = (endP-startP)+1
	make /o /d /n=(nPnt) $newName
	wave output = $newName
	
	for (i=0 ; i<nPnt ; i=i+1)
		output[i] = input[startP+i]
	endfor
end	

// -------------------------------------------------------------------------------
// -------------------------------------------------------------------------------
