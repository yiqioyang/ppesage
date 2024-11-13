This is the code for an additive emulator for climate model PPEs. It is simplified from additive Gaussian Processes, and coded in R. We nickname it as sage for Simplified Additive Gaussian processes Emulator. 
The codes are the method reported in the manuscript titled "A simple emulator that enables interpretation of parameter-output relationships in climate model PPEs and insights from applying it to two climate model PPEs", to be submitted to JAMES.

Authors: Qingyuan Yang, Gregory S Elsaesser, Marcus Van Lier-Walqui, Trude Eidhammer, and Linnia Hawkins

To run the method, go to application/run.R and read the notations therein. 
run.R includes the complete processes to run the method, including loading packages and functions, data loading, training, validaiton, saving results and etc.
run.R implements these processes through running the separate codes in run/
 
In run/, a new code LHS_generator.R is added as an example to generate the LHS samples. It reads data from data/para_def.csv which has three columns, i.e. parameter name, min, and max. This code outputs the sampled parameters to data/lhs_parameters.csv


Note: 
1. The current version of the codes does not implement uncertainty quantification, but this will be part of code expansion
2. sage works with one variable at a time.
3. During the training and testing, all parameters are uniformed to the range of 0-1, and the target variable is normalized to be zero-mean with a standard deviation of one. In the last segment of the code "run.R", the variable "out_generated_original_scale" converts the generated data back to the original scale. 

Method input (what is required for training sage): 
  Climate model PPE data:
  
   1. The parameters used to generate the PPE.
      
      It should be a n_ensemble x n_parameters dataframe/matrix saved as csv file. Each row corresponds to the parameters for one ensemble member run.
      
   2. The target climatologies.
      
      It should be a n_ensemble x n_climatologies dataframe/matrix saved as csv file. Each row corresponds to a series of climatologies of interest for one ensemble member run. 
   
   The two climate model PPEs adopted in this work can be found in ./data 
  
Method output (stored in the created directory: /cases/casename, casename defined by user):

  1. Three figures evaluating the emulator performance
     
       a. emu_comp.png:                       emulated results vs ground truths. Two sets of points are generated, which are based on the complete and optimized parameter sequences (see more below).
     
     ![emu_comp](https://github.com/user-attachments/assets/41a83b4d-2dc8-4087-8591-a17eb2606c30)
     
       b. emu_selec_para.png:                 how the explained variability (see more below) decreases with more terms added to the emulator prediction, during training.

     
      ![emu_selec_para](https://github.com/user-attachments/assets/9dc83e4c-fac7-4211-8ae7-37f656f1da77)
     
       c. sd_reduce_updated_parameters.png:   how the explained variability (see more below) decreases with more terms added to the emulator prediction, during validation.

  ![sd_reduce_updated_parameters](https://github.com/user-attachments/assets/4e72bbae-fbdb-494c-82a7-6fff972bcb28)
     
  2. Two csv files monitoring the explained variability during validation

       a. sd_reduce_all.csv:                  the explained variability for each parameter and parameter group using the complete parameter sequence, during validation.

       b. sd_reduce_update.csv:               the explained variability for each parameter and parameter group using the optimzed parameter sequence, during validation.
     
  3. The trained emulator saved as an .R file:
     
       emus.R


