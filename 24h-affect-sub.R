source("24h-affect-utils.R")

m_hapa_sub <- readRDS(paste0(outputdir, "m_hapa_sub", ".RDS"))
m_lapa_sub <- readRDS(paste0(outputdir, "m_lapa_sub", ".RDS"))
m_hana_sub <- readRDS(paste0(outputdir, "m_hana_sub", ".RDS"))
m_lana_sub <- readRDS(paste0(outputdir, "m_lana_sub", ".RDS"))

## substitution summary 
summary(m_hapa_sub, delta = 30)
summary(m_lapa_sub, delta = 30)
summary(m_hana_sub, delta = 30)
summary(m_lana_sub, delta = 30)

summary(m_hapa_sub, delta = 60, digits = 3)
summary(m_lapa_sub, delta = 60, digits = 3)
summary(m_hana_sub, delta = 60, digits = 3)
summary(m_lana_sub, delta = 60, digits = 3)

summary(mhapa_ww_lag_sub_adj, delta = 1, digits = 5)
summary(mlapa_ww_lag_sub_adj, delta = 1, digits = 5)
summary(mhana_ww_lag_sub_adj, delta = 1, digits = 5)
summary(mlana_ww_lag_sub_adj, delta = 1, digits = 5)

