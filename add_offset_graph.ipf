	
	
	String graphNameStr			// "" for the graph
 	String list = TraceNameList(graphNameStr,";",1)	// Ignore traces that belong to contour plots
	Variable numTraces = ItemsInList(list)
	print numTraces // this is the number of traces in the graph
