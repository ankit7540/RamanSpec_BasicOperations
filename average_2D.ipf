
//----------------------------------------------------------------------------------------------------------------
// To get the average of 2D input

function do_average(input)
	wave input
	
	variable nRows
	variable nCols
	variable i
	
	nRows=dimsize(input, 0)
	nCols=dimsize(input, 1)	
	print nRows, nCols
	
	string name=nameofwave (input)
	
	string new_name
	sprintf new_name, "%s_avg",name
	print new_name
	
	make /o/d /n=(nRows) $new_name
	wave output=$new_name
	
	make /o/d /n=(nRows) temp=0
	
	for (i=0 ; i<nCols ;  i=i+1)
		temp=temp+input [p][(i)]
	endfor
	
	output=temp / nCols
	
end


//----------------------------------------------------------------------------------------------------------------

//Select multiple waves in the data-browser and then use the command in the command window to use the function.
//Please edit the code to suit your needs.


function  averall ()
string nam5 ; variable we1
variable x2=0; variable ccount=0
 
string cdf =getdatafolder(1)
print cdf

for (we1=0; we1<1000; we1=we1+1)
 	nam5 = getbrowserselection(we1)
	print nam5
	variable str ; string emp=""
	str = stringmatch(nam5,emp)
//	printf "stringMatch result is : %g \r", str
 	if (str==1)
 		break
 	endif 
 		 
	wave wav3=$nam5
	// print NameOfWave(wav3)
	string tname=NameOfWave(wav3)+"_avg"
//	printf "Num Type of we1: %g \r" , numtype(we1)

	//	print tname					//for debugging
	//	variable ren = strlen(nam5)	//for debugging
	//	x2=numtype(ren)			//for debugging
	//	print ren , x2				//for debugging

	ccount=ccount+1				//counter of cycles

	variable cols, rows , c  
 	cols		=	dimsize (wav3,1) 
 	rows	=	dimsize(wav3,0)

 	make /o/n=(rows) $tname
 	wave tr = $tname
 
 	for (c=0 ;  c < cols ; c = c+1)
 		tr=tr[p] + wav3[p][c]
 	endfor
 		tr=tr[p]/cols
		display /w=(430,220,850,510) /k=0 tr
 		textbox /C/N =text0/A=MC "Averaged_" + NameOfWave(wav3)
  		print cols,rows, c

 	killstrings /Z tname
 
endfor 

//	print "Cycle ended" ;
printf "waves processed : %g \r" ccount

killvariables /Z ccount,y7,y6,y5,x2,we1,str
killstrings /Z nam5,emp
end 

//----------------------------------------------------------------------------------------------------------------


