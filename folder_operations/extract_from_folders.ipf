
//*************************************************************
//*************************************************************

// Extract data from a wave (having same name) in all subfolders and place in a 2D wave
//  along the columns

//	Argument : name of the wave,
//	For example, "data1"

// This assumes that `data1` in all folders is of same dimension

Function extract_data_from_subfolders (name)
	string name // name of wave, common in all subfolders

	string objName
	string data_name
	Variable index = 0
	Variable index2
	variable nRows
	string root_folder

	DFREF dfr = GetDataFolderDFR() // Reference to current data folder
	root_folder=getdatafolder(1)		// string, full path to original folder



	// to count the number of folders
	do
		objName = GetIndexedObjNameDFR(dfr, 4, index)
			if (strlen(objName) == 0)
			break
			endif
			//Print objName
			index += 1
	while(1)

	print "Number of subfolders: ", index


	// to count the number of data points in the target wave
	wave data=$name	// this will be used to count the datapoints later
	do
		objName = GetIndexedObjNameDFR(dfr, 4, index2)
		if (strlen(objName) == 0)
		break
		endif

		setdatafolder objName

		wave data=$name
		nRows= dimsize(data, 0)
		index2=index2+1
	while(index2 == 0)

	setdatafolder dfr	// move back to originating position

	print "Dimension of target wave :", nRows
	// generate the destination wave
	make /o /d /n=(nRows, index) output


	// iterate over the folders and keep the wave in the 2D wave as the destination
	index2=0
	do
		objName = GetIndexedObjNameDFR(dfr, 4, index2)
		if (strlen(objName) == 0)
		break
		endif


		string folder_path
		sprintf folder_path, "%s'%s'", root_folder, objName
		Print index2, folder_path

		//-------------------------
		setdatafolder folder_path
		String cdf = GetDataFolder(1)
		string wname
		sprintf wname, "%s'%s'",cdf, name
		//print wname

		wave data=$wname
		//print nameofwave(data), wavemax(data)

		output[][index2] = data[p]

		index2 += 1
	while(index2 < index)

	setdatafolder dfr
	print "\tdone."
End

//*************************************************************
//*************************************************************

// Extract data from a wave (having same name) in all subfolders and
//	 place in a 1D wave (as colncatenated form)
// 	target wave need not have the same number of data points
//	Folders not having these waves are skipped

//	Argument : name of the wave as a string
//		For example, "dataN"
//	Resultant data is placed in a newly created wave
//		called 'output' in the current folder

// Folders must be selected in the data browser

Function extract_data_subfolders_unEq (name )

	string name // name of wave, common in all subfolders

	variable total_pnts
	string fullwavepath

	variable nRows
	variable nCols
	string root_folder

	root_folder=getdatafolder(1)		// string, full path to original folder

	string folder_name
 	variable index // for initial count of waves
 	variable i, j
 	variable count

	string cdf =getdatafolder(1)
	printf "\tPresent folder : %s\r" cdf

	// Count the number of folders using selection
	do
		folder_name  = getbrowserselection(index)
		if (strlen( folder_name ) == 0)
			break
		endif
 		index += 1
	while(1)

	print "\tNumber of folders selected: ", index

	// to count the number of data points in the target wave
	for (i=0; i<index; i=i+1)
	 	folder_name = getbrowserselection(i)
	 	sprintf fullwavepath, "%s%s", folder_name, name

	 	printf "\t\t%s", fullwavepath
	 	wave selected = $fullwavepath	// wave reference to target

	 	if (waveExists(selected) == 1)
			nRows = dimsize ( selected, 0)
			total_pnts = nRows + total_pnts
			printf "\t OK, %g pnts\r", nRows
		else
			printf "\t target not found, skipping folder \r"
		endif

	endfor

	print "\tTotal number of data points :", total_pnts

	// generate the destination wave
	if (total_pnts > 1)
		make /o /d /n=(total_pnts) output

		// extract data here
		for (i=0; i<index; i=i+1)
		 	folder_name = getbrowserselection(i)
		 	sprintf fullwavepath, "%s%s", folder_name, name

		 	wave selected = $fullwavepath	// wave reference to target

		 	if (waveExists(selected) == 1)
				nRows = dimsize ( selected, 0)
				for (j=0 ;  j< nRows ; j=j+1)
					output [count] = selected[j]
					count = count + 1
				endfor
			endif

		endfor

	else
		abort " Number of data point found is 1. \n Likely that target not found ! "
	endif

	print "\tdone."
End

//*************************************************************
//*************************************************************
