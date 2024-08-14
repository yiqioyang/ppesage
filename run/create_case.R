setwd(wd)
print(out_nm[y_ind])
case_dir = case_name
######################
#################################################################################
dir.create(file.path("./cases", case_dir))
print("Case created")
case_var_dir = file.path("./cases", case_dir, var_name)
dir.create(case_var_dir)
print("Variable file created")

  

#setwd(file.path("./cases", case_dir))