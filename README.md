This is the code for an additive emulator for climate model PPEs. It is simplified from additive Gaussian Processes, and coded in R. 
The codes are the method reported in the manuscript titled "A simple emulator that enables interpretation of parameter-output relationships in climate model PPEs and insights from applying it to two climate model PPEs", to be submitted to JAMES.

Authors: Qingyuan Yang, Gregory S Elsaesser, Marcus Van Lier-Walqui, Trude Eidhammer, and Linnia Hawkins

To run the method, go to application/run.R and read the notations therein. This code implements codes in run/ 
Note: The current version of the codes does not implement uncertainty quantification, but this will be part of code expansion


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
     
     ![emu_comp](https://github.com/user-attachments/assets/41a83b4d-2dc8-4087-8591-a17eb2606c30)
     
       b. emu_selec_para.png:                 how the explained variability (see more below) decreases with more terms added to the emulator prediction, during training.

     
      ![emu_selec_para](https://github.com/user-attachments/assets/9dc83e4c-fac7-4211-8ae7-37f656f1da77)
     
       c. sd_reduce_updated_parameters.png:   how the explained variability (see more below) decreases with more terms added to the emulator prediction, during validation.

  ![sd_reduce_updated_parameters](https://github.com/user-attachments/assets/4e72bbae-fbdb-494c-82a7-6fff972bcb28)
     
  3. Two csv files monitoring the explained variability during validation

       a. sd_reduce_all.csv:                  the explained variability for each parameter and parameter group using the complete parameter sequence, during validation.

       b. sd_reduce_update.csv:               the explained variability for each parameter and parameter group using the optimzed parameter sequence, during validation.
     
  4. The trained emulator saved as an .R file:
     
       emus.R


