
val_pred = apply_emu_val(inp_trn, out_trn[,y_ind], meta_data = comb_meta, xtst = inp_val)
select_ind = plot_val(pred_adding = val_pred, ytrue = out_val[,y_ind], comb_meta, 
                      title = "Selecting parameters", threshold1 = threshold1_pre, threshold2 = threshold2_pre)

dev.copy(png, filename = file.path("./cases", case_dir,"emu_selec_para.png"), width = 600, height = 500)
dev.off()

comb_meta_update = comb_meta[select_ind,]