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

# need 50Gb mem
# MODELS --------------------
local <- FALSE
if (local) {
  
  source("24h-affect-utils.R")
  # m_hapa <- readRDS(paste0(outputdir, "m_hapa", ".RDS"))
  # m_lapa <- readRDS(paste0(outputdir, "m_lapa", ".RDS"))
  m_hana_unadj <- readRDS(paste0(outputdir, "m_hana_unadj", ".RDS"))
  m_lana_unadj <- readRDS(paste0(outputdir, "m_lana_unadj", ".RDS"))
  
  m_hana_unadj_sub <- substitution(
    m_hana_unadj,
    delta = c(1:60),
    # delta = c(60),
    level = c("between", "within"),
    ref = "grandmean",
    cores = 2
  )
  saveRDS(m_hana_unadj_sub, paste0(outputdir, "m_hana_unadj_sub", ".RDS"))
  rm(m_hapa)
  
  m_lana_unadj_sub <- substitution(
    m_lana_unadj,
    delta = c(1:60),
    # delta = c(60),
    level = c("between", "within"),
    ref = "grandmean",
    cores = 2
  )
  saveRDS(m_lana_unadj_sub, paste0(outputdir, "m_lana_unadj_sub", ".RDS"))
  rm(m_lana_unadj)
  
} else {
  # m_hapa <- readRDS("m_hapa.RDS")
  # m_lapa <- readRDS("m_lapa.RDS")
  m_hana_unadj <- readRDS("m_hana_unadj.RDS")
  m_lana_unadj <- readRDS("m_lana_unadj.RDS")
  
  m_hana_unadj_sub <- substitution(
    m_hana_unadj,
    delta = c(1:60),
    # delta = c(60),
    level = c("between", "within"),
    ref = "grandmean",
    cores = 2
  )
  saveRDS(m_hana_unadj_sub, "m_hana_unadj_sub.RDS")
  rm(m_hana_unadj)
  
  m_lana_unadj_sub <- substitution(
    m_lana_unadj,
    delta = c(1:60),
    # delta = c(60),
    level = c("between", "within"),
    ref = "grandmean",
    cores = 2
  )
  saveRDS(m_lana_unadj_sub, "m_lana_unadj_sub.RDS")
  rm(m_lana_unadj)
}
