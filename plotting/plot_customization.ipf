
//-------------------------------------------------------------------------------------------

//    plot spectra and export as png
//  		save spectra_data as txt

function plot_spectra_and_export_txt ( ramanshift , title_str, file_name )

	wave ramanshift    // xaxis wave
	string title_str   // string, for legend, for example, "C\\B6\\MH\\B6"
	string file_name   // string, for file_name

	string name
	name=GetBrowserSelection(0)
	wave input = $name

	display input   vs   ramanshift

	string wname = nameofwave(input)
	print wname
	// ---------------------------------------------
	wavestats /R=[650, 1600] /Q input
	variable spectra_min = v_min
	variable  spectra_max = v_max
	// ---------------------------------------------
	wavestats /Q ramanshift
	variable xaxis_min = v_min
	variable  xaxis_max = v_max
	// ---------------------------------------------
	SetAxis bottom v_max , v_min
	ModifyGraph grid(bottom)=1,mirror=1,fSize=30,axThick=2,gridHair(bottom)=1,manTick(bottom)={0,500,0,0},manMinor(bottom)={3,2},gridRGB(bottom)=(30583,30583,30583)

	ModifyGraph lsize=3.4

	ModifyGraph manTick(bottom)={0,400,0,0},manMinor(bottom)={3,2}
	ModifyGraph lblPosMode(left)=2,lblMargin(left)=15,tlblRGB(left)=(65535,65535,65535);DelayUpdate
	Label left "Raman intensity"
	Label bottom "Wavenumber / cm\\S-1"

	SetAxis left *, (spectra_max + 0.1*spectra_max)

	// --------------------------------------------
	string title
	sprintf title, "\\Zr260\\s(%s) %s" , nameofwave(input), title_str
	Legend/C/N=text0/J/Z=1/A=MC/X=2.00/Y=2.00 title
	Legend/C/N=text0/J/A=RT

	// exporting data to txt file

	Save/J/M="\r\n"   ramanshift   ,  input  as file_name

	sprintf file_name, "%s_plot.png", file_name
	SavePICT/E=-5 /B=288/W=(0,0,1000,375) as file_name


end

//-------------------------------------------------------------------------------------------
