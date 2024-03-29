source("24h-affect-data.R")

cilrw <- compilr(d,
                 sbp = sbp,
                 parts = part_ww,
                 idvar = "UID",
                 total = 1440)

# full ---------------------
m_hapa <- brmcoda(cilrw,
                  PosAffHADayLead ~ 
                    bilr1 + bilr2 + bilr3 + bilr4 +
                    wilr1 + wilr2 + wilr3 + wilr4 + 
                    # WPosAffHADay +
                    TotalDayg + WeekDay + 
                    Age + Female + RACE3G + BMI + SES_1 + 
                    CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                    # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WPosAffHADay| UID),
                    (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID),
                  iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                  backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(m_hapa, paste0(outputdir, "m_hapa", ".RDS"))

m_lapa <- brmcoda(cilrw,
                  PosAffLADayLead ~ 
                    bilr1 + bilr2 + bilr3 + bilr4 +
                    wilr1 + wilr2 + wilr3 + wilr4 + 
                    # WPosAffLADay +
                    TotalDayg + WeekDay + 
                    Age + Female + RACE3G + BMI + SES_1 + 
                    CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                    # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WPosAffLADay | UID), 
                    (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                  iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                  backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(m_lapa, paste0(outputdir, "m_lapa", ".RDS"))

m_hana <- brmcoda(cilrw,
                  NegAffHADayLead ~ 
                    bilr1 + bilr2 + bilr3 + bilr4 +
                    wilr1 + wilr2 + wilr3 + wilr4 + 
                    # WNegAffHADay +
                    TotalDayg + WeekDay + 
                    Age + Female + RACE3G + BMI + SES_1 + 
                    CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                    # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WNegAffHADay | UID), 
                    (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                  iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                  backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(m_hana, paste0(outputdir, "m_hana", ".RDS"))

m_lana <- brmcoda(cilrw,
                  NegAffLADayLead ~ 
                    bilr1 + bilr2 + bilr3 + bilr4 +
                    wilr1 + wilr2 + wilr3 + wilr4 + 
                    # WNegAffLADay +
                    TotalDayg + WeekDay + 
                    Age + Female + RACE3G + BMI + SES_1 + 
                    CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                    # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WNegAffLADay | UID), 
                    (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                  iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                  backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(m_lana, paste0(outputdir, "m_lana", ".RDS"))

# between ----------------------
mb_hapa <- brmcoda(cilrw,
                   PosAffHADayLead ~ 
                     bilr1 + bilr2 + bilr3 + bilr4 +
                     # WPosAffHADay +
                     TotalDayg + WeekDay + 
                     Age + Female + RACE3G + BMI + SES_1 + 
                     CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                     # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WPosAffHADay| UID),
                     (1 | UID),
                   iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                   backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(mb_hapa, paste0(outputdir, "mb_hapa", ".RDS"))

mb_lapa <- brmcoda(cilrw,
                   PosAffLADayLead ~ 
                     bilr1 + bilr2 + bilr3 + bilr4 +
                     # WPosAffLADay +
                     TotalDayg + WeekDay + 
                     Age + Female + RACE3G + BMI + SES_1 + 
                     CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                     # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WPosAffLADay | UID), 
                     (1 | UID), 
                   iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                   backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(mb_lapa, paste0(outputdir, "mb_lapa", ".RDS"))

mb_hana <- brmcoda(cilrw,
                   NegAffHADayLead ~ 
                     bilr1 + bilr2 + bilr3 + bilr4 +
                     # WNegAffHADay +
                     TotalDayg + WeekDay + 
                     Age + Female + RACE3G + BMI + SES_1 + 
                     CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                     # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WNegAffHADay | UID), 
                     (1 | UID), 
                   iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                   backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(mb_hana, paste0(outputdir, "mb_hana", ".RDS"))

mb_lana <- brmcoda(cilrw,
                   NegAffLADayLead ~ 
                     bilr1 + bilr2 + bilr3 + bilr4 +
                     # WNegAffLADay +
                     TotalDayg + WeekDay + 
                     Age + Female + RACE3G + BMI + SES_1 + 
                     CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                     # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WNegAffLADay | UID), 
                     (1 | UID), 
                   iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                   backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(mb_lana, paste0(outputdir, "mb_lana", ".RDS"))

# within -----------------
mw_hapa <- brmcoda(cilrw,
                   PosAffHADayLead ~ 
                     wilr1 + wilr2 + wilr3 + wilr4 + 
                     # WPosAffHADay +
                     TotalDayg + WeekDay + 
                     Age + Female + RACE3G + BMI + SES_1 + 
                     CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                     # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WPosAffHADay| UID),
                     (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID),
                   iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                   backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(mw_hapa, paste0(outputdir, "mw_hapa", ".RDS"))

mw_lapa <- brmcoda(cilrw,
                   PosAffLADayLead ~ 
                     wilr1 + wilr2 + wilr3 + wilr4 + 
                     # WPosAffLADay +
                     TotalDayg + WeekDay + 
                     Age + Female + RACE3G + BMI + SES_1 + 
                     CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                     # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WPosAffLADay | UID), 
                     (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                   iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                   backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(mw_lapa, paste0(outputdir, "mw_lapa", ".RDS"))

mw_hana <- brmcoda(cilrw,
                   NegAffHADayLead ~ 
                     wilr1 + wilr2 + wilr3 + wilr4 + 
                     # WNegAffHADay +
                     TotalDayg + WeekDay + 
                     Age + Female + RACE3G + BMI + SES_1 + 
                     CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                     # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WNegAffHADay | UID), 
                     (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                   iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                   backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(mw_hana, paste0(outputdir, "mw_hana", ".RDS"))

mw_lana <- brmcoda(cilrw,
                   NegAffLADayLead ~ 
                     wilr1 + wilr2 + wilr3 + wilr4 + 
                     # WNegAffLADay +
                     TotalDayg + WeekDay + 
                     Age + Female + RACE3G + BMI + SES_1 + 
                     CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                     # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WNegAffLADay | UID), 
                     (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                   iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                   backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(mw_lana, paste0(outputdir, "mw_lana", ".RDS"))

# null --------------------
m0_hapa <- brmcoda(cilrw,
                   PosAffHADayLead ~ 
                     # WNegAffLADay +
                     TotalDayg + WeekDay + 
                     Age + Female + RACE3G + BMI + SES_1 + 
                     CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                     # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WNegAffLADay | UID), 
                     (1 | UID), 
                   iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                   backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(m0_hapa, paste0(outputdir, "m0_hapa", ".RDS"))

m0_lapa <- brmcoda(cilrw,
                   PosAffLADayLead ~ 
                     # WNegAffLADay +
                     TotalDayg + WeekDay + 
                     Age + Female + RACE3G + BMI + SES_1 + 
                     CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                     # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WNegAffLADay | UID), 
                     (1 | UID), 
                   iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                   backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(m0_lapa, paste0(outputdir, "m0_lapa", ".RDS"))

m0_hana <- brmcoda(cilrw,
                   NegAffHADayLead ~ 
                     # WNegAffLADay +
                     TotalDayg + WeekDay + 
                     Age + Female + RACE3G + BMI + SES_1 + 
                     CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                     # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WNegAffLADay | UID), 
                     (1 | UID), 
                   iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                   backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(m0_hana, paste0(outputdir, "m0_hana", ".RDS"))

m0_lana <- brmcoda(cilrw,
                   NegAffLADayLead ~ 
                     # WNegAffLADay +
                     TotalDayg + WeekDay + 
                     Age + Female + RACE3G + BMI + SES_1 + 
                     CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                     # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WNegAffLADay | UID), 
                     (1 | UID), 
                   iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                   backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(m0_lana, paste0(outputdir, "m0_lana", ".RDS"))
