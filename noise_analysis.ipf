
// get a series of waves (spectra), and calculate the mean, and standard deviation at each point of the wave (spectra)

function standard_dev_eachPnt_spectra(prefixString, firstNum, lastNum)
	String prefixString		// The part of the name that is common to all waves.
	Variable firstNum		// Number of the first wave in the series.
	Variable lastNum
	//------------------------------------------------------------------------------------------------------------------------------------------------
	Variable n
	String currentWaveName

	sprintf currentWaveName, "%s1", prefixString, n
 	WAVE currentWave = $(currentWaveName)
	printf "%s %g\r" nameofwave(currentWave), dimsize(currentWave,0)
	wave inpw=currentWave
	variable x1=dimsize(inpw,0)
	print x1

	make /o /d /n=(x1) sum_wave=0
	wave sum_wave=sum_wave

// ---- averaging to find the mean at each point ----------------
	For (n=firstNum; n<=lastNum; n+=1)
		sprintf currentWaveName, "%s%d", prefixString, n
		WAVE currentWave = $(currentWaveName)
		printf "%s %g\r" nameofwave(currentWave), dimsize(currentWave,0)

		wave inpw=currentWave
		sum_wave= sum_wave+inpw

	endfor // loop over spectra
// -------------------------------------------------------------------------

	// averaging
	make /o /d /n=(x1) mean_wave=sum_wave/(lastNum)   // since firstNum starts with 1
	wave mean_wave=mean_wave


	sum_wave=0

// ---- square of difference from mean  at each point ----------------
	For (n=firstNum; n<=lastNum; n+=1)
		sprintf currentWaveName, "%s%d", prefixString, n
		WAVE currentWave = $(currentWaveName)
		printf "%s %g\r" nameofwave(currentWave), dimsize(currentWave,0)

		wave inpw = currentWave
		sum_wave = sum_wave + abs( (inpw-mean_wave)*(inpw-mean_wave) )
	endfor // loop over spectra


// -------------------------------------------------------------------------
print  (lastNum-1)

	// Corrected standard deviation
	make /o /d /n=(x1)  std_dev_eachPnt = sqrt( (sum_wave[p])/(lastNum-1) )   // since firstNum starts with 1

	// % error ( relative)
	make /o /d /n=(x1)  RelErr_eachPnt = abs(std_dev_eachPnt[p] / (mean_wave[p]) ) * 100  // since firstNum starts with 1

end



//------------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//	Find the integral in certain region of the spectra in a set of spectra given
//	The region for integral is mentioned in the procedure
//Parameters:
//	xwave= xaxis in points scaling againt which  areaxy works ( or trapezoidal integration, Riemann Integral).
//	n = number of waves to be analyzed

function  PeakAutoIntegrate_over_waves(xwave, n)
wave xwave
variable n
make /o /D /n=(n,9) data_output=0 ;  // for 8 peaks

wave dout=data_output

variable we1
string nam5
variable i
variable ar0,ar1,ar2,ar3,ar4,ar5,ar6,ar7

for (we1=0; we1<(n+1); we1=we1+1)

	nam5 = getbrowserselection(we1)
  		if (strlen(nam5) == 0)
			break
		endif

	wave wn=$nam5

			wave twv=wn
			//integrated area of the peaks (6 peaks) from the spectra.
			// position might be needed to change for specific spectra.
			 ar0=areaxy(xwave,twv,210,228)
			 ar1=areaxy(xwave,twv, 298, 323)
			 ar2=areaxy(xwave,twv, 394,419)
			 ar3 = areaxy(xwave,twv, 709,733)
			 ar4=areaxy(xwave,twv, 820,844)
			ar5 = areaxy(xwave,twv, 930,954)
			ar6 = areaxy(xwave,twv, 1035, 1059)
			ar7 = areaxy(xwave,twv, 1142, 1166)

	i= we1



	dout[i][0]=we1 // just the value of the variable or the peak number starting from zero.
	dout[i][1]=(ar0)
	dout[i][2]=(ar1)
	dout[i][3]=(ar2)
	dout[i][4]=(ar3)
	dout[i][5]=(ar4)
	dout[i][6]=(ar5)
	dout[i][7]=(ar6)
	dout[i][8]=(ar7)
	//dout[i][6]=(ar5)
	string sn=nameofwave(wn)
	//
endfor


end

//------------------------------------------------------------------------------------------------------------------------------------------
