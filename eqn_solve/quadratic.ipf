
//-------------------------------------------------------------------------------------
// solving quadratic equation for each triplet value of a,b and c
//  a, b and c are coefs for a quadratic equation
//  ax^2 + bx + c = 0

// returns a wave

function /WAVE quadratic_solver (a,b,c)
	variable a,b,c

	variable sqrt_term = sqrt(b^2 - 4*a*c)
	variable r1 = (-b+sqrt_term) / (2*a)
	variable r2 = (-b-sqrt_term) / (2*a)
	make /o/d/n=2 result
	result[0]=r1
	result[1]=r2
	return result
end

//-------------------------------------------------------------------------------------
