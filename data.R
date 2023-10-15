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
  ID, UID = paste0("S", ID), StudyID = "S",
  SurveyDay, Survey, USURVEYID, DayofWeek,
  
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
  ID, UID = paste0("D", ID), StudyID = "D",
  SurveyDay, Survey, USURVEYID, DayofWeek,
  
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
  ID, UID = paste0("A", ID), StudyID = "A",
  SurveyDay, Survey, USURVEYID, DayofWeek,
  
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
d[, USURVEYUID := 1:.N, by = .(UID)]

# daily average outcomes
d[, STRESSDay := mean(STRESS, na.rm = TRUE),
  by = .(UID, SurveyDay)]
d[, PosAffHADay := mean(PosAffHA, na.rm = TRUE),
  by = .(UID, SurveyDay)]
d[, PosAffLADay := mean(PosAffLA, na.rm = TRUE),
  by = .(UID, SurveyDay)]
d[, NegAffHADay := mean(NegAffHA, na.rm = TRUE),
  by = .(UID, SurveyDay)]
d[, NegAffLADay := mean(NegAffLA, na.rm = TRUE),
  by = .(UID, SurveyDay)]
d[Survey %in% c("Wake", "Morning", "Afternoon"), STRESSDay := NA_real_]
d[Survey %in% c("Wake", "Morning", "Afternoon"), PosAffHADay := NA_real_]
d[Survey %in% c("Wake", "Morning", "Afternoon"), PosAffLADay := NA_real_]
d[Survey %in% c("Wake", "Morning", "Afternoon"), NegAffHADay := NA_real_]
d[Survey %in% c("Wake", "Morning", "Afternoon"), NegAffLADay := NA_real_]

d[, c("BPosAffHADay", "WPosAffHADay") := meanDeviations(PosAffHADay), by = UID]
d[, c("BPosAffLADay", "WPosAffLADay") := meanDeviations(PosAffLADay), by = UID]
d[, c("BNegAffHADay", "WNegAffHADay") := meanDeviations(NegAffHADay), by = UID]
d[, c("BNegAffLADay", "WNegAffLADay") := meanDeviations(NegAffLADay), by = UID]
d[, c("BSTRESSDay", "WSTRESSDay") := meanDeviations(STRESSDay), by = UID]

# lag day
d[, c("SleepgDayLag", "WAKEgDayLag", "MVPAgDayLag", "LPAgDayLag", "SBgDayLag") :=
    .SD[.(UID = UID, Survey = Survey, SurveyDay = SurveyDay - 1),
        .(Sleepg, WAKEg, MVPAg, LPAg, SBg),
        on = c("UID", "SurveyDay", "Survey")]]

d[, c("PosAffHADayLag", "PosAffLADayLag", "NegAffHADayLag", "NegAffLADayLag", "STRESSDayLag") :=
    .SD[.(UID = UID, Survey = Survey, SurveyDay = SurveyDay - 1),
        .(PosAffHADay, PosAffLADay, NegAffHADay, NegAffLADay, STRESSDay),
        on = c("UID", "SurveyDay", "Survey")]]

d[, c("WPosAffHADayLag", "WPosAffLADayLag", "WNegAffHADayLag", "WNegAffLADayLag", "WSTRESSDayLag") :=
    .SD[.(UID = UID, Survey = Survey, SurveyDay = SurveyDay - 1),
        .(WPosAffHADay, WPosAffLADay, WNegAffHADay, WNegAffLADay, WSTRESSDay),
        on = c("UID", "SurveyDay", "Survey")]]

# lead day
d[, c("PosAffHADayLead", "PosAffLADayLead", "NegAffHADayLead", "NegAffLADayLead", "STRESSDayLead") :=
    .SD[.(UID = UID, Survey = Survey, SurveyDay = SurveyDay + 1),
        .(PosAffHADay, PosAffLADay, NegAffHADay, NegAffLADay, STRESSDay),
        on = c("UID", "SurveyDay", "Survey")]]

d[, c("SleepgDayLead", "WAKEgDayLead", "MVPAgDayLead", "LPAgDayLead", "SBgDayLead") :=
    .SD[.(UID = UID, Survey = Survey, SurveyDay = SurveyDay + 1),
        .(Sleepg, WAKEg, MVPAg, LPAg, SBg),
        on = c("UID", "SurveyDay", "Survey")]]

d[, c("PosAffHALead", "PosAffLALead", "NegAffHALead", "NegAffLALead", "STRESSLead") :=
    .SD[.(UID = UID, Survey = Survey, SurveyDay = SurveyDay + 1),
        .(PosAffHA, PosAffLA, NegAffHA, NegAffLA, STRESS),
        on = c("UID", "SurveyDay", "Survey")]] 

