//**************************************************************
//**************************************************************

// To merge any number of 2D waves selected in the data browser
// Output is generated in the same folder as "mergedWave2D"

// Usage : select waves in the data browser and run the command

function merge_2Dwaves_to_2D()

string name1
variable  j, jmax , k
variable rows, columns
variable x1,x2
variable totalCol
variable counter


// purpose is to count the number of waves selected
do
		name1 = GETBROWSERSELECTION(j)
		wave wav1=$name1
		if(strlen(name1)<=0)
			break
		endif
		x1=dimsize(wav1,0)
		j=j+1
while(1)
jmax=j	// jmax is the number of selected waves

make /o /d  /n=(jmax) tempCol
wave tempCol

print tempCol
j=0
// purpose is to count the number of columns per wave selected
do
		name1 = GETBROWSERSELECTION(j)
		wave wav1=$name1
		if(strlen(name1)<=0)
			break
		endif
		columns=dimsize(wav1,1)
		print columns
		tempCol [j] = columns

		counter=counter+columns
		j=j+1
while(1)


// print counter

// Construct and assign the 2D wave
make /o /d /n=(x1, counter) mergedWave2D=0
wave mergedWave=mergedWave2D

counter=0
// Assign the columns of data
for (j=0 ; j <  jmax ; j=j+1)

	name1 = GETBROWSERSELECTION(j)
	wave wav1=$name1
	columns = tempCol [j]

	for ( k=0 ; k <  columns ; k=k+1)

		// print j, k,  name1, counter
		mergedWave[][ counter ] = wav1[p][k]
		counter=counter+1
	endfor
endfor

totalCol = dimsize (mergedWave, 1)
printf "\tProcess finished. 'mergedWave2D' created as output with dimensions : %g x %g.\r", x1, totalCol

killwaves /Z tempCol
end

//**************************************************************
//**************************************************************
