rm(list = ls())
wd = "~/Documents/code_proj/simp_add_gp/"
setwd(wd)
#source("~/Documents/code_proj/simp_add_gp/data_load_reg.R")
fun_names = list.files("./functions/" ,full.names = TRUE)
apply(X = matrix(fun_names, ncol = 1), MARGIN = 1, FUN = source)

###########################
source("./loading_ModelE3_PPE.R")
df = cbind(to_hypercube(inp_a), y = to_gau01(out_a[,9]))
##############################
n_ens = nrow(df)
n_col = ncol(df)
n_par = n_col-1
sample_ind = sample(1:n_ens)

trn_count = round(0.8 * 0.8 * n_ens)
val_count = round(0.2 * 0.8 * n_ens)
trn = df[1:trn_count, ]
val = df[(trn_count + 1): (trn_count + 1 + val_count), ]
tst = df[((trn_count + 1 + val_count + 1):n_ens), ]
trn_val = rbind(trn, val)
########################


########################
l1_info = seq_gaus_1d_a(x = trn[,-n_col], y = trn$y, range = 0.6, nugget = 4, iteration = 22)
#########################
l2_info = seq_gaus_2d(x = trn[,-n_col], y = l1_info[[2]], range = c(0.5, 0.5), nugget = 4, top_n = 20)
l2_calc = apply_emu(x = trn[,-n_col], y = l1_info[[2]], meta_data = l2_info[[1]])
#########################
l3_info = seq_gaus_3d(x = trn[,-n_col], y = l2_calc[[2]], range = c(0.4, 0.4, 0.4), nugget = 4, top_n = 20)

comb_meta = rbind(l1_info[[1]], 
                  as.matrix(l2_info[[1]]),
                  as.matrix(l3_info[[1]]))
#########
par(mfrow = c(1,2))
val_pred = apply_emu_val(trn[,-n_col], trn$y, meta_data = comb_meta, xtst = val[,-n_col])
plot_val(pred_adding = val_pred, ytrue = val$y)

comb_meta_update = comb_meta[c(1:20, 23:50 ),]
################################
tst_pred_short = apply_emu_val(trn_val[,-n_col], trn_val$y, meta_data = comb_meta, xtst = tst[,-n_col])
tst_pred_tst = apply_emu_val(trn_val[,-n_col], trn_val$y, meta_data = comb_meta_update, xtst = tst[,-n_col])
plot_tst(val_pred, y_val = val$y, tst_pred_short, tst_pred_tst,ytrue = tst$y)
################################








