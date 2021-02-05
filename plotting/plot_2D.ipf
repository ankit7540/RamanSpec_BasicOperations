//Procedure to plot 2-D waves on plot with some offset //
// TO USE- Select a 2D wave in browser and then run the command in Command window. //
// NO OFFSET //

function plotall_nooffset( nCols)

variable nCols	// Number of columns to plot

wave twave
string name23		// name of trace wave
variable MaxValue		// vMax
variable p1,p2
string n1
string tracename
variable q1
string fullname
string annot2

name23=GetBrowserSelection(0)
print name23
wavestats $name23
MaxValue=V_max
		wave twave=$name23

		p1=dimsize(twave,1)
		p2=dimsize(twave,0)

		print p1,p2
		printf "columns : %g\r", p1

		if (p1==0)
			Abort "1D Wave selected. Choose right wave and try again. \r Column number 0 causes no ending loop ! \r Choose multi-dimensional wave.\r"
		endif

		n1= NameOfWave (twave)
		tracename=n1+"#"

		display /w=(350,230,720,420) /k=1 $name23

		// Iteratively append to graph while applying offset
		for (q1=1 ; q1!=nCols  ; q1=q1+1)
			AppendToGraph $name23[][(q1)]
			sprintf fullname, "%s%g",tracename,q1
			ModifyGraph rgb($fullname)=(8738,8738,8738)	// color
		endfor

		// Annotation in the text box
		sprintf annot2, " %g traces\r Wave name :%s \r V_Max: %g ", nCols,name23,MaxValue
		TextBox/C/N=text0/A=LT annot2
		print "Plotted successfully"
	killvariables /a/z
end

//**********************************************************************************************************************

//FUNCTION TO PLOT MULTIDIMENSIONAL (2D) WAVES WITH SPECIFIED OFFSET
//OFFSET VALUE IS DETERMINED BY THE MAXIMUM VALUE OF THE WAVE
//OFFSET IS 0.075 OF THE MAXIMUM VALUE // Change by changing number in the procedure
// 0.075 is a good number by the way ! Check yourself.

// TO USE- Select a 2D wave in browser and then run the command in Command window. //

function plotall_withoffset(nCols)

variable nCols	// Number of columns to plot

wave twave
string name23			// name of trace wave
variable MaxValue		// vMax
variable ofst 			// offset (present is 0.075)
variable p1,p2
string n1
string tracename
variable q1
string fullname
variable q4
string annot2


name23=GetBrowserSelection(0)
print name23
wavestats $name23
MaxValue=V_max

ofst = V_max * 0.075		//	(0.075 is the offset factor, change is to change y-offset scale in the plot.)

printf "Offset:%g\r",ofst
		wave twave=$name23

		p1=dimsize(twave,1)
		p2=dimsize(twave,0)

		print p1,p2
		printf "columns : %g\r", p1

		if (p1==0)
			Abort "1D Wave selected. Choose right wave and try again. \r Column number 0 causes no ending loop ! \r Choose multi-dimensional wave.\r"
		endif
		
		if (nCols > p1)
			Print "Asked columns is more than existing columns in the 2D wave."
			nCols = p1
		endif	

		n1= NameOfWave (twave)
		tracename=n1+"#"

		display /w=(350,230,720,420) /k=1 $name23

		// Iteratively append to graph while applying offset
		for (q1=1 ; q1!=nCols  ; q1=q1+1)
			AppendToGraph $name23[][(q1)]
			q4=q1*ofst
			sprintf fullname, "%s%g",tracename,q1
			//print fullname
			ModifyGraph offset ($fullname)={0,(q4)}			// y-offset
			ModifyGraph rgb($fullname)=(8738,8738,8738)	// color 
		endfor

		// Annotation in the text box
		sprintf annot2, " %g traces\r Wave name :%s \r V_Max: %g ",nCols,name23,MaxValue
		TextBox/C/N=text0/A=LT annot2
		print "Plotted successfully"
	killvariables /a/z
end


////**********************************************************************************************************
