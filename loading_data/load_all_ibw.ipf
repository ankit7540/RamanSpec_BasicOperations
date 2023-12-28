

//**************************************************************
//**************************************************************

// procedure to load all ibw (igor binary files) files from a folder at once

function Load_allIBW_files()
	String s

	string fileList
	string fileName
	variable fileNum
	variable i
	string ext
	ext = ".ibw"

	NewPath/O path;
	fileList = indexedFile(path,-1,ext);
	fileNum = ItemsInList(fileList);

	for(i=0;i<fileNum;i=i+1)
		fileName = stringFromList(i,fileList);
		LoadWave /H /P=path fileName;
	endfor
	printf "Loaded %g files.\r", filenum
end

//**************************************************************
//**************************************************************
