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

# MODELS --------------------
m_hapa <- readRDS("m_hapa.RDS")
m_lapa <- readRDS("m_lapa.RDS")
m_hana <- readRDS("m_hana.RDS")
m_lana <- readRDS("m_lana.RDS")

## substitution
plan(multisession, workers = 5)
mhana_ww_sub <- substitution(
  m_hana,
  delta = c(1:60),
  # delta = c(60),
  level = c("between", "within"),
  ref = "grandmean")
saveRDS(mhana_ww_sub, "mhana_ww_sub.RDS")

mlana_ww_sub <- substitution(
  m_lana,
  delta = c(1:60),
  # delta = c(60),
  level = c("between", "within"),
  ref = "grandmean")
saveRDS(mlana_ww_sub, "mlana_ww_sub.RDS")
plan(sequential)


