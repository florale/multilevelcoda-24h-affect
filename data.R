library(data.table)
library(extraoperators)
library(compositions)
library(zCompositions)
library(multilevelcoda)
library(brms)
library(cmdstanr)
library(insight)
library(MASS)
library(bayestestR)

library(doFuture)
library(foreach)
library(parallel)
library(doRNG)
library(future)
library(multilevelTools)
library(JWileymisc)
library(bayesplot)

shs <- as.data.table(readRDS("/Volumes/shared/Behavioral-med-lab/StressHealthStudy/SHS Research Interns/Data/shs_all_ggir.RDS"))
destress <- as.data.table(readRDS("/Volumes/shared/Behavioral-med-lab/DESTRESSStudy/Data/destress_all_ggir.RDS"))
aces <- as.data.table(readRDS("/Volumes/shared/Behavioral-med-lab/ACESStudy/Data/aces_all_ggir.RDS"))

parts <- c("Sleepg", "WAKEg", "MVPAg", "LPAg", "SBg")

setnames(shs, "Sex", "Female")
setnames(shs, "RACE3G", "RACE")

d <- rbind(shs[, .(
  ID, UID = paste0("S", ID), SurveyDay, Survey, USURVEYID, DayofWeek,
  
  # Covariates
  Age, Female, RACE, BMI, SES_1, 
  CurrentWork, CurrentSchool, DEDUUniPlus, SmokingStatus, AUDITCat, rMEQ,
  
  # Affect
  PosAffHA, PosAffLA, NegAffHA, NegAffLA,
  PosAffHADay, PosAffLADay, NegAffHADay, NegAffLADay,
  PosAffHANextDay, PosAffLANextDay, NegAffHANextDay, NegAffLANextDay,
  PosAffHALag1, PosAffLALag1, NegAffHALag1, NegAffLALag1,
  
  BPosAffHA, BPosAffLA, BNegAffHA, BNegAffLA,
  WPosAffHA, WPosAffLA, WNegAffHA, WNegAffLA,
  
  WPosAffHADay, WPosAffLADay, WNegAffHADay, WNegAffLADay,
  WPosAffHANextDay, WPosAffLANextDay, WNegAffHANextDay, WNegAffLANextDay,
  WPosAffHALag1, WPosAffLALag1, WNegAffHALag1, WNegAffLALag1,
  
  # Stress
  STRESS, STRESSDay, STRESSNextDay, STRESSLag1,
  BSTRESS, WSTRESS, WSTRESSDay, WSTRESSNextDay, WSTRESSLag1,
  
  # Behaviours
  Sleepg, WAKEg, MVPAg, LPAg, SBg
)],
destress[, .(
  ID, UID = paste0("S", ID), SurveyDay, Survey, USURVEYID, DayofWeek,
  
  # Covariates
  Age, Female, RACE, BMI, SES_1, 
  CurrentWork, CurrentSchool, DEDUUniPlus, SmokingStatus, AUDITCat, rMEQ,
  
  # Affect
  PosAffHA, PosAffLA, NegAffHA, NegAffLA,
  PosAffHADay, PosAffLADay, NegAffHADay, NegAffLADay,
  PosAffHANextDay, PosAffLANextDay, NegAffHANextDay, NegAffLANextDay,
  PosAffHALag1, PosAffLALag1, NegAffHALag1, NegAffLALag1,
  
  BPosAffHA, BPosAffLA, BNegAffHA, BNegAffLA,
  WPosAffHA, WPosAffLA, WNegAffHA, WNegAffLA,
  
  WPosAffHADay, WPosAffLADay, WNegAffHADay, WNegAffLADay,
  WPosAffHANextDay, WPosAffLANextDay, WNegAffHANextDay, WNegAffLANextDay,
  WPosAffHALag1, WPosAffLALag1, WNegAffHALag1, WNegAffLALag1,
  
  # Stress
  STRESS, STRESSDay, STRESSNextDay, STRESSLag1,
  BSTRESS, WSTRESS, WSTRESSDay, WSTRESSNextDay, WSTRESSLag1,
  
  # Behaviours
  Sleepg, WAKEg, MVPAg, LPAg, SBg
)],
aces[, .(
  ID, UID = paste0("S", ID), SurveyDay, Survey, USURVEYID, DayofWeek,
  
  # Covariates
  Age, Female, RACE, BMI, SES_1, 
  CurrentWork, CurrentSchool, DEDUUniPlus, SmokingStatus, AUDITCat, rMEQ,
  
  # Affect
  PosAffHA, PosAffLA, NegAffHA, NegAffLA,
  PosAffHADay, PosAffLADay, NegAffHADay, NegAffLADay,
  PosAffHANextDay, PosAffLANextDay, NegAffHANextDay, NegAffLANextDay,
  PosAffHALag1, PosAffLALag1, NegAffHALag1, NegAffLALag1,
  
  BPosAffHA, BPosAffLA, BNegAffHA, BNegAffLA,
  WPosAffHA, WPosAffLA, WNegAffHA, WNegAffLA,
  
  WPosAffHADay, WPosAffLADay, WNegAffHADay, WNegAffLADay,
  WPosAffHANextDay, WPosAffLANextDay, WNegAffHANextDay, WNegAffLANextDay,
  WPosAffHALag1, WPosAffLALag1, WNegAffHALag1, WNegAffLALag1,
  
  # Stress
  STRESS, STRESSDay, STRESSNextDay, STRESSLag1,
  BSTRESS, WSTRESS, WSTRESSDay, WSTRESSNextDay, WSTRESSLag1,
  
  # Behaviours
  Sleepg, WAKEg, MVPAg, LPAg, SBg
)]
)

