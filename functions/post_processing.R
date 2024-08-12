determine_para = function(res_decrease_val, threshold1 = 0.001, threshold2 = 0.005, n_single){
  res_decrease_val = c(1, res_decrease_val)
  sd_diff = -diff(res_decrease_val)
  
  selected_ind1 = which(sd_diff[1:n_single] > -threshold1)
  selected_ind2 = which(sd_diff[(n_single+1):length(sd_diff)] > -threshold2) + n_single
  return(c(selected_ind1, selected_ind2))
}
