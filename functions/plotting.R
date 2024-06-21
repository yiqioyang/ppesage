plot_val <- function(pred_adding, ytrue){
  plot(apply(ytrue - pred_adding[[3]], MARGIN = 2, sd)/sd(ytrue), 
       ylim = c(0, 1), xlab = "No of iteration", ylab = "Sd at each iteration", pch = 16, cex = 0.8)
  abline(v = (1:(nrow(comb_meta)/5))*5 , col = "gray", lty = 2)
  abline(v = (1:(nrow(comb_meta)/10))*10 , col = "gray")
  
  rel_sd = sd(pred_adding[[1]] - ytrue)/sd(ytrue)
  r2 = 1 - sum((pred_adding[[1]] - ytrue)^2) / sum((ytrue - mean(ytrue))^2)
  return(c(rel_sd, r2))
}


  
plot_tst <- function(tst_pred_long, tst_pred_short, ytrue){
  
  plot(apply(tst_pred_long[[3]] - ytrue, MARGIN = 2, sd)/sd(ytrue), 
       ylim = c(0, 1), xlab = "No of iteration", ylab = "Sd at each iteration", pch = 16, cex = 0.8)
  
  points(apply(tst_pred_long[[3]] - ytrue, MARGIN = 2, sd)/sd(ytrue), col = "seagreen", pch = 16, cex = 0.8) 
  
  lines(apply(tst_pred_short[[3]] - ytrue, MARGIN = 2, sd)/sd(ytrue), col = "indianred2")
  
  points(apply(tst_pred_short[[3]] - ytrue, MARGIN = 2, sd)/sd(ytrue), col = "indianred2", pch = 17)
  abline(v = (1:(nrow(comb_meta)/5))*5 , col = "gray", lty = 2)
  abline(v = (1:(nrow(comb_meta)/10))*10 , col = "gray")
  
  
  rel_sd1 = sd(tst_pred_long[[1]] - ytrue)/sd(ytrue)
  rel_sd2 = sd(tst_pred_short[[1]] - ytrue)/sd(ytrue)
  
  
  r2_1 = 1 - sum((tst_pred_long[[1]] - ytrue)^2) / sum((ytrue - mean(ytrue))^2)
  r2_2 = 1 - sum((tst_pred_short[[1]] - ytrue)^2) / sum((ytrue - mean(ytrue))^2)
  
  output = matrix(c(rel_sd1, rel_sd2, r2_1, r2_2), nrow = 2)
  colnames(output) = c("rel_sd", "r2")
  rownames(output) = c("long", "short")
  return(output)
}



