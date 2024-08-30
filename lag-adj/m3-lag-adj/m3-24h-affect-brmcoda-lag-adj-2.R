library(data.table)
library(extraoperators)
library(compositions)
library(multilevelcoda)
library(brms)
library(cmdstanr)
library(insight)

library(doFuture)
library(foreach)
library(parallel)
library(doRNG)
library(future)
library(loo)

cilrw <- readRDS("cilrw.RDS")

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
saveRDS(mb_hapa_lag_adj, paste0("mb_hapa_lag_adj", ".RDS"))

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
saveRDS(mb_lapa_lag_adj, paste0("mb_lapa_lag_adj", ".RDS"))

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
saveRDS(mb_hana_lag_adj, paste0("mb_hana_lag_adj", ".RDS"))

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
saveRDS(mb_lana_lag_adj, paste0("mb_lana_lag_adj", ".RDS"))

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
saveRDS(mw_hapa_lag_adj, paste0("mw_hapa_lag_adj", ".RDS"))

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
saveRDS(mw_lapa_lag_adj, paste0("mw_lapa_lag_adj", ".RDS"))

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
saveRDS(mw_hana_lag_adj, paste0("mw_hana_lag_adj", ".RDS"))

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
saveRDS(mw_lana_lag_adj, paste0("mw_lana_lag_adj", ".RDS"))

