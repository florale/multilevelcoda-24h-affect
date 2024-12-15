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

summary(m_hapa_sub, delta = 60)
summary(m_lapa_sub, delta = 60)
summary(m_hana_sub, delta = 60)
summary(m_lana_sub, delta = 60)

summary(m_hapa_sub, delta = 60, digits = 3)
summary(m_lapa_sub, delta = 60, digits = 3)
summary(m_hana_sub, delta = 60, digits = 3)
summary(m_lana_sub, delta = 60, digits = 3)

summary(mhapa_ww_lag_sub_adj, delta = 1, digits = 5)
summary(mlapa_ww_lag_sub_adj, delta = 1, digits = 5)
summary(mhana_ww_lag_sub_adj, delta = 1, digits = 5)
summary(mlana_ww_lag_sub_adj, delta = 1, digits = 5)

# standardised coefs ------------------

d_sub_hapa <- as.data.table(summary(m_hapa_sub, delta = 30, digits = "asis"))
d_sub_lapa <- as.data.table(summary(m_lapa_sub, delta = 30, digits = "asis"))
d_sub_hana <- as.data.table(summary(m_hana_sub, delta = 30, digits = "asis"))
d_sub_lana <- as.data.table(summary(m_lana_sub, delta = 30, digits = "asis"))

d_sub_hapa[Level == "between", SMean := round(Mean / sd(dw[Survey == "Evening"]$BPosAffHADayLead, na.rm = T), 2)]
d_sub_hapa[Level == "within", SMean := round(Mean / sd(dw[Survey == "Evening"]$WPosAffHADayLead, na.rm = T), 2)]

d_sub_lapa[Level == "between", SMean := round(Mean / sd(dw[Survey == "Evening"]$BPosAffLADayLead, na.rm = T), 2)]
d_sub_lapa[Level == "within", SMean := round(Mean / sd(dw[Survey == "Evening"]$WPosAffLADayLead, na.rm = T), 2)]

d_sub_hana[Level == "between", SMean := round(Mean / sd(dw[Survey == "Evening"]$BNegAffHADayLead, na.rm = T), 2)]
d_sub_hana[Level == "within", SMean := round(Mean / sd(d[Survey == "Evening"]$WNegAffHADayLead, na.rm = T), 2)]

d_sub_lana[Level == "between", SMean := round(Mean / sd(dw[Survey == "Evening"]$BNegAffLADayLead, na.rm = T), 2)]
d_sub_lana[Level == "within", SMean := round(Mean / sd(dw[Survey == "Evening"]$WNegAffLADayLead, na.rm = T), 2)]

# read last column
d_sub_hapa
d_sub_lapa
d_sub_hana
d_sub_lana
