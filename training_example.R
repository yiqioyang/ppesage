source("~/Documents/code_proj/simp_add_gp/lib_load_colors.R")
source("~/Documents/code_proj/simp_add_gp/data_load_reg.R")
library(parallel)
fun_names = list.files("~/Documents/code_proj/simp_add_gp/functions/" ,full.names = TRUE)
apply(X = matrix(fun_names, ncol = 1), MARGIN = 1, FUN = source)


###########
out_ind = 9
inp = to_hypercube(rbind(inp_a, inp_b))
out = rbind(out_a, out_b)
df = cbind(inp, y = to_gau01(out[, out_ind]))
df = df[1:751,]
n_inp = ncol(inp)

n_ensemble = nrow(df)
n_out = ncol(out)

n_trn = 611
########################
#trn_ind = sample(1:n_ensemble, n_trn)
trn_ind = c(1:451, 552:(551+80), 652:(651+80))
#trn_ind = 1:500
trn_ind_trn = sample(trn_ind, round(0.8 * n_trn))
trn_ind_val = trn_ind[!trn_ind %in% trn_ind_trn]

dftrn = df[trn_ind_trn,]
dftrn_val = df[trn_ind_val,]

dftrn_comb = rbind(dftrn, dftrn_val)

dftst = df[-trn_ind,]

########################
#l1_meta_a = seq_gaus_1d_b(x = dftrn[,1:n_inp], y = dftrn$y, range = 0.6, nugget = 4, iteration = 20)
#l1_calc_a = apply_emu(x = dftrn[,1:n_inp], y = dftrn$y, meta_data = l1_meta_a)
#l1_meta_b = seq_gaus_1d_b(x = dftrn[,1:n_inp], y = l1_calc_a[[2]], range = 0.6, nugget = 4, iteration = 20)
#l1_calc_b = apply_emu(x = dftrn[,1:n_inp], y = l1_calc_a[[2]], meta_data = l1_meta_b)

#Or
l1_meta = seq_gaus_1d_a(x = dftrn[,1:n_inp], y = dftrn$y, range = 0.6, nugget = 2, iteration = 40)

#########################
l2_meta = seq_gaus_2d(x = dftrn[,1:n_inp], y = l1_meta[[2]], range = c(0.5, 0.5), nugget = 2, var_nm = inp_nm, top_n = 40)[[1]]
l2_calc = apply_emu(x = dftrn[,1:n_inp], y = l1_meta[[2]], meta_data = l2_meta)
#########################
l3_meta = seq_gaus_3d(x = dftrn[,1:n_inp], y = l2_calc[[2]], range = c(0.4, 0.4, 0.4), nugget = 2, var_nm = inp_nm, top_n = 40)[[1]]

comb_meta = rbind(l1_meta[[1]], 
                  as.matrix(l2_meta), as.matrix(l3_meta))
#########
y_trn_val = apply_emu_val(dftrn[,1:n_inp], dftrn$y, meta_data = comb_meta, xtst = dftrn_val[,1:45])
plot(apply(dftrn_val$y - y_trn_val[[3]], MARGIN = 2, sd)/sd(dftrn_val$y), 
     ylim = c(0, 1), xlab = "No of iteration", ylab = "Sd at each iteration", pch = 16, cex = 0.8)
abline(v = (1:(nrow(comb_meta)/5))*5 , col = "gray", lty = 2)
abline(v = (1:(nrow(comb_meta)/10))*10 , col = "gray")


comb_meta_update = comb_meta[c(1:25, 41:50, 81:90),]
################################
y_pred_origin = apply_emu_val(dftrn_comb[,1:n_inp], dftrn_comb$y, meta_data = comb_meta, xtst = dftst[,1:n_inp])
y_pred_update = apply_emu_val(dftrn_comb[,1:n_inp], dftrn_comb$y, meta_data = comb_meta_update, xtst = dftst[,1:n_inp])

################################
plot(apply(dftrn_val$y - y_trn_val[[3]], MARGIN = 2, sd)/sd(dftrn_val$y), 
     ylim = c(0, 1), xlab = "No of iteration", ylab = "Sd at each iteration", pch = 16, cex = 0.8)
points(apply(dftst$y - y_pred_origin[[3]], MARGIN = 2, sd)/sd(dftst$y), col = "seagreen", pch = 16, cex = 0.8) 
lines(apply(dftst$y - y_pred_update[[3]], MARGIN = 2, sd)/sd(dftst$y), col = "indianred2")


points(apply(dftst$y - y_pred_update[[3]], MARGIN = 2, sd)/sd(dftst$y), col = "indianred2", pch = 17)
abline(v = (1:(nrow(comb_meta)/5))*5 , col = "gray", lty = 2)
abline(v = (1:(nrow(comb_meta)/10))*10 , col = "gray")

sd(y_pred_origin[[1]] - dftst$y)/sd(dftst$y)
sd(y_pred_update[[1]] - dftst$y)/sd(dftst$y)
################################








plot(apply(dftrn_val$y - y_trn_val[[3]], MARGIN = 2, sd)/sd(dftrn_val$y), 
     ylim = c(0, 1), xlab = "No of iteration", ylab = "Sd at each iteration", pch = 16, cex = 0.8)
abline(v = (1:(nrow(comb_meta)/5))*5 , col = "gray", lty = 2)
abline(v = (1:(nrow(comb_meta)/10))*10 , col = "gray")









