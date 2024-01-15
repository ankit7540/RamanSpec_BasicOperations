

# Function list

```

2D_operations
        - 1D_to_2D_rearrangements.ipf
                function merge1D_to_2D( prefix, starting_index, last_index , WLwave, FN )
                function /WAVE split1D_to_2D (input, length)
        - Analyse_2D_band_area_extraction.ipf
                function analyze_2D_data(input2D)
        - average_2D.ipf
                function do_average(input)
                function  averall ()
        - data_combine_delete.ipf
                function merge_waves_and_trim (input_wave2D1, xwave1 , input_wave2D2, xwave2 )
        - fitting_2D_data.ipf
                function fit_2D_data (input2D, xwave)
        - mathematical_ops.ipf
                function multiply_all_col (input2D, input1D)
                function subtract_from_2D(input2D, sub )
        - merge_2D.ipf
                function merge_2Dwaves_to_2D()
        - remove_col_from2D.ipf
                function  remove1col_from_selected_2D ( col_index )
                function remove_col_from_2D (input2D, col_index)

 background_correction
        - baseline_sub.ipf
                function   subtract_constant_bckg (input, pnt_start, pnt_end)
                function subtract_baseline_from_selected (pnt_start, pnt_end)

 basic_programming
        - s0_basic_of_functions.ipf
                function sum_numbers(a,b)
                function sum_waves(a,b)
                function subtract_waves(a,b)
                function divide_waves(a,b)
        - s1_wave_analysis.ipf
                function count_zero_pnts ( input)
                function reverse_ones_zero_pnts ( input)

 citation
        - *.ipf

 RamanSpec_BasicOperations
        - *.ipf

 custom_fit_functions
        - bands_withBaseline.ipf

 data_generation
        - sample_gen.ipf
                function construct_sample_str (length, separator)
                function sample_2D_gauss ()
                function sample_2D_2gauss ()
                function sample_2D_2lor ()
                function sample_2D_lor ()

 discussion
        - *.ipf

 eqn_solve
        - lin_eq.ipf
                function solve_linEq  (A, B)
                function solve_linEq_asymA (A, B)
        - non_linear_optimizaton.ipf
                function error_func ( w, k1, k2)
        - quadratic.ipf
                function /WAVE quadratic_solver (a,b,c)

 folder_operations
        - extract_from_folders.ipf
        - folder_contents.ipf

 RamanSpec_BasicOperations
        - *.ipf

 RamanSpec_BasicOperations
        - *.ipf

 general
        - spectroscopy.ipf
                function width_to_FWHM( width)
                function absorbance ( int0, int1)
                function intensity_with_depth(int0, epsilon, depth)
                function absorbance_BL( epsilon, concentration, depth)
                function epsilon_BL( absorbance, concentration, depth)
                function energyJ_per_photon (wavelength)
                function lambda_to_absWavenumber (wavelength)
                function lambda_to_Ramanshift (wavelength, laser_wavelength)
                function energyeV_per_photon (wavelength)
                function energyH_per_photon (wavelength)
                function wavelength_to_frequency( wavelength_nm)
                function  frequency_GHz_to_wavelength(  freq_GHz )
                function /WAVE frequencyGHz_to_wavelength_vec (freq_ghz)
                function /WAVE frequencyGHz_to_absWavenum_vec (freq_ghz)
                function absWavenum_to_freqGHz ( wavenum )
                function blackBody_spectral_output (wavelength, T)
                function logepsilon_to_absorbance( lgepsilon, path_length_cm, concentration_M)

 image_analysis
        - batch_binning.ipf
                function generate2D_from_image_batch ( folder_name )
                function generate2D_from_image ( input_image, output_folder,  col_start, col_end, col_start2, col_end2 , [remove_first] )
                function get_spectra_layered (ccd_image , wave_prefix  , col_start, col_end, col_start2, col_end2)
                function get_spectra (ccd_image ,  col_start, col_end, col_start2, col_end2)
        - binning.ipf
                function RMN_Anlys_gen2D_images_1bin ( bin1_Start, bin1_End )
                function RMN_Anlys_process_image_1bm ( input_image, output_folder,  col_start, col_end, noteString1, appendString, [remove_first] )
                function RMN_Anlys_processImg_1bm (ccd_image ,  col_start, col_end, appendString, noteString )

 intensity_corr
        - gen_correction.ipf
                function gen_C0_C1 ( ramanshift , laser_nm , wl_wave ,   norm_pnt , [ maskWave , set_mask_nan] )
                function gen_C0_C1_fixedT ( ramanshift , laser_nm , wl_wave ,   norm_pnt , temperatureK , [ maskWave , set_mask_nan] )
        - validation_antiStokes_Stokes.ipf
                function temp_sas_ratio_e (freq, is, ias, ref_T, laser_abs_wavenum)

 RamanSpec_BasicOperations
        - *.ipf

 loading_data
        - load_all_ibw.ipf
                function Load_allIBW_files()
        - load_all_itx.ipf
                function LoadITX_files_All()
        - load_all_txt.ipf
                function loadTXT_files_all()
        - load_csv.ipf
                function load_csv()
                function data_condenser( wname_str )

 noise_analysis
        - noise_analysis.ipf
                function standard_dev_eachPnt_spectra(prefixString, firstNum, lastNum)
                function  PeakAutoIntegrate_over_waves(xwave, n)
        - remove_cosmic_noise.ipf
                function remove_cosmic_noise( wave1D, index , cutoff )

 RamanSpec_BasicOperations
        - *.ipf

 plotting
        - add_offset_graph.ipf
        - plot_2D.ipf
                function plotall_nooffset( nCols)
                function plotall_withoffset(nCols)
        - plot_customization.ipf
                function plot_spectra_and_export_txt ( ramanshift , title_str, file_name )




```
