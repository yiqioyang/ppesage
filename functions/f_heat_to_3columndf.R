
heat_to_3columndf <- function(heat){
  ## The col of heat should be input
  ## The row of heat should be output
  ## 
  output_mat = heat %>% 
    as.data.frame() %>%
    rownames_to_column("output") %>%
    pivot_longer(!output, names_to = "input", values_to = "val") 
  
  output_mat$output = factor(output_mat$output, levels = unique(output_mat$output))
  output_mat$input = factor(output_mat$input, levels = unique(output_mat$input))
  return(output_mat)
}



heat_color_break_values <- function(heat3d){
  breaks = round(min(heat3d[,3]) + ((max(heat3d[,3]) - min(heat3d[,3]))/23 *(0:22)), digits = 5)
  return(breaks)
}
