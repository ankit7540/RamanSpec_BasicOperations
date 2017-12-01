# RamanSpec_BasicOperations
This repository contains the procedures for the mentioned job needed in day to day analysis of spectra which can be, for example, Raman or IR spectra etc... The procedures are for analyzing raw data (x,y columns) but might be useful for many other purposes.

1. average_2D.ipf : Procedure to average selected 2-D waves in a folder keep the averaged data in the 'averaged data' folder. More than one 2-D wave maybe selected.

2. plot_2D.ipf : Takes a 2D wave and plots all the individual columns against the points, with some constant off set, or wavemax deepndent offset. 

3. analysis.ipf : A set of procedures for analysis of waves.
  a) function = standard_dev_eachPnt_spectra : takes a set of waves, calculate the mean and std dev (1 sigma) and % error at each point of the wave.
  
4. add_offset.ipf : Two functions therein. One applies a constant offset to a traces on a plot ( offset is defined manually). Second, the offset is calculated such that two traces will never touch each other.
