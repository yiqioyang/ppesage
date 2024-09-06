### Lines marked with ** means that more details can be found in the manuscript to be submitted

### Libraries that need to be installed
### Please un-comment the three lines below, or use your own way to install these packages
#install.packages(c("ncdf4", "ggplot2", "raster", "rgdal", "ggcorrplot", "tidyverse",
#                   "RColorBrewer", "gridExtra", "rgl", "RobustGaSP", "ClusterR", "cluster",
#                   "gridExtra", "scatterplot3d", "plot3D", "parallel", "lhs"))
### The above packages are not all used in this method, but can be convenient for subsequent analysis, visualizations.
#################################################################################
### Define the input and output (loading the data)
### inp: n by m matrix with n ensemble members and m parameters
### out: n by p matrix with n ensemble members and p target variables
### inp_nm: names of the parameters
### out_nm: names of the target variables

### Define and set working directory
wd = "~/Documents/code_proj/simp_add_gp/"
setwd(wd)

inp_raw = read.table("./data/modele3_ppe_input.csv", sep = ",", header=TRUE)
out_raw = read.table("./data/modele3_ppe_output.csv", sep = ",", header=TRUE)

### The two lines below are just to keep the inp_raw, and out_raw unchanged throughout for references.
inp = inp_raw
out = out_raw
inp_nm = colnames(inp)
out_nm = colnames(out)
################################################################################

### Create a case name, for example, ModelE3_PPE
case_name = "PPE_test"
# The index of variables to be estimated
y_ind = 6


### Specifications to run the model     
### See the readme file for what they mean
groupthree_flag = 0               # If zero, skipping selecting parameter groups of three, if not, selects parameter groups of three
no_single = round(n_par*0.8)      # Initial guess on the number of single parameters  ** 
no_pairs = round(n_par*1/3)       # Initial guess on the number of parameter pairs  ** 
no_groups = round(n_par*1/4)      # Initial guess on the number of parameter groups of three  ** 

range_pre = c(0.6, 0.5, 0.4)      # Specified fixed GP hyperparameters  ** 
nugget_pre = 4                    # Specified fixed GP hyperparameters  ** 


threshold1_pre = 0.00             # Not necessary to change         **
threshold2_pre = 0.000            # Not necessary to change         **

### What the two thresholds are?
## threshold1_pre: in emu_selec_para.png, if adding more single parameters leads to 
##                 increase in normalized RMSE, then they are not selected.
## threshold2_pre: is the same as threshold1_pre, but for parameter pairs and groups of three

## If their values are 0.01, then if the RMSE increases by some value below 0.01 as a result of having
## some parameters and parameter groups included in the prediction, then these parameters and parameter groups
## will not be excluded in the optimized parameter sequences. 


### 
trn_ratio = 0.8 * 0.8     ## The ratio of training data to obtain the original parameter sequence **
val_ratio = 0.8 * 0.2     ## The ratio of training data to optimize the original parameter sequence **
####                      ## The rest data will be used for validation.
####                      ## When doing validation, data from (trn_ratio + val_ratio) will be used for training
####                      ## The output of the method, namely the emulator as an R file, is trained based on 
####                      ## the complete dataset. 


#################################################################################
### Reset the working directory in case previous data loading changes it;
### Identify the target variable to be estimated
setwd(wd) 
var_name = out_nm[y_ind]
#################################################################################
### 1. Load the libraries and functinons, 
### 2. Normalize the parameters (0-1) and outputs (0-mean and 1-sd)
### 3. Do a shuffle, and split the trn, val, and tst dataset (see README for more details)
source("./run/pre_processing.R")

### Create a new dir called "case_name", and another directory within it
### with the name of the target variable to be estimated
source("./run/create_case.R")

### Use trn data to select the parameters and parameter groups
source("./run/select_all_parameters.R")

### Apply the (temporary) emulator trained based on trn to val data
### and optimizes the parameters and parameter groups
source("./run/parameter_selection.R")

### User could mannual optimie the parameters and parameters based on the figure it 
### generates
#comb_meta_update = comb_meta[c(1:20),]

### 1. Train the emulator using trn and val as training data with the complete and 
###    optimized parameter sequences 
### 2. Apply it to the tst data
### 3. Visualize the results
source("./run/visualizing_results.R")

### 1. Train the emulator using ALL data with the optimzied parameter sequences
### 2. Save it to an .R file called "emus"
### 3. Output the variability explained by applying the emulator trained based on
###    (trn+val) to the tst data using both the complete and optimized parameter sequences
source("./run/saving_results.R")
#################################################################################
### Making predictions
### generate some data 
### The code below just generate samples, and make predictions using the trained emulator
### for the particular variable of interest, i.e., the "y_ind"th output variable
### We are working on the code that generates the parameters, and estimates all target variables
### 

n_generated = 10000
inp_generated = data.frame(randomLHS(n_generated, n_par))
colnames(inp_generated) = inp_nm
out_generated = apply_pred(trained_emu, inp_generated, comb_meta_update)
out_generated_original_scale = out_generated * sd(out_raw[,y_ind]) + mean(out_raw[,y_ind])


plot3d(inp_generated[,34], inp_generated[,31], out_generated_original_scale)



