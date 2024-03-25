gaus_3d <- function(x, y, inds,range, nugget){
  
  xdim = ncol(x)
  sd_3d = c()
  
  m_2d = rgasp(design = x[,inds], response = y, range.par = range[1:2], nugget = nugget)
  p_2d = predict(m_2d, x[,inds])$mean
  r_2d = y - p_2d
  sd_2d = sd(r_2d)
  #################### 2D
  for(i in 1:xdim){
    t_m_gau = auto_gaus(x = x[,c(inds, i)], y = y, range = range, nugget = nugget)
    sd_3d[i] = sd(t_m_gau[[1]]$r)
  }
    

  plot(sd_3d)
  print(sd_2d)
}

#gaus_3d(x = aa[,1:45], y = l0[[2]], inds = c(34, 43), range = c(0.4, 0.4, 0.4), nugget = 0.9)
