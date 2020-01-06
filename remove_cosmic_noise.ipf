//------------------------------------------------------------

// To substitute the numerical value for cosmic noise at index-pixel 
//	with the fit value, after setting -2 to +2 y values to nan around 
//	the index

// Examples :  
//		remove_cosmic_noise( spectra, 925 , 7 )
//			where spectra = 1D spectra wave
//			925 = index for the noise, max value preferred
//			7	= use 7 data points around the index, hence
//				   total 14 data points considered

// Exceptions : 
//	when working near the edges of the spectra

function remove_cosmic_noise( wave1D, index , cutoff )
	wave wave1D
	variable index
	variable cutoff
	variable value
	
	make /FREE /d /n=(cutoff*2) xwave =p+ (index-cutoff )
	make /FREE /d /n=(cutoff*2) ywave =  wave1D [ p+ (index-cutoff ) ]
	
	ywave [ cutoff -2,  cutoff +2] = nan
	
	CurveFit /Q   poly 3, ywave /X=xwave
	wave W_coef
	
	value=poly(W_coef, index-1)
	wave1D [index-1] = value
	
	value=poly(W_coef, index )
	wave1D [index ] = value
	
	value=poly(W_coef, index+1)
	wave1D [index+1] = value
	
end	
//------------------------------------------------------------