# get lag day
d[, c("SleepgLagDay", "WAKEgLagDay", "MVPAgLagDay", "LPAgLagDay", "SBgLagDay") :=
    .SD[.(UID = UID, Survey = Survey, SurveyDay = SurveyDay - 1),
        .(Sleepg, WAKEg, MVPAg, LPAg, SBg),
        on = c("UID", "SurveyDay", "Survey")]]

d[, c("PosAffHALagDay", "PosAffLALagDay", "NegAffHALagDay", "NegAffLALagDay", "STRESSLagDay") :=
    .SD[.(UID = UID, Survey = Survey, SurveyDay = SurveyDay - 1),
        .(PosAffHADay, PosAffLADay, NegAffHADay, NegAffLADay, STRESSDay),
        on = c("UID", "SurveyDay", "Survey")]]

d[, c("WPosAffHALagDay", "WPosAffLALagDay", "WNegAffHALagDay", "WNegAffLALagDay", "WSTRESSLagDay") :=
    .SD[.(UID = UID, Survey = Survey, SurveyDay = SurveyDay - 1),
        .(WPosAffHADay, WPosAffLADay, WNegAffHADay, WNegAffLADay, WSTRESSDay),
        on = c("UID", "SurveyDay", "Survey")]]

# get lead day
d[, c("PosAffHANextDay", "PosAffLANextDay", "NegAffHANextDay", "NegAffLANextDay", "STRESSNextDay") :=
    .SD[.(UID = UID, Survey = Survey, SurveyDay = SurveyDay + 1),
        .(PosAffHADay, PosAffLADay, NegAffHADay, NegAffLADay, STRESSDay),
        on = c("UID", "SurveyDay", "Survey")]]

# recode covariates
d[, RACE3G := NA]
d[, RACE3G := ifelse(RACE == "Asian", "Asian", RACE3G)]
d[, RACE3G := ifelse(RACE == "White/European", "White/European", RACE3G)]
d[, RACE3G := ifelse(RACE %in% c("Other", "Indian subcontinent", "Indigenous or Torres Strait Islander"), "Other", RACE3G)]
d[, RACE3G := as.factor(RACE3G)]

d[, AUDITCat := as.factor(AUDITCat)]

d[, CurrentWork := as.integer(CurrentWork == "Working")]
d[, SmokingStatus := as.integer(SmokingStatus == "Never")]
d[, CurrentSchool := as.integer(CurrentSchool == "In School")]


# composition
sbp <- matrix(c(
  1, 1, -1,-1, -1,
  1, -1, 0, 0, 0,
  0, 0, 1, -1, -1,
  0, 0, 0, 1, -1), ncol = 5, byrow = TRUE)

d <- d[complete.cases(d[, .(Sleepg, WAKEg, MVPAg, LPAg, SBg)])]
part_ww <- c("Sleepg", "WAKEg", "MVPAg", "LPAg", "SBg")

# impute 0
composition_imp <- lrEM(d[, parts, with = FALSE], label = 0,dl = rep(1,5), ini.cov = "multRepl")
d <- cbind(d[, -parts, with = FALSE], composition_imp)

# wake-wake composition
cilrw <- compilr(d,
                sbp = sbp,
                parts = part_ww,
                idvar = "UID",
                total = 1440)

# sleep-sleep composition
part_ss <- c("SleepgLagDay", "WAKEgLagDay", "MVPAg", "LPAg", "SBg")
ds <- d[complete.cases(d[, .(SleepgLagDay, WAKEgLagDay, MVPAg, LPAg, SBg)])]

# impute 0
composition_ss_imp <- lrEM(ds[, part_ss, with = FALSE], label = 0,dl = rep(1,5), ini.cov = "multRepl")
ds <- cbind(ds[, -part_ss, with = FALSE], composition_ss_imp)

cilrs <- compilr(ds,
                 sbp = sbp,
                 parts = part_ss,
                 idvar = "UID",
                 total = 1440)
