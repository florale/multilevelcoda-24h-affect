library(data.table)
library(extraoperators)
library(compositions)
library(multilevelcoda)
library(brms)
library(cmdstanr)
library(insight)

# library(doFuture)
# library(foreach)
# library(parallel)
# library(doRNG)
# library(future)
# library(loo)

# MODELS --------------------
local <- FALSE
if (local) {
  
  source("24h-affect-setup.R")
  m_hapa_unadj <- readRDS(paste0(outputdir, "m_hapa_unadj", ".RDS"))
  m_lapa_unadj <- readRDS(paste0(outputdir, "m_lapa_unadj", ".RDS"))
  # m_hana <- readRDS(paste0(outputdir, "m_hana", ".RDS"))
  # m_lana <- readRDS(paste0(outputdir, "m_lana", ".RDS"))
  
  m_hapa_unadj_sub <- substitution(
    m_hapa_unadj,
    delta = c(1:60),
    # delta = c(60),
    level = c("between", "within"),
    ref = "grandmean",
    cores = 2
  )
  saveRDS(m_hapa_unadj_sub, paste0(outputdir, "m_hapa_unadj_sub", ".RDS"))
  rm(m_hapa_unadj)
  
  m_lapa_unadj_sub <- substitution(
    m_lapa_unadj,
    delta = c(1:60),
    # delta = c(60),
    level = c("between", "within"),
    ref = "grandmean",
    cores = 2
  )
  saveRDS(m_lapa_unadj_sub, paste0(outputdir, "m_lapa_unadj_sub", ".RDS"))
  rm(m_lapa_unadj)
  
} else {
  m_hapa_unadj <- readRDS("m_hapa_unadj.RDS")
  m_lapa_unadj <- readRDS("m_lapa_unadj.RDS")
  # m_hana <- readRDS("m_hana.RDS")
  # m_lana <- readRDS("m_lana.RDS")
  
  m_hapa_unadj_sub <- substitution(
    m_hapa_unadj,
    delta = c(1:60),
    # delta = c(60),
    level = c("between", "within"),
    ref = "grandmean",
    cores = 2
  )
  saveRDS(m_hapa_unadj_sub, "m_hapa_unadj_sub.RDS")
  rm(m_hapa_unadj)
  
  m_lapa_unadj_sub <- substitution(
    m_lapa_unadj,
    delta = c(1:60),
    # delta = c(60),
    level = c("between", "within"),
    ref = "grandmean",
    cores = 2
  )
  saveRDS(m_lapa_unadj_sub, "m_lapa_unadj_sub.RDS")
  rm(m_lapa_unadj)
  
}
