
#################################################################################
l1_info = seq_gaus_1d_a(x = inp_trn, y = out_trn[,y_ind], range = range_pre[1], nugget = nugget_pre, iteration = no_single)
l2_info = seq_gaus_2d(x = inp_trn, y = l1_info[[2]], range = c(range_pre[2], range_pre[2]), nugget = nugget_pre, top_n = no_pairs)
l2_calc = apply_emu(x = inp_trn, y = l1_info[[2]], meta_data = l2_info[[1]])
#########################
if(groupthree_flag == 0){
  comb_meta = rbind(l1_info[[1]], 
                    as.matrix(l2_info[[1]]))
}else{
  l3_info = seq_gaus_3d(x = inp_trn, y = l2_calc[[2]], range = c(range_pre[3], range_pre[3], range_pre[3]), nugget = nugget_pre, top_n = no_groups)
  comb_meta = rbind(l1_info[[1]], 
                    as.matrix(l2_info[[1]]),
                    as.matrix(l3_info[[1]]))
}
#########