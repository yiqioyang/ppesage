tst_pred_optimized = apply_emu_val(inp_trn_val, out_trn_val[,y_ind], meta_data = comb_meta_update, xtst = inp_tst)
tst_pred_all   = apply_emu_val(inp_trn_val, out_trn_val[,y_ind], meta_data = comb_meta, xtst = inp_tst)

sd_diff_all = plot_res(pred_adding = tst_pred_all, ytrue = out_tst[,y_ind], comb_meta = comb_meta, title = "Based on all parameters and groups")
dev.copy(png, filename = "sd_reduce_all_parameters.png", width = 600, height = 500)
dev.off()

sd_diff_optimized = plot_res(pred_adding = tst_pred_optimized, ytrue = out_tst[,y_ind], comb_meta = comb_meta_update, title = "Based on optimized parameters and groups")
dev.copy(png, filename = file.path(case_var_dir,"sd_reduce_updated_parameters.png"), 
         width = 600, height = 500)
dev.off()


plot(out_tst[,y_ind], tst_pred_optimized[[1]], col = "navy", pch = 16, cex = 0.7,
     xlab = "Climate model output", ylab = "Emulator output", main = out_nm[y_ind])
points(out_tst[,y_ind], tst_pred_all[[1]], col = "red", pch = 16, cex = 0.5)
abline(a = 0, b = 1)
legend("topleft", # Position of the legend
       legend=c("Optimized", "All parameters and groups"), # Labels
       col=c("navy", "red"), # Colors
       pch=c(16, 16)) # Point types

dev.copy(png, filename = file.path(case_var_dir,"emu_comp.png"), width = 400, height = 400)
dev.off()