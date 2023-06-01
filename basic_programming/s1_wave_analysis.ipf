
///////////////////////////////////////////////////////////////////////////////

// To count the number of zero values in a wave (1D or 2D)
//   returns the count

function count_zero_pnts ( input)
	wave input

	variable nRows
	variable nCols

	nRows = dimsize ( input, 0)
	nCols = dimsize ( input, 1)

	variable i
	variable j
	variable count
	variable val


	if (nCols ==0 )

		// one-dimensional wave
		for (i=0 ; i < ( nRows  ) ; i=i+1)
			val = input [i]
			if ( val < 1e-15)
				count = count +1
			endif
		endfor
	else

		// two-dimensional wave
		for (i=0 ; i < ( nRows  ) ; i=i+1)
			for (j=0 ; j < ( nCols  ) ; j=j+1)
				val = input [i][j]
				if ( val < 1e-15)
					count = count +1
				endif
			endfor
		endfor
	endif

	return count

end

///////////////////////////////////////////////////////////////////////////////

// To reverse ones and zeros in the wave (1D or 2D)
//    this creates a new wave with suffix '_reverse'

function reverse_ones_zero_pnts ( input)
	wave input

	variable nRows
	variable nCols

	nRows = dimsize ( input, 0)
	nCols = dimsize ( input, 1)

	variable i
	variable j
	variable count
	variable val

	duplicate /O  input, tmp_reverse
	wave tmp_reverse


	if (nCols ==0 )

		// one-dimensional wave
		for (i=0 ; i < ( nRows  ) ; i=i+1)
			val = input [i]
			if ( val < 1e-14)
				tmp_reverse [i] =1
			endif

			if ( val ==1 )
				tmp_reverse [i] =0
			endif

		endfor
	else

		// two-dimensional wave
		for (i=0 ; i < ( nRows  ) ; i=i+1)
			for (j=0 ; j < ( nCols  ) ; j=j+1)

				val = input [i][j]

				if ( val < 1e-14)
					tmp_reverse [i][j] =1
				endif

				if ( val ==1 )
					tmp_reverse [i][j] =0
				endif

			endfor
		endfor
	endif



end

///////////////////////////////////////////////////////////////////////////////
