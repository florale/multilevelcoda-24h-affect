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

d <- rbind(shs[, .(ID, UID = paste0("S", ID), SurveyDay, Survey, USURVEYID,
                   PosAffHA, PosAffLA, NegAffHA, NegAffLA,
                   PosAffHADay, PosAffLADay, NegAffHADay, NegAffLADay,
                   PosAffHANextDay, PosAffLANextDay, NegAffHANextDay, NegAffLANextDay,
                   PosAffHALag1, PosAffLALag1, NegAffHALag1, NegAffLALag1,
                   STRESS, STRESSDay, STRESSNextDay, STRESSLag1,
                   Sleepg, WAKEg, MVPAg, LPAg, SBg,
                   Age, Female, DEDUUniPlus, RACE, BMI, SES_1, CurrentWork, CurrentSchool, DEDUUniPlus, SmokingStatus, AUDITCat, rMEQ
)],
destress[, .(ID, UID = paste0("D", ID), SurveyDay, Survey, USURVEYID,
             PosAffHA, PosAffLA, NegAffHA, NegAffLA,
             PosAffHADay, PosAffLADay, NegAffHADay, NegAffLADay,
             PosAffHANextDay, PosAffLANextDay, NegAffHANextDay, NegAffLANextDay,
             PosAffHALag1, PosAffLALag1, NegAffHALag1, NegAffLALag1,
             STRESS, STRESSDay, STRESSNextDay, STRESSLag1,
             Sleepg, WAKEg, MVPAg, LPAg, SBg,
             Age, Female, DEDUUniPlus, RACE, BMI, SES_1, CurrentWork, CurrentSchool, DEDUUniPlus, SmokingStatus, AUDITCat, rMEQ
             
)],
aces[, .(ID, UID = paste0("A", ID), SurveyDay, Survey, USURVEYID,
         PosAffHA, PosAffLA, NegAffHA, NegAffLA,
         PosAffHADay, PosAffLADay, NegAffHADay, NegAffLADay,
         PosAffHANextDay, PosAffLANextDay, NegAffHANextDay, NegAffLANextDay,
         PosAffHALag1, PosAffLALag1, NegAffHALag1, NegAffLALag1,
         STRESS, STRESSDay, STRESSNextDay, STRESSLag1,
         Sleepg, WAKEg, MVPAg, LPAg, SBg,
         Age, Female, DEDUUniPlus, RACE, BMI, SES_1, CurrentWork, CurrentSchool, DEDUUniPlus, SmokingStatus, AUDITCat, rMEQ
)]
)

# get lag day
d[, c("PosAffHALagDay", "PosAffLALagDay", "NegAffHALagDay", "NegAffLALagDay", "STRESSLagDay") :=
    .SD[.(UID = UID, Survey = Survey, SurveyDay = SurveyDay - 1),
        .(PosAffHADay, PosAffLADay, NegAffHADay, NegAffLADay, STRESSDay),
        on = c("UID", "SurveyDay", "Survey")]]

# get lead day
d[, c("PosAffHANextDay", "PosAffLANextDay", "NegAffHANextDay", "NegAffLANextDay", "STRESSNextDay") :=
    .SD[.(UID = UID, Survey = Survey, SurveyDay = SurveyDay + 1),
        .(PosAffHADay, PosAffLADay, NegAffHADay, NegAffLADay, STRESSDay),
        on = c("UID", "SurveyDay", "Survey")]]

# recode race
d[, RACE3G := NA]
d[, RACE3G := ifelse(RACE == "Asian", "Asian", RACE3G)]
d[, RACE3G := ifelse(RACE == "White/European", "White/European", RACE3G)]
d[, RACE3G := ifelse(RACE %in% c("Other", "Indian subcontinent", "Indigenous or Torres Strait Islander"), "Other", RACE3G)]
d[, RACE3G := as.factor(RACE3G)]

d <- d[complete.cases(d[, .(Sleepg, WAKEg, MVPAg, LPAg, SBg)])]

# impute 0
composition_imp <- lrEM(d[, parts, with = FALSE], label = 0,dl = rep(1,5), ini.cov = "multRepl")
d <- cbind(d[, -parts, with = FALSE], composition_imp)

# make composition
sbp <- matrix(c(
  1, 1, -1,-1, -1,
  1, -1, 0, 0, 0,
  0, 0, 1, -1, -1,
  0, 0, 0, 1, -1), ncol = 5, byrow = TRUE)

cilr <- compilr(d,
                sbp = sbp,
                parts = parts,
                idvar = "UID",
                total = 1440)

