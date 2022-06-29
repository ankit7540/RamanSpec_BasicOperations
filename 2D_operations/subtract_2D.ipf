
// function to subtract a 1D wave from all cols of a 2D wave 

function subtract_from_2D(input2D, sub )
	wave input2D
	
	wave sub
	
	variable nRows = dimsize(input2D, 0)
	variable nCols = dimsize(input2D, 1)
	
	variable i
	
	make /o /d /n=(nRows, nCols) out
	make /o /d /n=(nRows ) temp
	
	
	for (i=0 ; i< nCols ;i=i+1)
	
		temp = input2D[p][i]
		
		temp = temp - sub 
		
		out [][i] = temp[p]
		
	
	
	endfor
	
	killwaves /Z temp
	
end	
