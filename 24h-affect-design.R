source("24h-affect-data.R")

# Sleep-Sleep - Same day outcome adj for prev day -------------------------
mhapa_ss_lag_adj <- brmcoda(cilrs,
                            PosAffHADay ~ bilr1 + bilr2 + bilr3 + bilr4 +
                              wilr1 + wilr2 + wilr3 + wilr4 +
                              WPosAffHALagDay + 
                              Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                              CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                              (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                            cores = 4,
                            chains = 4,
                            # iter = 1000,
                            # warmup = 250,
                            seed = 123,
                            backend = "cmdstanr"
)
mlapa_ss_lag_adj <- brmcoda(cilrs,
                            PosAffLADay ~ bilr1 + bilr2 + bilr3 + bilr4 +
                              wilr1 + wilr2 + wilr3 + wilr4 +
                              WPosAffLALagDay +
                              Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                              CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                              (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                            cores = 4,
                            chains = 4,
                            # iter = 1000,
                            # warmup = 250,
                            seed = 123,
                            backend = "cmdstanr"
)
mhana_ss_lag_adj <- brmcoda(cilrs,
                            NegAffHADay ~ bilr1 + bilr2 + bilr3 + bilr4 +
                              wilr1 + wilr2 + wilr3 + wilr4 +
                              WNegAffHALagDay +
                              Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                              CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                              (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                            cores = 4,
                            chains = 4,
                            # iter = 1000,
                            # warmup = 250,
                            seed = 123,
                            backend = "cmdstanr"
)
mlana_ss_lag_adj <- brmcoda(cilrs,
                            NegAffLADay ~ bilr1 + bilr2 + bilr3 + bilr4 +
                              wilr1 + wilr2 + wilr3 + wilr4 +
                              WNegAffLALagDay +
                              Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                              CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                              (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                            cores = 4,
                            chains = 4,
                            # iter = 1000,
                            # warmup = 250,
                            seed = 123,
                            backend = "cmdstanr"
)

## brmcoda summary
summary(mhapa_ss_lag_adj)
summary(mlapa_ss_lag_adj)
summary(mhana_ss_lag_adj)
summary(mlana_ss_lag_adj)

## substitution
plan(multisession, workers = 5)
mhapa_ss_lag_sub_adj <- substitution(
  mhapa_ss_lag_adj,
  # delta = c(1:60),
  delta = c(30),
  level = c("between", "within"),
  ref = "grandmean")

mlapa_ss_lag_sub_adj <- substitution(
  mlapa_ss_lag_adj,
  # delta = c(1:60),
  delta = c(30),
  level = c("between", "within"),
  ref = "grandmean")

mhana_ss_lag_sub_adj <- substitution(
  mhana_ss_lag_adj,
  # delta = c(1:60),
  delta = c(30),
  level = c("between", "within"),
  ref = "grandmean")

mlana_ss_lag_sub_adj <- substitution(
  mlana_ss_lag_adj,
  # delta = c(1:60),
  delta = c(30),
  level = c("between", "within"),
  ref = "grandmean")

plan(sequential)

## substitution summary 
summary(mhapa_ss_lag_sub_adj, delta = 30)
summary(mlapa_ss_lag_sub_adj, delta = 30)
summary(mhana_ss_lag_sub_adj, delta = 30)
summary(mlana_ss_lag_sub_adj, delta = 30)

## substitution plot
plot(mhapa_ss_lag_sub_adj, to = "SleepgLagDay", ref = "grandmean", level = "between")
plot(mhapa_ss_lag_sub_adj, to = "WAKEgLagDay", ref = "grandmean", level = "between")
plot(mhapa_ss_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "between")
plot(mhapa_ss_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "between")
plot(mhapa_ss_lag_sub_adj, to = "SBg", ref = "grandmean", level = "between")

plot(mhapa_ss_lag_sub_adj, to = "SleepgLagDay", ref = "grandmean", level = "within")
plot(mhapa_ss_lag_sub_adj, to = "WAKEgLagDay", ref = "grandmean", level = "within")
plot(mhapa_ss_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "within")
plot(mhapa_ss_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "within")
plot(mhapa_ss_lag_sub_adj, to = "SBg", ref = "grandmean", level = "within")


plot(mlapa_ss_lag_sub_adj, to = "SleepgLagDay", ref = "grandmean", level = "between")
plot(mlapa_ss_lag_sub_adj, to = "WAKEgLagDay", ref = "grandmean", level = "between")
plot(mlapa_ss_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "between")
plot(mlapa_ss_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "between")
plot(mlapa_ss_lag_sub_adj, to = "SBg", ref = "grandmean", level = "between")

plot(mlapa_ss_lag_sub_adj, to = "SleepgLagDay", ref = "grandmean", level = "within")
plot(mlapa_ss_lag_sub_adj, to = "WAKEgLagDay", ref = "grandmean", level = "within")
plot(mlapa_ss_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "within")
plot(mlapa_ss_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "within")
plot(mlapa_ss_lag_sub_adj, to = "SBg", ref = "grandmean", level = "within")


plot(mhana_ss_lag_sub_adj, to = "SleepgLagDay", ref = "grandmean", level = "between")
plot(mhana_ss_lag_sub_adj, to = "WAKEgLagDay", ref = "grandmean", level = "between")
plot(mhana_ss_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "between")
plot(mhana_ss_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "between")
plot(mhana_ss_lag_sub_adj, to = "SBg", ref = "grandmean", level = "between")

plot(mhana_ss_lag_sub_adj, to = "SleepgLagDay", ref = "grandmean", level = "within")
plot(mhana_ss_lag_sub_adj, to = "WAKEgLagDay", ref = "grandmean", level = "within")
plot(mhana_ss_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "within")
plot(mhana_ss_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "within")
plot(mhana_ss_lag_sub_adj, to = "SBg", ref = "grandmean", level = "within")


plot(mlana_ss_lag_sub_adj, to = "SleepgLagDay", ref = "grandmean", level = "between")
plot(mlana_ss_lag_sub_adj, to = "WAKEgLagDay", ref = "grandmean", level = "between")
plot(mlana_ss_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "between")
plot(mlana_ss_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "between")
plot(mlana_ss_lag_sub_adj, to = "SBg", ref = "grandmean", level = "between")

plot(mlana_ss_lag_sub_adj, to = "SleepgLagDay", ref = "grandmean", level = "within")
plot(mlana_ss_lag_sub_adj, to = "WAKEgLagDay", ref = "grandmean", level = "within")
plot(mlana_ss_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "within")
plot(mlana_ss_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "within")
plot(mlana_ss_lag_sub_adj, to = "SBg", ref = "grandmean", level = "within")

# Wake-Wake - Next day average outcome adj for prev day (prospective) -------------------------
cilrw <- compilr(d,
                 sbp = sbp,
                 parts = part_ww,
                 idvar = "UID",
                 total = 1440)

mhapa_ww_lag_adj <- brmcoda(cilrw,
                            PosAffHADayLead ~ 
                              bilr1 + bilr2 + bilr3 + bilr4 +
                              wilr1 + wilr2 + wilr3 + wilr4 + 
                              # WPosAffHADay +
                              Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                              CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                              # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WPosAffHADay| UID), 
                              (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                            cores = 4,
                            chains = 4,
                            iter = 6000,
                            warmup = 1000,
                            seed = 123,
                            backend = "cmdstanr"
)

mlapa_ww_lag_adj <- brmcoda(cilrw,
                            PosAffLADayLead ~ 
                              bilr1 + bilr2 + bilr3 + bilr4 +
                              wilr1 + wilr2 + wilr3 + wilr4 + 
                              # WPosAffLADay +
                              Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                              CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                              # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WPosAffLADay | UID), 
                            (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                            cores = 4,
                            chains = 4,
                            iter = 6000,
                            warmup = 1000,
                            seed = 123,
                            backend = "cmdstanr"
)

mhana_ww_lag_adj <- brmcoda(cilrw,
                            NegAffHADayLead ~ 
                              bilr1 + bilr2 + bilr3 + bilr4 +
                              wilr1 + wilr2 + wilr3 + wilr4 + 
                              # WNegAffHADay +
                              Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                              CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                              # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WNegAffHADay | UID), 
                            (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                            cores = 4,
                            chains = 4,
                            iter = 6000,
                            warmup = 1000,
                            seed = 123,
                            backend = "cmdstanr"
)

mlana_ww_lag_adj <- brmcoda(cilrw,
                            NegAffLADayLead ~ 
                              bilr1 + bilr2 + bilr3 + bilr4 +
                              wilr1 + wilr2 + wilr3 + wilr4 + 
                              # WNegAffLADay +
                              Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                              CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                              # (1 + wilr1 + wilr2 + wilr3 + wilr4 + WNegAffLADay | UID), 
                            (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                            cores = 4,
                            chains = 4,
                            iter = 6000,
                            warmup = 1000,
                            seed = 123,
                            backend = "cmdstanr"
)


## brmcoda summary
summary(mhapa_ww_lag_adj)
summary(mlapa_ww_lag_adj)
summary(mhana_ww_lag_adj)
summary(mlana_ww_lag_adj)

## substitution
plan(multisession, workers = 5)
mhapa_ww_lag_sub_adj <- substitution(
  mhapa_ww_lag_adj,
  # delta = c(1:60),
  delta = c(60),
  level = c("between", "within"),
  ref = "grandmean")

mlapa_ww_lag_sub_adj <- substitution(
  mlapa_ww_lag_adj,
  # delta = c(1:60),
  delta = c(60),
  level = c("between", "within"),
  ref = "grandmean")

mhana_ww_lag_sub_adj <- substitution(
  mhana_ww_lag_adj,
  # delta = c(1:60),
  delta = c(60),
  level = c("between", "within"),
  ref = "grandmean")

mlana_ww_lag_sub_adj <- substitution(
  mlana_ww_lag_adj,
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

## substitution plot
plot(mhapa_ww_lag_sub_adj, to = "Sleepg", ref = "grandmean", level = "between")
plot(mhapa_ww_lag_sub_adj, to = "WAKEg", ref = "grandmean", level = "between")
plot(mhapa_ww_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "between")
plot(mhapa_ww_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "between")
plot(mhapa_ww_lag_sub_adj, to = "SBg", ref = "grandmean", level = "between")

plot(mhapa_ww_lag_sub_adj, to = "Sleepg", ref = "grandmean", level = "within")
plot(mhapa_ww_lag_sub_adj, to = "WAKEg", ref = "grandmean", level = "within")
plot(mhapa_ww_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "within")
plot(mhapa_ww_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "within")
plot(mhapa_ww_lag_sub_adj, to = "SBg", ref = "grandmean", level = "within")

plot(mlapa_ww_lag_sub_adj, to = "Sleepg", ref = "grandmean", level = "between")
plot(mlapa_ww_lag_sub_adj, to = "WAKEg", ref = "grandmean", level = "between")
plot(mlapa_ww_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "between")
plot(mlapa_ww_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "between")
plot(mlapa_ww_lag_sub_adj, to = "SBg", ref = "grandmean", level = "between")

plot(mlapa_ww_lag_sub_adj, to = "Sleepg", ref = "grandmean", level = "within")
plot(mlapa_ww_lag_sub_adj, to = "WAKEg", ref = "grandmean", level = "within")
plot(mlapa_ww_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "within")
plot(mlapa_ww_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "within")
plot(mlapa_ww_lag_sub_adj, to = "SBg", ref = "grandmean", level = "within")

plot(mhana_ww_lag_sub_adj, to = "Sleepg", ref = "grandmean", level = "between")
plot(mhana_ww_lag_sub_adj, to = "WAKEg", ref = "grandmean", level = "between")
plot(mhana_ww_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "between")
plot(mhana_ww_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "between")
plot(mhana_ww_lag_sub_adj, to = "SBg", ref = "grandmean", level = "between")

plot(mhana_ww_lag_sub_adj, to = "Sleepg", ref = "grandmean", level = "within")
plot(mhana_ww_lag_sub_adj, to = "WAKEg", ref = "grandmean", level = "within")
plot(mhana_ww_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "within")
plot(mhana_ww_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "within")
plot(mhana_ww_lag_sub_adj, to = "SBg", ref = "grandmean", level = "within")

plot(mlana_ww_lag_sub_adj, to = "Sleepg", ref = "grandmean", level = "between")
plot(mlana_ww_lag_sub_adj, to = "WAKEg", ref = "grandmean", level = "between")
plot(mlana_ww_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "between")
plot(mlana_ww_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "between")
plot(mlana_ww_sub_adj, to = "SBg", ref = "grandmean", level = "between")

plot(mlana_ww_lag_sub_adj, to = "Sleepg", ref = "grandmean", level = "within")
plot(mlana_ww_lag_sub_adj, to = "WAKEg", ref = "grandmean", level = "within")
plot(mlana_ww_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "within")
plot(mlana_ww_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "within")
plot(mlana_ww_lag_sub_adj, to = "SBg", ref = "grandmean", level = "within")



# Wake-Wake - Sameday average outcome adj for prev day (concurrent) -------------------------
cilrwc <- compilr(d, sbp = sbp,
                  idvar = "UID",
                  parts = part_ww, total = 1440)
mhapa_wc_lag_adj <- brmcoda(cilrwc,
                            PosAffHADay ~ 
                              bilr1 + bilr2 + bilr3 + bilr4 +
                              wilr1 + wilr2 + wilr3 + wilr4 + 
                              WPosAffHADayLag + 
                              Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                              CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                              (1 + wilr1 + wilr2 + wilr3 + wilr4 + WPosAffHADayLag| UID), 
                            cores = 4,
                            chains = 4,
                            iter = 3000,
                            # warmup = 250,
                            seed = 123,
                            backend = "cmdstanr"
)

mlapa_wc_lag_adj <- brmcoda(cilrwc,
                            PosAffLADay ~ 
                              bilr1 + bilr2 + bilr3 + bilr4 +
                              wilr1 + wilr2 + wilr3 + wilr4 + 
                              WPosAffLADayLag +
                              Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                              CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                              (1 + wilr1 + wilr2 + wilr3 + wilr4 + WPosAffLADayLag | UID), 
                            cores = 4,
                            chains = 4,
                            iter = 3000,
                            # warmup = 250,
                            seed = 123,
                            backend = "cmdstanr"
)

mhana_wc_lag_adj <- brmcoda(cilrwc,
                            NegAffHADay ~ 
                              bilr1 + bilr2 + bilr3 + bilr4 +
                              wilr1 + wilr2 + wilr3 + wilr4 + 
                              WNegAffHADayLag +
                              Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                              CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                              (1 + wilr1 + wilr2 + wilr3 + wilr4 + WNegAffHADayLag | UID), 
                            cores = 4,
                            chains = 4,
                            iter = 3000,
                            # warmup = 250,
                            seed = 123,
                            backend = "cmdstanr"
)

mlana_wc_lag_adj <- brmcoda(cilrwc,
                            NegAffLADay ~ 
                              bilr1 + bilr2 + bilr3 + bilr4 +
                              wilr1 + wilr2 + wilr3 + wilr4 + 
                              WNegAffLADayLag +
                              Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                              CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                              (1 + wilr1 + wilr2 + wilr3 + wilr4 + WNegAffLADayLag | UID), 
                            cores = 4,
                            chains = 4,
                            iter = 3000,
                            # warmup = 250,
                            seed = 123,
                            backend = "cmdstanr"
)


## brmcoda summary
summary(mhapa_wc_lag_adj)
summary(mlapa_wc_lag_adj)
summary(mhana_wc_lag_adj)
summary(mlana_wc_lag_adj)

## substitution
plan(multisession, workers = 5)
mhapa_wc_lag_sub_adj <- substitution(
  mhapa_wc_lag_adj,
  # delta = c(1:60),
  delta = c(60),
  level = c("between", "within"),
  ref = "grandmean")

mlapa_wc_lag_sub_adj <- substitution(
  mlapa_wc_lag_adj,
  # delta = c(1:60),
  delta = c(60),
  level = c("between", "within"),
  ref = "grandmean")

mhana_wc_lag_sub_adj <- substitution(
  mhana_wc_lag_adj,
  # delta = c(1:60),
  delta = c(60),
  level = c("between", "within"),
  ref = "grandmean")

mlana_wc_lag_sub_adj <- substitution(
  mlana_wc_lag_adj,
  # delta = c(1:60),
  delta = c(60),
  level = c("between", "within"),
  ref = "grandmean")
plan(sequential)

## substitution summary 
summary(mhapa_wc_lag_sub_adj, delta = 60)
summary(mlapa_wc_lag_sub_adj, delta = 60)
summary(mhana_wc_lag_sub_adj, delta = 60)
summary(mlana_wc_lag_sub_adj, delta = 60)

## substitution plot
plot(mhapa_ww_lag_sub_adj, to = "Sleepg", ref = "grandmean", level = "between")
plot(mhapa_ww_lag_sub_adj, to = "WAKEg", ref = "grandmean", level = "between")
plot(mhapa_ww_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "between")
plot(mhapa_ww_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "between")
plot(mhapa_ww_lag_sub_adj, to = "SBg", ref = "grandmean", level = "between")

plot(mhapa_ww_lag_sub_adj, to = "Sleepg", ref = "grandmean", level = "within")
plot(mhapa_ww_lag_sub_adj, to = "WAKEg", ref = "grandmean", level = "within")
plot(mhapa_ww_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "within")
plot(mhapa_ww_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "within")
plot(mhapa_ww_lag_sub_adj, to = "SBg", ref = "grandmean", level = "within")


plot(mlapa_ww_lag_sub_adj, to = "Sleepg", ref = "grandmean", level = "between")
plot(mlapa_ww_lag_sub_adj, to = "WAKEg", ref = "grandmean", level = "between")
plot(mlapa_ww_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "between")
plot(mlapa_ww_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "between")
plot(mlapa_ww_lag_sub_adj, to = "SBg", ref = "grandmean", level = "between")

plot(mlapa_ww_lag_sub_adj, to = "Sleepg", ref = "grandmean", level = "within")
plot(mlapa_ww_lag_sub_adj, to = "WAKEg", ref = "grandmean", level = "within")
plot(mlapa_ww_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "within")
plot(mlapa_ww_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "within")
plot(mlapa_ww_lag_sub_adj, to = "SBg", ref = "grandmean", level = "within")


plot(mhana_ww_lag_sub_adj, to = "Sleepg", ref = "grandmean", level = "between")
plot(mhana_ww_lag_sub_adj, to = "WAKEg", ref = "grandmean", level = "between")
plot(mhana_ww_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "between")
plot(mhana_ww_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "between")
plot(mhana_ww_lag_sub_adj, to = "SBg", ref = "grandmean", level = "between")

plot(mhana_ww_lag_sub_adj, to = "Sleepg", ref = "grandmean", level = "within")
plot(mhana_ww_lag_sub_adj, to = "WAKEg", ref = "grandmean", level = "within")
plot(mhana_ww_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "within")
plot(mhana_ww_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "within")
plot(mhana_ww_lag_sub_adj, to = "SBg", ref = "grandmean", level = "within")


plot(mlana_ww_lag_sub_adj, to = "Sleepg", ref = "grandmean", level = "between")
plot(mlana_ww_lag_sub_adj, to = "WAKEg", ref = "grandmean", level = "between")
plot(mlana_ww_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "between")
plot(mlana_ww_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "between")
plot(mlana_ww_sub_adj, to = "SBg", ref = "grandmean", level = "between")

plot(mlana_ww_lag_sub_adj, to = "Sleepg", ref = "grandmean", level = "within")
plot(mlana_ww_lag_sub_adj, to = "WAKEg", ref = "grandmean", level = "within")
plot(mlana_ww_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "within")
plot(mlana_ww_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "within")
plot(mlana_ww_lag_sub_adj, to = "SBg", ref = "grandmean", level = "within")


# Sleep-Sleep - Pre sleep outcome adj for prev survey -------------------------
cilrse <- compilr(ds[Survey == "Evening"], 
                  sbp = sbp, 
                  idvar = "UID",
                  parts = part_ss, 
                  total = 1440)
mhapa_se_lag_adj <- brmcoda(cilrse,
                            PosAffHA ~ bilr1 + bilr2 + bilr3 + bilr4 +
                              wilr1 + wilr2 + wilr3 + wilr4 +
                              # WPosAffHADayLag +
                              Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                              CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                              (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                            cores = 4,
                            chains = 4,
                            # iter = 1000,
                            # warmup = 250,
                            seed = 123,
                            backend = "cmdstanr"
)
mlapa_se_lag_adj <- brmcoda(cilrse,
                            PosAffLA ~ bilr1 + bilr2 + bilr3 + bilr4 +
                              wilr1 + wilr2 + wilr3 + wilr4 +
                              # WPosAffLADayLag +
                              Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                              CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                              (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                            cores = 4,
                            chains = 4,
                            # iter = 1000,
                            # warmup = 250,
                            seed = 123,
                            backend = "cmdstanr"
)
mhana_se_lag_adj <- brmcoda(cilrse,
                            NegAffHA ~ bilr1 + bilr2 + bilr3 + bilr4 +
                              wilr1 + wilr2 + wilr3 + wilr4 +
                              # WNegAffHADayLag +
                              Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                              CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                              (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                            cores = 4,
                            chains = 4,
                            # iter = 1000,
                            # warmup = 250,
                            seed = 123,
                            backend = "cmdstanr"
)
mlana_se_lag_adj <- brmcoda(cilrse,
                            NegAffLA ~ bilr1 + bilr2 + bilr3 + bilr4 +
                              wilr1 + wilr2 + wilr3 + wilr4 +
                              # WNegAffLADayLag +
                              Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                              CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                              (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                            cores = 4,
                            chains = 4,
                            # iter = 1000,
                            # warmup = 250,
                            seed = 123,
                            backend = "cmdstanr"
)

## brmcoda summary
summary(mhapa_se_lag_adj)
summary(mlapa_se_lag_adj)
summary(mhana_se_lag_adj)
summary(mlana_se_lag_adj)

## substitution
plan(multisession, workers = 5)
mhapa_se_lag_sub_adj <- substitution(
  mhapa_se_lag_adj,
  # delta = c(1:60),
  delta = c(30),
  level = c("between", "within"),
  ref = "grandmean")

mlapa_se_lag_sub_adj <- substitution(
  mlapa_se_lag_adj,
  # delta = c(1:60),
  delta = c(30),
  level = c("between", "within"),
  ref = "grandmean")

mhana_se_lag_sub_adj <- substitution(
  mhana_se_lag_adj,
  # delta = c(1:60),
  delta = c(30),
  level = c("between", "within"),
  ref = "grandmean")

mlana_se_lag_sub_adj <- substitution(
  mlana_se_lag_adj,
  # delta = c(1:60),
  delta = c(30),
  level = c("between", "within"),
  ref = "grandmean")
plan(sequential)

## substitution summary 
summary(mhapa_se_lag_sub_adj, delta = 30)
summary(mlapa_se_lag_sub_adj, delta = 30)
summary(mhana_se_lag_sub_adj, delta = 30)
summary(mlana_se_lag_sub_adj, delta = 30)

# Sleep-Sleep - Pre sleep outcome -------------------------
cilrse <- compilr(
  ds[Survey == "Evening"],
  sbp = sbp,
  idvar = "UID",
  parts = part_ss,
  total = 1440
)
mhapa_ss_lag_adj <- brmcoda(cilrse,
                            PosAffHA ~ bilr1 + bilr2 + bilr3 + bilr4 +
                              wilr1 + wilr2 + wilr3 + wilr4 +
                              # WPosAffHAlag1 + 
                              Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                              CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                              (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                            cores = 4,
                            chains = 4,
                            # iter = 1000,
                            # warmup = 250,
                            seed = 123,
                            backend = "cmdstanr"
)
mlapa_ss_lag_adj <- brmcoda(cilrse,
                            PosAffLA ~ bilr1 + bilr2 + bilr3 + bilr4 +
                              wilr1 + wilr2 + wilr3 + wilr4 +
                              # WPosAffLAlag1 +
                              Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                              CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                              (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                            cores = 4,
                            chains = 4,
                            # iter = 1000,
                            # warmup = 250,
                            seed = 123,
                            backend = "cmdstanr"
)
mhana_ss_lag_adj <- brmcoda(cilrse,
                            NegAffHA ~ bilr1 + bilr2 + bilr3 + bilr4 +
                              wilr1 + wilr2 + wilr3 + wilr4 +
                              # WNegAffHAlag1 +
                              Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                              CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                              (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                            cores = 4,
                            chains = 4,
                            # iter = 1000,
                            # warmup = 250,
                            seed = 123,
                            backend = "cmdstanr"
)
mlana_ss_lag_adj <- brmcoda(cilrse,
                            NegAffLA ~ bilr1 + bilr2 + bilr3 + bilr4 +
                              wilr1 + wilr2 + wilr3 + wilr4 +
                              # WNegAffLAlag1 +
                              Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                              CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                              (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                            cores = 4,
                            chains = 4,
                            # iter = 1000,
                            # warmup = 250,
                            seed = 123,
                            backend = "cmdstanr"
)

## brmcoda summary
summary(mhapa_ss_lag_adj)
summary(mlapa_ss_lag_adj)
summary(mhana_ss_lag_adj)
summary(mlana_ss_lag_adj)

## substitution
plan(multisession, workers = 5)
mhapa_ss_lag_sub_adj <- substitution(
  mhapa_ss_lag_adj,
  # delta = c(1:60),
  delta = c(30),
  level = c("between", "within"),
  ref = "grandmean")

mlapa_ss_lag_sub_adj <- substitution(
  mlapa_ss_lag_adj,
  # delta = c(1:60),
  delta = c(30),
  level = c("between", "within"),
  ref = "grandmean")

mhana_ss_lag_sub_adj <- substitution(
  mhana_ss_lag_adj,
  # delta = c(1:60),
  delta = c(30),
  level = c("between", "within"),
  ref = "grandmean")

mlana_ss_lag_sub_adj <- substitution(
  mlana_ss_lag_adj,
  # delta = c(1:60),
  delta = c(30),
  level = c("between", "within"),
  ref = "grandmean")

plan(sequential)

## substitution summary 
summary(mhapa_ss_lag_sub_adj, delta = 30)
summary(mlapa_ss_lag_sub_adj, delta = 30)
summary(mhana_ss_lag_sub_adj, delta = 30)
summary(mlana_ss_lag_sub_adj, delta = 30)

# Wake-Wake - Next day morning outcome adj for prev day -------------------------
cilrwm <- compilr(d[Survey == "Morning"], sbp = sbp,
                  idvar = "UID",
                  parts = part_ww, total = 1440)
mhapa_wm_lag_adj <- brmcoda(cilrw,
                            PosAffHALead ~
                              bilr1 + bilr2 + bilr3 + bilr4 +
                              wilr1 + wilr2 + wilr3 + wilr4 +
                              # WPosAffHADay +
                              Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                              CurrentWork + CurrentSchool + SmokingStatus + AUDITCat +
                              (1 + wilr1 + wilr2 + wilr3 + wilr4| UID),
                            cores = 4,
                            chains = 4,
                            iter = 3000,
                            # warmup = 250,
                            seed = 123,
                            backend = "cmdstanr"
)

mlapa_wm_lag_adj <- brmcoda(cilrw,
                            PosAffLADayLead ~
                              bilr1 + bilr2 + bilr3 + bilr4 +
                              wilr1 + wilr2 + wilr3 + wilr4 +
                              # WPosAffLADay +
                              Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                              CurrentWork + CurrentSchool + SmokingStatus + AUDITCat +
                              (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID),
                            cores = 4,
                            chains = 4,
                            iter = 3000,
                            # warmup = 250,
                            seed = 123,
                            backend = "cmdstanr"
)

mhana_wm_lag_adj <- brmcoda(cilrw,
                            NegAffHADayLead ~
                              bilr1 + bilr2 + bilr3 + bilr4 +
                              wilr1 + wilr2 + wilr3 + wilr4 +
                              # WNegAffHADay +
                              Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                              CurrentWork + CurrentSchool + SmokingStatus + AUDITCat +
                              (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID),
                            cores = 4,
                            chains = 4,
                            iter = 3000,
                            # warmup = 250,
                            seed = 123,
                            backend = "cmdstanr"
)

mlana_wm_lag_adj <- brmcoda(cilrw,
                            NegAffLADayLead ~
                              bilr1 + bilr2 + bilr3 + bilr4 +
                              wilr1 + wilr2 + wilr3 + wilr4 +
                              # WNegAffLADay +
                              Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                              CurrentWork + CurrentSchool + SmokingStatus + AUDITCat +
                              (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID),
                            cores = 4,
                            chains = 4,
                            iter = 3000,
                            # warmup = 250,
                            seed = 123,
                            backend = "cmdstanr"
)


## brmcoda summary
summary(mhapa_wm_lag_adj)
summary(mlapa_wm_lag_adj)
summary(mhana_wm_lag_adj)
summary(mlana_wm_lag_adj)

## substitution
plan(multisession, workers = 5)
mhapa_wm_lag_sub_adj <- substitution(
  mhapa_wm_lag_adj,
  # delta = c(1:60),
  delta = c(60),
  level = c("between", "within"),
  ref = "grandmean")

mlapa_wm_lag_sub_adj <- substitution(
  mlapa_wm_lag_adj,
  # delta = c(1:60),
  delta = c(60),
  level = c("between", "within"),
  ref = "grandmean")

mhana_wm_lag_sub_adj <- substitution(
  mhana_wm_lag_adj,
  # delta = c(1:60),
  delta = c(60),
  level = c("between", "within"),
  ref = "grandmean")

mlana_wm_lag_sub_adj <- substitution(
  mlana_wm_lag_adj,
  # delta = c(1:60),
  delta = c(60),
  level = c("between", "within"),
  ref = "grandmean")
plan(sequential)

## substitution summary
summary(mhapa_wm_lag_sub_adj, delta = 60)
summary(mlapa_wm_lag_sub_adj, delta = 60)
summary(mhana_wm_lag_sub_adj, delta = 60)
summary(mlana_wm_lag_sub_adj, delta = 60)

## substitution plot
plot(mhapa_ww_lag_sub_adj, to = "Sleepg", ref = "grandmean", level = "between")
plot(mhapa_ww_lag_sub_adj, to = "WAKEg", ref = "grandmean", level = "between")
plot(mhapa_ww_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "between")
plot(mhapa_ww_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "between")
plot(mhapa_ww_lag_sub_adj, to = "SBg", ref = "grandmean", level = "between")

plot(mhapa_ww_lag_sub_adj, to = "Sleepg", ref = "grandmean", level = "within")
plot(mhapa_ww_lag_sub_adj, to = "WAKEg", ref = "grandmean", level = "within")
plot(mhapa_ww_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "within")
plot(mhapa_ww_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "within")
plot(mhapa_ww_lag_sub_adj, to = "SBg", ref = "grandmean", level = "within")


plot(mlapa_ww_lag_sub_adj, to = "Sleepg", ref = "grandmean", level = "between")
plot(mlapa_ww_lag_sub_adj, to = "WAKEg", ref = "grandmean", level = "between")
plot(mlapa_ww_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "between")
plot(mlapa_ww_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "between")
plot(mlapa_ww_lag_sub_adj, to = "SBg", ref = "grandmean", level = "between")

plot(mlapa_ww_lag_sub_adj, to = "Sleepg", ref = "grandmean", level = "within")
plot(mlapa_ww_lag_sub_adj, to = "WAKEg", ref = "grandmean", level = "within")
plot(mlapa_ww_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "within")
plot(mlapa_ww_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "within")
plot(mlapa_ww_lag_sub_adj, to = "SBg", ref = "grandmean", level = "within")


plot(mhana_ww_lag_sub_adj, to = "Sleepg", ref = "grandmean", level = "between")
plot(mhana_ww_lag_sub_adj, to = "WAKEg", ref = "grandmean", level = "between")
plot(mhana_ww_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "between")
plot(mhana_ww_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "between")
plot(mhana_ww_lag_sub_adj, to = "SBg", ref = "grandmean", level = "between")

plot(mhana_ww_lag_sub_adj, to = "Sleepg", ref = "grandmean", level = "within")
plot(mhana_ww_lag_sub_adj, to = "WAKEg", ref = "grandmean", level = "within")
plot(mhana_ww_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "within")
plot(mhana_ww_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "within")
plot(mhana_ww_lag_sub_adj, to = "SBg", ref = "grandmean", level = "within")


plot(mlana_ww_lag_sub_adj, to = "Sleepg", ref = "grandmean", level = "between")
plot(mlana_ww_lag_sub_adj, to = "WAKEg", ref = "grandmean", level = "between")
plot(mlana_ww_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "between")
plot(mlana_ww_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "between")
plot(mlana_ww_sub_adj, to = "SBg", ref = "grandmean", level = "between")

plot(mlana_ww_lag_sub_adj, to = "Sleepg", ref = "grandmean", level = "within")
plot(mlana_ww_lag_sub_adj, to = "WAKEg", ref = "grandmean", level = "within")
plot(mlana_ww_lag_sub_adj, to = "MVPAg", ref = "grandmean", level = "within")
plot(mlana_ww_lag_sub_adj, to = "LPAg", ref = "grandmean", level = "within")
plot(mlana_ww_lag_sub_adj, to = "SBg", ref = "grandmean", level = "within")



# # Wake-Wake - Next day outcome -------------------------
# mhapa_ww_adj <- brmcoda(cilrw,
#                         PosAffHADayLead ~ bilr1 + bilr2 + bilr3 + bilr4 +
#                           wilr1 + wilr2 + wilr3 + wilr4 + 
#                           Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
#                           CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
#                           (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
#                         cores = 4,
#                         chains = 4,
#                         # iter = 1000,
#                         # warmup = 250,
#                         seed = 123,
#                         backend = "cmdstanr"
# )
# 
# mlapa_ww_adj <- brmcoda(cilrw,
#                         PosAffLADayLead ~ bilr1 + bilr2 + bilr3 + bilr4 +
#                           wilr1 + wilr2 + wilr3 + wilr4 +
#                           Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
#                           CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
#                           (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
#                         cores = 4,
#                         chains = 4,
#                         # iter = 1000,
#                         # warmup = 250,
#                         seed = 123,
#                         backend = "cmdstanr"
# )
# 
# mhana_ww_adj <- brmcoda(cilrw,
#                         NegAffHADayLead ~ bilr1 + bilr2 + bilr3 + bilr4 +
#                           wilr1 + wilr2 + wilr3 + wilr4 +
#                           Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
#                           CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
#                           (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
#                         cores = 4,
#                         chains = 4,
#                         # iter = 1000,
#                         # warmup = 250,
#                         seed = 123,
#                         backend = "cmdstanr"
# )
# 
# mlana_ww_adj <- brmcoda(cilrw,
#                         NegAffLADayLead ~ bilr1 + bilr2 + bilr3 + bilr4 +
#                           wilr1 + wilr2 + wilr3 + wilr4 +
#                           Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
#                           CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
#                           (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
#                         cores = 4,
#                         chains = 4,
#                         # iter = 1000,
#                         # warmup = 250,
#                         seed = 123,
#                         backend = "cmdstanr"
# )
# 
# 
# ## brmcoda summary
# summary(mhapa_ww_adj)
# summary(mlapa_ww_adj)
# summary(mhana_ww_adj)
# summary(mlana_ww_adj)
# 
# ## substitution
# plan(multisession, workers = 5)
# mhapa_ww_sub_adj <- substitution(
#   mhapa_ww_adj,
#   delta = c(1:60),
#   # delta = c(30),
#   level = c("between", "within"),
#   ref = "grandmean")
# 
# mlapa_ww_sub_adj <- substitution(
#   mlapa_ww_adj,
#   delta = c(1:60),
#   # delta = c(30),
#   level = c("between", "within"),
#   ref = "grandmean")
# 
# mhana_ww_sub_adj <- substitution(
#   mhana_ww_adj,
#   delta = c(1:60),
#   # delta = c(30),
#   level = c("between", "within"),
#   ref = "grandmean")
# 
# mlana_ww_sub_adj <- substitution(
#   mlana_ww_adj,
#   delta = c(1:60),
#   # delta = c(30),
#   level = c("between", "within"),
#   ref = "grandmean")
# 
# plan(sequential)
# 
# ## substitution summary 
# summary(mhapa_ww_sub_adj, delta = 30)
# summary(mlapa_ww_sub_adj, delta = 30)
# summary(mhana_ww_sub_adj, delta = 30)
# summary(mlana_ww_sub_adj, delta = 30)
# 
# ## substitution plot
# plot(mhapa_ww_sub_adj, to = "Sleepg", ref = "grandmean", level = "between")
# plot(mhapa_ww_sub_adj, to = "WAKEg", ref = "grandmean", level = "between")
# plot(mhapa_ww_sub_adj, to = "MVPAg", ref = "grandmean", level = "between")
# plot(mhapa_ww_sub_adj, to = "LPAg", ref = "grandmean", level = "between")
# plot(mhapa_ww_sub_adj, to = "SBg", ref = "grandmean", level = "between")
# 
# plot(mhapa_ww_sub_adj, to = "Sleepg", ref = "grandmean", level = "within")
# plot(mhapa_ww_sub_adj, to = "WAKEg", ref = "grandmean", level = "within")
# plot(mhapa_ww_sub_adj, to = "MVPAg", ref = "grandmean", level = "within")
# plot(mhapa_ww_sub_adj, to = "LPAg", ref = "grandmean", level = "within")
# plot(mhapa_ww_sub_adj, to = "SBg", ref = "grandmean", level = "within")
# 
# 
# plot(mlapa_ww_sub_adj, to = "Sleepg", ref = "grandmean", level = "between")
# plot(mlapa_ww_sub_adj, to = "WAKEg", ref = "grandmean", level = "between")
# plot(mlapa_ww_sub_adj, to = "MVPAg", ref = "grandmean", level = "between")
# plot(mlapa_ww_sub_adj, to = "LPAg", ref = "grandmean", level = "between")
# plot(mlapa_ww_sub_adj, to = "SBg", ref = "grandmean", level = "between")
# 
# plot(mlapa_ww_sub_adj, to = "Sleepg", ref = "grandmean", level = "within")
# plot(mlapa_ww_sub_adj, to = "WAKEg", ref = "grandmean", level = "within")
# plot(mlapa_ww_sub_adj, to = "MVPAg", ref = "grandmean", level = "within")
# plot(mlapa_ww_sub_adj, to = "LPAg", ref = "grandmean", level = "within")
# plot(mlapa_ww_sub_adj, to = "SBg", ref = "grandmean", level = "within")
# 
# 
# plot(mhana_ww_sub_adj, to = "Sleepg", ref = "grandmean", level = "between")
# plot(mhana_ww_sub_adj, to = "WAKEg", ref = "grandmean", level = "between")
# plot(mhana_ww_sub_adj, to = "MVPAg", ref = "grandmean", level = "between")
# plot(mhana_ww_sub_adj, to = "LPAg", ref = "grandmean", level = "between")
# plot(mhana_ww_sub_adj, to = "SBg", ref = "grandmean", level = "between")
# 
# plot(mhana_ww_sub_adj, to = "Sleepg", ref = "grandmean", level = "within")
# plot(mhana_ww_sub_adj, to = "WAKEg", ref = "grandmean", level = "within")
# plot(mhana_ww_sub_adj, to = "MVPAg", ref = "grandmean", level = "within")
# plot(mhana_ww_sub_adj, to = "LPAg", ref = "grandmean", level = "within")
# plot(mhana_ww_sub_adj, to = "SBg", ref = "grandmean", level = "within")
# 
# 
# plot(mlana_ww_sub_adj, to = "Sleepg", ref = "grandmean", level = "between")
# plot(mlana_ww_sub_adj, to = "WAKEg", ref = "grandmean", level = "between")
# plot(mlana_ww_sub_adj, to = "MVPAg", ref = "grandmean", level = "between")
# plot(mlana_ww_sub_adj, to = "LPAg", ref = "grandmean", level = "between")
# plot(mlana_ww_sub_adj, to = "SBg", ref = "grandmean", level = "between")
# 
# plot(mlana_ww_sub_adj, to = "Sleepg", ref = "grandmean", level = "within")
# plot(mlana_ww_sub_adj, to = "WAKEg", ref = "grandmean", level = "within")
# plot(mlana_ww_sub_adj, to = "MVPAg", ref = "grandmean", level = "within")
# plot(mlana_ww_sub_adj, to = "LPAg", ref = "grandmean", level = "within")
# plot(mlana_ww_sub_adj, to = "SBg", ref = "grandmean", level = "within")
# 
# 
# # Sleep-Sleep - Same day outcome -------------------------
# mhapa_ss_adj <- brmcoda(cilrs,
#                         PosAffHADay ~ bilr1 + bilr2 + bilr3 + bilr4 +
#                           wilr1 + wilr2 + wilr3 + wilr4 +
#                           Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
#                           CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
#                           (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
#                         cores = 4,
#                         chains = 4,
#                         # iter = 1000,
#                         # warmup = 250,
#                         seed = 123,
#                         backend = "cmdstanr"
# )
# mlapa_ss_adj <- brmcoda(cilrs,
#                         PosAffLADay ~ bilr1 + bilr2 + bilr3 + bilr4 +
#                           wilr1 + wilr2 + wilr3 + wilr4 +
#                           Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
#                           CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
#                           (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
#                         cores = 4,
#                         chains = 4,
#                         # iter = 1000,
#                         # warmup = 250,
#                         seed = 123,
#                         backend = "cmdstanr"
# )
# mhana_ss_adj <- brmcoda(cilrs,
#                         NegAffHADay ~ bilr1 + bilr2 + bilr3 + bilr4 +
#                           wilr1 + wilr2 + wilr3 + wilr4 +
#                           Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
#                           CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
#                           (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
#                         cores = 4,
#                         chains = 4,
#                         # iter = 1000,
#                         # warmup = 250,
#                         seed = 123,
#                         backend = "cmdstanr"
# )
# mlana_ss_adj <- brmcoda(cilrs,
#                         NegAffLADay ~ bilr1 + bilr2 + bilr3 + bilr4 +
#                           wilr1 + wilr2 + wilr3 + wilr4 +
#                           Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
#                           CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
#                           (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
#                         cores = 4,
#                         chains = 4,
#                         # iter = 1000,
#                         # warmup = 250,
#                         seed = 123,
#                         backend = "cmdstanr"
# )
# 
# ## brmcoda summary
# summary(mhapa_ss_adj)
# summary(mlapa_ss_adj)
# summary(mhana_ss_adj)
# summary(mlana_ss_adj)
# 
# ## substitution
# plan(multisession, workers = 5)
# mhapa_ss_sub_adj <- substitution(
#   mhapa_ss_adj,
#   delta = c(1:60),
#   # delta = c(30),
#   level = c("between", "within"),
#   ref = "grandmean")
# 
# mlapa_ss_sub_adj <- substitution(
#   mlapa_ss_adj,
#   delta = c(1:60),
#   # delta = c(30),
#   level = c("between", "within"),
#   ref = "grandmean")
# 
# mhana_ss_sub_adj <- substitution(
#   mhana_ss_adj,
#   delta = c(1:60),
#   # delta = c(30),
#   level = c("between", "within"),
#   ref = "grandmean")
# 
# mlana_ss_sub_adj <- substitution(
#   mlana_ss_adj,
#   delta = c(1:60),
#   # delta = c(30),
#   level = c("between", "within"),
#   ref = "grandmean")
# plan(sequential)
# 
# ## substitution summary 
# summary(mhapa_ss_sub_adj, delta = 60)
# summary(mlapa_ss_sub_adj, delta = 60)
# summary(mhana_ss_sub_adj, delta = 60)
# summary(mlana_ss_sub_adj, delta = 60)
# 
# ## substitution plot
# plot(mhapa_ss_sub_adj, to = "SleepgLagDay", ref = "grandmean", level = "between")
# plot(mhapa_ss_sub_adj, to = "WAKEgLagDay", ref = "grandmean", level = "between")
# plot(mhapa_ss_sub_adj, to = "MVPAg", ref = "grandmean", level = "between")
# plot(mhapa_ss_sub_adj, to = "LPAg", ref = "grandmean", level = "between")
# plot(mhapa_ss_sub_adj, to = "SBg", ref = "grandmean", level = "between")
# 
# plot(mhapa_ss_sub_adj, to = "SleepgLagDay", ref = "grandmean", level = "within")
# plot(mhapa_ss_sub_adj, to = "WAKEgLagDay", ref = "grandmean", level = "within")
# plot(mhapa_ss_sub_adj, to = "MVPAg", ref = "grandmean", level = "within")
# plot(mhapa_ss_sub_adj, to = "LPAg", ref = "grandmean", level = "within")
# plot(mhapa_ss_sub_adj, to = "SBg", ref = "grandmean", level = "within")
# 
# 
# plot(mlapa_ss_sub_adj, to = "SleepgLagDay", ref = "grandmean", level = "between")
# plot(mlapa_ss_sub_adj, to = "WAKEgLagDay", ref = "grandmean", level = "between")
# plot(mlapa_ss_sub_adj, to = "MVPAg", ref = "grandmean", level = "between")
# plot(mlapa_ss_sub_adj, to = "LPAg", ref = "grandmean", level = "between")
# plot(mlapa_ss_sub_adj, to = "SBg", ref = "grandmean", level = "between")
# 
# plot(mlapa_ss_sub_adj, to = "SleepgLagDay", ref = "grandmean", level = "within")
# plot(mlapa_ss_sub_adj, to = "WAKEgLagDay", ref = "grandmean", level = "within")
# plot(mlapa_ss_sub_adj, to = "MVPAg", ref = "grandmean", level = "within")
# plot(mlapa_ss_sub_adj, to = "LPAg", ref = "grandmean", level = "within")
# plot(mlapa_ss_sub_adj, to = "SBg", ref = "grandmean", level = "within")
# 
# 
# plot(mhana_ss_sub_adj, to = "SleepgLagDay", ref = "grandmean", level = "between")
# plot(mhana_ss_sub_adj, to = "WAKEgLagDay", ref = "grandmean", level = "between")
# plot(mhana_ss_sub_adj, to = "MVPAg", ref = "grandmean", level = "between")
# plot(mhana_ss_sub_adj, to = "LPAg", ref = "grandmean", level = "between")
# plot(mhana_ss_sub_adj, to = "SBg", ref = "grandmean", level = "between")
# 
# plot(mhana_ss_sub_adj, to = "SleepgLagDay", ref = "grandmean", level = "within")
# plot(mhana_ss_sub_adj, to = "WAKEgLagDay", ref = "grandmean", level = "within")
# plot(mhana_ss_sub_adj, to = "MVPAg", ref = "grandmean", level = "within")
# plot(mhana_ss_sub_adj, to = "LPAg", ref = "grandmean", level = "within")
# plot(mhana_ss_sub_adj, to = "SBg", ref = "grandmean", level = "within")
# 
# 
# plot(mlana_ss_sub_adj, to = "SleepgLagDay", ref = "grandmean", level = "between")
# plot(mlana_ss_sub_adj, to = "WAKEgLagDay", ref = "grandmean", level = "between")
# plot(mlana_ss_sub_adj, to = "MVPAg", ref = "grandmean", level = "between")
# plot(mlana_ss_sub_adj, to = "LPAg", ref = "grandmean", level = "between")
# plot(mlana_ss_sub_adj, to = "SBg", ref = "grandmean", level = "between")
# 
# plot(mlana_ss_sub_adj, to = "SleepgLagDay", ref = "grandmean", level = "within")
# plot(mlana_ss_sub_adj, to = "WAKEgLagDay", ref = "grandmean", level = "within")
# plot(mlana_ss_sub_adj, to = "MVPAg", ref = "grandmean", level = "within")
# plot(mlana_ss_sub_adj, to = "LPAg", ref = "grandmean", level = "within")
# plot(mlana_ss_sub_adj, to = "SBg", ref = "grandmean", level = "within")
# 


# # Sleep - Sleep - Evening outcome
mhapa_ss_lag1_adj <- brmcoda(cilre,
                             PosAffHA ~ bilr1 + bilr2 + bilr3 + bilr4 +
                               wilr1 + wilr2 + wilr3 + wilr4 +
                               # WPosAffHALag1 + 
                               Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                               CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                               (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                             cores = 4,
                             chains = 4,
                             # iter = 1000,
                             # warmup = 250,
                             seed = 123,
                             backend = "cmdstanr"
)
mlapa_ss_lag1_adj <- brmcoda(cilre,
                             PosAffLA ~ bilr1 + bilr2 + bilr3 + bilr4 +
                               wilr1 + wilr2 + wilr3 + wilr4 +
                               # WPosAffLALag1 + 
                               Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                               CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                               (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                             cores = 4,
                             chains = 4,
                             # iter = 1000,
                             # warmup = 250,
                             seed = 123,
                             backend = "cmdstanr"
)
mhana_ss_lag1_adj <- brmcoda(cilre,
                             NegAffHA ~ bilr1 + bilr2 + bilr3 + bilr4 +
                               wilr1 + wilr2 + wilr3 + wilr4 +
                               # WNegAffHALag1 + 
                               Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                               CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                               (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                             cores = 4,
                             chains = 4,
                             # iter = 1000,
                             # warmup = 250,
                             seed = 123,
                             backend = "cmdstanr"
)
mlana_ss_lag1_adj <- brmcoda(cilre,
                             NegAffLA ~ bilr1 + bilr2 + bilr3 + bilr4 +
                               wilr1 + wilr2 + wilr3 + wilr4 +
                               # WNegAffLALag1 + 
                               Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                               CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                               (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                             cores = 4,
                             chains = 4,
                             # iter = 1000,
                             # warmup = 250,
                             seed = 123,
                             backend = "cmdstanr"
)
plan(multisession, workers = 5)
mhapa_ss_lag1_sub_adj <- substitution(
  mhapa_ss_lag1_adj,
  # delta = c(1:60),
  delta = c(30),
  level = c("between", "within"),
  ref = "grandmean")
mlapa_ss_lag1_sub_adj <- substitution(
  mlapa_ss_lag1_adj,
  # delta = c(1:60),
  delta = c(30),
  level = c("between", "within"),
  ref = "grandmean")
mhana_ss_lag1_sub_adj <- substitution(
  mhana_ss_lag1_adj,
  # delta = c(1:60),
  delta = c(30),
  level = c("between", "within"),
  ref = "grandmean")
mlana_ss_lag1_sub_adj <- substitution(
  mlana_ss_lag1_adj,
  # delta = c(1:60),
  delta = c(30),
  level = c("between", "within"),
  ref = "grandmean")
plan(sequential)

summary(mhapa_ss_lag1_sub_adj)
summary(mlapa_ss_lag1_sub_adj)
summary(mhana_ss_lag1_sub_adj)
summary(mlana_ss_lag1_sub_adj)

## # Wake-wake - Morning outcome

mhapa_ww_lag1_adj <- brmcoda(cilrm,
                             PosAffHA ~ bilr1 + bilr2 + bilr3 + bilr4 +
                               wilr1 + wilr2 + wilr3 + wilr4 +
                               # WPosAffHALag1 + 
                               Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                               CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                               (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                             cores = 4,
                             chains = 4,
                             # iter = 1000,
                             # warmup = 250,
                             seed = 123,
                             backend = "cmdstanr"
)
mlapa_ww_lag1_adj <- brmcoda(cilrm,
                             PosAffLA ~ bilr1 + bilr2 + bilr3 + bilr4 +
                               wilr1 + wilr2 + wilr3 + wilr4 +
                               # WPosAffLALag1 + 
                               Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                               CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                               (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                             cores = 4,
                             chains = 4,
                             # iter = 1000,
                             # warmup = 250,
                             seed = 123,
                             backend = "cmdstanr"
)
mhana_ww_lag1_adj <- brmcoda(cilrm,
                             NegAffHA ~ bilr1 + bilr2 + bilr3 + bilr4 +
                               wilr1 + wilr2 + wilr3 + wilr4 +
                               # WNegAffHALag1 + 
                               Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                               CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                               (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                             cores = 4,
                             chains = 4,
                             # iter = 1000,
                             # warmup = 250,
                             seed = 123,
                             backend = "cmdstanr"
)
mlana_ww_lag1_adj <- brmcoda(cilrm,
                             NegAffLA ~ bilr1 + bilr2 + bilr3 + bilr4 +
                               wilr1 + wilr2 + wilr3 + wilr4 +
                               # WNegAffLALag1 + 
                               Age + Female + RACE3G + BMI + SES_1 + StudyID + WeekDay +
                               CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                               (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                             cores = 4,
                             chains = 4,
                             # iter = 1000,
                             # warmup = 250,
                             seed = 123,
                             backend = "cmdstanr"
)
plan(multisession, workers = 5)
mhapa_ww_lag1_sub_adj <- substitution(
  mhapa_ss_lag1_adj,
  # delta = c(1:60),
  delta = c(30),
  level = c("between", "within"),
  ref = "grandmean")
mlapa_ww_lag1_sub_adj <- substitution(
  mlapa_ss_lag1_adj,
  # delta = c(1:60),
  delta = c(30),
  level = c("between", "within"),
  ref = "grandmean")
mhana_ww_lag1_sub_adj <- substitution(
  mhana_ss_lag1_adj,
  # delta = c(1:60),
  delta = c(30),
  level = c("between", "within"),
  ref = "grandmean")
mlana_ww_lag1_sub_adj <- substitution(
  mlana_ss_lag1_adj,
  # delta = c(1:60),
  delta = c(30),
  level = c("between", "within"),
  ref = "grandmean")
plan(sequential)

summary(mhapa_ww_lag1_sub_adj)
summary(mlapa_ww_lag1_sub_adj)
summary(mhana_ww_lag1_sub_adj)
summary(mlana_ww_lag1_sub_adj)


# # projection
# 
# cv_varsel(
#   m_hapa$Model,
#   # formula = formula(m_hapa$Model),
#   formula = PosAffHADayLead ~ bilr1 + bilr2 + bilr3 + bilr4 + wilr1 + wilr2 + wilr3 + wilr4,
#   data = m_hapa$Model$data,
#   latent = TRUE,
#   dis = as.matrix(m_hapa$Model)[, "sigma"]
# )

