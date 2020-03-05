#pragma rtGlobals=3		// Use modern global access method and strict wave access.
#include <Multi-peak fitting 2.0>

//-----------------------------------------------------------------------
//-----------------------------------------------------------------------

function analyze_2D_data(input2D)
	wave input2D
	
	variable nRows, nCols
	variable i
	
	variable a1,a2
	variable b1, b2
	variable c1, c2
	variable avg1, avg2, avg3
	variable band1, band2, band3
	
	nRows=dimsize(input2D, 0)
	nCols=dimsize(input2D, 1)	
	
	print "dimensions:",nRows, nCols
	
	make /o /d /n=(nCols, 5) output
	make /FREE /d /n=(nRows) temp
	make /o /d /n=(nRows, nCols) processed
	make /o /d /n=(nRows) xaxis=p
	
	make /o /d /n=(nCols) err1, err2, err3
	
	// --------------------------------------
	// change following
	// **** define band params ****
	
		// band 1
		a1=1046
		a2=1153
	//--------------------------------------			
		// band2
		b1=574
		b2=581		
		
	//--------------------------------------			
		// band3
		c1=1233
		c2=1320		
	//**************************************
	// --------------------------------------	
	
	for (i=0 ; i < nCols; i=i+1)
		
		temp=input2D [p][i]
		
		// do some operation and get data
		
		avg1=(temp[(a1)] + temp[(a2)])/2
		
		// remove the mean, similar to remove baseline
		temp=temp-avg1
		
		band1=areaxy(xaxis, temp, a1, a2 )
		
		// assign temp to 2D (for checking)
		processed[][i]=temp[p]
	
		//-------------------------------
		// band 2
		
		temp=input2D [p][i]
				
		avg2=(temp[(b1)] + temp[(b2)])/2
		
		// remove the mean, similar to remove baseline
		temp=temp-avg2
		
		band2=areaxy(xaxis, temp, b1, b2 )
		//-------------------------------
		// band 3
		
		temp=input2D [p][i]
		
		avg3=(temp[(c1)] + temp[(c2)])/2
		
		// remove the mean, similar to remove baseline
		temp=temp-avg3
		
		band3=areaxy(xaxis, temp, c1, c2 )
		//-------------------------------
		
		
		print i, band1 ,band2, band3, avg1, avg2, avg3
		
		output[i][0]=0
		output[i][1]=band1
		output[i][2]=band2
		output[i][3]=band3
		
		//------------------------------
		
	endfor	
	
	err1 [] = sqrt( output[p][1] ) + 0.005 *output[p][1]
	err2 [] = sqrt( output[p][2] ) + 0.005 *output[p][2]
	err3 [] = sqrt( output[p][3] ) + 0.005 *output[p][3]
	
	//wave angle
	//output[][0]=angle[p]
	
end

//-----------------------------------------------------------------------
//-----------------------------------------------------------------------


