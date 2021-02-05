

#pragma TextEncoding = "UTF-8"
#pragma rtGlobals=3		// Use modern global access method and strict wave access.


//***********************************************************************************
//***********************************************************************************

// Generate 2D spectra from set of images ( image represents spectra acquired in 2D)

// Select the data waves in the data browser and run the command in the
//    command browser. For example,
//      generate2D_from_image_batch ( "extracted_spectra" ) while the data waves
//      are selected in the data browser

//  A new folder with name "extracted_spectra" will be made under the present
//  directory

function generate2D_from_image_batch ( folder_name )
	string folder_name	//	new folder with this name will be created

	string wname
	variable i
	string name
	variable count
	string output

	// count number of waves in the list
	count=0
	do
		name =GetBrowserSelection( count )
		if (strlen(name) <= 0)
			break
		endif
		count = count +1
	while(1)

	printf "%g waves selected - - - \r", count

	for (i=0 ; i< count  ; i=i+1)
		wname=GetBrowserSelection(i)
		wave input = $wname

		// remove_first parameter removes the first spectra from the data set

		// the  binning area is fixed here                    binStart1, binEnd1, binStart2, binEnd2
		// which are substituted as                                   5            18         22             32
		// for the  present setting
		generate2D_from_image ( input , folder_name,  5, 18, 22, 32 , remove_first=1 )

		// if single image, then remove_first has no consequence

	endfor

end


//***********************************************************************************
//***********************************************************************************

function generate2D_from_image ( input_image, output_folder,  col_start, col_end, col_start2, col_end2 , [remove_first] )
	wave input_image				// input image wave
	string output_folder				// new folder name
	variable col_start, col_end		// binned columns (set 1)
	variable col_start2, col_end2	 	// binned columns (set 2)
	variable remove_first			// =0 or 1, removes the first set of spectra

	DFREF presentFolder = GetDataFolderDFR()

	variable nRows
	variable nCols
	variable nLayers
	string newName1
	string newName2
	string wname = NameofWave(input_image)
	wname = RemoveEnding(wname)

	newName1 = wname+"_2D_perp"
	newName2 = wname+"_2D_para"

	nRows = dimsize(input_image, 0 )
	nCols = dimsize(input_image, 1 )
	nLayers= dimsize(input_image, 2 )


	// abort

	print "\t", wname, nRows,  nCols, nLayers

	if (nRows != 0 && nCols !=0 && nLayers == 0)

		// Single image, produces 1D spectra as output
		newdatafolder /O /S $output_folder
		get_spectra (  input_image ,  col_start, col_end, col_start2, col_end2 )

	elseif(nRows != 0 && nCols !=0 && nLayers != 0)

		// Multi-images, as layers, produces 2D  spectra as output

		// print nRows, nCols,  nLayers, wname
		newdatafolder /O /S $output_folder

		variable i, j		// i goes over columns,  j over layers

		make /o /d /n=(nRows, nLayers) $newName1
		wave output1 = $newName1
		make /o /d /n=(nRows, nLayers) $newName2
		wave output2 = $newName2

		make /d /o /n=(nRows) temp

		for (j=0 ; j< nLayers ; j=j+1)
			temp = 0
			// print j

			for (i=col_start ; i< col_end+1 ;i=i+1)
					temp  = temp + input_image [p][i][j]
					//print i,j
			endfor
			output1 [][j] = temp[p]


			temp = 0
			for ( i= col_start2 ; i < col_end2+1 ;i=i+1)
					temp  = temp + input_image [p][i][j]
					//print i,j
			endfor
			output2 [][j] = temp[p]
			// display temp0, temp1

		endfor

		if (remove_first ==1)
			DeletePoints /M=1 0,1, output1, output2
			// DeletePoints /M=1 0,1 output2
		endif

	endif

	killwaves /Z temp
	SetDataFolder presentFolder

end


//***********************************************************************************
//***********************************************************************************

function get_spectra_layered (ccd_image , wave_prefix  , col_start, col_end, col_start2, col_end2)
	wave ccd_image
	string wave_prefix
	variable col_start, col_end
	variable col_start2, col_end2

	variable nRows
	variable nCols
	variable nLayers
	variable i, j		// i goes over columns,  j over layers
	string wName1, wName2

	nRows = dimsize(ccd_image, 0 )
	nCols = dimsize(ccd_image, 1 )
	nLayers= dimsize(ccd_image, 2 )

	print nRows, nCols,  nLayers

	make /d /o /n=(nRows) temp

	for (j=0 ; j< nLayers+1 ; j=j+1)

		sprintf wName1, "%s_perp_L%g", wave_prefix, j
		sprintf wName2, "%s_para_L%g", wave_prefix, j

		make /o /d /n=(nRows) $wName1
		make /o /d /n=(nRows) $wName2

		wave output1=$wName1
		wave output2=$wName2

		for (i=col_start ; i< col_end+1 ;i=i+1)
				temp [] = temp + ccd_image[p][i][j]
				//print i,j
		endfor
		output1= temp
		//print NameofWave(output1)


		temp[] = 0

		i= col_start2
		for ( i= col_start2 ; i < col_end2+1 ;i=i+1)
				temp [] = temp + ccd_image[p][i][j]
				//print i,j
		endfor
		output2 = temp
		printf "Range: %g-%g -> %s\t    Range: %g-%g -> %s\r", col_start, col_end,  NameofWave(output1), col_start2, col_end2,  NameofWave(output2)
		//display output1, output2
		//abort
		//print i, j
	endfor


end

//***********************************************************************************
//***********************************************************************************


// Function to extract binned spectra from a single CCD image

function get_spectra (ccd_image ,  col_start, col_end, col_start2, col_end2)
	wave ccd_image				// input wave, non layered
	variable col_start, col_end		// binning region,  set 1
	variable col_start2, col_end2		// binning region, set  2

	variable nrows
	variable nCols
	variable i
	string wName1
	string wName2

	nRows = dimsize(ccd_image, 0 )
	nCols = dimsize(ccd_image, 1 )

	//  print nRows, nCols

	sprintf wName1, "%s_1D_perp", nameofwave(ccd_image)
	sprintf wName2, "%s_1D_para", nameofwave(ccd_image)

	make /o /d /n=(nRows) $wName1
	make /o /d /n=(nRows) $wName2

	wave spec1 = $wName1
	wave spec2 = $wName2

	make /d /FREE /n=(nRows) temp

	for (i=col_start ; i< col_end+1 ;i=i+1)
			temp [] = temp + ccd_image[p][i]
	endfor
	spec1 = temp

	temp[] = 0

	for ( i= col_start2 ; i < col_end2+1 ;i=i+1)
			temp [] = temp + ccd_image[p][i]
	endfor

	spec2 = temp


end

//***********************************************************************************
//***********************************************************************************
