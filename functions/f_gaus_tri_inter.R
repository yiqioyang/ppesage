#x = df[,1:45]
#y = df$y
#range = c(0.5, 0.5)
#nugget = 0.7
#var_nm = inp_nm



gaus_tri_inter <- function(x, y, range, nugget, var_nm, top_n){
  
  x_dim = ncol(x)
  
  auto_cor_mat = matrix(ncol = x_dim, nrow = x_dim)
  colnames(auto_cor_mat) = var_nm
  rownames(auto_cor_mat) = var_nm
  
  auto_cor_mat_ind = auto_cor_mat
  
  single_var_sd = c()
  for(i in 1:x_dim){
    one_var_res = auto_gaus(x[,i], y = y, nugget = nugget, range = range[2])[[1]]$r
    single_var_sd[i] = sd(one_var_res)
  }
  
  
  #################### 2D
  for(i in 1:(x_dim - 1)){
    for(j in (i+1):x_dim){
      t_m_gau = rgasp(design = x[,c(i, j)], response = y, range.par = range, nugget = nugget)
      
      t_p = predict(t_m_gau, x[,c(i,j)])$mean
      t_r = y - t_p
      
      auto_cor_mat[i,j] = sd(y) - sd(t_r)
      auto_cor_mat_ind[i,j] = sd(y) * 2 - single_var_sd[i] - single_var_sd[j]
    }
    print(i)
  }
  
  auto_cor_mat = auto_cor_mat - auto_cor_mat_ind
  
  auto_cor_3d = heat_to_3columndf(auto_cor_mat)
  auto_cor_3d = subset(auto_cor_3d, !is.na(val))
  
  gp = ggplot() +
    geom_raster(data = auto_cor_3d,      
                aes(x=input, y=output, fill=val)) +
    geom_point(data = subset(auto_cor_3d, val > quantile(auto_cor_3d$val, 0.97)),      
               aes(x=input, y=output, fill=val), shape = 21, fill = "gold") +
    
    scale_fill_stepsn(colours = (myPallette), 
                      breaks = heat_color_break_values(subset(auto_cor_3d, val <= quantile(auto_cor_3d$val, 1))))+
    gg_theme_correlation + 
    geom_vline(xintercept = var_nm[seq(5,length(var_nm), 5)], linetype = "dashed") +
    geom_hline(yintercept = var_nm[seq(5,length(var_nm), 5)], linetype = "dashed")
  
  auto_cor_3d_order = auto_cor_3d[order(auto_cor_3d[,3], decreasing = TRUE),]
  auto_cor_3d_order_sel = auto_cor_3d_order[1:top_n, ]
  
  auto_cor_3d_order_sel[,1] = as.numeric(auto_cor_3d_order_sel$output)
  auto_cor_3d_order_sel[,2] = as.numeric(auto_cor_3d_order_sel$input)
  
  select_pairs = cbind(auto_cor_3d_order_sel[,1:2], rep(NA, top_n), 
                        rep(range[1], top_n), rep(range[2], top_n), rep(NA, top_n),
                        rep(nugget, top_n))
  colnames(select_pairs) = NULL
  select_pairs = as.matrix(select_pairs)
  
  
  print(gp)
  best_comb = subset(auto_cor_3d, val == max(auto_cor_3d$val))
  best_ind = c(which(var_nm == best_comb$input), which(var_nm == best_comb$output))
  
  
  
  print(best_ind)
  return(list(auto_cor_3d, best_ind, select_pairs))
}



gaus_tri_inter_seq <- function(x, y, range, nugget, var_nm){
  
  x_dim = ncol(x)
  
  auto_cor_mat = matrix(ncol = x_dim, nrow = x_dim)
  colnames(auto_cor_mat) = var_nm
  rownames(auto_cor_mat) = var_nm
  
  auto_cor_mat_ind = auto_cor_mat
  
  
  
  #################### 2D
  for(i in 1:(x_dim - 1)){
    for(j in (i+1):x_dim){
      t_m_gau = rgasp(design = x[,c(i, j)], response = y, range.par = range, nugget = nugget)
      
      t_p = predict(t_m_gau, x[,c(i,j)])$mean
      t_r = y - t_p
      
      auto_cor_mat[i,j] = sd(y) - sd(t_r)
    }
    print(i)
  }
  
  for(i in 1:(x_dim - 1)){
    for(j in (i+1):x_dim){
      t_m_gau_seq_a = auto_gaus(x[,c(i)], y = y,             nugget = nugget, range = range[1])[[1]]$r
      t_m_gau_seq_b = auto_gaus(x[,c(j)], y = t_m_gau_seq_a, nugget = nugget, range = range[1])[[1]]$r  

      auto_cor_mat_ind[i,j] = sd(y) - sd(t_m_gau_seq_b)
    }
    print(i)
  }
  
  
  auto_cor_mat = auto_cor_mat - auto_cor_mat_ind
  
  auto_cor_3d = heat_to_3columndf(auto_cor_mat)
  auto_cor_3d = subset(auto_cor_3d, !is.na(val))
  
  gp = ggplot() +
    geom_raster(data = auto_cor_3d,      
                aes(x=input, y=output, fill=val)) +
    geom_point(data = subset(auto_cor_3d, val > quantile(auto_cor_3d$val, 0.97)),      
               aes(x=input, y=output, fill=val), shape = 21, fill = "gold") +
    
    scale_fill_stepsn(colours = (myPallette), 
                      breaks = heat_color_break_values(subset(auto_cor_3d, val <= quantile(auto_cor_3d$val, 1))))+
    gg_theme_correlation + 
    geom_vline(xintercept = var_nm[seq(5,length(var_nm), 5)], linetype = "dashed") +
    geom_hline(yintercept = var_nm[seq(5,length(var_nm), 5)], linetype = "dashed")
  
  
  print(gp)
  best_comb = subset(auto_cor_3d, val == max(auto_cor_3d$val))
  best_ind = c(which(var_nm == best_comb$input), which(var_nm == best_comb$output))
  
  print(best_ind)
  return(list(auto_cor_3d, best_ind))
}
