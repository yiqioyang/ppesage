meta_modification <- function(meta_data, ranges, nugget){
  meta_1d = meta_data[!is.na(meta_data[,1]) & is.na(meta_data[,2]) & is.na(meta_data[,3]), ]
  meta_2d = meta_data[!is.na(meta_data[,1]) & !is.na(meta_data[,2]) & is.na(meta_data[,3]), ]
  meta_3d = meta_data[!is.na(meta_data[,1]) & !is.na(meta_data[,2]) & !is.na(meta_data[,3]), ]
  
  meta_1d[,4] = ranges[1]
  meta_1d[,7] = nugget
  
  if(nrow(meta_2d)>0){
    meta_2d[,4:5] = ranges[2]
    meta_2d[,7] = nugget
  }
  
  if(nrow(meta_3d)>0){
    meta_3d[,4:6] = ranges[3]
    meta_3d[,7] = nugget
  }
  
  output = meta_1d
  
  if(nrow(meta_2d)>0){
    output = rbind(output, meta_2d)
  }
  
  if(nrow(meta_3d)>0){
    output = rbind(output, meta_3d)
  }
  
  return(output)
}

#meta_modification(meta_data, ranges = c(0.1, 0.2, 0.3), nugget = 3)
