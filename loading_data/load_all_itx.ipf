
//**************************************************************
//**************************************************************

// procedure to load all itx waves in a folder.
// take care of the formatting of the itx wave for proper loading.

function LoadITX_files_All()

	string fileList
	string fileName
	variable fileNum
	variable i
	string ext

	// define extension here
  // This is used for auto-selection of similar files in a directory
	ext = ".itx"

	NewPath/O path;
	fileList = indexedFile(path,-1,ext);
	fileNum = ItemsInList(fileList);

	for(i=0;i<fileNum;i=i+1)
		fileName = stringFromList(i,fileList);
		LoadWave /T   /P=path fileName;
	endfor
	printf "\n\tLoaded %g files.\r", filenum
end

//**************************************************************
//**************************************************************
