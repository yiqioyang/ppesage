auto_gaus <- function(x, y, nugget, range){
  ### Location:  r_code/function_carry/
  ### Purpose:   implement gaussian process
  if(length(x) == length(y)){x = matrix(x, ncol = 1)}
  

  gaus_model_temp = rgasp(design = x, response = y, nugget = nugget, range.par = range)
  gaus_pred = predict(gaus_model_temp, x)$mean
  gaus_res = y - gaus_pred
  
  output = data.frame(cbind(p = gaus_pred, r = gaus_res))
  return(output)
}


auto_gaus_sel_ind <- function(x_mat, y, nugget, range, sel_ind){
  ### Location:  r_code/function_carry/
  ### Purpose:   implement gaussian process
  x_mat = x_mat[,sel_ind]
  if(length(sel_ind) == 1){x_mat = matrix(x_mat, ncol = 1)}
  
  gaus_model_temp = rgasp(design = x_mat, response = y, nugget = nugget, range.par = range)
  gaus_pred = predict(gaus_model_temp, x_mat)$mean
  gaus_res = y - gaus_pred
  
  res_sd = sd(gaus_res)
  return(res_sd)
}

