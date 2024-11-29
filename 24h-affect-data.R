source("24h-affect-utils.R")

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
  Sleepg, WAKEg, MVPAg, LPAg, SBg, TotalDayg,
  
  # adj
  HAPPY, CHEERFUL, ENTHUSIASTIC,
  RELAXED, CALM, ATEASE,
  
  AFRAID, NERVOUS, IRRITABLE,
  SAD, LONELY, GUILTY
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
  Sleepg, WAKEg, MVPAg, LPAg, SBg, TotalDayg,
  
  # adj
  HAPPY, CHEERFUL, ENTHUSIASTIC,
  RELAXED, CALM, ATEASE,
  
  AFRAID, NERVOUS, IRRITABLE,
  SAD, LONELY, GUILTY
  
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
  Sleepg, WAKEg, MVPAg, LPAg, SBg, TotalDayg,
  
  # adj
  HAPPY, CHEERFUL, ENTHUSIASTIC,
  RELAXED, CALM, ATEASE,
  
  AFRAID, NERVOUS, IRRITABLE,
  SAD, LONELY, GUILTY
  
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

d[, c("BPosAffHADayLag", "BPosAffLADayLag", "BNegAffHADayLag", "BNegAffLADayLag", "BSTRESSDayLag") :=
    .SD[.(UID = UID, Survey = Survey, SurveyDay = SurveyDay - 1),
        .(BPosAffHADay, BPosAffLADay, BNegAffHADay, BNegAffLADay, BSTRESSDay),
        on = c("UID", "SurveyDay", "Survey")]]

### lead day - used variables
d[, c("PosAffHADayLead", "PosAffLADayLead", "NegAffHADayLead", "NegAffLADayLead", "STRESSDayLead") :=
    .SD[.(UID = UID, Survey = Survey, SurveyDay = SurveyDay + 1),
        .(PosAffHADay, PosAffLADay, NegAffHADay, NegAffLADay, STRESSDay),
        on = c("UID", "SurveyDay", "Survey")]]

### others
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

d[, c("BPosAffHADayLead", "WPosAffHADayLeadAffHALead") := meanDeviations(PosAffHADayLead), by = UID]
d[, c("BPosAffLADayLead", "WPosAffLADayLead") := meanDeviations(PosAffLADayLead), by = UID]
d[, c("BNegAffHADayLead", "WNegAffHADayLead") := meanDeviations(NegAffHADayLead), by = UID]
d[, c("BNegAffLADayLead", "WNegAffLADayLead") := meanDeviations(NegAffLADayLead), by = UID]
d[, c("BSTRESSDayLead", "WSTRESSDayLead") := meanDeviations(STRESSDayLead), by = UID]

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

View(d[, .(ID, UID, USURVEYUID, SurveyDay, Survey, PosAffHADay, PosAffHADayLag, 
           STRESS, WSTRESSDayLag,
           PosAffHALead, WPosAffHADay, WPosAffHADayLag, PosAffHADayLead, Sleepg,
           Age, Female,  RACE3G, BMI, SES_1, StudyID, WeekDay, CurrentWork,
           CurrentSchool, SmokingStatus, AUDITCat
           )])

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

part_ww <- c("Sleepg", "WAKEg", "MVPAg", "LPAg", "SBg")

# use complete cases
dw <- d[complete.cases(d[, .(Sleepg, WAKEg, MVPAg, LPAg, SBg)])]

# check 0s
any(apply(dw[, part_ww, with = FALSE], 2, function(x) x == 0))
dw[which(Sleepg == 0), "ID"]
dw[which(WAKEg == 0), "ID"]
dw[which(MVPAg == 0), "ID"]
dw[which(LPAg == 0), "ID"]
dw[which(SBg == 0), "ID"]

# composition_imp <- lrEM(d[, parts, with = FALSE], label = 0,dl = rep(1, 4), ini.cov = "multRepl")
# d <- cbind(d[, -parts, with = FALSE], composition_imp)

