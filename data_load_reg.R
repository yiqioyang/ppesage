#############
setwd("~/Documents/proj/leap_gcm/data/gcm_551/")
nc_data_a = nc_open("./tparams_gcmglobalaverages.GISS-E3tuningexp.v5.nc")
nc_data_b = nc_open("./tparams_gcmglobalaverages.GISS-E3emulatorguided.v5.nc")

inp_a = ncvar_get(nc_data_a, "param_vals")
out_a = ncvar_get(nc_data_a, "model_annout")

inp_b = ncvar_get(nc_data_b, "param_vals")
out_b = ncvar_get(nc_data_b, "model_annout")


inp_nm = c("debdecaytime", "cdnc_ocean_mc", "cdnc_land_mc_xs", "dcw_qc", "qci_detrainment_multiplier",
           "cloudrvl_mstcnv", "cloudrvi_mstcnv", "bsort_enteff1", "bsort_enteff2", "urelscale", "cond_repart_dpscale",
           "pthresh_closure2", "tadjmc1", "tadjmc2", "tadjmc3", "dd_evpeff_qp_scale", "geometric_fevapfac", "dp_disp_fac", 
           "dp_disp_max", "dp_disp2_fac", "dp_disp2_max", "dd_detbyent", "entcon_dd", "max_dt_overshoot", "terminal_aspcp",
           "mc_tqstar_fac", "mc_fddrt", "tfmc", "vterm_env", "t_homf", "rhcsl", "rhctl", "ni_homfree", "dcs", "wb99_rh", "invar_pow",
           "ac_time", "scale_cn", "scale_iifn", "scale_difn", "ifluffy", "sfluffy", "vf_multi", "vf_mults", "a_sed_entrain")

out_nm = c("netrad_toa", "netheat_grnd", "albedo", "swabstoa_ave", "swabstoa", "swabstoa_soceans", "sw_cre", "olr_ave", 
           "olr", "lw_cre", "pwv", "qv_100hpa", "qv_200hpa", "qv_600hpa", "qv_925hpa", "T_trop", "T_100hpa", "T_200hpa", "T_600hpa", 
           "T_925hpa", "TLWP", "TIWP", "prec_mc", "prec", "prec_amazon", "tcc", "tcc_isccp", "tcc_shcu", "tcc_sc", 
           "cdnc", "sfcwind", "T_for_Phase0.90", "Z_for_Phase0.90", "Trop_Cyclone_Count", "StreamFunction_DJF", "StreamFunction_JJA")

inp_a = data.frame(inp_a)
out_a = data.frame(out_a)
colnames(inp_a) = inp_nm
colnames(out_a) = out_nm

inp_b = data.frame(inp_b)
out_b = data.frame(out_b)
colnames(inp_b) = inp_nm
colnames(out_b) = out_nm
