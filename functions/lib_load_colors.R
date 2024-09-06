## Load libraries
library(ncdf4)
library(ggplot2)
library(raster)
library(rgdal)
library(ggcorrplot)
library(tidyverse)
library(RColorBrewer)
library(gridExtra)
library(rgl)
library(RobustGaSP)
library(ClusterR)
library(cluster)
library(gridExtra)
library(scatterplot3d)
library(plot3D)
library(parallel)



myPallette <-
  c(rev(colorRampPalette(brewer.pal(9,"YlGnBu")[3:9])(11)),"khaki1",
    colorRampPalette(brewer.pal(9, "YlOrRd")[3:9])(11))

myPallette_postive <-
  c(rev(colorRampPalette(brewer.pal(9,"YlGnBu")[1:9])(23)))


gg_theme_correlation = list(theme(axis.text.x = element_text(angle = -40, vjust = 0, hjust=0),
                                  axis.ticks.length.x = unit(.4, "cm"),
                                  legend.key.height= unit(2, 'cm'),
                                  legend.title = element_text(size = 10),
                                  axis.title.x = element_blank(),
                                  axis.title.y = element_blank()), coord_fixed())

gg_theme_correlation_no_fix_coord = list(theme(axis.text.x = element_text(angle = -40, vjust = 0, hjust=0),
                                               axis.ticks.length.x = unit(.4, "cm"),
                                               legend.key.height= unit(2, 'cm'),
                                               legend.title = element_text(size = 10),
                                               axis.title.x = element_blank(),
                                               axis.title.y = element_blank()))




random_colors = c("red", "navy","seagreen","pink", "gray", "khaki1", 
                  "aquamarine1","violetred2","green", "gray6")



#####

