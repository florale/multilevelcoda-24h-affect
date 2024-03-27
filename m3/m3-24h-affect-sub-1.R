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
mhapa_ww_lag_sub_adj <- substitution(
  m_hapa,
  delta = c(1:60),
  # delta = c(60),
  level = c("between", "within"),
  ref = "grandmean")
saveRDS(mhapa_ww_lag_sub_adj, "mhapa_ww_lag_sub_adj.RDS")

mlapa_ww_lag_sub_adj <- substitution(
  m_lapa,
  delta = c(1:60),
  # delta = c(60),
  level = c("between", "within"),
  ref = "grandmean")
saveRDS(mlapa_ww_lag_sub_adj, "mlapa_ww_lag_sub_adj.RDS")
plan(sequential)



