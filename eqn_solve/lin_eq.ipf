
// -------------------------------------------------------------------

// solve for coefs in X, AX=B >>  X=inv(A) B
// matrix A is square


function solve_linEq  (A, B)
	wave A   //  2D (not a square matrix)
	wave B   //  1D

	matrixop /O X_out= inv(A)  x B

end

// -------------------------------------------------------------------

// solve for coefs in X, AX=B >>  X=inv(A) B
// matrix A is not a square matrix

function solve_linEq_asymA (A, B)
	wave A   //  2D (not a square matrix)
	wave B   //  1D

	matrixop /O A_T= A^t
	matrixop /O A_TA= A^t x A
	matrixop /O left_inv =  inv(A_TA ) x A_T
	matrixop /O X_out= left_inv  x B

  killwaves /Z A_T, A_TA, left_inv
end



// -------------------------------------------------------------------
