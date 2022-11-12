//Procedure to plot 2-D waves on plot with some offset //
// TO USE- Select a 2D wave in browser and then run the command in Command window. //
// FOLLOWING IS FOR NO OFFSET //

function plotall_nooffset( nCols)

	variable nCols	// Number of columns to plot

	wave twave
	string name		// name of trace wave
	variable MaxValue		// vMax
	variable nCol,nRow
	string n1
	string tracename
	variable i
	string fullname
	string annot2

	name=GetBrowserSelection(0)
	print name
	wavestats $name
	MaxValue=V_max
		wave twave=$name

		nCol=dimsize(twave,1)
		nRow=dimsize(twave,0)

		print nCol,nRow
		printf "columns : %g\r", nCol

		if (nCol==0)
			Abort "1D Wave selected. Choose right wave and try again. \r Column number 0 causes no ending loop ! \r Choose multi-dimensional wave.\r"
		endif

		n1= NameOfWave (twave)
		tracename=n1+"#"

		display /w=(350,230,720,420) /k=1 $name

		// Iteratively append to graph while applying offset
		for (i=1 ; i!=nCols  ; i=i+1)
			AppendToGraph $name[][(i)]
			sprintf fullname, "%s%g",tracename,i
			ModifyGraph rgb($fullname)=(8738,8738,8738)	// color
		endfor

		// Annotation in the text box
		sprintf annot2, " %g traces\r Wave name :%s \r V_Max: %g ", nCols,name,MaxValue
		TextBox/C/N=text0 /X=1.00/Y=1.00 annot2
		print "Plotted successfully\r"

end

//******************************************************************************

//FUNCTION TO PLOT MULTIDIMENSIONAL (2D) WAVES WITH SPECIFIED OFFSET
//OFFSET VALUE IS DETERMINED BY THE MAXIMUM VALUE OF THE WAVE
//OFFSET IS 0.075 OF THE MAXIMUM VALUE // Change by changing number in the procedure
// 0.075 is a good number by the way ! Check yourself.

// TO USE- Select a 2D wave in browser and then run the command in Command window. //

function plotall_withoffset(nCols)

	variable nCols	// Number of columns to plot

	wave twave
	string name			// name of trace wave
	variable MaxValue		// vMax
	variable ofst 			// offset (present is 0.075)
	variable nCol,nRow
	string n1
	string tracename
	variable i
	string fullname
	variable trace_offset
	string annot2

	name=GetBrowserSelection(0)
	print name
	wavestats $name
	MaxValue=V_max

	ofst = V_max * 0.075		//	(0.075 is the offset factor, change is to change y-offset scale in the plot.)

	printf "Offset:%g\r",ofst
		wave twave=$name

		nCol=dimsize(twave,1)
		nRow=dimsize(twave,0)

		printf "columns : %g\r", nCol

		if (nCol==0)
			Abort "1D Wave selected. Choose right wave and try again. \r Column number 0 causes no ending loop ! \r Choose multi-dimensional wave.\r"
		endif

		if (nCols > nCol)
			Print "Asked columns is more than existing columns in the 2D wave."
			nCols = nCol
		endif

		n1= NameOfWave (twave)
		tracename=n1+"#"

		display /w=(350,230,720,420) /k=1 $name

		variable color_step = floor(65536 / nCols+1)

		// Iteratively append to graph while applying offset
		for (i=1 ; i!=nCols  ; i=i+1)
			AppendToGraph $name[][(i)]
			trace_offset=i*ofst
			sprintf fullname, "%s%g",tracename,i
			//print fullname
			ModifyGraph offset ($fullname)={0,(trace_offset)}			// y-offset
			ModifyGraph rgb($fullname)=(  65000-( color_step *i) , 8736 , color_step * i )	// color
			// print color_step * i
		endfor

		// Annotation in the text box
		sprintf annot2, " %g traces\r Wave name :%s \r V_Max: %g ",nCols,name,MaxValue
		TextBox/C/N=text0 /X=1.00/Y=1.00 annot2
		print "Plotted successfully\r"

end

//******************************************************************************
