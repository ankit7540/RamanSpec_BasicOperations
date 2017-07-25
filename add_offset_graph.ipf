
// Fixed offset to the waves.

Function Apply_yOffset(graphNameStr, offset_value)
	//	parameters
	//	"graphNameStr" - name of the graph
	//	offset value
	
	String graphNameStr			// "" for top graph
 	variable offset_value
 
	String list = TraceNameList(graphNameStr,";",1)	// Ignore traces that belong to contour plots
	Variable numTraces = ItemsInList(list)
	print numTraces, "traces in selected graph" // this is the number of traces in the graph
	
	
	Variable i, V_max_prev=0
	
	// 	loop running over each trace
	for(i=0; i< numTraces ; i=i+1)
		String traceNameStr = StringFromList(i, list)
		Wave w = TraceNameToWaveRef(graphNameStr, traceNameStr )
	
		//	Print i, NameOfWave(w)
		string name=NameOfWave(w)
		WaveStats/Q  w
		Wave M_WaveStats

		ModifyGraph offset($name)={0,(i* offset_value )}
		print i, NameOfWave(w),"y-offset =",( i* offset_value)," applied" 
		
		V_max_prev=V_max
	endfor
End


//---------------------------------------------------------------------------------------------------
// Dynamic offset ( depends on the maximum value of y, in the previous wave to get the dynamic offset.

Function Apply_yOffset_vmax(graphNameStr, offset_value)
	//	parameters
	//	"graphNameStr" - name of the graph
	//	offset value
	
	String graphNameStr			// "" for top graph
 	variable offset_value
 
	String list = TraceNameList(graphNameStr,";",1)	// Ignore traces that belong to contour plots
	Variable numTraces = ItemsInList(list)
	print numTraces, "traces in selected graph" // this is the number of traces in the graph
	
	
	Variable i, V_max_prev=0
	variable offs
	
	// 	loop running over each trace
	if (i>0)
		for(i=0; i< numTraces ; i=i+1)
			String traceNameStr = StringFromList(i, list)
			Wave w = TraceNameToWaveRef(graphNameStr, traceNameStr )
	
			//	Print i, NameOfWave(w)
			string name=NameOfWave(w)
			WaveStats/Q  w	//performed for obtaining the V_max in a 1D wave
				
			if (i>0)
				offs=offs+V_max_prev + offset_value	// dynamic offset
				ModifyGraph offset($name)={0,( offs )}
			endif
			print i, NameOfWave(w),"y-offset =",(offs)," applied" 
			V_max_prev=V_max	// save vmax to a variable
		endfor
	else
	abort "Error : Only one trace on the graph. Offset cannot be applied !"
End

//------------------------------------------------------------------------------------------------------
