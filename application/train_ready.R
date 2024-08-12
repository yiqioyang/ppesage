rm(list = ls())
wd = "~/Documents/code_proj/simp_add_gp/"
setwd(wd)
source("./loading_ModelE3_PPE.R")
inp = inp_a
out = out_a
inp_nm = 
out_nm = 
setwd(wd)
######################
wd = "~/Documents/code_proj/simp_add_gp/"
setwd(wd)
#source("~/Documents/code_proj/simp_add_gp/data_load_reg.R")
fun_names = list.files("./functions/" ,full.names = TRUE)
## Add a line that excludes the pre_processing
apply(X = matrix(fun_names, ncol = 1), MARGIN = 1, FUN = source)
#################################################################################


y_ind = 1
########################
l1_info = seq_gaus_1d_a(x = inp_trn, y = out_trn[,y_ind], range = 0.6, nugget = 4, iteration = round(n_par * 0.8))
l2_info = seq_gaus_2d(x = inp_trn, y = l1_info[[2]], range = c(0.5, 0.5), nugget = 4, top_n = 20)
l2_calc = apply_emu(x = inp_trn, y = l1_info[[2]], meta_data = l2_info[[1]])
#########################
l3_info = seq_gaus_3d(x = inp_trn, y = l2_calc[[2]], range = c(0.4, 0.4, 0.4), nugget = 4, top_n = 20)

comb_meta = rbind(l1_info[[1]], 
                  as.matrix(l2_info[[1]]),
                  as.matrix(l3_info[[1]]))
#########

val_pred = apply_emu_val(inp_trn, out_trn[,y_ind], meta_data = comb_meta, xtst = inp_val)
select_ind = plot_val(pred_adding = val_pred, ytrue = out_val[,y_ind], comb_meta, 
                            title = "Validation", threshold = 0.002)


comb_meta_update = comb_meta[select_ind,]
####################################
#comb_meta_update = comb_meta[c(1:20),]
################################
tst_pred_short = apply_emu_val(inp_trn_val, out_trn_val[,y_ind], meta_data = comb_meta_update, xtst = inp_tst)
tst_pred_tst   = apply_emu_val(inp_trn_val, out_trn_val[,y_ind], meta_data = comb_meta, xtst = inp_tst)

plot_res(pred_adding = tst_pred_short, ytrue = out_tst[,y_ind], comb_meta = comb_meta_update, title = "Based on optimized parameters and groups")
plot_res(pred_adding = tst_pred_tst, ytrue = out_tst[,y_ind], comb_meta = comb_meta, title = "Based on all parameters and groups")


plot(out_tst[,y_ind], tst_pred_short[[1]], col = "seagreen", pch = 16, cex = 0.7,
     xlab = "Climate model output", ylab = "Emulator output")
points(out_tst[,y_ind], tst_pred_tst[[1]], col = "black", pch = 16, cex = 0.5)
abline(a = 0, b = 1)
legend("topleft", # Position of the legend
       legend=c("Optimized", "All parameters and groups"), # Labels
       col=c("seagreen", "black"), # Colors
       pch=c(16, 16)) # Point types
################################

