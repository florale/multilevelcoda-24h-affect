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
  m_hapa <- readRDS(paste0(outputdir, "m_hapa", ".RDS"))
  m_lapa <- readRDS(paste0(outputdir, "m_lapa", ".RDS"))
  # m_hana <- readRDS(paste0(outputdir, "m_hana", ".RDS"))
  # m_lana <- readRDS(paste0(outputdir, "m_lana", ".RDS"))
  
  m_hapa_sub <- substitution(
    m_hapa,
    delta = c(1:60),
    # delta = c(30),
    level = c("between", "within"),
    ref = "grandmean",
    cores = 1
  )
  saveRDS(m_hapa_sub, paste0(outputdir, "m_hapa_sub", ".RDS"))
  rm(m_hapa)
  
  m_lapa_sub <- substitution(
    m_lapa,
    delta = c(1:60),
    # delta = c(30),
    level = c("between", "within"),
    ref = "grandmean",
    cores = 1
  )
  saveRDS(m_lapa_sub, paste0(outputdir, "m_lapa_sub", ".RDS"))
  rm(m_lapa)
  
} else {
  m_hapa <- readRDS("m_hapa.RDS")
  m_lapa <- readRDS("m_lapa.RDS")
  # m_hana <- readRDS("m_hana.RDS")
  # m_lana <- readRDS("m_lana.RDS")
  
  m_hapa_sub <- substitution(
    m_hapa,
    delta = c(1:60),
    # delta = c(60),
    level = c("between", "within"),
    ref = "grandmean",
    cores = 2
  )
  saveRDS(m_hapa_sub, "m_hapa_sub.RDS")
  rm(m_hapa)
  
  m_lapa_sub <- substitution(
    m_lapa,
    delta = c(1:60),
    # delta = c(60),
    level = c("between", "within"),
    ref = "grandmean",
    cores = 2
  )
  saveRDS(m_lapa_sub, "m_lapa_sub.RDS")
  rm(m_lapa)
  
}
