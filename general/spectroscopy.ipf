
//////////////////////////////////////////////////////
/////////////  Define common constants ///////////////
//////////////////////////////////////////////////////

constant const_h = 6.62607015e-34		// Joules. second
constant const_c = 299792458				// meters per second
constant const_k = 1.380649e-23			//  Joules / kelvin
constant const_NA = 6.02214076e23		// number of particles per mole
constant const_e = 1.602176634e-19	// elementary charge

//////////////////////////////////////////////////////

// to compute FWHM from band width

function width_to_FWHM( width)
	variable width

	return width * 2 * sqrt(ln(2))
end

//////////////////////////////////////////////////////

// to compute absorbance from intensity0 and intensity

function absorbance ( int0, int1)
	variable int0		// without sample
	variable int1		// with sample

	return -log (int1 / int0)
end

//////////////////////////////////////////////////////

// to compute the intensity at a particular depth given
//	the epsilon, depth and original intensity

function intensity_with_depth(int0, epsilon, depth)
	variable int0
	variable epsilon
	variable depth

	return int0 * exp( - epsilon * depth )
end

//////////////////////////////////////////////////////

// to compute the absorbance using path length
//	epsilon (molar absorptivity coef) and concentration
//	Beer-Lamberts Law

function absorbance_BL( epsilon, concentration, depth)
	variable epsilon
	variable concentration
	variable depth

	return epsilon * concentration * depth

end

//////////////////////////////////////////////////////

// to compute energy in Joule for one photon of particular wavelength
// wavelength : unit nm, for example, 532

function energyJ_per_photon (wavelength)
	variable wavelength  // nm

	return (const_h * const_c)/ (wavelength * 1e-9 )
end


//////////////////////////////////////////////////////

// to convert wavelength to absolute wavenumber

function lambda_to_absWavenumber (wavelength)
	variable wavelength  // nm

	return ( 1e7 / wavelength )
end

//////////////////////////////////////////////////////

// obtain relative wavenumber for a wavelength
//	in comparison to the laser wavelength

function lambda_to_Ramanshift (wavelength, laser_wavelength)
	variable wavelength  // nm
	variable laser_wavelength // nm

	variable laser_abs_wavenumber = 1e7 / laser_wavelength

	return laser_abs_wavenumber -  ( 1e7 / wavelength )
end
//////////////////////////////////////////////////////

// wavelength to eV

function energyeV_per_photon (wavelength)
	variable wavelength  // nm

	variable e_J =  (const_h * const_c)/ (wavelength * 1e-9 )

	return (e_J / e)

end
//////////////////////////////////////////////////////

// wavelength to Hartree

function energyH_per_photon (wavelength)
	variable wavelength  // nm

	variable e_J =  (const_h * const_c)/ (wavelength * 1e-9 )

	return (e_J )* (1/4.35974465E-18)

end
//////////////////////////////////////////////////////

// wavelength to frequency in Hz

function wavelength_to_frequency( wavelength_nm)
	variable wavelength_nm

	return const_c / (wavelength_nm * 1e-9)
end
//////////////////////////////////////////////////////
