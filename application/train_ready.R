source("~/Documents/code_proj/simp_add_gp/lib_load_colors.R")
source("~/Documents/code_proj/simp_add_gp/data_load_cam_bylat.R")
library(parallel)
fun_names = list.files("~/Documents/code_proj/simp_add_gp/functions/" ,full.names = TRUE)
apply(X = matrix(fun_names, ncol = 1), MARGIN = 1, FUN = source)

ind_set = read.table("~/Documents/manu/add_gp_cam_new/sample_index.csv", sep = ",", header=TRUE)
ind_set[ind_set == 261] = 1
ind_set[ind_set == 262] = 2
##########
y_lat = ncvar_get(nc_data, 'SW_CRE') #########***
lats = ncvar_get(nc_data, "lat")
y_lat_ave = y_lat[,c(-1,-2)]
y_ave = apply(y_lat_ave[43:47,], MARGIN = 2, FUN = mean)
######


n_inp = ncol(inp)

df = cbind(to_hypercube(inp), y = to_gau01(y_ave))
# 39 and 140
df = df[c(-39, -140),]
n_trn = 211
n_ensemble = nrow(df)

########################
trn_ind = sample(1:n_ensemble, n_trn)
#trn_ind = ind_set[,1]
  
trn_ind_trn = sample(trn_ind, round(0.8 * n_trn))
trn_ind_val = trn_ind[!trn_ind %in% trn_ind_trn]

dftrn = df[trn_ind_trn,]
dftrn_val = df[trn_ind_val,]

dftrn_comb = rbind(dftrn, dftrn_val)

dftst = df[-trn_ind,]

########################
l1_meta = seq_gaus_1d_a(x = dftrn[,1:n_inp], y = dftrn$y, range = 0.6, nugget = 4, iteration = 10)
#########################
l2_meta = seq_gaus_2d(x = dftrn[,1:n_inp], y = l1_meta[[2]], range = c(0.5, 0.5), nugget = 4, var_nm = para_nm, top_n = 20)[[1]]
l2_calc = apply_emu(x = dftrn[,1:n_inp], y = l1_meta[[2]], meta_data = l2_meta)
#########################
#l3_meta = seq_gaus_3d(x = dftrn[,1:n_inp], y = l2_calc[[2]], range = c(0.4, 0.4, 0.4), nugget = 4, var_nm = para_nm, top_n = 20)[[1]]

comb_meta = rbind(l1_meta[[1]], 
                  as.matrix(l2_meta))
#########
y_trn_val = apply_emu_val(dftrn[,1:n_inp], dftrn$y, meta_data = comb_meta, xtst = dftrn_val[,1:45])
plot(apply(dftrn_val$y - y_trn_val[[3]], MARGIN = 2, sd)/sd(dftrn_val$y), 
     ylim = c(0, 1), xlab = "No of iteration", ylab = "Sd at each iteration", pch = 16, cex = 0.8)
abline(v = (1:(nrow(comb_meta)/5))*5 , col = "gray", lty = 2)
abline(v = (1:(nrow(comb_meta)/10))*10 , col = "gray")

comb_meta_update = comb_meta[c(1:10, 11:30),]
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


################################
1 - sum((y_pred_update[[1]] - dftst$y)^2) / sum((dftst$y - mean(dftst$y))^2)



#####################################################################################
for(i in 1:11){
trn_ind = ind_set[,i]
trn_ind_trn = sample(trn_ind, round(0.8 * n_trn))
trn_ind_val = trn_ind[!trn_ind %in% trn_ind_trn]
dftrn = df[trn_ind_trn,]
dftrn_val = df[trn_ind_val,]
dftrn_comb = rbind(dftrn, dftrn_val)
dftst = df[-trn_ind,]



y_pred_origin = apply_emu_val(dftrn_comb[,1:n_inp], dftrn_comb$y, meta_data = comb_meta, xtst = dftst[,1:n_inp])
y_pred_update = apply_emu_val(dftrn_comb[,1:n_inp], dftrn_comb$y, meta_data = comb_meta_update, xtst = dftst[,1:n_inp])

################################
#plot(apply(dftrn_val$y - y_trn_val[[3]], MARGIN = 2, sd)/sd(dftrn_val$y), 
#     ylim = c(0, 1), xlab = "No of iteration", ylab = "Sd at each iteration", pch = 16, cex = 0.8)
points(apply(dftst$y - y_pred_origin[[3]], MARGIN = 2, sd)/sd(dftst$y), col = "seagreen", pch = 16, cex = 0.8) 
lines(apply(dftst$y - y_pred_update[[3]], MARGIN = 2, sd)/sd(dftst$y), col = "indianred2")


points(apply(dftst$y - y_pred_update[[3]], MARGIN = 2, sd)/sd(dftst$y), col = "indianred2", pch = 17)
abline(v = (1:(nrow(comb_meta)/5))*5 , col = "gray", lty = 2)
abline(v = (1:(nrow(comb_meta)/10))*10 , col = "gray")
abline(h = (1:20)*0.05 , col = "gray", lty = 2)
abline(h = (1:10)*0.1, col = "gray")


sd(y_pred_origin[[1]] - dftst$y)/sd(dftst$y)
print(c(sd(y_pred_update[[1]] - dftst$y)/sd(dftst$y),1 - sum((y_pred_update[[1]] - dftst$y)^2) / sum((dftst$y - mean(dftst$y))^2)))
################################
}









