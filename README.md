This is the code for an additive emulator for climate model PPEs. It is simplified from additive Gaussian Processes, and coded in R. 
The codes are the method reported in the manuscript titled "A simple emulator that enables interpretation of parameter-output relationships in climate model PPEs and insights from applying it to two climate model PPEs", to be submitted to JAMES.

Authors: Qingyuan Yang, Gregory S Elsaesser, Marcus Van Lier-Walqui, Trude Eidhammer, and Linnia Hawkins

Method input: 
  Climate model PPE data:
  
   1. The parameters used to generate the PPE.
      
      It should be a n_ensemble x n_parameters dataframe/matrix saved as csv file. Each row corresponds to the parameters for one ensemble member run.
      
   2. The target climatologies.
      
      It should be a n_ensemble x n_climatologies dataframe/matrix saved as csv file. Each row corresponds to a series of climatologies of interest for one ensemble member run. 
   
   The two climate model PPEs adopted in this work can be found in ./data 
  
Method output:
  1. Three figures evaluating the emulator performance
     
       a. emu_comp.png:                       emulated results vs ground truths. Two sets of points are generated, which are based on the complete and optimized parameter sequences (see more below).
     
       b. emu_selec_para.png:                 how the explained variability (see more below) decreases with more terms added to the emulator prediction, during training.
     
       c. sd_reduce_updated_parameters.png:   how the explained variability (see more below) decreases with more terms added to the emulator prediction, during validation.
     
  2. Two csv files monitoring the explained variability during validation

       a. sd_reduce_all.csv:                  the explained variability for each parameter and parameter group using the complete parameter sequence, during validation.

       b. sd_reduce_update.csv:               the explained variability for each parameter and parameter group using the optimzed parameter sequence, during validation.
     
  3. The trained emulator saved as an .R file:
     
       emus.R

