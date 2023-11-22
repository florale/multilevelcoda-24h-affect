source("data.R")
# Wake-Wake - Next day average outcome (prospective) -------------------------

cilrw <- compilr(d,
                 sbp = sbp,
                 parts = part_ww,
                 idvar = "UID",
                 total = 1440)

## sub model ---------------
m_hapa_sub <- brmcoda(cilrw,
                  PosAffHADayLead ~ 
                    bilr1 + bilr2 + bilr3 + bilr4 +
                    wilr1 + wilr2 + wilr3 + wilr4 + 
                    # WPosAffHADay +
                    TotalDayg +
                    Age + Female + RACE3G + BMI + SES_1 + WeekDay +
                    CurrentWork + CurrentSchool + SmokingStatus + AUDITCat +
                    # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WPosAffHADay| UID),
                    (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID),
                  iter = 6000, chains = 4, cores = 4, seed = 123, warmup = 1000,
                  backend = "cmdstanr")

m_lapa_sub <- brmcoda(cilrw,
                  PosAffLADayLead ~ 
                    bilr1 + bilr2 + bilr3 + bilr4 +
                    wilr1 + wilr2 + wilr3 + wilr4 + 
                    # WPosAffLADay +
                    TotalDayg +
                    Age + Female + RACE3G + BMI + SES_1 + WeekDay +
                    CurrentWork + CurrentSchool + SmokingStatus + AUDITCat +
                    # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WPosAffLADay | UID), 
                    (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                  iter = 6000, chains = 4, cores = 4, seed = 123, warmup = 1000,
                  backend = "cmdstanr")

m_hana_sub <- brmcoda(cilrw,
                  NegAffHADayLead ~ 
                    bilr1 + bilr2 + bilr3 + bilr4 +
                    wilr1 + wilr2 + wilr3 + wilr4 + 
                    # WNegAffHADay +
                    TotalDayg +
                    Age + Female + RACE3G + BMI + SES_1 + WeekDay +
                    CurrentWork + CurrentSchool + SmokingStatus + AUDITCat +
                    # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WNegAffHADay | UID), 
                    (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                  iter = 6000, chains = 4, cores = 4, seed = 123, warmup = 1000,
                  backend = "cmdstanr")

m_lana_sub <- brmcoda(cilrw,
                  NegAffLADayLead ~ 
                    bilr1 + bilr2 + bilr3 + bilr4 +
                    wilr1 + wilr2 + wilr3 + wilr4 + 
                    # WNegAffLADay +
                    TotalDayg +
                    Age + Female + RACE3G + BMI + SES_1 + WeekDay +
                    CurrentWork + CurrentSchool + SmokingStatus + AUDITCat +
                    # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WNegAffLADay | UID), 
                    (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                  iter = 6000, chains = 4, cores = 4, seed = 123, warmup = 1000,
                  backend = "cmdstanr")

## brmcoda summary
summary(m_hapa_sub)
summary(m_lapa_sub)
summary(m_hana_sub)
summary(m_lana_sub)

## substitution
plan(multisession, workers = 5)
mhapa_ww_lag_sub_adj <- substitution(
  m_hapa_sub,
  # delta = c(1:60),
  delta = c(60),
  level = c("between", "within"),
  ref = "grandmean")

mlapa_ww_lag_sub_adj <- substitution(
  m_lapa_sub,
  # delta = c(1:60),
  delta = c(60),
  level = c("between", "within"),
  ref = "grandmean")

mhana_ww_lag_sub_adj <- substitution(
  m_hana_sub,
  # delta = c(1:60),
  delta = c(60),
  level = c("between", "within"),
  ref = "grandmean")

mlana_ww_lag_sub_adj <- substitution(
  mlana_sub,
  # delta = c(1:60),
  delta = c(60),
  level = c("between", "within"),
  ref = "grandmean")
plan(sequential)

## substitution summary 
summary(mhapa_ww_lag_sub_adj, delta = 60)
summary(mlapa_ww_lag_sub_adj, delta = 60)
summary(mhana_ww_lag_sub_adj, delta = 60)
summary(mlana_ww_lag_sub_adj, delta = 60)
