# RamanSpec_BasicOperations

[![DOI](https://zenodo.org/badge/50757391.svg)](https://zenodo.org/badge/latestdoi/50757391)

***

This repository contains procedures for the analysis of spectra. These can be, for example, Raman or IR spectra or others. The procedures are for analyzing raw data (x, y columns) of data loaded in IgorPro application.

Refer to the few lines before each function to understand the purpose and the scheme. Edits might be needed for the correct usage of a function depending on the specific dataset.

Question / comments / suggestions are welcome via the `Issues` tab.

 - Some functions are better documented in comparison to others.

***

## Citing this repository

Citation is requested if the procedures are useful in your analysis. Save the file and open with the reference manager to add to the reference list.

Download citation file : [Bibtex](https://raw.githubusercontent.com/ankit7540/RamanSpec_BasicOperations/master/citation/RamanOps.bib) / [Endnote](https://raw.githubusercontent.com/ankit7540/RamanSpec_BasicOperations/master/citation/RamanOps.RIS) (Right click on the link and select 'Save link as')


***

## Project tree

```
└── RamanSpec_BasicOperations
    ├── 2D_operations
    │   ├── 1D_to_2D_rearrangements.ipf
    │   ├── Analyse_2D_band_area_extraction.ipf
    │   ├── average_2D.ipf
    │   ├── data_combine_delete.ipf
    │   ├── fitting_2D_data.ipf
    │   ├── mathematical_ops.ipf
    │   ├── merge_2D.ipf
    │   ├── README.md
    │   └── remove_col_from2D.ipf
    ├── background_correction
    │   ├── baseline_sub.ipf
    │   └── README.md
    ├── basic_programming
    │   ├── s0_basic_of_functions.ipf
    │   └── s1_wave_analysis.ipf
    ├── citation
    │   ├── RamanOps.bib
    │   └── RamanOps.RIS
    ├── _config.yml
    ├── custom_fit_functions
    │   └── bands_withBaseline.ipf
    ├── data_generation
    │   ├── README.md
    │   └── sample_gen.ipf
    ├── discussion
    │   ├── Curve_fitting_Gaussian.pxp
    │   ├── Curve_fitting_Gaussian_run.pxp
    │   ├── fitting_many_gaussians_using_function.pxp
    │   ├── plotting_custom.pxp
    │   └── README.md
    ├── eqn_solve
    │   ├── lin_eq.ipf
    │   ├── non_linear_optimizaton.ipf
    │   └── quadratic.ipf
    ├── folder_operations
    │   ├── extract_from_folders.ipf
    │   ├── folder_contents.ipf
    │   └── README.md
    ├── general
    │   ├── README.md
    │   └── spectroscopy.ipf
    ├── image_analysis
    │   ├── batch_binning.ipf
    │   ├── binning.ipf
    │   └── README.md
    ├── intensity_corr
    │   ├── gen_correction.ipf
    │   ├── README.md
    │   └── validation_antiStokes_Stokes.ipf
    ├── LICENSE.md
    ├── loading_data
    │   ├── load_all_itx.ipf
    │   ├── load_all_txt.ipf
    │   └── README.md
    ├── noise_analysis
    │   ├── noise_analysis.ipf
    │   └── remove_cosmic_noise.ipf
    ├── plotting
    │   ├── add_offset_graph.ipf
    │   ├── plot_2D.ipf
    │   └── plot_customization.ipf
    └── README.md

```
