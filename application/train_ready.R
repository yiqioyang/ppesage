rm(list = ls())
library(ncdf4)
wd = "~/Documents/code_proj/simp_add_gp/"
setwd(wd)
source("./loading_CAM6_PPE.R")
inp = inp[-c(39,140),]
out = out[-c(39,140),]
inp_nm = inp_nm
out_nm = out_nm
trn_ratio = 0.8 * 0.8
val_ratio = 0.8 * 0.2
setwd(wd)

######################
no_single = 20
no_pairs = 10
no_groups = 10
range_pre = c(0.6, 0.5, 0.4)
nugget_pre = 4

threshold1_pre = -0.00
threshold2_pre = 0.000

######################
wd = "~/Documents/code_proj/simp_add_gp/"
setwd(wd)
#source("~/Documents/code_proj/simp_add_gp/data_load_reg.R")
fun_names = list.files("./functions/" ,full.names = TRUE)
## Add a line that excludes the pre_processing
apply(X = matrix(fun_names, ncol = 1), MARGIN = 1, FUN = source)
#################################################################################

########################################################################################
# which(!is.na(out[1,])):1  3  4  5  6  7  8  9 10 11 12 15 16 17 22

y_ind = 9
########################
l1_info = seq_gaus_1d_a(x = inp_trn, y = out_trn[,y_ind], range = range_pre[1], nugget = nugget_pre, iteration = no_single)
l2_info = seq_gaus_2d(x = inp_trn, y = l1_info[[2]], range = c(range_pre[2], range_pre[2]), nugget = nugget_pre, top_n = no_pairs)
l2_calc = apply_emu(x = inp_trn, y = l1_info[[2]], meta_data = l2_info[[1]])
#########################
l3_info = seq_gaus_3d(x = inp_trn, y = l2_calc[[2]], range = c(range_pre[3], range_pre[3], range_pre[3]), nugget = nugget_pre, top_n = no_groups)

comb_meta = rbind(l1_info[[1]], 
                  as.matrix(l2_info[[1]]),
                  as.matrix(l3_info[[1]]))
#########
val_pred = apply_emu_val(inp_trn, out_trn[,y_ind], meta_data = comb_meta, xtst = inp_val)
select_ind = plot_val(pred_adding = val_pred, ytrue = out_val[,y_ind], comb_meta, 
                            title = "Validation", threshold1 = threshold1_pre, threshold2 = threshold2_pre)




comb_meta_update = comb_meta[select_ind,]
####################################
#comb_meta_update = comb_meta[c(1:20),]
################################
tst_pred_short = apply_emu_val(inp_trn_val, out_trn_val[,y_ind], meta_data = comb_meta_update, xtst = inp_tst)
tst_pred_tst   = apply_emu_val(inp_trn_val, out_trn_val[,y_ind], meta_data = comb_meta, xtst = inp_tst)

plot_res(pred_adding = tst_pred_tst, ytrue = out_tst[,y_ind], comb_meta = comb_meta, title = "Based on all parameters and groups")
plot_res(pred_adding = tst_pred_short, ytrue = out_tst[,y_ind], comb_meta = comb_meta_update, title = "Based on optimized parameters and groups")


plot(out_tst[,y_ind], tst_pred_short[[1]], col = "navy", pch = 16, cex = 0.7,
     xlab = "Climate model output", ylab = "Emulator output", main = out_nm[y_ind])
points(out_tst[,y_ind], tst_pred_tst[[1]], col = "red", pch = 16, cex = 0.5)
abline(a = 0, b = 1)
legend("topleft", # Position of the legend
       legend=c("Optimized", "All parameters and groups"), # Labels
       col=c("navy", "red"), # Colors
       pch=c(16, 16)) # Point types
################################

