
// To load all delimited txt files in a folder

// The file has the format

//  header1 header2 ... ...
//  <data>   <data> ... ...


// For each loaded file, a new folder is created in the data-browser
// the column in the txt file is loaded as waves ( autonamed as the header)

function loadTXT_files_all()

	String s

	string fileList
	string fileName
	variable fileNum
	variable i
	string ext

	string folder_name
	string mod_filename

  // define extension here
  // This is used for auto-selection of similar files in a directory
	ext = ".txt"

	NewPath/O path;
	fileList = indexedFile(path,-1,ext);
	fileNum = ItemsInList(fileList);

	DFREF savedDF = GetDataFolderDFR()

	for(i=0;i<fileNum;i=i+1)
		fileName = stringFromList(i,fileList)

    // remove blank in the filename
		mod_filename = ReplaceString(" ", fileName, "_" )

    // remove extension from the filename
		mod_filename = ReplaceString(".txt", mod_filename, "" )

    // replacing part of filename which are not needed
		mod_filename = ReplaceString("__", mod_filename, "" )

		sprintf folder_name, "d_%s", mod_filename
		print folder_name

		newdatafolder /o/s $folder_name

		// /A=Auto, /J = delimited text, /W = header as name, /D=double precision
		//  Refer to LoadWave (page 1708 and so on) in manual for other flags
		//  replace /J with /G to load general text
		
		LoadWave /A /J /W /D  /P=path fileName;

		setdatafolder savedDF
	endfor
	printf "\n\tLoaded %g files.\r", filenum
end

end

//------------------------------------------------------------------------
