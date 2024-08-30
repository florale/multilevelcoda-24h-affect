
local <- FALSE

# MODELS --------------------
if (local) {
  source("24h-affect-utils.R")
  
} else {
  library(data.table)
  library(extraoperators)
  library(compositions)
  library(multilevelcoda)
  library(brms)
  library(cmdstanr)
  library(insight)
  
  library(doFuture)
  library(foreach)
  library(parallel)
  library(doRNG)
  library(future)
  library(loo)
  
  outdir <- NULL
}

# need 50Gb mem
# m_hapa <- readRDS(paste0(outputdir, "m_hapa", ".RDS"))
# m_lapa <- readRDS(paste0(outputdir, "m_lapa", ".RDS"))
m_hana <- readRDS(paste0(outputdir, "m_hana", ".RDS"))
m_lana <- readRDS(paste0(outputdir, "m_lana", ".RDS"))

m_hana_sub <- substitution(
  m_hana,
  delta = c(1:60),
  # delta = c(60),
  level = c("between", "within"),
  ref = "grandmean",
  cores = 2
)
saveRDS(m_hana_sub, paste0(outputdir, "m_hana_sub", ".RDS"))
rm(m_hapa)

m_lana_sub <- substitution(
  m_lana,
  delta = c(1:60),
  # delta = c(60),
  level = c("between", "within"),
  ref = "grandmean",
  cores = 2
)
saveRDS(m_lana_sub, paste0(outputdir, "m_lana_sub", ".RDS"))
rm(m_lana)

