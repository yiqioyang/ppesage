range_comp_1d <- function(x = x, y = y,  ranges, nugget, var_nm){
  xdim = ncol(x)
  no_r = length(ranges)
  
  res_mat = matrix(nrow = xdim, ncol = no_r)
  
  for(i in 1:no_r){
    for(j in 1:xdim){
      t_res = auto_gaus(x = x[,j], y = y, nugget = nugget, range = ranges[i])
      res_mat[j, i] = sd(t_res[[1]]$r)
    }
  }
  
  res_mat = data.frame(res_mat)
  res_mat$name = factor(var_nm, levels = var_nm)
  fig1 = ggplot() + 
    geom_point(data = res_mat, aes(x = name, y = X1 - X2)) + 
    theme(axis.text.x = element_text(angle = -40, vjust = 0, hjust=0))
  print(fig1)
  return()
}
