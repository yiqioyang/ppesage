to_hypercube <- function(inp){
  ndim = ncol(inp)
  for(i in 1:ndim){
    inp[,i] = (inp[,i]-min(inp[,i]))/(max(inp[,i]) - min(inp[,i]))
  }
  return(inp)
}

to_gau01 = function(y){
  y = y - mean(y)
  y = y/sd(y)
  return(y)
}
