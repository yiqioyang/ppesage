fixed_compare <- function(x, y, ind_sel, range2d, nugget){
  
  x_dim = ncol(x)
  ind_out = matrix(nrow = 1, ncol = 7)
  
  joint_res = c()
  single_res = c()
  res = c()
  
  fixed_res = auto_gaus(x[,ind_sel], y = y, nugget = nugget, range = range2d[1])[[1]]$r
  
  for(i in 1:x_dim){
    single_res[i] = sd(auto_gaus(x[,i], y = fixed_res, nugget = nugget, range = range2d[1])[[1]]$r)
    joint_res[i] = sd(auto_gaus(x[,c(ind_sel, i)], y, nugget = nugget, range = range2d)[[1]]$r)
  }
    
  res = sd(y) - joint_res - (sd(y) - single_res)

  plot(x = 1:ncol(x), y = res, col = "red", ylim = c(0, max(res)))
  abline(v = seq(5, x_dim, 5),h = c(0.005, 0.01))
    
      
  max_k_ind = which(res == max(res))
  #print(res)
  if(max(res) > 0.01){
    print("update")
    output = auto_gaus(x[,c(ind_sel, max_k_ind)], y = y, nugget, range = range2d)[[1]]$r
    ind_out[1,1:2] = c(ind_sel, max_k_ind)
    ind_out[1,3:7] = c(NA, range2d[1], range2d[2], NA, nugget)
    y_or_n = "yes"
  }else{
    print("Stay!")
    output = y
    ind_out[1,] = rep(NA, 7)
    y_or_n = "no"
  }
  
  print(ind_out)
  return(list(ind_out,output,y_or_n))
}


fixed_compare_3d <- function(x, y, ind_sels, range3d, nugget){
  
  x_dim = ncol(x)
  ind_out = matrix(nrow = 1, ncol = 7)
  
  joint_res_2d_a = c()
  joint_res_2d_b = c()
  
  joint_res_3d = c()
  single_res = c()
  
  diff_res1 = c()
  diff_res2 = c()
  
  res_fixed = auto_gaus(x[,ind_sels], y = y, nugget = nugget, range = range3d[1:2])[[1]]$r
  
  for(i in 1:x_dim){
    single_res[i] = sd(auto_gaus(x[,i], y = res_fixed, nugget = nugget, range = range3d[1])[[1]]$r)
    joint_res_3d[i] = sd(auto_gaus(x[,c(ind_sels, i)], y, nugget = nugget, range = range3d)[[1]]$r)
  }
  
  diff_res1 = sd(y) - joint_res_3d - (sd(y) - single_res)
  
  par(mfrow = c(1,1))
  plot(x = 1:ncol(x), y = diff_res1, col = "navy")
  abline(v = seq(5, x_dim, 5))
  
  
  max_k_ind = which(diff_res1 == max(diff_res1))
  print(max_k_ind)
  if(max(diff_res1) > 0.01){
    print("update")
    output = auto_gaus(x[,c(ind_sels, max_k_ind)], y = y, nugget, range = range3d)[[1]]$r
    ind_out[1,1:3] = c(ind_sels, max_k_ind)
    ind_out[1,4:7] = c(range3d, nugget)
    y_or_n = "yes"
  }else{
    print("Stay!")
    output = y
    ind_out[1,] = rep(NA, 7)
    y_or_n = "no"
  }
  
  #print(ind_out)
  return(list(ind_out,output,y_or_n))
}
