auto_gaus <- function(x, y, nugget, range){
  ### Location:  r_code/function_carry/
  ### Purpose:   implement gaussian process
  if(length(x) == length(y)){x = matrix(x, ncol = 1)}
  

  gaus_model_temp = rgasp(design = x, response = y, nugget = nugget, range.par = range)
  gaus_pred = predict(gaus_model_temp, x)$mean
  gaus_res = y - gaus_pred
  
  output = data.frame(cbind(p = gaus_pred, r = gaus_res))
  return(list(output, gaus_model_temp))
}
