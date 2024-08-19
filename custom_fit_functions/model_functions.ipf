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
