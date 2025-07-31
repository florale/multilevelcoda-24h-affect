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
  m_hapa_sen <- readRDS(paste0(outputdir, "m_hapa_sen", ".RDS"))
  m_lapa_sen <- readRDS(paste0(outputdir, "m_lapa_sen", ".RDS"))
  # m_hana <- readRDS(paste0(outputdir, "m_hana", ".RDS"))
  # m_lana <- readRDS(paste0(outputdir, "m_lana", ".RDS"))
  
  m_hapa_sen_sub <- substitution(
    m_hapa_sen,
    delta = c(1:60),
    # delta = c(60),
    level = c("between", "within"),
    ref = "grandmean",
    cores = 2
  )
  saveRDS(m_hapa_sen_sub, paste0(outputdir, "m_hapa_sen_sub", ".RDS"))
  rm(m_hapa_sen)
  
  m_lapa_sen_sub <- substitution(
    m_lapa_sen,
    delta = c(1:60),
    # delta = c(60),
    level = c("between", "within"),
    ref = "grandmean",
    cores = 2
  )
  saveRDS(m_lapa_sen_sub, paste0(outputdir, "m_lapa_sen_sub", ".RDS"))
  rm(m_lapa_sen)
  
} else {
  m_hapa_sen <- readRDS("m_hapa_sen.RDS")
  m_lapa_sen <- readRDS("m_lapa_sen.RDS")
  # m_hana <- readRDS("m_hana.RDS")
  # m_lana <- readRDS("m_lana.RDS")
  
  m_hapa_sen_sub <- substitution(
    m_hapa_sen,
    delta = c(1:60),
    # delta = c(60),
    level = c("between", "within"),
    ref = "grandmean",
    cores = 2
  )
  saveRDS(m_hapa_sen_sub, "m_hapa_sen_sub.RDS")
  rm(m_hapa_sen)
  
  m_lapa_sen_sub <- substitution(
    m_lapa_sen,
    delta = c(1:60),
    # delta = c(60),
    level = c("between", "within"),
    ref = "grandmean",
    cores = 2
  )
  saveRDS(m_lapa_sen_sub, "m_lapa_sen_sub.RDS")
  rm(m_lapa_sen)
  
}
