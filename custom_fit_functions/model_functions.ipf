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
