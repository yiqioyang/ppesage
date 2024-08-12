plot_val <- function(pred_adding, ytrue, comb_meta, title, threshold = 0.001){
  
  xlabel = paste(inp_nm[comb_meta[,1]],inp_nm[comb_meta[,2]],inp_nm[comb_meta[,3]], sep = " + ")
  
  to_plot = apply(ytrue - pred_adding[[3]], MARGIN = 2, sd)/sd(ytrue)
  
  par(mar=c(20, 4, 4, 2) + 0.1)
  
  plot(to_plot, 
       ylim = c(0, 1), xlab = "", ylab = "Sd at each iteration", pch = 16, cex = 0.8, 
       xaxt = "n", main = title, col = "gray")
  axis(1, labels = FALSE)
  text(x = 1:length(to_plot), y = par("usr")[3] - 0.05,
       labels = xlabel, xpd = NA, srt = 270, cex = 0.6, adj = 0)
  
  
  abline(v = (1:(nrow(comb_meta)/5))*5 , col = "gray", lty = 2)
  abline(v = (1:(nrow(comb_meta)/10))*10 , col = "gray")
  
  rel_sd = sd(pred_adding[[1]] - ytrue)/sd(ytrue)
  r2 = 1 - sum((pred_adding[[1]] - ytrue)^2) / sum((ytrue - mean(ytrue))^2)
  print(c(rel_sd, r2))
  
  selected_ind = determine_para(to_plot, threshold)
  for(v_x in selected_ind){
    segments(x0 = v_x, y0 = 0, x1 = v_x, y1 = 0.1, col = "seagreen")
    points(x = v_x, y = to_plot[v_x], col = "seagreen", pch = 1, cex = 1.3)
  }
  
  return(selected_ind)
}

  

plot_res <- function(pred_adding, ytrue, comb_meta, title){
  xlabel = paste(inp_nm[comb_meta[,1]],inp_nm[comb_meta[,2]],inp_nm[comb_meta[,3]], sep = " + ")
  to_plot = apply(ytrue - pred_adding[[3]], MARGIN = 2, sd)/sd(ytrue)
  
  par(mar=c(20, 4, 4, 2) + 0.1)
  
  plot(to_plot, 
       ylim = c(0, 1), xlab = "", ylab = "Sd at each iteration", pch = 16, cex = 0.8, 
       xaxt = "n", main = title, col = "gray")
  points(to_plot, 
       ylim = c(0, 1), xlab = "", ylab = "Sd at each iteration", pch = 1, cex = 1.3,col = "seagreen")
  
  axis(1, labels = FALSE)
  text(x = 1:length(to_plot), y = par("usr")[3] - 0.05,
       labels = xlabel, xpd = NA, srt = 270, cex = 0.6, adj = 0)
  
  
  abline(v = (1:(nrow(comb_meta)/5))*5 , col = "gray", lty = 2)
  abline(v = (1:(nrow(comb_meta)/10))*10 , col = "gray")
  
  rel_sd = sd(pred_adding[[1]] - ytrue)/sd(ytrue)
  r2 = 1 - sum((pred_adding[[1]] - ytrue)^2) / sum((ytrue - mean(ytrue))^2)
  print(c(rel_sd, r2))
}








