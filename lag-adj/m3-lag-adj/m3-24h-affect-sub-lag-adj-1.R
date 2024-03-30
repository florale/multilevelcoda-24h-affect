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
m_hapa_lag_adj <- readRDS("m_hapa_lag_adj.RDS")
m_hapa_lag_adj <- readRDS("m_lapa_lag_adj.RDS")
m_hana_lag_adj <- readRDS("m_hana_lag_adj.RDS")
m_lana_lag_adj <- readRDS("m_lana_lag_adj.RDS")

## substitution
plan(multisession, workers = 5)
m_hapa_lag_adj_sub <- substitution(
  m_hapa_lag_adj,
  delta = c(1:60),
  # delta = c(60),
  level = c("between", "within"),
  ref = "grandmean")

m_lapa_lag_adj_sub <- substitution(
  m_lapa_lag_adj,
  delta = c(1:60),
  # delta = c(60),
  level = c("between", "within"),
  ref = "grandmean")
plan(sequential)

saveRDS(m_hapa_lag_adj_sub, "m_hapa_lag_adj_sub.RDS")
saveRDS(m_lapa_lag_adj_sub, "m_lapa_lag_adj_sub.RDS")



