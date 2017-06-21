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
