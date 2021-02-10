

//-------------------------------------------------------------------------------------

// to optmize the function defined below and determine k1 and k2

//    optimize /A=0 /I=5 /M={0,0}  /X={init_k1, init_k2} /Y = 1e-3 function_name, wave w
//    optimize /A=0 /I=5 /M={0,0}  /X={17.55, 1.26} /Y = 1e-3 error_func, temp

//-------------------------------------------------------------------------------------

// error_function

function error_func ( w, k1, k2)

	wave w         // for passing parameters (not optimized)
	variable k1    // coef 1, to be optimized
	variable k2    // coef 2, to be optimized

  variable e


  // calling some other WAVE


	wave w1
  wave w2

  // do some operation ----


  wave w3
  wave w4

  // ----------------------

  variable nRows=dimsize(w1, 0)
	make /o /d /n= (nRows) diff_1
	make /o /d /n= (nRows) diff_2


	// compute the difference
	diff_1 = w1 - w3
	diff_2 = w2 - w4



	// take square value of difference vectors
	diff_1 = diff_1^2
	diff_2 = diff_2^2
	diff_3 = diff_3^2

	e = custom_WaveSum(diff_1)+custom_WaveSum(diff_2)+custom_WaveSum(diff_3)
	return e

end


//-------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------

Function custom_WaveSum(w)
	Wave w
	Variable i, n=numpnts(w), total=0
	for(i=0;i<n;i+=1)
		total += w[i]
	endfor
	return total
End


//-------------------------------------------------------------------------------------
