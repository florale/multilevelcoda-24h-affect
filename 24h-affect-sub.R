source("24h-affect-utils.R")

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
