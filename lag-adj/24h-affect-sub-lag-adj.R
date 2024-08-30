source("24h-affect-utils.R")

m_hapa_lag_adj_sub <- readRDS(paste0(outputdir, "m_hapa_lag_adj_sub", ".RDS"))
m_lapa_lag_adj_sub <- readRDS(paste0(outputdir, "m_lapa_lag_adj_sub", ".RDS"))
m_hana_lag_adj_sub <- readRDS(paste0(outputdir, "m_hana_lag_adj_sub", ".RDS"))
m_lana_lag_adj_sub <- readRDS(paste0(outputdir, "m_lana_lag_adj_sub", ".RDS"))


summary(m_hapa_lag_adj_sub, delta = 30)
summary(m_lapa_lag_adj_sub, delta = 30)
summary(m_hana_lag_adj_sub, delta = 30)
summary(m_lana_lag_adj_sub, delta = 30)

summary(m_hapa_lag_adj_sub, delta = 60, digits = 4)
summary(m_lapa_lag_adj_sub, delta = 60, digits = 4)
summary(m_hana_lag_adj_sub, delta = 60, digits = 4)
summary(m_lana_lag_adj_sub, delta = 60, digits = 4)
