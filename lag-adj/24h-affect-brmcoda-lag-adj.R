source("24h-affect-data.R")

cilrw <- compilr(d,
                 sbp = sbp,
                 parts = part_ww,
                 idvar = "UID",
                 total = 1440)

# full ---------------------
m_hapa_lag_adj <- brmcoda(cilrw,
                          PosAffHADayLead ~ 
                            bilr1 + bilr2 + bilr3 + bilr4 +
                            wilr1 + wilr2 + wilr3 + wilr4 + 
                            WPosAffHADay +
                            TotalDayg + WeekDay + 
                            Age + Female + RACE3G + BMI + SES_1 + 
                            CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                            (1 + wilr1 + wilr2 + wilr3 + wilr4 + WPosAffHADay| UID),
                          # (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID),
                          iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                          backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(m_hapa_lag_adj, paste0(outputdir, "m_hapa_lag_adj", ".RDS"))

m_lapa_lag_adj <- brmcoda(cilrw,
                          PosAffLADayLead ~ 
                            bilr1 + bilr2 + bilr3 + bilr4 +
                            wilr1 + wilr2 + wilr3 + wilr4 + 
                            WPosAffLADay +
                            TotalDayg + WeekDay + 
                            Age + Female + RACE3G + BMI + SES_1 + 
                            CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                            (1 + wilr1 + wilr2 + wilr3 + wilr4 + WPosAffLADay | UID),
                          # (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                          iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                          backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(m_lapa_lag_adj, paste0(outputdir, "m_lapa_lag_adj", ".RDS"))

m_hana_lag_adj <- brmcoda(cilrw,
                          NegAffHADayLead ~ 
                            bilr1 + bilr2 + bilr3 + bilr4 +
                            wilr1 + wilr2 + wilr3 + wilr4 + 
                            WNegAffHADay +
                            TotalDayg + WeekDay + 
                            Age + Female + RACE3G + BMI + SES_1 + 
                            CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                            (1 + wilr1 + wilr2 + wilr3 + wilr4 + WNegAffHADay | UID),
                          # (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                          iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                          backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(m_hana_lag_adj, paste0(outputdir, "m_hana_lag_adj", ".RDS"))

m_lana_lag_adj <- brmcoda(cilrw,
                          NegAffLADayLead ~ 
                            bilr1 + bilr2 + bilr3 + bilr4 +
                            wilr1 + wilr2 + wilr3 + wilr4 + 
                            WNegAffLADay +
                            TotalDayg + WeekDay + 
                            Age + Female + RACE3G + BMI + SES_1 + 
                            CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                            (1 + wilr1 + wilr2 + wilr3 + wilr4 + WNegAffLADay | UID),
                          # (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                          iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                          backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(m_lana_lag_adj, paste0(outputdir, "m_lana_lag_adj", ".RDS"))

# between ----------------------
mb_hapa_lag_adj <- brmcoda(cilrw,
                           PosAffHADayLead ~ 
                             bilr1 + bilr2 + bilr3 + bilr4 +
                             WPosAffHADay +
                             TotalDayg + WeekDay + 
                             Age + Female + RACE3G + BMI + SES_1 + 
                             CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                             (1 + WPosAffHADay| UID),
                           # (1 | UID),
                           iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                           backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(mb_hapa_lag_adj, paste0(outputdir, "mb_hapa_lag_adj", ".RDS"))

mb_lapa_lag_adj <- brmcoda(cilrw,
                           PosAffLADayLead ~ 
                             bilr1 + bilr2 + bilr3 + bilr4 +
                             WPosAffLADay +
                             TotalDayg + WeekDay + 
                             Age + Female + RACE3G + BMI + SES_1 + 
                             CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                             (1 + WPosAffLADay | UID),
                           # (1 | UID), 
                           iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                           backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(mb_lapa_lag_adj, paste0(outputdir, "mb_lapa_lag_adj", ".RDS"))

mb_hana_lag_adj <- brmcoda(cilrw,
                           NegAffHADayLead ~ 
                             bilr1 + bilr2 + bilr3 + bilr4 +
                             WNegAffHADay +
                             TotalDayg + WeekDay + 
                             Age + Female + RACE3G + BMI + SES_1 + 
                             CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                             (1 + WNegAffHADay | UID),
                           # (1 | UID), 
                           iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                           backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(mb_hana_lag_adj, paste0(outputdir, "mb_hana_lag_adj", ".RDS"))

mb_lana_lag_adj <- brmcoda(cilrw,
                           NegAffLADayLead ~ 
                             bilr1 + bilr2 + bilr3 + bilr4 +
                             WNegAffLADay +
                             TotalDayg + WeekDay + 
                             Age + Female + RACE3G + BMI + SES_1 + 
                             CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                             (1 + WNegAffLADay | UID),
                           # (1 | UID), 
                           iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                           backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(mb_lana_lag_adj, paste0(outputdir, "mb_lana_lag_adj", ".RDS"))

# within -----------------
mw_hapa_lag_adj <- brmcoda(cilrw,
                           PosAffHADayLead ~ 
                             wilr1 + wilr2 + wilr3 + wilr4 + 
                             WPosAffHADay +
                             TotalDayg + WeekDay + 
                             Age + Female + RACE3G + BMI + SES_1 + 
                             CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                             (1 + wilr1 + wilr2 + wilr3 + wilr4 + WPosAffHADay| UID),
                           # (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID),
                           iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                           backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(mw_hapa_lag_adj, paste0(outputdir, "mw_hapa_lag_adj", ".RDS"))

mw_lapa_lag_adj <- brmcoda(cilrw,
                           PosAffLADayLead ~ 
                             wilr1 + wilr2 + wilr3 + wilr4 + 
                             WPosAffLADay +
                             TotalDayg + WeekDay + 
                             Age + Female + RACE3G + BMI + SES_1 + 
                             CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                             (1 + wilr1 + wilr2 + wilr3 + wilr4 + WPosAffLADay | UID),
                           # (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                           iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                           backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(mw_lapa_lag_adj, paste0(outputdir, "mw_lapa_lag_adj", ".RDS"))

mw_hana_lag_adj <- brmcoda(cilrw,
                           NegAffHADayLead ~ 
                             wilr1 + wilr2 + wilr3 + wilr4 + 
                             WNegAffHADay +
                             TotalDayg + WeekDay + 
                             Age + Female + RACE3G + BMI + SES_1 + 
                             CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                             (1 + wilr1 + wilr2 + wilr3 + wilr4 + WNegAffHADay | UID),
                           # (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                           iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                           backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(mw_hana_lag_adj, paste0(outputdir, "mw_hana_lag_adj", ".RDS"))

mw_lana_lag_adj <- brmcoda(cilrw,
                           NegAffLADayLead ~ 
                             wilr1 + wilr2 + wilr3 + wilr4 + 
                             WNegAffLADay +
                             TotalDayg + WeekDay + 
                             Age + Female + RACE3G + BMI + SES_1 + 
                             CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                             (1 + wilr1 + wilr2 + wilr3 + wilr4 + WNegAffLADay | UID),
                           # (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                           iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                           backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(mw_lana_lag_adj, paste0(outputdir, "mw_lana_lag_adj", ".RDS"))

# null --------------------
m0_hapa_lag_adj <- brmcoda(cilrw,
                           PosAffHADayLead ~ 
                             WPosAffHADay +
                             TotalDayg + WeekDay + 
                             Age + Female + RACE3G + BMI + SES_1 + 
                             CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                             (1 + WPosAffHADay | UID),
                           # (1 | UID), 
                           iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                           backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(m0_hapa_lag_adj, paste0(outputdir, "m0_hapa_lag_adj", ".RDS"))

m0_lapa_lag_adj <- brmcoda(cilrw,
                           PosAffLADayLead ~ 
                             WPosAffLADay +
                             TotalDayg + WeekDay + 
                             Age + Female + RACE3G + BMI + SES_1 + 
                             CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                             (1 + WPosAffLADay | UID),
                           # (1 | UID), 
                           iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                           backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(m0_lapa_lag_adj, paste0(outputdir, "m0_lapa_lag_adj", ".RDS"))

m0_hana_lag_adj <- brmcoda(cilrw,
                           NegAffHADayLead ~ 
                             WNegAffHADay +
                             TotalDayg + WeekDay + 
                             Age + Female + RACE3G + BMI + SES_1 + 
                             CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                             (1 + WNegAffHADay | UID),
                           # (1 | UID), 
                           iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                           backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(m0_hana_lag_adj, paste0(outputdir, "m0_hana_lag_adj", ".RDS"))

m0_lana_lag_adj <- brmcoda(cilrw,
                           NegAffLADayLead ~ 
                             WNegAffLADay +
                             TotalDayg + WeekDay + 
                             Age + Female + RACE3G + BMI + SES_1 + 
                             CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                             (1 + WNegAffLADay | UID),
                           # (1 | UID), 
                           iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                           backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(m0_lana_lag_adj, paste0(outputdir, "m0_lana_lag_adj", ".RDS"))
