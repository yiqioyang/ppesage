seq_gaus_2d <- function(x = x, y = y,  select_pairs){
  ncol = ncol(x)
  res_y = y
  
  temp_res = c()
  
  par(mfrow = c(4,4))
  
  iteration = nrow(select_pairs)
  
  for(i in 1:iteration){
    res_y = auto_gaus(x[,select_pairs[i,1:2]], y = res_y, 
                            range = select_pairs[i,4:5], nugget = select_pairs[i,7])[[1]]$r
    print(sd(res_y))
  }
  
  return(res_y)
}