//----------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------
Function gauss_with_baseline(w,x) : FitFunc
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
