seq_gaus_1d <- function(x = x, y = y,  range, nugget, iteration){
  ncol = ncol(x)
  pre_y = y
  
  temp_res = c()
  
  sel_ind = c()
  par(mfrow = c(4,4))
  
  for(i in 1:iteration){
    for(j in 1:ncol){
      temp_res[j] = sd(auto_gaus(x[,j], y = pre_y, range = range, nugget = nugget)[[1]]$r)
    }
    temp_ind = which(temp_res == min(temp_res))
    plot(temp_res)
    sel_ind[i] = temp_ind[1]   #xxx
    pre_y = auto_gaus(x[,temp_ind[1]], y = pre_y, range = range, nugget = nugget)[[1]]$r
  }
  output = cbind(sel_ind, rep(NA, length(sel_ind)), rep(NA, length(sel_ind)), 
                 rep(range, length(sel_ind)), rep(NA, length(sel_ind)), rep(NA, length(sel_ind)),
                 rep(nugget, length(sel_ind)))
  
  return(list(output, pre_y))
}

#x = dftrn[,1:45]
#y = dftrn$y
#ranges = c(0.4, 0.4, 0.4)
#nugget = 0.9
#iteration = 2
#sub_iter = 3

seq_gaus_2d <- function(x = x, y = y,  ranges, nugget, iteration, sub_iter){
  xdim = ncol(x)
  y_iter = y
  temp_res = c()
  
  sel_ind = c()
  
  out_meta = matrix(ncol = 7, nrow = 1)

  for(i in 1:iteration){
    for(j in 1:xdim){
      temp_res[j] = sd(auto_gaus(x[,j], y = y_iter, range = ranges[1], nugget = nugget)[[1]]$r)
    }
    temp_ind = which(temp_res == min(temp_res))
    plot(temp_res)
    sel_ind[i] = temp_ind
    
    res_1d = auto_gaus(x[,temp_ind], y = y_iter, range = ranges[1], nugget = nugget)[[1]]$r
    
    print("Checking 2-D")
    for(k in 1:sub_iter){
      temp_res_2d = fixed_compare(x = x, y = y_iter, ind_sel = temp_ind, range2d = ranges[1:2], nugget = nugget)
      if(temp_res_2d[[3]] == "no"){
        out_meta = rbind(out_meta, c(temp_ind, NA, NA, ranges[1], NA, NA, nugget))
        y_iter = res_1d
        break
      }else{
        out_meta = rbind(out_meta, temp_res_2d[[1]])
        y_iter = temp_res_2d[[2]]
      }
    }
  }
  
  out_meta = out_meta[-1,]
  
  return(list(out_meta, y_iter))
}

#par(mfrows = c(3,1))
#comb_meta = seq_gaus_2d(x = dftrn[,1:45], dftrn$y, ranges = c(0.4, 0.4), nugget = 0.9, iteration = 25)[[1]]
#fixed_compare(x = dftrn[,1:45],y = comb_meta, ind_sel = 34, range2d = c(0.4, 0.4), nugget = 0.9)