## only three so just remove that participant, instead of imputation
dw <- dw[ WAKEg > 0]

cilrw <- complr(dw,
                 sbp = sbp,
                 parts = part_ww,
                 idvar = "UID",
                 total = 1440)
saveRDS(cilrw, paste0(outputdir, "cilrw", ".RDS"))

# recheck
# zPatterns(dw[Survey == "Wake", part_ww, with = FALSE], label = NA)
# zPatterns(dw[, part_ww, with = FALSE], label = 0)

## sleep-sleep composition
part_ss <- c("Sleepg", "WAKEg", "MVPAgDayLead", "LPAgDayLead", "SBgDayLead")
ds <- d[complete.cases(d[, .(Sleepg, WAKEg, MVPAgDayLead, LPAgDayLead, SBgDayLead)])]

# check 0s
any(apply(ds[, part_ss, with = FALSE], 2, function(x) x == 0))
ds[which(Sleepg == 0), "ID"]
ds[which(WAKEg == 0), "ID"]
ds[which(MVPAg == 0), "ID"]
ds[which(LPAg == 0), "ID"]
ds[which(SBg == 0), "ID"]

ds <- ds[ WAKEg > 0]

cilrs <- complr(ds,
                 sbp = sbp,
                 parts = part_ss,
                 idvar = "UID",
                 total = 1440)
saveRDS(cilrs, paste0(outputdir, "cilrs", ".RDS"))

## Descriptive stats ---------------------------

egltable(c("Sleepg", "WAKEg", "MVPAg", "LPAg", "SBg",
           "PosAffHADayLead","PosAffLADayLead", "NegAffHADayLead", "NegAffLADayLead",
           
           "Age", "BMI", "SES_1", "Female", 
           "CurrentWork","CurrentSchool","DEDUUniPlus", "SmokingStatus",
           "RACE3G", "AUDITCat", "rMEQ"), strict = FALSE, g = "StudyID" ,  data = d[!duplicated(UID)])

# descriptive stats
fvars <- c("Female", "SmokingStatus", "CurrentWork", "AUDITCat", "DEDUUniPlus", "CurrentSchool")
egltable(c(
  # "PosAffHADayLead", "PosAffLADayLead", "NegAffHADayLead", "NegAffLADayLead", "STRESSDayLead",
  # "Sleepg", "WAKEg", "MVPAg", "LPAg", "SBg",
  # "SleepLight", "SleepDeep", "SleepREM", "WAKE", "TIBz",
  # "WeekDay", 
  "SmokingStatus", "CurrentWork", "AUDITCat", "DEDUUniPlus", "CurrentSchool",
  "Age", "Female", "RACE3G", "BMI", "SES_1" ),
  idvar = "UID", g = "StudyID",
  data = d[Survey == "Evening"][, (fvars) := lapply(.SD, as.factor), .SDcols = fvars][!duplicated(UID)]
)
egltable(c(
  "PosAffHADayLead", "PosAffLADayLead", "NegAffHADayLead", "NegAffLADayLead", "STRESSDayLead",
  "Sleepg", "WAKEg", "MVPAg", "LPAg", "SBg",
  # "SleepLight", "SleepDeep", "SleepREM", "WAKE", "TIBz",
  "WeekDay"
),
idvar = "UID", g = "StudyID",
data = d[Survey == "Evening"][, (fvars) := lapply(.SD, as.factor), .SDcols = fvars]
)
egltable(c(
  # "PosAffHADayLead", "PosAffLADayLead", "NegAffHADayLead", "NegAffLADayLead", "STRESSDayLead",
  # "Sleepg", "WAKEg", "MVPAg", "LPAg", "SBg",
  # "SleepLight", "SleepDeep", "SleepREM", "WAKE", "TIBz",
  # "WeekDay", 
  "SmokingStatus", "CurrentWork", "AUDITCat", "DEDUUniPlus", "CurrentSchool",
  "Age", "Female", "RACE3G", "BMI", "SES_1" ),
  idvar = "UID", 
  data = d[Survey == "Evening"][, (fvars) := lapply(.SD, as.factor), .SDcols = fvars][!duplicated(UID)]
)
egltable(c(
  "PosAffHADayLead", "PosAffLADayLead", "NegAffHADayLead", "NegAffLADayLead", "STRESSDayLead",
  "Sleepg", "WAKEg", "MVPAg", "LPAg", "SBg",
  # "SleepLight", "SleepDeep", "SleepREM", "WAKE", "TIBz",
  "WeekDay"
),
idvar = "UID", 
data = d[Survey == "Evening"][, (fvars) := lapply(.SD, as.factor), .SDcols = fvars]
)