# lag of lead day by survey
d[, c("PosAffHALeadLag1", "PosAffLALeadLag1", "NegAffHALeadLag1", "NegAffLALeadLag1", "STRESSLeadLag1") :=
    .SD[.(UID = UID, USURVEYUID = USURVEYUID - 1),
        .(PosAffHALead, PosAffLALead, NegAffHALead, NegAffLALead, STRESSLead),
        on = c("UID", "USURVEYUID")]]

d[, c("PosAffHALeadLag2", "PosAffLALeadLag2", "NegAffHALeadLag2", "NegAffLALeadLag2", "STRESSLeadLag2") :=
    .SD[.(UID = UID, USURVEYUID = USURVEYUID - 2),
        .(PosAffHALead, PosAffLALead, NegAffHALead, NegAffLALead, STRESSLead),
        on = c("UID", "USURVEYUID")]]

d[, c("BPosAffHALead", "WPosAffHALead") := meanDeviations(PosAffHALead), by = UID]
d[, c("BPosAffLALead", "WPosAffLALead") := meanDeviations(PosAffLALead), by = UID]
d[, c("BNegAffHALead", "WNegAffHALead") := meanDeviations(NegAffHALead), by = UID]
d[, c("BNegAffLALead", "WNegAffLALead") := meanDeviations(NegAffLALead), by = UID]
d[, c("BSTRESSLead", "WSTRESSLead") := meanDeviations(STRESSLead), by = UID]

# lag of lead day by survey decomposed
d[, c("WPosAffHALeadLag1", "WPosAffLALeadLag1", "WNegAffHALeadLag1", "WNegAffLALeadLag1", "WSTRESSLeadLag1",
      "BPosAffHALeadLag1", "BPosAffLALeadLag1", "BNegAffHALeadLag1", "BNegAffLALeadLag1", "BSTRESSLeadLag1") :=
    .SD[.(UID = UID, USURVEYUID = USURVEYUID - 1),
        .(WPosAffHALead, WPosAffLALead, WNegAffHALead, WNegAffLALead, WSTRESSLead,
          BPosAffHALead, BPosAffLALead, BNegAffHALead, BNegAffLALead, BSTRESSLead
        ),
        on = c("UID", "USURVEYUID")]]

View(d[, .(ID, UID, USURVEYUID, SurveyDay, Survey, PosAffHADay, PosAffHADayLag, PosAffHALead, WPosAffHADay, WPosAffHADayLag, PosAffHADayLead, Sleepg)])

# recode covariates
d[, RACE3G := NA]
d[, RACE3G := ifelse(RACE == "Asian", "Asian", RACE3G)]
d[, RACE3G := ifelse(RACE == "White/European", "White/European", RACE3G)]
d[, RACE3G := ifelse(RACE %in% c("Other", "Indian subcontinent", "Indigenous or Torres Strait Islander"), "Other", RACE3G)]
d[, RACE3G := as.factor(RACE3G)]

