//----------------------------------------------------------------------------------------------------------------
// function header `CFF` is used to describe Custom Fit Function
//----------------------------------------------------------------------------------------------------------------
Function CFF_gauss_baseline(w,x) : FitFunc
	Wave w
	Variable x

	//CurveFitDialog/ These comments were created by the Curve Fitting dialog. Altering them will
	//CurveFitDialog/ make the function less convenient to work with in the Curve Fitting dialog.
	//CurveFitDialog/ Equation:
	//CurveFitDialog/ f(x) = c0+c1*x + a*exp( -(x-c)^2 / w^2  )
	//CurveFitDialog/ End of Equation
	//CurveFitDialog/ Independent Variables 1
	//CurveFitDialog/ x
	//CurveFitDialog/ Coefficients 5
	//CurveFitDialog/ w[0] = A
	//CurveFitDialog/ w[1] = c
	//CurveFitDialog/ w[2] = w
	//CurveFitDialog/ w[3] = c0
	//CurveFitDialog/ w[4] = c1

	return w[3]+w[4]*x + w[0]*exp( -(x-w[1])^2 / w[2]^2  )
End

//----------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------

Function CFF_GaussGauss_baseline(w,x) : FitFunc
	Wave w
	Variable x

	//CurveFitDialog/ These comments were created by the Curve Fitting dialog. Altering them will
	//CurveFitDialog/ make the function less convenient to work with in the Curve Fitting dialog.
	//CurveFitDialog/ Equation:
	//CurveFitDialog/ f(x) = (ampl1*exp( -(x-posn1)/fwhm1 )) + (ampl2*exp( -(x-posn2)/fwhm2 )) + c0+c1*x
	//CurveFitDialog/ End of Equation
	//CurveFitDialog/ Independent Variables 1
	//CurveFitDialog/ x
	//CurveFitDialog/ Coefficients 8
	//CurveFitDialog/ w[0] = ampl1
	//CurveFitDialog/ w[1] = fwhm1
	//CurveFitDialog/ w[2] = posn1
	//CurveFitDialog/ w[3] = ampl2
	//CurveFitDialog/ w[4] = fwhm2
	//CurveFitDialog/ w[5] = posn2
	//CurveFitDialog/ w[6] = c0
	//CurveFitDialog/ w[7] = c1

	return (w[0]*exp( -(x-w[2])^2/(2*w[1]^2) )) + (w[3]*exp( -(x-w[5])^2/ (2*w[4]^2) )) + w[6]+w[7]*x
End

// --------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------
Function CFF_LorGauss_baseline(w,x) : FitFunc
	Wave w
	Variable x

	//CurveFitDialog/ These comments were created by the Curve Fitting dialog. Altering them will
	//CurveFitDialog/ make the function less convenient to work with in the Curve Fitting dialog.
	//CurveFitDialog/ Equation:
	//CurveFitDialog/ f(x) = c0+(c1*x)+amplG*exp(-(x-posnG)^2 / fwhmG^2)+amplL/((x-posnL)^2 + bL)
	//CurveFitDialog/ End of Equation
	//CurveFitDialog/ Independent Variables 1
	//CurveFitDialog/ x
	//CurveFitDialog/ Coefficients 8
	//CurveFitDialog/ w[0] = amplL
	//CurveFitDialog/ w[1] = posnL
	//CurveFitDialog/ w[2] = bL
	//CurveFitDialog/ w[3] = amplG
	//CurveFitDialog/ w[4] = fwhmG
	//CurveFitDialog/ w[5] = posnG
	//CurveFitDialog/ w[6] = c0
	//CurveFitDialog/ w[7] = c1

	return w[6]+(w[7]*x)+w[3]*exp(-(x-w[5])^2 / (2*w[4]^2))+w[0]/((x-w[1])^2 + w[2])
End

// --------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------
