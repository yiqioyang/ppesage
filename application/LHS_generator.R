####### Required libraries: "lhs"
##installed.packages("lhs")
library(lhs)

wd = "where this is repo is located"
setwd(wd)

para_name_range_path = "./data/para_def.csv"
n_ens = 10000

para_def = read.table(para_name_range_path, sep = ",", header = TRUE)

ens01 = randomLHS(n_ens, nrow(para_def))
colnames(ens01) = para_def$names

ens = ens01

for(i in 1:nrow(para_def)){
  ens[,i] = ens01[,i] * (para_def[i,]$max - para_def[i,]$min) + para_def[i,]$min
}

write.table(ens, "./data/lhs_parameters.csv", sep = ",", col.names=TRUE, row.names=FALSE)
