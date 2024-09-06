
trained_emu = apply_trn(x = inp, y = out[,y_ind], comb_meta_update)
#pred = apply_pred(trained_emu, x_pred = inp_tst, comb_meta_update) 

#hist(pred - out_tst[,y_ind], breaks = 15)
saveRDS(trained_emu, file = file.path(case_var_dir, "emus.R"), ascii = FALSE, version = NULL,
        compress = TRUE, refhook = NULL)

write.table(sd_diff_all, file = file.path(case_var_dir,"sd_reduce_all.csv"), col.names = TRUE, row.names = FALSE, sep = ",")
write.table(sd_diff_optimized, file = file.path(case_var_dir,"sd_reduce_optimized.csv"), col.names = TRUE, row.names = FALSE, sep = ",")

