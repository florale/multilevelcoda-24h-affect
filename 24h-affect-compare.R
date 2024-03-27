source("utils.R")
# MODELS --------------------
m_hapa <- readRDS(paste0(outputdir, "m_hapa", ".RDS"))
m_lapa <- readRDS(paste0(outputdir, "m_lapa", ".RDS"))
m_hana <- readRDS(paste0(outputdir, "m_hana", ".RDS"))
m_lana <- readRDS(paste0(outputdir, "m_lana", ".RDS"))

mb_hapa <- readRDS(paste0(outputdir, "mb_hapa", ".RDS"))
mb_lapa <- readRDS(paste0(outputdir, "mb_lapa", ".RDS"))
mb_hana <- readRDS(paste0(outputdir, "mb_hana", ".RDS"))
mb_lana <- readRDS(paste0(outputdir, "mb_lana", ".RDS"))

mw_hapa <- readRDS(paste0(outputdir, "mw_hapa", ".RDS"))
mw_lapa <- readRDS(paste0(outputdir, "mw_lapa", ".RDS"))
mw_hana <- readRDS(paste0(outputdir, "mw_hana", ".RDS"))
mw_lana <- readRDS(paste0(outputdir, "mw_lana", ".RDS"))

m0_hapa <- readRDS(paste0(outputdir, "m0_hapa", ".RDS"))
m0_lapa <- readRDS(paste0(outputdir, "m0_lapa", ".RDS"))
m0_hana <- readRDS(paste0(outputdir, "m0_hana", ".RDS"))
m0_lana <- readRDS(paste0(outputdir, "m0_lana", ".RDS"))

# LOO ---------------------- MOVED TO M3  
options(mc.cores = 8)
options(future.globals.maxSize = 850*1024^2)

# kfold_m_hapa <- kfold(m_hapa$Model, future_args = list(globals = list(future.globals.maxSize = 850*1024^2))) # works woooo
# loo_m_hapa_mm <- loo_moment_match(m_hapa$Model, loo_m_hapa, cores = 8) # crash

# these works so moved to m3
loo_m_hapa <- loo(m_hapa$Model, cores = 8, reloo = TRUE, 
                  reloo_args = list(recompile = TRUE, 
                                    future_args = list(globals = list(future.globals.maxSize = 850*1024^2))))

# OR 
loo_m_lapa <- loo(m_lapa$Model, cores = 8)
loo_m_lapa<- reloo(m_lapa$Model, loo_m_lapa, future_args = list(globals = list(future.globals.maxSize = 850*1024^2)))

loo_m_hana <- loo(m_hana$Model, cores = 8)
loo_m_hana<- reloo(m_hana$Model, loo_m_hana, future_args = list(globals = list(future.globals.maxSize = 850*1024^2)))

loo_m_lana <- loo(m_lana$Model, cores = 8)
loo_m_lana<- reloo(m_lana$Model, loo_m_lana, future_args = list(globals = list(future.globals.maxSize = 850*1024^2)))

loo_mb_hapa <- loo(mb_hapa$Model, cores = 8)
loo_mb_hapa<- reloo(mb_hapa$Model, loo_mb_hapa, future_args = list(globals = list(future.globals.maxSize = 850*1024^2)))

loo_mb_lapa <- loo(mb_lapa$Model, cores = 8)
loo_mb_lapa<- reloo(loo_mb_lapa$Model, loo_mb_lapa, future_args = list(globals = list(future.globals.maxSize = 850*1024^2)))

loo_mb_hana <- loo(mb_hana$Model, cores = 8)
loo_mb_hana<- reloo(mb_hana$Model, loo_mb_hana, future_args = list(globals = list(future.globals.maxSize = 850*1024^2)))

loo_mb_lana <- loo(mb_lana$Model, cores = 8)
loo_mb_lana<- reloo(mb_lana$Model, loo_mb_lana, future_args = list(globals = list(future.globals.maxSize = 850*1024^2)))

