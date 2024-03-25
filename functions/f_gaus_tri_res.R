

gaus_tri_res <- function(x, y, range, nugget, var_nm){
  ### Location:  r_code/function_carry/
  ### Purpose:   do gaussian process pairwise and compare the sum of squared residuals
  
  x_dim = ncol(x)
  
  auto_cor_mat = matrix(ncol = x_dim, nrow = x_dim)
  colnames(auto_cor_mat) = var_nm
  rownames(auto_cor_mat) = var_nm
  

  #################### 2D
  for(i in 1:(x_dim - 1)){
    for(j in (i + 1):x_dim){
      t_m_gau = rgasp(design = x[,c(i, j)], response = y, range.par = range, nugget = nugget)
      
      t_p = predict(t_m_gau, x[,c(i,j)])$mean
      t_r = y - t_p
      
      auto_cor_mat[i,j] = sd(t_r)
    }
    print(i)
  }
  
  
  #sub3_res = heat_to_3columndf(auto_cor_mat)
  auto_cor_3d = heat_to_3columndf(auto_cor_mat)
  auto_cor_3d = subset(auto_cor_3d, !is.na(val))
  
  
  gp = ggplot() +
    geom_raster(data = auto_cor_3d,      
                aes(x=input, y=output, fill=val)) +
    geom_point(data = subset(auto_cor_3d, val < quantile(auto_cor_3d$val, 0.01)),      
               aes(x=input, y=output, fill=val), shape = 21, fill = "gold") +
    
    scale_fill_stepsn(colours = (myPallette), 
                      breaks = heat_color_break_values(subset(auto_cor_3d, val <= quantile(auto_cor_3d$val, 1))))+
    gg_theme_correlation + 
    geom_vline(xintercept = var_nm[seq(5,length(var_nm), 5)], linetype = "dashed") +
    geom_hline(yintercept = var_nm[seq(5,length(var_nm), 5)], linetype = "dashed")
    
  
  print(gp)
  
  best_comb = subset(auto_cor_3d, val == min(auto_cor_3d$val))
  best_ind = c(which(var_nm == best_comb$input), which(var_nm == best_comb$output))
  
  print(best_ind)
  return(list(auto_cor_3d, best_ind))
}


