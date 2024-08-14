setwd(wd)
print(out_nm[y_ind])
case_var_name = out_nm[y_ind]
case_dir = paste(case_name, case_var_name, sep = "_")
######################
#################################################################################
dir.create(file.path("./cases", case_dir))

print("Case created")

#setwd(file.path("./cases", case_dir))