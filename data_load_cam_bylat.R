setwd("~/Documents/manu/add_gp/cam/")

nc_data = nc_open("./data/raw/tparams_gcmglobalaverages.CAM6tuningexp.v1.obsbias_used.1yearave.nc")
para_nc = ncvar_get(nc_data, "param_vals")
out_nc = ncvar_get(nc_data, "model_annout")

para_nm = c("clubb_c2rt", "micro_mg_autocon_nd_exp", "micro_mg_dcs", "cldfrc_dp1", "cldfrc_dp2", "clubb_c6rt", "clubb_c6rtb", "clubb_c6thl", 
            "clubb_c6thlb", "clubb_c8", "clubb_beta", "clubb_c1", "clubb_c11", "clubb_c14", "clubb_c_k10", "clubb_gamma_coef", "clubb_wpxp_l_thresh", 
            "dust_emis_fact", "micro_mg_accre_enhan_fact", "micro_mg_autocon_fact", "micro_mg_autocon_lwp_exp", "micro_mg_berg_eff_factor", 
            "micro_mg_effi_factor", "micro_mg_homog_size", "micro_mg_iaccr_factor", "micro_mg_max_nicons", "micro_mg_vtrmi_factor",
            "microp_aero_npccn_scale", "microp_aero_wsub_min", "microp_aero_wsub_scale", "microp_aero_wsubi_min", "microp_aero_wsubi_scale",
            "seasalt_emis_scale", "sol_factb_interstitial", "sol_factic_interstitial", "zmconv_c0_lnd", "zmconv_c0_ocn", "zmconv_capelmt",
            "zmconv_dmpdz", "zmconv_ke", "zmconv_ke_lnd", "zmconv_momcd", "zmconv_momcu", "zmconv_num_cin", "zmconv_tiedke_add")

out_nm = c("netrad_toa", "netheat_grnd", "albedo", "swabstoa_ave", "swabstoa", "swabstoa_soceans", "sw_cre", "olr_ave", "olr", "lw_cre", "pwv", "qv_100hpa", "qv_200hpa",
           "qv_600hpa", "qv_925hpa", "T_trop", "T_100hpa", "T_200hpa", "T_600hpa", "T_925hpa", "CLWP_no_precip_cond", "TIWP", "prec_mc", "prec", "prec_amazon", "tcc",
           "tcc_isccp", "tcc_shcu", "tcc_sc", "cdnc", "sfcwind", "T_for_Phase0.90", 'Z_for_Phase0.90', "Trop_Cyclone_Count", "StreamFunction_DJF", "StreamFunction_JJA")


para = data.frame(para_nc)
colnames(para) = para_nm
out = data.frame(out_nc)
colnames(out) = out_nm

####
nc_data = nc_open("./data/raw/selected_cam6_fields.1yearave.nc")
#nc_data2 = nc_open("./data/raw/selected_cam6_fields.3yearave.nc")

