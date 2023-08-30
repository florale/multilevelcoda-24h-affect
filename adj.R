source("data.R")

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
                       Age + Female + RACE3G + BMI + SES_1 + StudyID + DayofWeek +
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
                       Age + Female + RACE3G + BMI + SES_1 + StudyID + DayofWeek +
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
                       Age + Female + RACE3G + BMI + SES_1 + StudyID + DayofWeek +
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

# Wake-Wake - Next day outcome adj for prev day -------------------------
mhapa_ww_lag_adj <- brmcoda(cilrw,
                         PosAffHANextDay ~ bilr1 + bilr2 + bilr3 + bilr4 +
                           wilr1 + wilr2 + wilr3 + wilr4 + 
                           WPosAffHADay + 
                           Age + Female + RACE3G + BMI + SES_1 + StudyID + DayofWeek +
                           CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                           (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                         cores = 4,
                         chains = 4,
                         # iter = 1000,
                         # warmup = 250,
                         seed = 123,
                         backend = "cmdstanr"
)

mlapa_ww_lag_adj <- brmcoda(cilrw,
                         PosAffLANextDay ~ bilr1 + bilr2 + bilr3 + bilr4 +
                           wilr1 + wilr2 + wilr3 + wilr4 + 
                           WPosAffLADay +
                           Age + Female + RACE3G + BMI + SES_1 + StudyID + DayofWeek +
                           CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                           (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                         cores = 4,
                         chains = 4,
                         # iter = 1000,
                         # warmup = 250,
                         seed = 123,
                         backend = "cmdstanr"
)

mhana_ww_lag_adj <- brmcoda(cilrw,
                         NegAffHANextDay ~ bilr1 + bilr2 + bilr3 + bilr4 +
                           wilr1 + wilr2 + wilr3 + wilr4 + 
                           WNegAffHADay +
                           Age + Female + RACE3G + BMI + SES_1 + StudyID + DayofWeek +
                           CurrentWork + CurrentSchool + SmokingStatus + AUDITCat + 
                           (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                         cores = 4,
                         chains = 4,
                         # iter = 1000,
                         # warmup = 250,
                         seed = 123,
                         backend = "cmdstanr"
)

mlana_ww_lag_adj <- brmcoda(cilrw,
                         NegAffLANextDay ~ bilr1 + bilr2 + bilr3 + bilr4 +
                           wilr1 + wilr2 + wilr3 + wilr4 + 
                           WNegAffLADay +
                           Age + Female + RACE3G + BMI + SES_1 + StudyID + DayofWeek +
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
summary(mhapa_ww_lag_adj)
summary(mlapa_ww_lag_adj)
summary(mhana_ww_lag_adj)
summary(mlana_ww_lag_adj)

## substitution
plan(multisession, workers = 5)
mhapa_ww_lag_sub_adj <- substitution(
  mhapa_ww_lag_adj,
  delta = c(1:60),
  # delta = c(30),
  level = c("between", "within"),
  ref = "grandmean")

mlapa_ww_lag_sub_adj <- substitution(
  mlapa_ww_lag_adj,
  delta = c(1:60),
  # delta = c(30),
  level = c("between", "within"),
  ref = "grandmean")

mhana_ww_lag_sub_adj <- substitution(
  mhana_ww_lag_adj,
  delta = c(1:60),
  # delta = c(30),
  level = c("between", "within"),
  ref = "grandmean")

mlana_ww_lag_sub_adj <- substitution(
  mlana_ww_lag_adj,
  delta = c(1:60),
  # delta = c(30),
  level = c("between", "within"),
  ref = "grandmean")

plan(sequential)

## substitution summary 
summary(mhapa_ww_lag_sub_adj, delta = 30)
summary(mlapa_ww_lag_sub_adj, delta = 30)
summary(mhana_ww_lag_sub_adj, delta = 30)
summary(mlana_ww_lag_sub_adj, delta = 30)

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
#                         PosAffHANextDay ~ bilr1 + bilr2 + bilr3 + bilr4 +
#                           wilr1 + wilr2 + wilr3 + wilr4 + 
#                           Age + Female + RACE3G + BMI + SES_1 + StudyID + DayofWeek +
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
#                         PosAffLANextDay ~ bilr1 + bilr2 + bilr3 + bilr4 +
#                           wilr1 + wilr2 + wilr3 + wilr4 +
#                           Age + Female + RACE3G + BMI + SES_1 + StudyID + DayofWeek +
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
#                         NegAffHANextDay ~ bilr1 + bilr2 + bilr3 + bilr4 +
#                           wilr1 + wilr2 + wilr3 + wilr4 +
#                           Age + Female + RACE3G + BMI + SES_1 + StudyID + DayofWeek +
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
#                         NegAffLANextDay ~ bilr1 + bilr2 + bilr3 + bilr4 +
#                           wilr1 + wilr2 + wilr3 + wilr4 +
#                           Age + Female + RACE3G + BMI + SES_1 + StudyID + DayofWeek +
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
#                           Age + Female + RACE3G + BMI + SES_1 + StudyID + DayofWeek +
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
#                           Age + Female + RACE3G + BMI + SES_1 + StudyID + DayofWeek +
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
#                           Age + Female + RACE3G + BMI + SES_1 + StudyID + DayofWeek +
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
#                           Age + Female + RACE3G + BMI + SES_1 + StudyID + DayofWeek +
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
