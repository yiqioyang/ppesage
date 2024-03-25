
#x = dftrn[,1:15]
#y = dftrn$y
#range3d = c(0.4, 0.4, 0.4)
#nugget = 4
#var_nm = inp_nm[1:15]

gaus_3d <- function(x, y, range3d, nugget, var_nm, n_sel){
  
  x_dim = ncol(x)
  
  auto_cor_mat = data.frame(matrix(nrow = (x_dim-1) * (x_dim-2) * (x_dim-3)/6, ncol = 4))
  single_var_sd = c()
  
  for(i in 1:x_dim){
    one_var_res = auto_gaus(x[,i], y = y, nugget = nugget, range = range3d[1])[[1]]$r
    single_var_sd[i] = sd(one_var_res)
  }
  
  row_num = 1
  #################### 2D
  for(i in 1:(x_dim - 2)){
    print(i)
    for(j in (i+1):(x_dim-1)){
      print(j)
      for(k in (j+1):x_dim){
        t_m_gau = rgasp(design = x[,c(i, j, k)], response = y, range.par = range3d, nugget = nugget)
      
        t_p = predict(t_m_gau, x[,c(i,j, k)])$mean
        t_r = y - t_p
      
        auto_cor_mat[row_num,1] = var_nm[i]
        auto_cor_mat[row_num,2] = var_nm[j]
        auto_cor_mat[row_num,3] = var_nm[k]
        
        auto_cor_mat[row_num,4] = (sd(y) - sd(t_r)) - (sd(y) * 3 - single_var_sd[i] - single_var_sd[j] - single_var_sd[k])
        row_num = row_num + 1
      }
      print(j)
      print(row_num)
    }
  }
  
  
  auto_cor_mat[,1] = match(auto_cor_mat[,1], var_nm)
  auto_cor_mat[,2] = match(auto_cor_mat[,2], var_nm)
  auto_cor_mat[,3] = match(auto_cor_mat[,3], var_nm)
  
  auto_cor_mat_order = auto_cor_mat[order(auto_cor_mat[,4], decreasing = TRUE),]
  print(auto_cor_mat_order[1:n_sel, 4])
  
  auto_cor_mat_order = auto_cor_mat_order[1:n_sel, 1:3]
  
  
  auto_cor_mat_order  = cbind(auto_cor_mat_order, rep(range3d[1], n_sel), rep(range3d[1], n_sel), rep(range3d[1], n_sel),
                              rep(nugget, n_sel))
  auto_cor_mat_order = as.matrix(auto_cor_mat_order)
  colnames(auto_cor_mat_order) = NULL
  return(list(auto_cor_mat, auto_cor_mat_order))
}


