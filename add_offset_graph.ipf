Function Demo(graphNameStr)
	String graphNameStr			// "" for top graph
 
	String list = TraceNameList(graphNameStr,";",1)	// Ignore traces that belong to contour plots
	Variable numTraces = ItemsInList(list)
	Variable i
	for(i=0; i<numTraces; i+=1)
		String traceNameStr = StringFromList(i, list)
		Wave w = TraceNameToWaveRef(graphNameStr, traceNameStr )
		// Do something with w here
		Print i, NameOfWave(w)
	endfor
End
