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

## models---------
m_hapa_lag_adj <- readRDS("m_hapa_lag_adj.RDS")
m_lapa_lag_adj <- readRDS("m_lapa_lag_adj.RDS")
m_hana_lag_adj <- readRDS("m_hana_lag_adj.RDS")
m_lana_lag_adj <- readRDS("m_lana_lag_adj.RDS")

mb_hapa_lag_adj <- readRDS("mb_hapa_lag_adj.RDS")
mb_lapa_lag_adj <- readRDS("mb_lapa_lag_adj.RDS")
mb_hana_lag_adj <- readRDS("mb_hana_lag_adj.RDS")
mb_lana_lag_adj <- readRDS("mb_lana_lag_adj.RDS")

mw_hapa_lag_adj <- readRDS("mw_hapa_lag_adj.RDS")
mw_lapa_lag_adj <- readRDS("mw_lapa_lag_adj.RDS")
mw_hana_lag_adj <- readRDS("mw_hana_lag_adj.RDS")
mw_lana_lag_adj <- readRDS("mw_lana_lag_adj.RDS")

m0_hapa_lag_adj <- readRDS("m0_hapa_lag_adj.RDS")
m0_lapa_lag_adj <- readRDS("m0_lapa_lag_adj.RDS")
m0_hana_lag_adj <- readRDS("m0_hana_lag_adj.RDS")
m0_lana_lag_adj <- readRDS("m0_lana_lag_adj.RDS")

## loo ------------
options(mc.cores = 20)

loo_mw_hapa_lag_adj <- loo(mw_hapa_lag_adj$Model, reloo = TRUE, 
                  reloo_args = list(recompile = TRUE, 
                                    future_args = list(globals = list(future.globals.maxSize = 850*1024^2))))
saveRDS(loo_mw_hapa_lag_adj, "loo_mw_hapa_lag_adj.RDS")

loo_mw_lapa_lag_adj <- loo(mw_lapa_lag_adj$Model, reloo = TRUE, 
                  reloo_args = list(recompile = TRUE, 
                                    future_args = list(globals = list(future.globals.maxSize = 850*1024^2))))
saveRDS(loo_mw_lapa_lag_adj, "loo_mw_lapa_lag_adj.RDS")

loo_mw_hana_lag_adj <- loo(mw_hana_lag_adj$Model, reloo = TRUE, 
                  reloo_args = list(recompile = TRUE, 
                                    future_args = list(globals = list(future.globals.maxSize = 850*1024^2))))
saveRDS(loo_mw_hana_lag_adj, "loo_mw_hana_lag_adj.RDS")

loo_mw_lana_lag_adj <- loo(mw_lana_lag_adj$Model, reloo = TRUE, 
                  reloo_args = list(recompile = TRUE, 
                                    future_args = list(globals = list(future.globals.maxSize = 850*1024^2))))
saveRDS(loo_mw_lana_lag_adj, "loo_mw_lana_lag_adj.RDS")

loo_m0_hapa_lag_adj <- loo(m0_hapa_lag_adj$Model, reloo = TRUE, 
                   reloo_args = list(recompile = TRUE, 
                                     future_args = list(globals = list(future.globals.maxSize = 850*1024^2))))
saveRDS(loo_m0_hapa_lag_adj, "loo_m0_hapa_lag_adj.RDS")

loo_m0_lapa_lag_adj <- loo(m0_lapa_lag_adj$Model, reloo = TRUE, 
                   reloo_args = list(recompile = TRUE, 
                                     future_args = list(globals = list(future.globals.maxSize = 850*1024^2))))
saveRDS(loo_m0_lapa_lag_adj, "loo_m0_lapa_lag_adj.RDS")

loo_m0_hana_lag_adj <- loo(m0_hana_lag_adj$Model, reloo = TRUE, 
                   reloo_args = list(recompile = TRUE, 
                                     future_args = list(globals = list(future.globals.maxSize = 850*1024^2))))
saveRDS(loo_m0_hana_lag_adj, "loo_m0_hana_lag_adj.RDS")

loo_m0_lana_lag_adj <- loo(m0_lana_lag_adj$Model, reloo = TRUE, 
                   reloo_args = list(recompile = TRUE, 
                                     future_args = list(globals = list(future.globals.maxSize = 850*1024^2))))
saveRDS(loo_m0_lana_lag_adj, "loo_m0_lana_lag_adj.RDS")
