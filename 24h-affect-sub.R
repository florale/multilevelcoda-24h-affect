source("24h-affect-utils.R")

# Wake-Wake - Next day average outcome (prospective) -------------------------
m_hapa <- readRDS(paste0(outputdir, "m_hapa", ".RDS"))
m_lapa <- readRDS(paste0(outputdir, "m_lapa", ".RDS"))
m_hana <- readRDS(paste0(outputdir, "m_hana", ".RDS"))
m_lana <- readRDS(paste0(outputdir, "m_lana", ".RDS"))

# plan(multisession, workers = 5)
# mhapa_ww_lag_sub_adj <- substitution(
#   m_hapa,
#   delta = c(1:60),
#   # delta = c(60),
#   level = c("between", "within"),
#   ref = "grandmean")
# 
# mlapa_ww_lag_sub_adj <- substitution(
#   m_lapa,
#   delta = c(1:60),
#   # delta = c(60),
#   level = c("between", "within"),
#   ref = "grandmean")
# 
# mhana_ww_lag_sub_adj <- substitution(
#   m_hana,
#   delta = c(1:60),
#   # delta = c(60),
#   level = c("between", "within"),
#   ref = "grandmean")
# 
# mlana_ww_lag_sub_adj <- substitution(
#   mlana,
#   delta = c(1:60),
#   # delta = c(60),
#   level = c("between", "within"),
#   ref = "grandmean")
# plan(sequential)

mhapa_ww_sub <- readRDS(paste0(outputdir, "mhapa_ww_sub", ".RDS"))
mlapa_ww_sub <- readRDS(paste0(outputdir, "mlapa_ww_sub", ".RDS"))
mhana_ww_sub <- readRDS(paste0(outputdir, "mhana_ww_sub", ".RDS"))
mlana_ww_sub <- readRDS(paste0(outputdir, "mlana_ww_sub", ".RDS"))

## substitution summary 
summary(mhapa_ww_sub, delta = 30)
summary(mlapa_ww_sub, delta = 30)
summary(mhana_ww_sub, delta = 30)
summary(mlana_ww_sub, delta = 30)

summary(mhapa_ww_sub, delta = 60, digits = 3)
summary(mlapa_ww_sub, delta = 60, digits = 3)
summary(mhana_ww_sub, delta = 60, digits = 3)
summary(mlana_ww_sub, delta = 60, digits = 3)

summary(mhapa_ww_lag_sub_adj, delta = 1, digits = 5)
summary(mlapa_ww_lag_sub_adj, delta = 1, digits = 5)
summary(mhana_ww_lag_sub_adj, delta = 1, digits = 5)
summary(mlana_ww_lag_sub_adj, delta = 1, digits = 5)
