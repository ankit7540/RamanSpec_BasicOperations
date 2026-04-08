//----------------------------------------------------------------------------------------------------------------
// function header `CFF` is used to describe Custom Fit Function
//----------------------------------------------------------------------------------------------------------------
Function CFF_logistic(w,x) : FitFunc
	Wave w
	Variable x

	//CurveFitDialog/ These comments were created by the Curve Fitting dialog. Altering them will
	//CurveFitDialog/ make the function less convenient to work with in the Curve Fitting dialog.
	//CurveFitDialog/ Equation:
	//CurveFitDialog/ f(x) = maxima / ( 1+  exp(-rise * (x-midpoint)) )
	//CurveFitDialog/ End of Equation
	//CurveFitDialog/ Independent Variables 1
	//CurveFitDialog/ x
	//CurveFitDialog/ Coefficients 3
	//CurveFitDialog/ w[0] = maxima
	//CurveFitDialog/ w[1] = rise
	//CurveFitDialog/ w[2] = midpoint

	return w[0] / ( 1+  exp(-w[1] * (x-w[2])) )
End


//----------------------------------------------------------------------------------------------------------------

// This function is listed in the documentation of Ocean Optics mini-spectrometer for wavelength
//	calibration
// USB4000 Fiber Optic Spectrometer, Appendix A Calibrating the Wavelength of the USB4000
//  Page 19/36, Document Number 211-00000-000-02-1006

Function CFF_OceanOpt_WavelengthCal(w,x) : FitFunc
	Wave w
	Variable x

	//CurveFitDialog/ These comments were created by the Curve Fitting dialog. Altering them will
	//CurveFitDialog/ make the function less convenient to work with in the Curve Fitting dialog.
	//CurveFitDialog/ Equation:
	//CurveFitDialog/ f(x) = I + C1*x + C2*(x^2) + C3*(x^3)
	//CurveFitDialog/ End of Equation
	//CurveFitDialog/ Independent Variables 1
	//CurveFitDialog/ x
	//CurveFitDialog/ Coefficients 4
	//CurveFitDialog/ w[0] = I
	//CurveFitDialog/ w[1] = C1
	//CurveFitDialog/ w[2] = C2
	//CurveFitDialog/ w[3] = C3

	return w[0] + w[1]*x + w[2]*(x^2) + w[3]*(x^3)
End

//----------------------------------------------------------------------------------------------------------------

/////////////////////////////////////////////////////////////////////////////////////////

// asymmetric function by Korepanov and Sedlovets described in
//    V. I. Korepanov and D. M. Sedlovets, An asymmetric fitting function for condensed-phase Raman spectroscopy,
//     Analyst 143, 2674 (2018)

// suitable for fitting asymmetric peaks with no baseline
// combine with other functions to generate custom functions

Function CFF_asym_pV_no_BSL(x, a, center, fwhm, asym, gaussshare)
    Variable x, a, center, fwhm, asym, gaussshare
    
    Variable wn, x_distorted
    Variable Lor_asym, Gauss_asym, voigt_asym
    
    wn = x - center
    
    x_distorted = wn * (1 - exp(-wn^2 / (2 * (2 * fwhm)^2)) * asym * wn / fwhm)
    
    Lor_asym = fwhm / (x_distorted^2 + fwhm^2 / 4) / (2 * pi)
    
    Gauss_asym = sqrt(4 * ln(2) / pi) / fwhm * exp(-(x_distorted^2 * 4 * ln(2)) / fwhm^2)
    
    voigt_asym = (1 - gaussshare) * Lor_asym + gaussshare * Gauss_asym
    
    return a * voigt_asym
End

/////////////////////////////////////////////////////////////////////////////////////////

