
//*************************************************************
//*************************************************************

// Extract data from a wave (having same name) in all subfolders and place in a 2D wave
//  along the columns

//	Argument : name of the wave,
//	For example, "data1"


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
