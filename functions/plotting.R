plot_val <- function(pred_adding, ytrue, comb_meta, title, threshold1, threshold2){
  
  n_single = length(which(is.na(comb_meta[,2])))
  n_pair = length(which(!is.na(comb_meta[,2]) & is.na(comb_meta[,3])))
  
  xlabel = paste(inp_nm[comb_meta[,1]],inp_nm[comb_meta[,2]],inp_nm[comb_meta[,3]], sep = " + ")
  xlabel = gsub("\\+ NA", "", xlabel)
    
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
  abline(v = n_single+0.5, col = "red", lty = 2)
  abline(v = n_single + n_pair +0.5, col = "red", lty = 2)
  
  rel_sd = sd(pred_adding[[1]] - ytrue)/sd(ytrue)
  r2 = 1 - sum((pred_adding[[1]] - ytrue)^2) / sum((ytrue - mean(ytrue))^2)
  print(paste("rel_sd: ", rel_sd, "R2: ", r2, sep = " "))
  
  selected_ind = determine_para(to_plot, threshold1, threshold2, n_single)
  for(v_x in selected_ind){
    segments(x0 = v_x, y0 = 0, x1 = v_x, y1 = 0.1, col = "seagreen")
    points(x = v_x, y = to_plot[v_x], col = "seagreen", pch = 1, cex = 1.3)
  }
  par(mar = c(5.1, 4.1, 4.1, 2.1))
  return(selected_ind)
}

  

plot_res <- function(pred_adding, ytrue, comb_meta, title){
  
  n_single = length(which(is.na(comb_meta[,2])))
  n_pair = length(which(!is.na(comb_meta[,2]) & is.na(comb_meta[,3])))
  
  no_sing = length(which(is.na(comb_meta[,2])))
  no_pair = length(which(is.na(comb_meta[,2])))
  
  xlabel = paste(inp_nm[comb_meta[,1]],inp_nm[comb_meta[,2]],inp_nm[comb_meta[,3]], sep = " + ")
  xlabel = gsub("\\+ NA", "", xlabel)
  
  to_plot = apply(ytrue - pred_adding[[3]], MARGIN = 2, sd)/sd(ytrue)
  
  sd_cumulative = c(1, to_plot)
  sd_diff = -diff(sd_cumulative)
  
  
  par(mar=c(20, 4, 4, 2) + 0.1)
  
  plot(to_plot, 
       ylim = c(0, 1), xlab = "", ylab = "Sd at each iteration", pch = 16, cex = 0.8, 
       xaxt = "n", main = title, col = "gray")
  points(to_plot, 
       ylim = c(0, 1), xlab = "", ylab = "Sd at each iteration", pch = 1, cex = 1.3,col = "seagreen")
  abline(v =  n_single + 0.5 , col = "red", lty = 2)
  abline(v =  n_single + n_pair + 0.5 , col = "red", lty = 2)
  
  axis(1, labels = FALSE)
  text(x = 1:length(to_plot), y = par("usr")[3] - 0.05,
       labels = xlabel, xpd = NA, srt = 270, cex = 0.6, adj = 0)
  
  
  abline(v = (1:(nrow(comb_meta)/5))*5 , col = "gray", lty = 2)
  abline(v = (1:(nrow(comb_meta)/10))*10 , col = "gray")
  
  rel_sd = sd(pred_adding[[1]] - ytrue)/sd(ytrue)
  r2 = 1 - sum((pred_adding[[1]] - ytrue)^2) / sum((ytrue - mean(ytrue))^2)
  par(mar = c(5.1, 4.1, 4.1, 2.1))
  print(paste("rel_sd: ", rel_sd, "R2: ", r2, sep = " "))
  
  output = data.frame(cbind(comb_meta,sd_diff))
  
  output_names = data.frame(cbind(inp1 = inp_nm[output[,1]], inp2 = inp_nm[output[,2]], inp3 = inp_nm[output[,3]]))
  output = cbind(output_names, output)
  
  return(output)
}








