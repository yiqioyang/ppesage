determine_para = function(res_decrease_val, threshold = 0.001){
  res_decrease_val = c(1, res_decrease_val)
  sd_diff = -diff(res_decrease_val)
  selected_ind = which(sd_diff > -threshold)
  return(selected_ind)
}
