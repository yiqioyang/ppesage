################################################################################
### Define and set working directory
wd = "~/Documents/code_proj/simp_add_gp/"
setwd(wd)

### Create a case name, for example, ModelE3_PPE
case_name = "random_test"
# The index of variables to be estimated
y_ind = 3


### Specifications to run the model     
### See the readme file for what they mean
groupthree_flag = 1

no_single = 40
no_pairs = 20
no_groups = 15
range_pre = c(0.6, 0.5, 0.4)
nugget_pre = 4

threshold1_pre = 0.00
threshold2_pre = 0.000

trn_ratio = 0.8 * 0.8
val_ratio = 0.8 * 0.2
#################################################################################
### Define the input and output (loading the data)
### inp: n by m matrix with n ensemble members and m parameters
### out: n by p matrix with n ensemble members and p target variables
### inp_nm: names of the parameters
### out_nm: names of the target variables

inp = read.table("./where/inp/is/stored", sep = ",", header=TRUE)
out = read.table("./where/out/is/stored", sep = ",", header=TRUE)
inp_nm = inp_nm
out_nm = out_nm

source("./loading_ModelE3_PPE.R")
#inp = inp[-c(39,140),]
#out = out[-c(39,140),]
inp = rbind(inp_a,inp_b)[1:751,]
out = rbind(out_a,out_b)[1:751,]
inp_nm = inp_nm
out_nm = out_nm
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



