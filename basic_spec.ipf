
 function  averall ()
 string nam5 ; variable we1
 variable x2=0; variable ccount=0
 
 NewDataFolder /O AveragedData
 for (we1=0; we1<45; we1=we1+1)
 nam5 = getbrowserselection(we1)
  print nam5
  variable str ; string emp=""
  str = stringmatch(nam5,emp)
printf "stringMatch result is : %g \r", str
 		if (str==1)
 		break
 		endif 
 		 
 wave wav3=$nam5
// print NameOfWave(wav3)
 string tname=NameOfWave(wav3)+"_avg"
  printf "Num Type of we1: %g \r" , numtype(we1)
//print tname					//for debugging
//variable ren = strlen(nam5)	//for debugging
//x2=numtype(ren)			//for debugging
//print ren , x2				//for debugging
ccount=ccount+1				//counter of cycles

variable y7,y6,y5  //y7=columns ;  y6=data points/rows ;y5=counter variable
 y7=dimsize (wav3,1) ; y6=dimsize(wav3,0)
 make /o/n=(y6) root:AveragedData:$tname

 wave tr =root:AveragedData:$tname
 tr=0
 
 	for (y5=0 ;  y5< y7 ; y5=y5+1)
 	tr=tr[p] + wav3[p][y5]
 	endfor
 	tr=tr[p]/y7
	display /w=(430,220,850,510) /k=0 tr
 	 textbox /C/N =text0/A=MC "Averaged_" + NameOfWave(wav3)
  	print y7,y6,y5
 printf "stringMatch result is : %g \r", str
 killstrings /Z tname
 
endfor 

print "Cycle ended" ;
printf "waves processed : %g \r" ccount

killvariables /Z ccount,y7,y6,y5,x2,we1,str
killstrings /Z nam5,emp
end 
