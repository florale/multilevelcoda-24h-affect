source("24h-affect-setup.R")
cilrw <- readRDS(paste0(outputdir, "cilrw", ".RDS"))

# unadj ---------------------
m_hapa_unadj <- brmcoda(cilrw,
                  PosAffHADayLead ~ 
                    bilr1 + bilr2 + bilr3 + bilr4 +
                    wilr1 + wilr2 + wilr3 + wilr4 + 
                    # WPosAffHADay +
                    # TotalDayg + WeekDay + 
                    # Age + Female + RACE3G + BMI + SES_1 + 
                    # CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                    # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WPosAffHADay| UID),
                    (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID),
                  iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                  backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(m_hapa_unadj, paste0(outputdir, "m_hapa_unadj", ".RDS"))

m_lapa_unadj <- brmcoda(cilrw,
                  PosAffLADayLead ~ 
                    bilr1 + bilr2 + bilr3 + bilr4 +
                    wilr1 + wilr2 + wilr3 + wilr4 + 
                    # WPosAffLADay +
                    # TotalDayg + WeekDay + 
                    # Age + Female + RACE3G + BMI + SES_1 + 
                    # CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                    # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WPosAffLADay | UID), 
                    (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                  iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                  backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(m_lapa_unadj, paste0(outputdir, "m_lapa_unadj", ".RDS"))

m_hana_unadj <- brmcoda(cilrw,
                  NegAffHADayLead ~ 
                    bilr1 + bilr2 + bilr3 + bilr4 +
                    wilr1 + wilr2 + wilr3 + wilr4 + 
                    # WNegAffHADay +
                    # TotalDayg + WeekDay + 
                    # Age + Female + RACE3G + BMI + SES_1 + 
                    # CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                    # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WNegAffHADay | UID), 
                    (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                  iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                  backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(m_hana_unadj, paste0(outputdir, "m_hana_unadj", ".RDS"))

m_lana_unadj <- brmcoda(cilrw,
                  NegAffLADayLead ~ 
                    bilr1 + bilr2 + bilr3 + bilr4 +
                    wilr1 + wilr2 + wilr3 + wilr4 + 
                    # WNegAffLADay +
                    # TotalDayg + WeekDay + 
                    # Age + Female + RACE3G + BMI + SES_1 + 
                    # CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                    # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WNegAffLADay | UID), 
                    (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                  iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                  backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(m_lana_unadj, paste0(outputdir, "m_lana_unadj", ".RDS"))

# pivot coordinates -------------------
m_hapa_unadj <- readRDS(paste0(outputdir, "m_hapa_unadj", ".RDS"))
m_lapa_unadj <- readRDS(paste0(outputdir, "m_lapa_unadj", ".RDS"))
m_hana_unadj <- readRDS(paste0(outputdir, "m_hana_unadj", ".RDS"))
m_lana_unadj <- readRDS(paste0(outputdir, "m_lana_unadj", ".RDS"))

# pivot coordinates
m_hapa_unadj_pc <- pivot_coord(m_hapa_unadj, method = "rotate")
m_lapa_unadj_pc <- pivot_coord(m_lapa_unadj, method = "rotate")
m_hana_unadj_pc <- pivot_coord(m_hana_unadj, method = "rotate")
m_lana_unadj_pc <- pivot_coord(m_lana_unadj, method = "rotate")

summary(m_hapa_unadj_pc)
summary(m_lapa_unadj_pc)
summary(m_hana_unadj_pc)
summary(m_lana_unadj_pc)

# sensitivity analysis -------------------
# full ---------------------
m_hapa_sen <- brmcoda(cilrw,
                  PosAffHADayLead ~ 
                    bilr1 + bilr2 + bilr3 + bilr4 +
                    wilr1 + wilr2 + wilr3 + wilr4 + 
                    WPosAffHADayLag +
                    TotalDayg + WeekDay + 
                    # Age + Female + RACE3G + BMI + SES_1 + 
                    # CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                    # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WPosAffHADay| UID),
                    (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID),
                  iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                  backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(m_hapa_sen, paste0(outputdir, "m_hapa_sen", ".RDS"))

m_lapa_sen <- brmcoda(cilrw,
                  PosAffLADayLead ~ 
                    bilr1 + bilr2 + bilr3 + bilr4 +
                    wilr1 + wilr2 + wilr3 + wilr4 + 
                    WPosAffLADayLag +
                    TotalDayg + WeekDay + 
                    # Age + Female + RACE3G + BMI + SES_1 + 
                    # CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                    # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WPosAffLADay | UID), 
                    (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                  iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                  backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(m_lapa_sen, paste0(outputdir, "m_lapa_sen", ".RDS"))

m_hana_sen <- brmcoda(cilrw,
                  NegAffHADayLead ~ 
                    bilr1 + bilr2 + bilr3 + bilr4 +
                    wilr1 + wilr2 + wilr3 + wilr4 + 
                    WNegAffHADayLag +
                    TotalDayg + WeekDay + 
                    # Age + Female + RACE3G + BMI + SES_1 + 
                    # CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                    # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WNegAffHADay | UID), 
                    (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                  iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                  backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(m_hana_sen, paste0(outputdir, "m_hana_sen", ".RDS"))

m_lana_sen <- brmcoda(cilrw,
                  NegAffLADayLead ~ 
                    bilr1 + bilr2 + bilr3 + bilr4 +
                    wilr1 + wilr2 + wilr3 + wilr4 + 
                    WNegAffHADayLag +
                    TotalDayg + WeekDay + 
                    # Age + Female + RACE3G + BMI + SES_1 + 
                    # CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                    # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WNegAffLADay | UID), 
                    (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                  iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                  backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(m_lana_sen, paste0(outputdir, "m_lana_sen", ".RDS"))

# Pivot coordinates -------------------
m_hapa_sen <- readRDS(paste0(outputdir, "m_hapa_sen", ".RDS"))
m_lapa_sen <- readRDS(paste0(outputdir, "m_lapa_sen", ".RDS"))
m_hana_sen <- readRDS(paste0(outputdir, "m_hana_sen", ".RDS"))
m_lana_sen <- readRDS(paste0(outputdir, "m_lana_sen", ".RDS"))

# pivot coordinates
m_hapa_sen_pc <- pivot_coord(m_hapa_sen, method = "rotate")
m_lapa_sen_pc <- pivot_coord(m_lapa_sen, method = "rotate")
m_hana_sen_pc <- pivot_coord(m_hana_sen, method = "rotate")
m_lana_sen_pc <- pivot_coord(m_lana_sen, method = "rotate")

summary(m_hapa_sen_pc)
summary(m_lapa_sen_pc)
summary(m_hana_sen_pc)
summary(m_lana_sen_pc)
