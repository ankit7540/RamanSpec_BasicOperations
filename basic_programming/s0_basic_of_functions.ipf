// writing functions in Igor Pro

//-----------------------------------------
// sum of numbers

function sum_numbers(a,b)
	variable a
	variable b
	
	print a+b

end

//-----------------------------------------

// sum of waves (1D waves)
function sum_waves(a,b)
	wave a
	wave b
	
	variable nRows=dimsize(a, 0)
	make /o /n=(nRows) output = a+b

end

//-----------------------------------------

// subtract waves (1D waves)
function subtract_waves(a,b)
	wave a
	wave b
	
	variable nRows=dimsize(a, 0)
	make /o /n=(nRows) output = a-b

end

//-----------------------------------------

// divide a wave by another wave

// subtract waves (1D waves)
function divide_waves(a,b)
	wave a
	wave b
	
	variable nRows=dimsize(a, 0)
	make /o /n=(nRows) output = a/b

end

//-----------------------------------------
