source("data.R")

# Sleep-Sleep - Same day outcome -------------------------
mhapa_ss <- brmcoda(cilrs,
                    PosAffHADay ~ bilr1 + bilr2 + bilr3 + bilr4 +
                      wilr1 + wilr2 + wilr3 + wilr4 +
                      (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                    cores = 4,
                    chains = 4,
                    # iter = 1000,
                    # warmup = 250,
                    seed = 123,
                    backend = "cmdstanr"
)
mlapa_ss <- brmcoda(cilrs,
                    PosAffLADay ~ bilr1 + bilr2 + bilr3 + bilr4 +
                      wilr1 + wilr2 + wilr3 + wilr4 +
                      (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                    cores = 4,
                    chains = 4,
                    # iter = 1000,
                    # warmup = 250,
                    seed = 123,
                    backend = "cmdstanr"
)
mhana_ss <- brmcoda(cilrs,
                    NegAffHADay ~ bilr1 + bilr2 + bilr3 + bilr4 +
                      wilr1 + wilr2 + wilr3 + wilr4 +
                      (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                    cores = 4,
                    chains = 4,
                    # iter = 1000,
                    # warmup = 250,
                    seed = 123,
                    backend = "cmdstanr"
)
mlana_ss <- brmcoda(cilrs,
                    NegAffLADay ~ bilr1 + bilr2 + bilr3 + bilr4 +
                      wilr1 + wilr2 + wilr3 + wilr4 +
                      (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                    cores = 4,
                    chains = 4,
                    # iter = 1000,
                    # warmup = 250,
                    seed = 123,
                    backend = "cmdstanr"
)

## brmcoda summary
summary(mhapa_ss)
summary(mlapa_ss)
summary(mhana_ss)
summary(mlana_ss)

## substitution
plan(multisession, workers = 5)
mhapa_ss_sub <- substitution(
  mhapa_ss,
  # delta = c(1:60),
  delta = c(30, 60),
  level = c("between", "within"),
  ref = "grandmean")

mlapa_ss_sub <- substitution(
  mlapa_ss,
  # delta = c(1:60),
  delta = c(30, 60),
  level = c("between", "within"),
  ref = "grandmean")

mhana_ss_sub <- substitution(
  mhana_ss,
  # delta = c(1:60),
  delta = c(30, 60),
  level = c("between", "within"),
  ref = "grandmean")

mlana_ss_sub <- substitution(
  mlana_ss,
  # delta = c(1:60),
  delta = c(30, 60),
  level = c("between", "within"),
  ref = "grandmean")

plan(sequential)

## substitution summary 
summary(mhapa_ss_sub, delta = 30)
summary(mlapa_ss_sub, delta = 30)
summary(mhana_ss_sub, delta = 30)
summary(mlana_ss_sub, delta = 30)

summary(mhapa_ss_sub, delta = 60)
summary(mlapa_ss_sub, delta = 60)
summary(mhana_ss_sub, delta = 60)
summary(mlana_ss_sub, delta = 60)

## substitution plot
plot(mhapa_ss_sub, to = "SleepgLagDay", ref = "grandmean", level = "between")
plot(mhapa_ss_sub, to = "WAKEgLagDay", ref = "grandmean", level = "between")
plot(mhapa_ss_sub, to = "MVPAg", ref = "grandmean", level = "between")
plot(mhapa_ss_sub, to = "LPAg", ref = "grandmean", level = "between")
plot(mhapa_ss_sub, to = "SBg", ref = "grandmean", level = "between")

plot(mhapa_ss_sub, to = "SleepgLagDay", ref = "grandmean", level = "within")
plot(mhapa_ss_sub, to = "WAKEgLagDay", ref = "grandmean", level = "within")
plot(mhapa_ss_sub, to = "MVPAg", ref = "grandmean", level = "within")
plot(mhapa_ss_sub, to = "LPAg", ref = "grandmean", level = "within")
plot(mhapa_ss_sub, to = "SBg", ref = "grandmean", level = "within")


plot(mlapa_ss_sub, to = "SleepgLagDay", ref = "grandmean", level = "between")
plot(mlapa_ss_sub, to = "WAKEgLagDay", ref = "grandmean", level = "between")
plot(mlapa_ss_sub, to = "MVPAg", ref = "grandmean", level = "between")
plot(mlapa_ss_sub, to = "LPAg", ref = "grandmean", level = "between")
plot(mlapa_ss_sub, to = "SBg", ref = "grandmean", level = "between")

plot(mlapa_ss_sub, to = "SleepgLagDay", ref = "grandmean", level = "within")
plot(mlapa_ss_sub, to = "WAKEgLagDay", ref = "grandmean", level = "within")
plot(mlapa_ss_sub, to = "MVPAg", ref = "grandmean", level = "within")
plot(mlapa_ss_sub, to = "LPAg", ref = "grandmean", level = "within")
plot(mlapa_ss_sub, to = "SBg", ref = "grandmean", level = "within")


plot(mhana_ss_sub, to = "SleepgLagDay", ref = "grandmean", level = "between")
plot(mhana_ss_sub, to = "WAKEgLagDay", ref = "grandmean", level = "between")
plot(mhana_ss_sub, to = "MVPAg", ref = "grandmean", level = "between")
plot(mhana_ss_sub, to = "LPAg", ref = "grandmean", level = "between")
plot(mhana_ss_sub, to = "SBg", ref = "grandmean", level = "between")

plot(mhana_ss_sub, to = "SleepgLagDay", ref = "grandmean", level = "within")
plot(mhana_ss_sub, to = "WAKEgLagDay", ref = "grandmean", level = "within")
plot(mhana_ss_sub, to = "MVPAg", ref = "grandmean", level = "within")
plot(mhana_ss_sub, to = "LPAg", ref = "grandmean", level = "within")
plot(mhana_ss_sub, to = "SBg", ref = "grandmean", level = "within")


plot(mlana_ss_sub, to = "SleepgLagDay", ref = "grandmean", level = "between")
plot(mlana_ss_sub, to = "WAKEgLagDay", ref = "grandmean", level = "between")
plot(mlana_ss_sub, to = "MVPAg", ref = "grandmean", level = "between")
plot(mlana_ss_sub, to = "LPAg", ref = "grandmean", level = "between")
plot(mlana_ss_sub, to = "SBg", ref = "grandmean", level = "between")

plot(mlana_ss_sub, to = "SleepgLagDay", ref = "grandmean", level = "within")
plot(mlana_ss_sub, to = "WAKEgLagDay", ref = "grandmean", level = "within")
plot(mlana_ss_sub, to = "MVPAg", ref = "grandmean", level = "within")
plot(mlana_ss_sub, to = "LPAg", ref = "grandmean", level = "within")
plot(mlana_ss_sub, to = "SBg", ref = "grandmean", level = "within")

# Wake-Wake - Next day outcome -------------------------
mhapa_ww <- brmcoda(cilr,
                    PosAffHANextDay ~ bilr1 + bilr2 + bilr3 + bilr4 +
                      wilr1 + wilr2 + wilr3 + wilr4 + 
                      (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                    cores = 4,
                    chains = 4,
                    # iter = 1000,
                    # warmup = 250,
                    seed = 123,
                    backend = "cmdstanr"
)

mlapa_ww <- brmcoda(cilr,
                    PosAffLANextDay ~ bilr1 + bilr2 + bilr3 + bilr4 +
                      wilr1 + wilr2 + wilr3 + wilr4 +
                      (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                    cores = 4,
                    chains = 4,
                    # iter = 1000,
                    # warmup = 250,
                    seed = 123,
                    backend = "cmdstanr"
)

mhana_ww <- brmcoda(cilr,
                    NegAffHANextDay ~ bilr1 + bilr2 + bilr3 + bilr4 +
                      wilr1 + wilr2 + wilr3 + wilr4 +
                      (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                    cores = 4,
                    chains = 4,
                    # iter = 1000,
                    # warmup = 250,
                    seed = 123,
                    backend = "cmdstanr"
)

mlana_ww <- brmcoda(cilr,
                    NegAffLANextDay ~ bilr1 + bilr2 + bilr3 + bilr4 +
                      wilr1 + wilr2 + wilr3 + wilr4 +
                      (1 + wilr1 + wilr2 + wilr3 + wilr4 | UID), 
                    cores = 4,
                    chains = 4,
                    # iter = 1000,
                    # warmup = 250,
                    seed = 123,
                    backend = "cmdstanr"
)


## brmcoda summary
summary(mhapa_ww)
summary(mlapa_ww)
summary(mhana_ww)
summary(mlana_ww)

## substitution
plan(multisession, workers = 5)
mhapa_ww_sub <- substitution(
  mhapa_ww,
  # delta = c(1:60),
  delta = c(30, 60),
  level = c("between", "within"),
  ref = "grandmean")

mlapa_ww_sub <- substitution(
  mlapa_ww,
  # delta = c(1:60),
  delta = c(30, 60),
  level = c("between", "within"),
  ref = "grandmean")

mhana_ww_sub <- substitution(
  mhana_ww,
  # delta = c(1:60),
  delta = c(30, 60),
  level = c("between", "within"),
  ref = "grandmean")

mlana_ww_sub <- substitution(
  mlana_ww,
  # delta = c(1:60),
  delta = c(30, 60),
  level = c("between", "within"),
  ref = "grandmean")

plan(sequential)

## substitution summary 
summary(mhapa_ww_sub, delta = 30)
summary(mlapa_ww_sub, delta = 30)
summary(mhana_ww_sub, delta = 30)
summary(mlana_ww_sub, delta = 30)

summary(mhapa_ww_sub, delta = 60)
summary(mlapa_ww_sub, delta = 60)
summary(mhana_ww_sub, delta = 60)
summary(mlana_ww_sub, delta = 60)


## substitution plot
plot(mhapa_ww_sub, to = "Sleepg", ref = "grandmean", level = "between")
plot(mhapa_ww_sub, to = "WAKEg", ref = "grandmean", level = "between")
plot(mhapa_ww_sub, to = "MVPAg", ref = "grandmean", level = "between")
plot(mhapa_ww_sub, to = "LPAg", ref = "grandmean", level = "between")
plot(mhapa_ww_sub, to = "SBg", ref = "grandmean", level = "between")

plot(mhapa_ww_sub, to = "Sleepg", ref = "grandmean", level = "within")
plot(mhapa_ww_sub, to = "WAKEg", ref = "grandmean", level = "within")
plot(mhapa_ww_sub, to = "MVPAg", ref = "grandmean", level = "within")
plot(mhapa_ww_sub, to = "LPAg", ref = "grandmean", level = "within")
plot(mhapa_ww_sub, to = "SBg", ref = "grandmean", level = "within")


plot(mlapa_ww_sub, to = "Sleepg", ref = "grandmean", level = "between")
plot(mlapa_ww_sub, to = "WAKEg", ref = "grandmean", level = "between")
plot(mlapa_ww_sub, to = "MVPAg", ref = "grandmean", level = "between")
plot(mlapa_ww_sub, to = "LPAg", ref = "grandmean", level = "between")
plot(mlapa_ww_sub, to = "SBg", ref = "grandmean", level = "between")

plot(mlapa_ww_sub, to = "Sleepg", ref = "grandmean", level = "within")
plot(mlapa_ww_sub, to = "WAKEg", ref = "grandmean", level = "within")
plot(mlapa_ww_sub, to = "MVPAg", ref = "grandmean", level = "within")
plot(mlapa_ww_sub, to = "LPAg", ref = "grandmean", level = "within")
plot(mlapa_ww_sub, to = "SBg", ref = "grandmean", level = "within")


plot(mhana_ww_sub, to = "Sleepg", ref = "grandmean", level = "between")
plot(mhana_ww_sub, to = "WAKEg", ref = "grandmean", level = "between")
plot(mhana_ww_sub, to = "MVPAg", ref = "grandmean", level = "between")
plot(mhana_ww_sub, to = "LPAg", ref = "grandmean", level = "between")
plot(mhana_ww_sub, to = "SBg", ref = "grandmean", level = "between")

plot(mhana_ww_sub, to = "Sleepg", ref = "grandmean", level = "within")
plot(mhana_ww_sub, to = "WAKEg", ref = "grandmean", level = "within")
plot(mhana_ww_sub, to = "MVPAg", ref = "grandmean", level = "within")
plot(mhana_ww_sub, to = "LPAg", ref = "grandmean", level = "within")
plot(mhana_ww_sub, to = "SBg", ref = "grandmean", level = "within")


plot(mlana_ww_sub, to = "Sleepg", ref = "grandmean", level = "between")
plot(mlana_ww_sub, to = "WAKEg", ref = "grandmean", level = "between")
plot(mlana_ww_sub, to = "MVPAg", ref = "grandmean", level = "between")
plot(mlana_ww_sub, to = "LPAg", ref = "grandmean", level = "between")
plot(mlana_ww_sub, to = "SBg", ref = "grandmean", level = "between")

plot(mlana_ww_sub, to = "Sleepg", ref = "grandmean", level = "within")
plot(mlana_ww_sub, to = "WAKEg", ref = "grandmean", level = "within")
plot(mlana_ww_sub, to = "MVPAg", ref = "grandmean", level = "within")
plot(mlana_ww_sub, to = "LPAg", ref = "grandmean", level = "within")
plot(mlana_ww_sub, to = "SBg", ref = "grandmean", level = "within")
