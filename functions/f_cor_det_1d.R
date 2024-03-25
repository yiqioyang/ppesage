#x = dftrn[,1:45]
#y = dftrn$y
#y = l0[[2]]
#range = 0.6
#nugget = 0.8

cor_det_1d <- function(x = x, y = y,  range, nugget){
  xdim = ncol(x)
  sd_y = sd(y)
  temp_res = c()
  temp_res_post = c()
  for(j in 1:xdim){
    temp_res[j] = sd(auto_gaus(x[,j], y = y, range = range, nugget = nugget)[[1]]$r)
  }
  sel_ind = which(temp_res == min(temp_res))
  plot(sd_y - temp_res)
  
  res_post = auto_gaus(x[,sel_ind], y = y, range = range, nugget = nugget)[[1]]$r
  
  for(j in 1:xdim){
    temp_res_post[j] = sd(auto_gaus(x[,j], y = res_post, range = range, nugget = nugget)[[1]]$r)
  }
  
  plot(sd_y - temp_res_post)
  
  plot(temp_res[-sel_ind] - temp_res_post[-sel_ind])
}