#x = dftrn[,1:n_inp]
#y = dftrn$y 
#range = 0.6
#nugget = 4
#iteration = 10

#detectCores()

seq_gaus_1d_a <- function(x = x, y = y,  range, nugget, iteration, var_nm = colnames(x)){
  ncol_x = ncol(x)
  pre_y = y
  temp_res = c()
  sel_ind = c()
  par(mfrow = c(2,2))
  
  for(i in 1:iteration){
    
    temp_res = apply(data.frame(dims = 1:ncol_x), MARGIN = 1, FUN = auto_gaus_sel_ind, y = pre_y, range = range, nugget = nugget, x = x)
    temp_ind = which(temp_res == min(temp_res))[1]
    
    if(i == 1 | i %% 10 == 1 ){
      initial_res = temp_res
    }
    
    print(var_nm[temp_ind])
    if(i == 1 | i %% 10 == 1 ){
      plot(initial_res, ylim = c(0,1.1), xlab = "Para No", ylab = "Res at each iteration")
      abline(v = temp_ind, col = "black", lty = 2)
    }else{
     lines(temp_res, col = i) 
      abline(v = temp_ind, col = i, lty = 2)
    }
    sel_ind[i] = temp_ind   #xxx
    temp_pred_obj = rgasp(design = x[,temp_ind], response = pre_y, nugget = nugget, range.par = range)
    pre_y = pre_y - predict(temp_pred_obj, cbind(x[,temp_ind]))$mean 
  }
  output = cbind(sel_ind, rep(NA, length(sel_ind)), rep(NA, length(sel_ind)), 
                 rep(range, length(sel_ind)), rep(NA, length(sel_ind)), rep(NA, length(sel_ind)),
                 rep(nugget, length(sel_ind)))
  colnames(output) = NULL
  return(list(output, pre_y))
}


seq_gaus_1d_b <- function(x = x, y = y,  range, nugget, iteration){
  ncol_x = ncol(x)
  pre_y = y
  temp_res = c()
  sel_ind = c()
    
  temp_res = apply(data.frame(dims = 1:ncol_x), MARGIN = 1, FUN = auto_gaus_sel_ind, y = pre_y, range = range, nugget = nugget, x = x)
  sorted_indices = order(temp_res)[1:iteration]
  
  plot(temp_res, ylim = c(min(temp_res)-0.15, 1))
  abline(a = temp_res[sorted_indices[iteration]], b = 0)
  
  output = cbind(sorted_indices, rep(NA, iteration), rep(NA, iteration), 
                rep(range, iteration), rep(NA, iteration), rep(NA, iteration),
                rep(nugget, iteration))
  colnames(output) = NULL
  return(output)
}

