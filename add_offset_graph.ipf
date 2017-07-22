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