loo_mw_hapa <- loo(mw_hapa$Model, cores = 8)
loo_mw_hapa<- reloo(mw_hapa$Model, loo_mw_hapa, future_args = list(globals = list(future.globals.maxSize = 850*1024^2)))

loo_mw_lapa <- loo(mw_lapa$Model, cores = 8)
loo_mw_lapa<- reloo(mw_lapa$Model, loo_mw_lapa, future_args = list(globals = list(future.globals.maxSize = 850*1024^2)))

loo_mw_hana <- loo(mw_hana$Model, cores = 8)
loo_mw_hana<- reloo(mw_hana$Model, loo_mw_hana, future_args = list(globals = list(future.globals.maxSize = 850*1024^2)))

loo_mw_lana <- loo(mw_lana$Model, cores = 8)
loo_mw_lana<- reloo(mw_lana$Model, loo_mw_lana, future_args = list(globals = list(future.globals.maxSize = 850*1024^2)))

loo_m0_hapa <- loo(m0_hapa$Model, cores = 8)
loo_m0_hapa<- reloo(m0_hapa$Model, loo_m0_hapa, future_args = list(globals = list(future.globals.maxSize = 850*1024^2)))

loo_m0_lapa <- loo(m0_lapa$Model, cores = 8)
loo_m0_lapa<- reloo(m0_lapa$Model, loo_m0_lapa, future_args = list(globals = list(future.globals.maxSize = 850*1024^2)))

loo_m0_hana <- loo(m0_hana$Model, cores = 8)
loo_m0_hana<- reloo(m0_hana$Model, loo_m0_hana, future_args = list(globals = list(future.globals.maxSize = 850*1024^2)))

loo_m0_lana <- loo(m0_lana$Model, cores = 8)
loo_m0_lana<- reloo(m0_lana$Model, loo_m0_lana, future_args = list(globals = list(future.globals.maxSize = 850*1024^2)))

# plan(sequential)
# 
# saveRDS(loo_m_lapa, paste0(outputdir, "loo_m_lapa", ".RDS"))
# saveRDS(loo_m_hana, paste0(outputdir, "loo_m_hana", ".RDS"))
# saveRDS(loo_m_lana, paste0(outputdir, "loo_m_lana", ".RDS"))
# 
# saveRDS(loo_mb_hapa, paste0(outputdir, "loo_mb_hapa", ".RDS"))
# saveRDS(loo_mb_lapa, paste0(outputdir, "loo_mb_lapa", ".RDS"))
# saveRDS(loo_mb_hana, paste0(outputdir, "loo_mb_hana", ".RDS"))
# saveRDS(loo_mb_lana, paste0(outputdir, "loo_mb_lana", ".RDS"))
# 
# saveRDS(loo_mw_hapa, paste0(outputdir, "loo_mw_hapa", ".RDS"))
# saveRDS(loo_mw_lapa, paste0(outputdir, "loo_mw_lapa", ".RDS"))
# saveRDS(loo_mw_hana, paste0(outputdir, "loo_mw_hana", ".RDS"))
# saveRDS(loo_mw_lana, paste0(outputdir, "loo_mw_lana", ".RDS"))
# 
# saveRDS(loo_m0_hapa, paste0(outputdir, "loo_m0_hapa", ".RDS"))
# saveRDS(loo_m0_lapa, paste0(outputdir, "loo_m0_lapa", ".RDS"))
# saveRDS(loo_m0_hana, paste0(outputdir, "loo_m0_hana", ".RDS"))
# saveRDS(loo_m0_lana, paste0(outputdir, "loo_m0_lana", ".RDS"))

# READ LOOs --------------------
loo_m_hapa <- readRDS(paste0(outputdir, "loo_m_hapa", ".RDS"))
loo_m_lapa <- readRDS(paste0(outputdir, "loo_m_lapa", ".RDS"))
loo_m_hana <- readRDS(paste0(outputdir, "loo_m_hana", ".RDS"))
loo_m_lana <- readRDS(paste0(outputdir, "loo_m_lana", ".RDS"))

