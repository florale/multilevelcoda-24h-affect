source("24h-affect-utils.R")

# # brmcoda
# m_hapa <- readRDS(paste0(outputdir, "m_hapa", ".RDS"))
# m_lapa <- readRDS(paste0(outputdir, "m_lapa", ".RDS"))
# m_hana <- readRDS(paste0(outputdir, "m_hana", ".RDS"))
# m_lana <- readRDS(paste0(outputdir, "m_lana", ".RDS"))

# substitution
m_hapa_sub <- readRDS(paste0(outputdir, "m_hapa_sub", ".RDS"))
m_lapa_sub <- readRDS(paste0(outputdir, "m_lapa_sub", ".RDS"))
m_hana_sub <- readRDS(paste0(outputdir, "m_hana_sub", ".RDS"))
m_lana_sub <- readRDS(paste0(outputdir, "m_lana_sub", ".RDS"))

h24_affect_sub_list <- lapply(list(
  m_hapa_sub, m_lapa_sub, m_hana_sub, m_lana_sub
), function(X) {
  
  X <- summary(X, delta = 30)
  X[, From := ifelse(From == "Sleepg", "Sleep", From)]
  X[, From := ifelse(From == "WAKEg", "Awake in Bed", From)]
  X[, From := ifelse(From == "MVPAg", "MVPA", From)]
  X[, From := ifelse(From == "LPAg", "LPA", From)]
  X[, From := ifelse(From == "SBg", "SB", From)]
  
  X[, To := ifelse(To == "Sleepg", "Sleep", To)]
  X[, To := ifelse(To == "WAKEg", "Awake in Bed", To)]
  X[, To := ifelse(To == "MVPAg", "MVPA", To)]
  X[, To := ifelse(To == "LPAg", "LPA", To)]
  X[, To := ifelse(To == "SBg", "SB", To)]
  
  X$Sig <- between(0, X$CI_low, X$CI_high)
  X[, Sig := ifelse(Sig == FALSE & Delta %in% c(-30, 30), "Yes", "")]

  X[, `Estimate [95% CI]` := paste0(format(round(Mean, digits = 2), nsmall = 2),
                                    " [",
                                    format(round(CI_low, digits = 2), nsmall = 2),
                                    ", ",
                                    format(round(CI_high, digits = 2), nsmall = 2),
                                    "]")]
  X <- X[, .(`Estimate [95% CI]`, Minute = Delta, From, To, Level, Sig)]
})

# graphs
h24_affect_plot_b <- readRDS(paste0(outputdir, "h24_affect_plot_b_supp", ".RDS"))
h24_affect_plot_w <- readRDS(paste0(outputdir, "h24_affect_plot_w_supp", ".RDS"))
rg <- readRDS(paste0(outputdir, "h24_affect_rg", ".RDS"))

names <- c(`Sleepg` = "Sleep",
           `WAKEg` = "Awake in Bed",
           `MVPAg` = "MVPA",
           `LPAg` = "LPA",
           `SBg` = "SB")
labeller <- function(variable,value){
  return(names[value])
}