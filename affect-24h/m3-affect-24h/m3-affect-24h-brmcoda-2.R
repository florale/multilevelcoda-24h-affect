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

cilrs <- readRDS("cilrs.RDS")

# models -----------------
m_hana_24h <- brmcoda(cilrs,
                      mvbind(ilr1, ilr2, ilr3, ilr4) ~
                        BNegAffHADay + WNegAffHADay +
                        WeekDay + TotalDayg +
                        Age + Female + RACE3G + BMI + SES_1 +
                        CurrentWork + CurrentSchool + SmokingStatus + AUDITCat +
                        (1 + WNegAffHADay | UID),
                      iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                      backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(m_hana_24h, paste0("m_hana_24h", ".RDS"))

m_lana_24h <- brmcoda(cilrs,
                      mvbind(ilr1, ilr2, ilr3, ilr4) ~
                        BNegAffLADay + WNegAffLADay +
                        WeekDay + TotalDayg +
                        Age + Female + RACE3G + BMI + SES_1 +
                        CurrentWork + CurrentSchool + SmokingStatus + AUDITCat +
                        (1 + WNegAffLADay | UID),
                      iter = 6000, chains = 8, cores = 8, seed = 123, warmup = 1000,
                      backend = "cmdstanr", save_pars = save_pars(all = TRUE))
saveRDS(m_lana_24h, paste0("m_lana_24h", ".RDS"))
