
//------------------------------------------------------------------------

// Load a CSV file
//			(allows for customization of lines to be skipped
//        set loaded wname )
//  assumes that first col in the csv file is wavenumber axis

// this function serves as template to design other fileLoading functions

function load_csv()

	variable ref;
	variable i

	string ext = ".CSV"

	open/R/D/T=".CSV" ref;
	if(cmpStr(S_fileName ,"") == 0)
		return 0; // user canceled
	endif


	print S_fileName
	string fileName
	fileName = S_fileName[lastIndexOf(S_fileName,":")+1,lastIndexOf(S_fileName,".")-1];

	print "\t wavename : ", fileName

	string mod_filename
	string folder_name

	// selection of number of lines to be skipped (comments) and wavename
	string wname = fileName
	variable skipLines = 12

	string cdf = getdatafolder(1)

	Prompt wname,  "Wave name :  "
	Prompt skipLines, "Number of lines to be skipped :"
	Prompt cdf , "Current Data folder is "
	DoPrompt "Give information about file load ", wname, skipLines, cdf


	//-----------
   // remove blank in the filename
		mod_filename = ReplaceString(" ", fileName, "_" )

   // remove extension from the filename
		mod_filename = ReplaceString( ext, mod_filename, "" )

   // replacing part of filename which are not needed
		mod_filename = ReplaceString("__", mod_filename, "" )


	// /A=Auto, /J = delimited text, /W = header as name, /D=double precision
	//  Refer to LoadWave (page 1708 and so on) in manual for other flags
	//  replace /J with /G to load general text

		LoadWave /A  /J   /D /L={0,12,0,0,0} S_fileName ;

		data_condenser( wname )
	//-----------
end

//------------------------------------------------------------------------

// Purpose :
// rename wave0 to wavenumber
// combine wave1 to waven as a 2D wave

function data_condenser( wname_str )

	string wname_str

	string wList = waveList ( "wave*", "," , "")
	Variable numItems = ItemsInList( wList , ",")

	string selected
	selected = stringFromList (0, wList, ",")
	wave sel = $selected

	variable nRows = dimsize(sel, 0)
	print nameofwave(sel), nRows, numItems

	make /o /d /n=( nRows, numItems - 1 ) sp

	variable j


	for (j=1 ; j <  numItems ; j=j+1)
		selected = stringFromList (j, wList, ",")
		wave wav1=$selected
		sp [][j-1] = wav1[p]
	endfor

	variable totalCol
	totalCol = dimsize (sp, 1)

	wave wave0
	duplicate /O wave0, wavenumber
	KillWaves wave0

	// clear out the 1D waves
	for (j=1 ; j <  numItems ; j=j+1)
		selected = stringFromList (j, wList, ",")
		wave wav1=$selected
		killwaves /Z wav1
	endfor

	rename  sp, $wname_str

end

//------------------------------------------------------------------------
