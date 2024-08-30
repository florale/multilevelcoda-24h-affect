source("24h-affect-utils.R")

# brmcoda
m_hapa <- readRDS(paste0(outputdir, "m_hapa", ".RDS"))
m_lapa <- readRDS(paste0(outputdir, "m_lapa", ".RDS"))
m_hana <- readRDS(paste0(outputdir, "m_hana", ".RDS"))
m_lana <- readRDS(paste0(outputdir, "m_lana", ".RDS"))

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
  X[, From := ifelse(From == "WAKEg", "Wake Time in Bed", From)]
  X[, From := ifelse(From == "MVPAg", "MVPA", From)]
  X[, From := ifelse(From == "LPAg", "LPA", From)]
  X[, From := ifelse(From == "SBg", "SB", From)]
  
  X[, To := ifelse(To == "Sleepg", "Sleep", To)]
  X[, To := ifelse(To == "WAKEg", "Wake Time in Bed", To)]
  X[, To := ifelse(To == "MVPAg", "MVPA", To)]
  X[, To := ifelse(To == "LPAg", "LPA", To)]
  X[, To := ifelse(To == "SBg", "SB", To)]
  
})

# graphs
h24_affect_plot_b <- readRDS(paste0(outputdir, "h24_affect_plot_b", ".RDS"))
h24_affect_plot_w <- readRDS(paste0(outputdir, "h24_affect_plot_w", ".RDS"))

names <- c(`Sleepg` = "Sleep",
           `WAKEg` = "Wake Time in Bed",
           `MVPAg` = "MVPA",
           `LPAg` = "LPA",
           `SBg` = "SB")
labeller <- function(variable,value){
  return(names[value])
}