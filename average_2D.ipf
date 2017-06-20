//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//Select multiple waves in the data-browser and then use the command in the command window to use the function.
//Please edit the code to suit your needs.

 function  averall_new ()
 string nam5 ; variable we1
 variable x2=0; variable ccount=0
 
 string cdf=getdatafolder(1)
// print cdf
 
 NewDataFolder /O AveragedData
 string new_wave_name
 for (we1=0; we1<45; we1=we1+1)
 	nam5 = getbrowserselection(we1)
	print nam5
	variable str ; string emp=""
	str = stringmatch(nam5,emp)
//	printf "stringMatch result is : %g \r", str
 		if (str==1)
 		break
 		endif 
 		 
	wave input_wave=$nam5

	string tname=NameOfWave(input_wave)+"_avg"
//	printf "Num Type of we1: %g \r" , numtype(we1)
	//	print tname					//for debugging
	//	variable ren = strlen(nam5)	//for debugging
	//	x2=numtype(ren)			//for debugging
	//	print ren , x2				//for debugging

	ccount=ccount+1				//counter of cycles

	sprintf  new_wave_name,"%sAveragedData:'%s'",cdf,tname
//	print new_wave_name

	variable row1, col1, i1  // row1=columns ;  col1=data points/rows ; i1 =counter variable
	row1 = dimsize (input_wave,0) 
	col1 = dimsize (input_wave,1)
	make /o /n=(row1) $new_wave_name =0

	wave tr = $new_wave_name
 
 	for (i1=0 ;  i1 < col1 ; i1 = i1+1)
 		tr=tr[p] + input_wave[p][i1]
 	endfor
 	
 	tr=tr[p]/i1
 
endfor 

print "Cycle ended" ;
printf "waves processed : %g \r" ccount

killvariables /Z ccount,y7,y6,y5,x2,we1,str
killstrings /Z nam5,emp
end 

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
