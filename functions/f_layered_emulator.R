layer_emulator <- function(x, x_ind, y, layer_no, range, nugget){
  output = matrix(nrow = layer_no, ncol = 2)
  gau_res = y
  
  for(i in 1:layer_no){
    output[i,1:2] = gaus_2d_tri_res_comp(x, x_ind, gau_res, range = range, nugget = nugget)[[2]]
    gau_res       = auto_gaus(x[,output[i,1:2]], y = gau_res, nugget = nugget, range = range)[[1]]$r
  }
  return_out = list(output, gau_res)
  return(return_out)
}

layer_emulator_inter <- function(x, x_ind, y, layer_no, range, nugget){
  output = matrix(nrow = layer_no, ncol = 2)
  gau_res = y
  
  for(i in 1:layer_no){
    output[i,1:2] = gaus_2d_tri_inter(x, x_ind, gau_res, range = range, nugget = nugget)[[2]]
    gau_res = auto_gaus(x[,output[i,1:2]], y = gau_res, nugget = nugget, range = range)[[1]]$r
  }
  return_out = list(output, gau_res)
  return(return_out)
}



apply_emu <- function(x, y, meta_data, xtst){
  
  var_mat = meta_data[,1:3]
  range = meta_data[,4:6]
  nugget = meta_data[,7]
  
  output = matrix(ncol = nrow(var_mat), nrow = length(y))
  m_list = list()
  
  pred_layer = matrix(ncol = nrow(var_mat), nrow = nrow(xtst))
  
  for(i in 1:nrow(var_mat)){
    
    var_ind = var_mat[i,][!is.na(var_mat[i,])]
    range_in = range[i,][!is.na(range[i,])]
    
    if(i == 1){
      gaus_output = auto_gaus(x[,var_ind], y, nugget = nugget[i], range = range_in)
      output[,i] = gaus_output[[1]]$r
      m_list[[i]] = gaus_output[[2]]
    }else{
      gaus_output = auto_gaus(x[,var_ind], output[,i-1], nugget = nugget[i], range = range_in)
      output[,i] = gaus_output[[1]]$r
      m_list[[i]] = gaus_output[[2]]
    }
  }
  
  ypred = rep(0, nrow(xtst))
  
  for(i in 1:nrow(var_mat)){
    
    var_ind = var_mat[i,][!is.na(var_mat[i,])]
    
    if(length(var_ind)==1){
      pred_layer[,i] = predict(m_list[[i]], matrix(xtst[,var_ind], ncol = 1))$mean
      ypred = ypred + pred_layer[,i]
    }else{
      pred_layer[,i] = predict(m_list[[i]], xtst[,var_ind])$mean
      ypred = ypred + pred_layer[,i]
    }
  }
  
  output_r = list()
  output_r[[1]] = ypred
  output_r[[2]] = pred_layer
  return(output_r)
}







