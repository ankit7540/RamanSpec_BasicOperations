
#pragma TextEncoding = "UTF-8"
#pragma rtGlobals=3		// Use modern global access method and strict wave access.

///////////////////////////////////////////////////////////////////////////////

// to generate a sample string, similar to list, which is
//	stores as a global string variable, `sample`, containing
//	random values

function construct_sample_str (length, separator)
	variable length    // 100 is a good length
	string separator   // ","

	string str=""

	make /o /d /n=(length) tmp_data = enoise(1)

	variable i
	variable val

	for (i=0 ; i<length ; i=i+1 )
		val = tmp_data[i]

		if (i==0)
			str=num2str(val)
		elseif (i>0)
			sprintf str, "%s%s%s", str,separator, num2str(val)
		endif

	endfor

	string /G sample =  str

end

///////////////////////////////////////////////////////////////////////////////


// to generate 2D sample dataset with 1 gaussian peak and linear baseline

function sample_2D_gauss ()

	variable nrows = 200
	variable nCols = 20
	variable slope

	variable i

	make /FREE /d /n=(4) gCoefs

	make /o /d /n=(nRows, nCols) sampleD_2D
	make /o /d /n=(nRows) xaxis = p/8
	make /FREE /n=(nRows) tmp

	variable center = (wavemin(xaxis) + wavemax(xaxis) ) / 2


	for (i=0 ; i< nCols ;  i=i+1)

		gCoefs [0] = 0.0
		gCoefs [1] = 4.5
		gCoefs [2] = center +enoise(0.25)
		gCoefs [3] = 2.56
		slope = 0.0115

		tmp = enoise(0.0655) + gauss1d(gCoefs, xaxis  ) + slope * xaxis

		sampleD_2D [][i] = tmp[p]



	endfor

end

///////////////////////////////////////////////////////////////////////////////

// to generate 2D sample dataset with 2 convoluted gaussian peaks and
//			a linear baseline

function sample_2D_2gauss ()

	variable nrows = 200
	variable nCols = 20
	variable slope

	variable i

	make /FREE /d /n=(4) gCoefs1
	make /FREE /d /n=(4) gCoefs2

	make /o /d /n=(nRows, nCols) sampleD_2D_2G
	make /o /d /n=(nRows) xaxis = p/8
	make /FREE /n=(nRows) tmp

	variable center = (wavemin(xaxis) + wavemax(xaxis) ) / 2


	for (i=0 ; i< nCols ;  i=i+1)

		gCoefs1 [0] = 0.0
		gCoefs1 [1] = 5.5
		gCoefs1 [2] = center - (0.11*center) +enoise(0.15)
		gCoefs1 [3] = 2.05

		gCoefs2 [0] = 0.0
		gCoefs2 [1] = 2.55
		gCoefs2 [2] = center + (gCoefs1 [3] * 1.165)  +enoise(0.1)
		gCoefs2 [3] = 3.85

		slope = 0.0105

		tmp = enoise(0.0655) + gauss1d(gCoefs1, xaxis  ) + gauss1d(gCoefs2, xaxis  ) + slope * xaxis

		sampleD_2D_2G [][i] = tmp[p]

	endfor

end
///////////////////////////////////////////////////////////////////////////////
// to generate 2D sample dataset with 2 convoluted lorentzian peaks and
//			a linear baseline


function sample_2D_2lor ()

	variable nrows = 300
	variable nCols = 20
	variable slope
	variable offset

	variable i

	make /FREE /d /n=(3) lCoefs1
	make /FREE /d /n=(3) lCoefs2

	make /o /d /n=(nRows, nCols) sampleD_2D_2lor
	make /o /d /n=(nRows) xaxis = p/8
	make /FREE /n=(nRows) tmp

	variable center = (wavemin(xaxis) + wavemax(xaxis) ) / 2
	print center

	for (i=0 ; i< nCols ;  i=i+1)

		slope = 0.0115
		offset = 0.15
		lCoefs1 [0] = 25
		lCoefs1 [1] = center + enoise(0.25) // + 0.275 * i
		lCoefs1 [2] = 1.05

		lCoefs2 [0] = 15
		lCoefs2 [1] = center + enoise(0.25)   + 0.25 * center
		lCoefs2 [2] = 1.365


		tmp = enoise(0.0655) + lCoefs1[0] /((xaxis-lCoefs1[1])^2+ (lCoefs1[2]^2) ) + slope * xaxis + offset + lCoefs2[0] /((xaxis-lCoefs2[1])^2+(lCoefs2[2]^2 ) )

		sampleD_2D_2lor [][i] = tmp[p]



	endfor

end

///////////////////////////////////////////////////////////////////////////////

function sample_2D_lor ()

	variable nrows = 300
	variable nCols = 20
	variable slope
	variable offset

	variable i

	make /FREE /d /n=(3) lCoefs

	make /o /d /n=(nRows, nCols) sampleD_2D_lor
	make /o /d /n=(nRows) xaxis = p/8
	make /FREE /n=(nRows) tmp

	variable center = (wavemin(xaxis) + wavemax(xaxis) ) / 2
	print center

	for (i=0 ; i< nCols ;  i=i+1)

		slope = 0.0115
		offset = 0.15
		lCoefs [0] = 25
		lCoefs [1] = center + enoise(0.25) // + 0.205 * i
		lCoefs [2] = 1.1025


		tmp = enoise(0.0655) + lCoefs[0] /((xaxis-lCoefs[1])^2+ (lCoefs[2]^2) ) + slope * xaxis + offset

		sampleD_2D_lor [][i] = tmp[p]



	endfor

end

///////////////////////////////////////////////////////////////////////////////