summary(cilrw)

# ICC
multilevelTools::iccMixed(c("PosAffHADayLead"), id = "UID", data = d[Survey == "Evening"])
multilevelTools::iccMixed(c("PosAffLADayLead"), id = "UID", data = d[Survey == "Evening"])
multilevelTools::iccMixed(c("NegAffHADayLead"), id = "UID", data = d[Survey == "Evening"])
multilevelTools::iccMixed(c("NegAffLADayLead"), id = "UID", data = d[Survey == "Evening"])
multilevelTools::iccMixed(c("STRESSDayLead"), id = "UID", data = d[Survey == "Evening"])

multilevelTools::iccMixed(c("Sleepg"), id = "UID", data = d[Survey == "Evening"])
multilevelTools::iccMixed(c("WAKEg"), id = "UID", data = d[Survey == "Evening"])
multilevelTools::iccMixed(c("MVPAg"), id = "UID", data = d[Survey == "Evening"])
multilevelTools::iccMixed(c("LPAg"), id = "UID", data = d[Survey == "Evening"])
multilevelTools::iccMixed(c("SBg"), id = "UID", data = d[Survey == "Evening"])

# nobs
nrow(d[Survey == "Evening"][complete.cases(PosAffHADayLead)])
nrow(d[Survey == "Evening"][complete.cases(PosAffLADayLead)])
nrow(d[Survey == "Evening"][complete.cases(NegAffHADayLead)])
nrow(d[Survey == "Evening"][complete.cases(NegAffLADayLead)])
nrow(d[Survey == "Evening"][complete.cases(STRESSDayLead)])

nrow(d[Survey == "Evening"][complete.cases(Sleepg)])
nrow(d[Survey == "Evening"][complete.cases(WAKEg)])
nrow(d[Survey == "Evening"][complete.cases(MVPAg)])
nrow(d[Survey == "Evening"][complete.cases(LPAg)])
nrow(d[Survey == "Evening"][complete.cases(SBg)])

nrow(d[Survey == "Evening" & StudyID == "A"][complete.cases(PosAffHADayLead)])
nrow(d[Survey == "Evening" & StudyID == "A"][complete.cases(PosAffLADayLead)])
nrow(d[Survey == "Evening" & StudyID == "A"][complete.cases(NegAffHADayLead)])
nrow(d[Survey == "Evening" & StudyID == "A"][complete.cases(NegAffLADayLead)])
nrow(d[Survey == "Evening" & StudyID == "A"][complete.cases(STRESSDayLead)])

nrow(d[Survey == "Evening" & StudyID == "A"][complete.cases(Sleepg)])
nrow(d[Survey == "Evening" & StudyID == "A"][complete.cases(WAKEg)])
nrow(d[Survey == "Evening" & StudyID == "A"][complete.cases(MVPAg)])
nrow(d[Survey == "Evening" & StudyID == "A"][complete.cases(LPAg)])
nrow(d[Survey == "Evening" & StudyID == "A"][complete.cases(SBg)])

