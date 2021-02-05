#pragma rtGlobals=3		// Use modern global access method and strict wave access.


//*************************************************************
//*************************************************************

// Print name of all waves in the current data folder

Function PrintAllWaveNames()
	String objName
	Variable index = 0
	DFREF dfr = GetDataFolderDFR() // Reference to current data folder
	do
		objName = GetIndexedObjNameDFR(dfr, 1, index)
		if (strlen(objName) == 0)
			break
		endif
		print objName
	index += 1
	while(1)
End

//*************************************************************
//*************************************************************
// Print name of all subfolders in the current data folder

// Arguments :
//	startingDFR , for example, root:
//	level , for exmaple, 0 or 1

// PrintDataFolderPaths( root:, 0)

Function PrintDataFolderPaths(startingDFR, level)
    DFREF startingDFR
    Variable level          // 0 for top level

    Variable i

    String prefix = ""              // Used to show data folder level using indentation
    for(i=0; i<level; i += 1)
        prefix += "\t"
    endfor

    Variable numDataFolders = CountObjectsDFR(startingDFR, 4)
    for(i=0; i<numDataFolders; i+=1)
        String dfName = GetIndexedObjNameDFR(startingDFR, 4, i)
        if (strlen(dfName) == 0)
            break
        endif

        DFREF dfr = startingDFR:$dfName
        String path = GetDataFolder(1, dfr)

        Print prefix + path

        PrintDataFolderPaths(dfr, level+1)              // Returns
    endfor
End

//*************************************************************
//*************************************************************
