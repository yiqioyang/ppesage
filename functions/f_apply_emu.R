apply_emu <- function(x, y, meta_data){
  
  var_mat = meta_data[,1:3]
  range = meta_data[,4:6]
  nugget = meta_data[,7]
  
  pred_step = matrix(ncol = nrow(var_mat), nrow = length(y))
  
  for(i in 1:nrow(var_mat)){
    
    var_ind = var_mat[i,][!is.na(var_mat[i,])]
    range_in = range[i,][!is.na(range[i,])]
    
    if(i == 1){
      gaus_output = auto_gaus(x[,var_ind], y, nugget = nugget[i], range = range_in)
      next_y = gaus_output$r
      pred_step[,i] = gaus_output$p
    }else{
      gaus_output = auto_gaus(x[,var_ind], next_y, nugget = nugget[i], range = range_in)
      next_y = gaus_output$r
      pred_step[,i] = gaus_output$p
    }
  }
  
  output = list()
  output[[1]] = rowSums(pred_step)
  output[[2]] = next_y
  output[[3]] = pred_step
  
  return(output)
}


apply_emu_val <- function(x, y, meta_data, xtst){
  
  var_mat = meta_data[,1:3]
  range = meta_data[,4:6]
  nugget = meta_data[,7]
  
  pred_step = matrix(ncol = nrow(var_mat), nrow = nrow(xtst))
  
  for(i in 1:nrow(var_mat)){
    
    var_ind = var_mat[i,][!is.na(var_mat[i,])]
    range_in = range[i,][!is.na(range[i,])]
    
    if(i == 1){
      temp_rgasp_model = rgasp(design = cbind(x[,var_ind]), response = y, nugget = nugget[i], range.par = range_in)
      
      temp_pred_trn = predict(temp_rgasp_model, cbind(x[,var_ind]))$mean
      temp_pred_val = predict(temp_rgasp_model, cbind(xtst[,var_ind]))$mean
      
      pred_step[,i] = temp_pred_val
      next_y = y - temp_pred_trn
    }else{
      temp_rgasp_model = rgasp(design = cbind(x[,var_ind]), response = next_y, nugget = nugget[i], range.par = range_in)
      
      temp_pred_trn = predict(temp_rgasp_model, cbind(x[,var_ind]))$mean
      temp_pred_val = predict(temp_rgasp_model, cbind(xtst[,var_ind]))$mean
      
      pred_step[,i] = temp_pred_val
      next_y = next_y - temp_pred_trn
    }
  }
  
  output = list()
  output[[1]] = rowSums(pred_step)
  output[[2]] = pred_step
  output[[3]] = t(apply(pred_step, MARGIN = 1, cumsum))
  return(output)
}


apply_trn <- function(x, y, meta_data){
  
  var_mat = meta_data[,1:3]
  range = meta_data[,4:6]
  nugget = meta_data[,7]
  
  trained_emu = list()
  
  for(i in 1:nrow(meta_data)){
    var_ind = var_mat[i,][!is.na(var_mat[i,])]
    range_in = range[i,][!is.na(range[i,])]
    x_inp = x[,var_ind]
    if(i == 1){
      gaus_output = auto_gaus(x_inp, y, nugget = nugget[i], range = range_in)
      trained_emu[[i]] = rgasp(design = cbind(x_inp), response = y, nugget = nugget[i], range.par = range_in)
      next_y = gaus_output$r
    }else{
      gaus_output = auto_gaus(x_inp, next_y, nugget = nugget[i], range = range_in)
      trained_emu[[i]] = rgasp(design = cbind(x_inp), response = next_y, nugget = nugget[i], range.par = range_in)
      next_y = gaus_output$r
    }
  }
  return(trained_emu)
}


apply_pred <- function(emus, x_pred, meta_data){
  n_emu = length(emus)
  var_mat = meta_data[,1:3]
  
  pred = matrix(ncol = nrow(meta_data), nrow =  nrow(x_pred))
  
  for(i in 1:n_emu){
    var_ind = var_mat[i,][!is.na(var_mat[i,])]
    x_inp = cbind(x_pred[,var_ind])
    pred[,i] = predict(emus[[i]], x_inp)$mean
  }
  
  return(rowSums(pred))
}




