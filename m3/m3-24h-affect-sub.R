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
mhapa_ww_sub <- substitution(
  m_hapa,
  delta = c(1:60),
  # delta = c(60),
  level = c("between", "within"),
  ref = "grandmean")

mlapa_ww_sub <- substitution(
  m_lapa,
  delta = c(1:60),
  # delta = c(60),
  level = c("between", "within"),
  ref = "grandmean")

mhana_ww_sub <- substitution(
  m_hana,
  delta = c(1:60),
  # delta = c(60),
  level = c("between", "within"),
  ref = "grandmean")

mlana_ww_sub <- substitution(
  mlana,
  delta = c(1:60),
  # delta = c(60),
  level = c("between", "within"),
  ref = "grandmean")
plan(sequential)

## substitution summary 
summary(mhapa_ww_sub, delta = 30)
summary(mlapa_ww_sub, delta = 30)
summary(mhana_ww_sub, delta = 30)
summary(mlana_ww_sub, delta = 30)

saveRDS(mhapa_ww_sub, "mhapa_ww_sub.RDS")
saveRDS(mlapa_ww_sub, "mlapa_ww_sub.RDS")
saveRDS(mhana_ww_sub, "mhana_ww_sub.RDS")
saveRDS(mlana_ww_sub, "mlana_ww_sub.RDS")

