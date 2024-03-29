source("~/Documents/code_proj/simp_add_gp/lib_load_colors.R")
source("~/Documents/code_proj/simp_add_gp/data_load_reg.R")
library(parallel)
fun_names = list.files("~/Documents/code_proj/simp_add_gp/functions/" ,full.names = TRUE)
apply(X = matrix(fun_names, ncol = 1), MARGIN = 1, FUN = source)

###########
out_ind = 1
inp = to_hypercube(rbind(inp_a, inp_b))
out = rbind(out_a, out_b)
df = cbind(inp, y = to_gau01(out[, out_ind]))
df = df[1:751,]
n_inp = ncol(inp)

n_ensemble = nrow(df)
n_out = ncol(out)

n_trn = 200
########################
trn_ind = sample(1:n_ensemble, n_trn)
#trn_ind = c(1:451, 552:(551+80), 652:(651+80))
#trn_ind = 1:500
trn_ind_trn = sample(trn_ind, round(0.8 * n_trn))
trn_ind_val = trn_ind[!trn_ind %in% trn_ind_trn]

dftrn = df[trn_ind_trn,]
dftrn_val = df[trn_ind_val,]

dftrn_comb = rbind(dftrn, dftrn_val)

dftst = df[-trn_ind,]
########################
meta_load = read.table("~/Documents/manu/add_gp_giss_new/meta/meta_611/meta_01.csv", sep = ",")


y_pred_update = apply_emu_val(dftrn_comb[,1:n_inp], dftrn_comb$y, meta_data = meta_load, xtst = dftst[,1:n_inp])
################################
plot(apply(dftst$y - y_pred_update[[3]], MARGIN = 2, sd)/sd(dftst$y), 
     ylim = c(0, 1), xlab = "No of iteration", ylab = "Sd at each iteration", 
     pch = 16, cex = 0.8, col = "indianred2")

abline(v = (1:(nrow(comb_meta)/5))*5 , col = "gray", lty = 2)
abline(v = (1:(nrow(comb_meta)/10))*10 , col = "gray")

#sd(y_pred_origin[[1]] - dftst$y)/sd(dftst$y)
sd(y_pred_update[[1]] - dftst$y)/sd(dftst$y)

