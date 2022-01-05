///////////////////////////////////////////////////////////////////////////////////
// to multiply every column of a 2D wave
//   with a 1D wave

// result is a 1D wave with name : $input2D_out

function multiply_all_col (input2D, input1D)
	wave input2D	// 2D wave
	wave input1D	// 1D wave

	variable nRows =  dimsize(input2D, 0)
	variable nCols =  dimsize(input2D, 1)
	printf "\t\t %s (Rows : %d, Cols : %d)\r", nameofwave(input2D), nRows, nCols

	string result
	sprintf result, "%s_out", nameofwave(input2D)

	variable i
	make /o /d /n=(nRows, nCols) $result
	wave output = $result

	for (i=0 ; i<nCols ; i=i+1  )
		output [][i] = input2D[p][i] * input1D[p]
	endfor

end

///////////////////////////////////////////////////////////////////////////////////
