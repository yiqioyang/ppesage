n_ens = nrow(inp)
#n_col = ncol(df)
n_par = ncol(inp)
n_y = ncol(out)
sample_ind = sample(1:n_ens)
###
inp = to_hypercube(inp)
for(i in 1:n_y){
  out[,i] = to_gau01(out[,i])
}

inp = inp[sample_ind,]
out = out[sample_ind,]

trn_count = round(trn_ratio * n_ens)
val_count = round(val_ratio * n_ens)
###
trn_ind = 1:trn_count
val_ind = (trn_count + 1): (trn_count + 1 + val_count)
tst_ind = ((trn_count + 1 + val_count + 1):n_ens)


inp_trn = inp[trn_ind,]
out_trn = out[trn_ind,]

inp_val = inp[val_ind,]
out_val = out[val_ind,]

inp_tst = inp[tst_ind,]
out_tst = out[tst_ind,]

inp_trn_val = inp[c(trn_ind, val_ind),]
out_trn_val = out[c(trn_ind, val_ind),]



