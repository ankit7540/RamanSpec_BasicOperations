
// fit 2D data to a Gaussian + line function and save coefs in a result wave 
// custom fit function defined below is used for this fit


function fit_2D_data (input2D, xwave)
	wave input2D
	wave xwave 
	
	variable nRows=dimsize(input2D, 0)
	variable nCols=dimsize(input2D, 1)
	
	print nRows, nCols
	
	make /o /n=(5, nCols) result	// for 5 parameters
	
	variable i 
	print "starting fit now"
	
	for (i=0 ; i<nCols ; i=i+1)
		print (i)
		make /o /n=(nRows) temp=input2D[p][i] // selecting a column
		wave W_coef
		FuncFit gauss_with_line W_coef temp /X=xwave
		
		print ("--------------------------------")
		// saving fit coef values to result 
		result [] [i] = W_coef[p] 
		
	endfor 
	
end	
// -------------------------------------------------------------------------
Function gauss_with_line(w,x) : FitFunc
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

// ---------------------------------------------------------------------------------------------
