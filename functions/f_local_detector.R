local_detect_no_fit <- function(x, y, yres){
  x_dim = ncol(x)
  check = matrix(ncol = 8, nrow = x_dim)
  
  
  dftrn = cbind(x, y, yres)
  
  for(i in 1:x_dim){
    
    intervals = ((max(dftrn[,i]) - min(dftrn[,i]))/10 * (0:10)) + min(dftrn[,i])
    
    for(j in 1:8){
      df_temp = dftrn[dftrn[,i] >= intervals[j] & dftrn[,i] < intervals[j+3], ]
      check[i,j] =  sd(df_temp$yres)  ## xxxx
    }
  } 
  
  check_diff =   check ## xxxx
  check_min = min(check_diff[!is.na(check_diff)])
  check_max = max(check_diff[!is.na(check_diff)])
  
  
  par(mfrow = c(5,5), mai = c(0.55, 0.55, 0.1, 0.1))
  for(i in 1:x_dim){
    intervals = ((max(dftrn[,i]) - min(dftrn[,i]))/10 * (0:10)) + min(dftrn[,i])
    plot(intervals[1:8],check_diff[i,], ylim = c(check_min, check_max), xlab = inp_nm[i], ylab = "residual")
  }
  return(check)
}