nrow(d[Survey == "Evening" & StudyID == "D"][complete.cases(PosAffHADayLead)])
nrow(d[Survey == "Evening" & StudyID == "D"][complete.cases(PosAffLADayLead)])
nrow(d[Survey == "Evening" & StudyID == "D"][complete.cases(NegAffHADayLead)])
nrow(d[Survey == "Evening" & StudyID == "D"][complete.cases(NegAffLADayLead)])
nrow(d[Survey == "Evening" & StudyID == "D"][complete.cases(STRESSDayLead)])

nrow(d[Survey == "Evening" & StudyID == "D"][complete.cases(Sleepg)])
nrow(d[Survey == "Evening" & StudyID == "D"][complete.cases(WAKEg)])
nrow(d[Survey == "Evening" & StudyID == "D"][complete.cases(MVPAg)])
nrow(d[Survey == "Evening" & StudyID == "D"][complete.cases(LPAg)])
nrow(d[Survey == "Evening" & StudyID == "D"][complete.cases(SBg)])

nrow(d[Survey == "Evening" & StudyID == "S"][complete.cases(PosAffHADayLead)])
nrow(d[Survey == "Evening" & StudyID == "S"][complete.cases(PosAffLADayLead)])
nrow(d[Survey == "Evening" & StudyID == "S"][complete.cases(NegAffHADayLead)])
nrow(d[Survey == "Evening" & StudyID == "S"][complete.cases(NegAffLADayLead)])
nrow(d[Survey == "Evening" & StudyID == "S"][complete.cases(STRESSDayLead)])

nrow(d[Survey == "Evening" & StudyID == "S"][complete.cases(Sleepg)])
nrow(d[Survey == "Evening" & StudyID == "S"][complete.cases(WAKEg)])
nrow(d[Survey == "Evening" & StudyID == "S"][complete.cases(MVPAg)])
nrow(d[Survey == "Evening" & StudyID == "S"][complete.cases(LPAg)])
nrow(d[Survey == "Evening" & StudyID == "S"][complete.cases(SBg)])

nrow(d[Survey == "Evening"][complete.cases(Age)][!duplicated(UID)])
nrow(d[Survey == "Evening" & StudyID == "A"][complete.cases(Age)][!duplicated(UID)])
nrow(d[Survey == "Evening" & StudyID == "D"][complete.cases(Age)][!duplicated(UID)])
nrow(d[Survey == "Evening" & StudyID == "S"][complete.cases(Age)][!duplicated(UID)])

# saveRDS(d, paste0(outputdir, "d", ".RDS"))
# saveRDS(cilrw, paste0(outputdir, "cilrw", ".RDS"))
# saveRDS(cilrs, paste0(outputdir, "cilrs", ".RDS"))

hapa_adj <- c("HAPPY", "CHEERFUL", "ENTHUSIASTIC")
lapa_adj <- c("RELAXED", "CALM", "ATEASE")
hana_adj <- c("AFRAID", "NERVOUS", "IRRITABLE")
lana_adj <- c("SAD", "LONELY", "GUILTY")
affect_adj <- c(hapa_adj, lapa_adj, hana_adj, lana_adj)

# reliability
d[, paste0(affect_adj, "_day") := lapply(.SD, function(x) mean(x, na.rm = TRUE)), by = .(UID, SurveyDay), .SDcols = affect_adj]

multilevelTools::omegaSEM(
  items = paste0(hapa_adj, "_day"),
  id = "UID",
  data = d,
  savemodel = FALSE)

multilevelTools::omegaSEM(
  items = paste0(lapa_adj, "_day"),
  id = "UID",
  data = d,
  savemodel = FALSE)

multilevelTools::omegaSEM(
  items = paste0(hana_adj, "_day"),
  id = "UID",
  data = d,
  savemodel = FALSE)

multilevelTools::omegaSEM(
  items = paste0(lana_adj, "_day"),
  id = "UID",
  data = d,
  savemodel = FALSE)