d[, WeekDay := NA]
d[, WeekDay := ifelse(DayofWeek %in% c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday"), 1, WeekDay)]
d[, WeekDay := ifelse(DayofWeek %in% c("Saturday", "Sunday"), 0, WeekDay)]

d[, AUDITCat := as.factor(AUDITCat)]
d[, StudyID := as.factor(StudyID)]

d[, CurrentWork := as.integer(CurrentWork == "Working")]
d[, SmokingStatus := as.integer(SmokingStatus == "Never")]
d[, CurrentSchool := as.integer(CurrentSchool == "In School")]

sbp <- matrix(c(
  1, 1, -1,-1, -1,
  1, -1, 0, 0, 0,
  0, 0, 1, -1, -1,
  0, 0, 0, 1, -1), ncol = 5, byrow = TRUE)

# use complete data and non-zeros
d <- d[complete.cases(d[, .(Sleepg, WAKEg, MVPAg, LPAg, SBg)])]
d <- d[ WAKEg > 0]

# d <- d[0 %nin% c(Sleepg, WAKEg, MVPAg, LPAg, SBg,
#                  SleepgDayLag, WAKEgDayLag,
#                  SleepgNextDay, WAKEgNextDay, MVPAgNextDay, LPAgNextDay, SBgNextDay)]

part_ww <- c("Sleepg", "WAKEg", "MVPAg", "LPAg", "SBg")

# check
zPatterns(d[Survey == "Wake", part_ww, with = FALSE], label = NA)
zPatterns(d[, part_ww, with = FALSE], label = 0)


# impute 0
# composition_imp <- lrEM(d[, parts, with = FALSE], label = 0,dl = rep(1,5))
# d <- cbind(d[, -parts, with = FALSE], composition_imp)

# wake-wake composition

cilrm <- compilr(d[Survey == "Morning"],
                 sbp = sbp,
                 parts = part_ww,
                 idvar = "UID",
                 total = 1440)

# sleep-sleep composition
part_ss <- c("SleepgDayLag", "WAKEgDayLag", "MVPAg", "LPAg", "SBg")
ds <- d[complete.cases(d[, .(SleepgDayLag, WAKEgDayLag, MVPAg, LPAg, SBg)])]

# check
# zPatterns(ds[, part_ss, with = FALSE], label = NA)
# zPatterns(ds[, part_ss, with = FALSE], label = 0)
ds <- ds[ WAKEgDayLag > 0]

# impute 0
# composition_ss_imp <- lrEM(ds[, part_ss, with = FALSE], label = 0,dl = rep(1,5))
# ds <- cbind(ds[, -part_ss, with = FALSE], composition_ss_imp)

cilrs <- compilr(ds,
                 sbp = sbp,
                 parts = part_ss,
                 idvar = "UID",
                 total = 1440)

cilre <- compilr(ds[Survey == "Evening"],
                 sbp = sbp,
                 parts = part_ss,
                 idvar = "UID",
                 total = 1440)

# wake-wake next day composition
parts_ww_next <- c("SleepgNextDay", "WAKEgNextDay", "MVPAgNextDay", "LPAgNextDay", "SBgNextDay")
# zPatterns(d[, parts_ww_next, with = FALSE], label = 0)
# zPatterns(d[, parts_ww_next, with = FALSE], label = NA)

dnext_lag <- cbind(cilrw$TotalILR, cilrw$BetweenILR, cilrw$WithinILR, cilrw$data)
setnames(dnext_lag, "ilr1", "ilr1_lag")
setnames(dnext_lag, "ilr2", "ilr2_lag")
setnames(dnext_lag, "ilr3", "ilr3_lag")
setnames(dnext_lag, "ilr4", "ilr4_lag")
setnames(dnext_lag, "bilr1", "bilr1_lag")
setnames(dnext_lag, "bilr2", "bilr2_lag")
setnames(dnext_lag, "bilr3", "bilr3_lag")
setnames(dnext_lag, "bilr4", "bilr4_lag")
setnames(dnext_lag, "wilr1", "wilr1_lag")
setnames(dnext_lag, "wilr2", "wilr2_lag")
setnames(dnext_lag, "wilr3", "wilr3_lag")
setnames(dnext_lag, "wilr4", "wilr4_lag")

dnext <- d[complete.cases(d[, .(SleepgNextDay, WAKEgNextDay, MVPAgNextDay, LPAgNextDay, SBgNextDay)])]
dnext <- merge(dnext, 
               dnext_lag[, .(UID, Survey, SurveyDay, ilr1_lag, ilr2_lag, ilr3_lag, ilr4_lag,
                             bilr1_lag, bilr2_lag, bilr3_lag, bilr4_lag,
                             wilr1_lag, wilr2_lag, wilr3_lag, wilr4_lag
               )], 
               by = c("UID", "Survey", "SurveyDay"), all.x = TRUE)

dnext <- dnext[WAKEgNextDay > 0]

cilrw_next <- compilr(dnext,
                      sbp = sbp,
                      parts = parts_ww_next,
                      idvar = "UID",
                      total = 1440)

# sleep-sleep next day composition
parts_ss_next <- c("Sleepg", "WAKEg", "MVPAgNextDay", "LPAgNextDay", "SBgNextDay")

dsnext_lag <- cbind(cilrs$TotalILR, cilrs$BetweenILR, cilrs$WithinILR, cilrs$data)
setnames(dsnext_lag, "ilr1", "ilr1_lag")
setnames(dsnext_lag, "ilr2", "ilr2_lag")
setnames(dsnext_lag, "ilr3", "ilr3_lag")
setnames(dsnext_lag, "ilr4", "ilr4_lag")
setnames(dsnext_lag, "bilr1", "bilr1_lag")
setnames(dsnext_lag, "bilr2", "bilr2_lag")
setnames(dsnext_lag, "bilr3", "bilr3_lag")
setnames(dsnext_lag, "bilr4", "bilr4_lag")
setnames(dsnext_lag, "wilr1", "wilr1_lag")
setnames(dsnext_lag, "wilr2", "wilr2_lag")
setnames(dsnext_lag, "wilr3", "wilr3_lag")
setnames(dsnext_lag, "wilr4", "wilr4_lag")

dsnext <- d[complete.cases(d[, .(Sleepg, WAKEg, MVPAgNextDay, LPAgNextDay, SBgNextDay)])]
dsnext <- merge(dsnext, 
                dsnext_lag[, .(UID, Survey, SurveyDay, 
                               ilr1_lag, ilr2_lag, ilr3_lag, ilr4_lag,
                               bilr1_lag, bilr2_lag, bilr3_lag, bilr4_lag,
                               wilr1_lag, wilr2_lag, wilr3_lag, wilr4_lag
                )], 
                by = c("UID", "Survey", "SurveyDay"), all.x = TRUE)

cilrs_next <- compilr(dsnext,
                      sbp = sbp,
                      parts = parts_ss_next,
                      idvar = "UID",
                      total = 1440)
