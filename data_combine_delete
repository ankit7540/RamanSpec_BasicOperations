
//---------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------
// To merge two 2D waves along with x-waves (Ramanshift) along the rows
// then delete some data points 

// result : waves named as 'output' and 'x_output'

function merge_waves_and_trim (input_wave2D1, xwave1 , input_wave2D2, xwave2 )
	wave input_wave2D1    //  2D
	wave xwave1           //  1D xaxis
	wave input_wave2D2    //  2D
	wave xwave2	          //  1D xaxis
	
	variable nRows1, nCols1
  variable nRows2, nCols2
	nRows1=dimsize(input_wave2D1, 0)
  nCols1=dimsize(input_wave2D1, 1)
  nRows2=dimsize(input_wave2D2, 0)  
	nCols2=dimsize(input_wave2D2, 1)
	
	print nRows1, nCols1
  print nRows2, nCols2
	
	// combine data here along the rows
	concatenate  /o /NP=0 {input_wave2D2, input_wave2D1 } , output
	concatenate  /o /NP=0 { xwave2, xwave1 } , x_output	
	
	// remove data points
	// change the data points as needed
	DeletePoints 990,81, x_output,output
	DeletePoints 0,116, x_output,output
		
	
end	

//---------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------