loo_mb_hapa <- readRDS(paste0(outputdir, "loo_mb_hapa", ".RDS"))
loo_mb_lapa <- readRDS(paste0(outputdir, "loo_mb_lapa", ".RDS"))
loo_mb_hana <- readRDS(paste0(outputdir, "loo_mb_hana", ".RDS"))
loo_mb_lana <- readRDS(paste0(outputdir, "loo_mb_lana", ".RDS"))

loo_mw_hapa <- readRDS(paste0(outputdir, "loo_mw_hapa", ".RDS"))
loo_mw_lapa <- readRDS(paste0(outputdir, "loo_mw_lapa", ".RDS"))
loo_mw_hana <- readRDS(paste0(outputdir, "loo_mw_hana", ".RDS"))
loo_mw_lana <- readRDS(paste0(outputdir, "loo_mw_lana", ".RDS"))

loo_m0_hapa <- readRDS(paste0(outputdir, "loo_m0_hapa", ".RDS"))
loo_m0_lapa <- readRDS(paste0(outputdir, "loo_m0_lapa", ".RDS"))
loo_m0_hana <- readRDS(paste0(outputdir, "loo_m0_hana", ".RDS"))
loo_m0_lana <- readRDS(paste0(outputdir, "loo_m0_lana", ".RDS"))

# stacking -----------------------
# full vs between vs within vs null
lpd_point_hapa <- cbind(loo_m0_hapa$pointwise[,"elpd_loo"],
                        loo_mb_hapa$pointwise[,"elpd_loo"],
                        loo_mw_hapa$pointwise[,"elpd_loo"],
                        loo_m_hapa$pointwise[,"elpd_loo"])

lpd_point_lapa <- cbind(loo_m0_lapa$pointwise[,"elpd_loo"],
                        loo_mb_lapa$pointwise[,"elpd_loo"],
                        loo_mw_lapa$pointwise[,"elpd_loo"],
                        loo_m_lapa$pointwise[,"elpd_loo"])

lpd_point_hana <- cbind(loo_m0_hana$pointwise[,"elpd_loo"],
                        loo_mb_hana$pointwise[,"elpd_loo"],
                        loo_mw_hana$pointwise[,"elpd_loo"],
                        loo_m_hana$pointwise[,"elpd_loo"])

lpd_point_lana <- cbind(loo_m0_lana$pointwise[,"elpd_loo"],
                        loo_mb_lana$pointwise[,"elpd_loo"],
                        loo_mw_lana$pointwise[,"elpd_loo"],
                        loo_m_lana$pointwise[,"elpd_loo"])

loo::stacking_weights(lpd_point_hapa)
loo::stacking_weights(lpd_point_lapa)
loo::stacking_weights(lpd_point_hana)
loo::stacking_weights(lpd_point_lana)

loo_compare_hapa <- loo::loo_compare(loo_m0_hapa, loo_mb_hapa, loo_mw_hapa, loo_m_hapa)
loo_compare_lapa <- loo::loo_compare(loo_m0_lapa, loo_mb_lapa, loo_mw_lapa, loo_m_lapa)
loo_compare_hana <- loo::loo_compare(loo_m0_hana, loo_mb_hana, loo_mw_hana, loo_m_hana)
loo_compare_lana <- loo::loo_compare(loo_m0_lana, loo_mb_lana, loo_mw_lana, loo_m_lana)

print(loo_compare_hapa, digits = 3)
print(loo_compare_lapa, digits = 3)
print(loo_compare_hana, digits = 3)
print(loo_compare_lana, digits = 3)

# BF -------------------------
comparison_hapa <- readRDS(paste0(outputdir, "comparison_hapa", ".RDS"))
comparison_lapa <- readRDS(paste0(outputdir, "comparison_lapa", ".RDS"))
comparison_hana <- readRDS(paste0(outputdir, "comparison_hana", ".RDS"))
comparison_lana <- readRDS(paste0(outputdir, "comparison_lana", ".RDS"))

comparison_hapa
comparison_lapa
comparison_hana
comparison_lana
