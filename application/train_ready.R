
## Experiment going back
library(ncdf4)
#################################################################################
wd = "~/Documents/code_proj/simp_add_gp/"
setwd(wd)
case_name = "manuscript_figs_giss"
y_ind = 3

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
#source("./loading_CAM6_PPE.R")
source("./loading_ModelE3_PPE.R")
#inp = inp[-c(39,140),]
#out = out[-c(39,140),]
inp = rbind(inp_a,inp_b)[1:751,]
out = rbind(out_a,out_b)[1:751,]
inp_nm = inp_nm
out_nm = out_nm
#################################################################################
setwd(wd) 
var_name = out_nm[y_ind]
######################
source("./run/pre_processing.R")
source("./run/create_case.R")
source("./run/select_all_parameters.R")

source("./run/parameter_selection.R")
#comb_meta_update = comb_meta[c(1:20),]

source("./run/visualizing_results.R")
source("./run/saving_results.R")
#################################################################################



