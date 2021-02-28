//----------------------------------------------------------------------------------------------------------------

//  To check the accuracy of the intensity calibration using anti-Stokes and Stokes Raman intensities

//   Requires:
//      frequency
//      Raman intensity for the pair of bands
//      Reference expt temperature 
//      Laser wavenumber(absolute)
   
function temp_sas_ratio_e (freq, is, ias, ref_T, laser_abs_wavenum)

        variable is		// Raman intensity, Stokes
        variable ias		// Raman intensity, antiStokes
        variable freq	// frequency (relative, scalar)
        variable ref_T			// true temperature data
        variable laser_abs_wavenum	// laser absolute wavenumber, scalar

        variable c,h,k,T, v0,n
        variable ratioSpectra, ratioTrue
      
      	  // define constants --------
        c=2.99792458e+10
        h=6.6260e-34
        k=1.38064e-23
        v0=laser_abs_wavenum
        // --------------------------------

        n=ln (  (ias/is)*( ((v0-freq)^3 )/((v0+freq)^3)  ) )
        
        T= ((-1*h*c*freq) / (k*n))
         print "  \nTemperature from spectra : ", T
        //---------------------------------------------
        variable RV_exptData = (ias/is)
        //---------------------------------------------
        variable term = ((-1*h*c*freq) / (k*ref_T ) )
        variable RHS  = exp ( term )
        
        variable LHS = (      (ias/is)*( ((v0-freq)^3 )/((v0+freq)^3)  )   )
        variable delta = abs(LHS-RHS)
        print "  Eqn:   (I_as / I_s ) * ((v0-freq)/(v0+freq))^3 = exp(-hc*freq / (kT)) "
        printf "  LHS : %5.5f\tRHS : %5.5f\t\tDelta (percent) : %5.5f %\r" LHS, RHS ,  (delta/RHS)*100
        //---------------------------------------------        

end

//----------------------------------------------------------------------------------------------------------------
