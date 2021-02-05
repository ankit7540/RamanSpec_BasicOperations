#pragma rtGlobals=3		// Use modern global access method and strict wave access.



//*******************************************************************************************************************
//*******************************************************************************************************************

// Generate 2D spectra from set of images ( image represents spectra acquired in 2D)
// single images are also processed to give 1D spectra

function RMN_Anlys_gen2D_images_1bin ( bin1_Start, bin1_End )

	variable bin1_Start
	variable bin1_End


	string folder_name	//	new folder with this name will be created
	string append_string	//	new folder with this name will be created

	prompt folder_name, "Enter name of destination folder"
	prompt append_string, "Enter string to be appended to all waves"
	DoPrompt "Input required (folder will be created if not exists, if already exists  new files will be added).", folder_name, append_string

 		if( V_Flag )
     			return 0         		// user canceled
   		endif

	string wname
	variable i
	string name
	variable count
	string output
	variable nLayer

	string wnote1


	// ----------------------------------------

	// count number of waves in the list
	count=0
	do
		name =GetBrowserSelection( count )
		if (strlen(name) <= 0)
			break
		endif
		count = count +1
	while(1)

	printf "Image  to spectra\n  %g  waves selected - - - \r", count
	printf "Binning  region : Bin1  : [%g, %g] \r", bin1_Start, bin1_End
	printf "Number of vertical pixels : Bin1  : %g  \r", (bin1_End-bin1_Start+1)

	sprintf wnote1, "Binning  region : Bin1 = [%g, %g]; Number of vertical pixels : Bin1 = %g", bin1_Start, bin1_End, (bin1_End-bin1_Start+1)

	for (i=0 ; i< count  ; i=i+1)
		wname=GetBrowserSelection(i)
		wave input = $wname
		// remove_first parameter removes the first spectra from the data set
		//	*This is of no consequence for single image

		// print i, wname

		// the  binning area is fixed here                    binStart1, binEnd1, binStart2, binEnd2
		// which are substituted as                                   5            18         22             32
		// for the  present setting

		nLayer = dimsize(input, 2)

		if (nLayer < 5  ) // if layers are one or two, no loss in dimension
			RMN_Anlys_process_image_1bm ( input , folder_name,  bin1_Start, bin1_End,  wnote1, append_string, remove_first=0 )
		else
			RMN_Anlys_process_image_1bm ( input , folder_name,  bin1_Start, bin1_End,  wnote1, append_string, remove_first=0 )
		endif


	endfor

end


//*******************************************************************************************************************
//*******************************************************************************************************************


// To extract spectra from image where a single beam of light is imaged corresponding to a spectra

function RMN_Anlys_process_image_1bm ( input_image, output_folder,  col_start, col_end, noteString1, appendString, [remove_first] )
	wave input_image				// input image wave
	string output_folder				// new folder name
	variable col_start, col_end		// binned columns (set 1)
	string noteString1				// String defining the wave note
	string appendString				// string to be appended to the new wave
	variable remove_first			// =0 or 1, removes the first set of spectra

	DFREF presentFolder = GetDataFolderDFR()

	variable nRows
	variable nCols
	variable nLayers
	string newName1
	string wname = NameofWave(input_image)
	wname = RemoveEnding(wname)

	newName1 = wname+"_2D_"+appendString

	nRows = dimsize(input_image, 0 )
	nCols = dimsize(input_image, 1 )
	nLayers= dimsize(input_image, 2 )

	if (nRows == 0 || nCols ==0 )
		abort ("Error : Probably no waves selected. nRows, nCols found to be zero.")
	endif
	printf "\t %s\t\t%g\t%g\t%g\r", wname, nRows,  nCols, nLayers

	if (nRows != 0 && nCols !=0 && nLayers == 0)

		// Single image, produces 1D spectra as output
		newdatafolder /O /S $output_folder
		RMN_Anlys_processImg_1bm (  input_image ,  col_start, col_end, appendString, noteString1 )

	elseif(nRows != 0 && nCols !=0 && nLayers != 0)

		// Multi-images, as layers, produces 2D  spectra as output

		// print nRows, nCols,  nLayers, wname
		newdatafolder /O /S $output_folder

		variable i, j		// i goes over columns,  j over layers

		make /o /d /n=(nRows, nLayers) $newName1
		wave output1 = $newName1
		Note output1, noteString1		//	Apply note to the wave

		make /d /o /n=(nRows) temp

		for (j=0 ; j< nLayers ; j=j+1)
			temp = 0
			//print j

			for (i=col_start ; i< col_end+1 ; i=i+1)
					temp  = temp + input_image [p][i][j]
					//print i, j
			endfor
			output1 [][j] = temp[p]

		endfor

		if (remove_first ==1)
			DeletePoints /M=1 0,1, output1
		endif

	endif

	killwaves /Z temp

	SetDataFolder presentFolder

end


//*******************************************************************************************************************
//*******************************************************************************************************************

// Function to extract binned spectra from a single CCD image
// 1 beam , to obtain 1 spectra from the image
// no layers

// Used in the above function

function RMN_Anlys_processImg_1bm (ccd_image ,  col_start, col_end, appendString, noteString )
	wave ccd_image				// input wave, non layered
	variable col_start, col_end		// binning region,  set 1
	string appendString				// String to be appended to the output spectra
	string noteString					// wave note

	variable nrows
	variable nCols
	variable i
	string wName1

	nRows = dimsize(ccd_image, 0 )
	nCols = dimsize(ccd_image, 1 )

	//  print nRows, nCols

	sprintf wName1, "%s_1D_%s", nameofwave(ccd_image), appendString

	make /o /d /n=(nRows) $wName1

	wave spec1 = $wName1
	Note spec1, noteString		//	Apply note to the wave

	make /d /FREE /n=(nRows) temp

	for (i=col_start ; i< col_end+1 ;i=i+1)
			temp [] = temp + ccd_image[p][i]
	endfor
	spec1 = temp

end

//*******************************************************************************************************************
//*******************************************************************************************************************
