source("24h-affect-setup.R")

# main output -------------------
m_hapa_sub <- readRDS(paste0(outputdir, "m_hapa_sub", ".RDS"))
m_lapa_sub <- readRDS(paste0(outputdir, "m_lapa_sub", ".RDS"))
m_hana_sub <- readRDS(paste0(outputdir, "m_hana_sub", ".RDS"))
m_lana_sub <- readRDS(paste0(outputdir, "m_lana_sub", ".RDS"))

## substitution summary 
summary(m_hapa_sub, level = "within", delta = 30)
summary(m_lapa_sub, level = "within", delta = 30)
summary(m_hana_sub, level = "within", delta = 30)
summary(m_lana_sub, level = "within", delta = 30)

## standardised coefs ------------------
d_sub_hapa <- as.data.table(summary(m_hapa_sub, delta = 30, digits = "asis"))
d_sub_lapa <- as.data.table(summary(m_lapa_sub, delta = 30, digits = "asis"))
d_sub_hana <- as.data.table(summary(m_hana_sub, delta = 30, digits = "asis"))
d_sub_lana <- as.data.table(summary(m_lana_sub, delta = 30, digits = "asis"))
clrw <- readRDS(paste0(outputdir, "cilrw", ".RDS"))

d_sub_hapa[Level == "between", SMean := round(Mean / sd(clrw$data[Survey == "Evening"]$BPosAffHADayLead, na.rm = T), 2)]
d_sub_hapa[Level == "within", SMean := round(Mean / sd(clrw$data[Survey == "Evening"]$WPosAffHADayLead, na.rm = T), 2)]

d_sub_lapa[Level == "between", SMean := round(Mean / sd(clrw$data[Survey == "Evening"]$BPosAffLADayLead, na.rm = T), 2)]
d_sub_lapa[Level == "within", SMean := round(Mean / sd(clrw$data[Survey == "Evening"]$WPosAffLADayLead, na.rm = T), 2)]

d_sub_hana[Level == "between", SMean := round(Mean / sd(clrw$data[Survey == "Evening"]$BNegAffHADayLead, na.rm = T), 2)]
d_sub_hana[Level == "within", SMean := round(Mean / sd(clrw$data[Survey == "Evening"]$WNegAffHADayLead, na.rm = T), 2)]

d_sub_lana[Level == "between", SMean := round(Mean / sd(clrw$data[Survey == "Evening"]$BNegAffLADayLead, na.rm = T), 2)]
d_sub_lana[Level == "within", SMean := round(Mean / sd(clrw$data[Survey == "Evening"]$WNegAffLADayLead, na.rm = T), 2)]

# read last column for standardised coefs
d_sub_hapa[Level == "within"]
d_sub_lapa[Level == "within"]
d_sub_hana[Level == "within"]
d_sub_lana[Level == "within"]
