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
m_hapa <- readRDS("m_hapa.RDS")
m_lapa <- readRDS("m_lapa.RDS")
m_hana <- readRDS("m_hana.RDS")
m_lana <- readRDS("m_lana.RDS")

mb_hapa <- readRDS("mb_hapa.RDS")
mb_lapa <- readRDS("mb_lapa.RDS")
mb_hana <- readRDS("mb_hana.RDS")
mb_lana <- readRDS("mb_lana.RDS")

mw_hapa <- readRDS("mw_hapa.RDS")
mw_lapa <- readRDS("mw_lapa.RDS")
mw_hana <- readRDS("mw_hana.RDS")
mw_lana <- readRDS("mw_lana.RDS")

m0_hapa <- readRDS("m0_hapa.RDS")
m0_lapa <- readRDS("m0_lapa.RDS")
m0_hana <- readRDS("m0_hana.RDS")
m0_lana <- readRDS("m0_lana.RDS")

## loo ------------
options(mc.cores = 20)
options(future.globals.maxSize = 850*1024^2)

loo_mw_hapa <- loo(mw_hapa$Model, reloo = TRUE, 
                   reloo_args = list(recompile = TRUE, 
                                     future_args = list(globals = list(future.globals.maxSize = 850*1024^2))))
saveRDS(loo_mw_hapa, "loo_mw_hapa.RDS")

loo_mw_lapa <- loo(mw_lapa$Model, reloo = TRUE, 
                   reloo_args = list(recompile = TRUE, 
                                     future_args = list(globals = list(future.globals.maxSize = 850*1024^2))))
saveRDS(loo_mw_lapa, "loo_mw_lapa.RDS")

loo_mw_hana <- loo(mw_hana$Model, reloo = TRUE, 
                   reloo_args = list(recompile = TRUE, 
                                     future_args = list(globals = list(future.globals.maxSize = 850*1024^2))))
saveRDS(loo_mw_hana, "loo_mw_hana.RDS")

loo_mw_lana <- loo(mw_lana$Model, reloo = TRUE, 
                   reloo_args = list(recompile = TRUE, 
                                     future_args = list(globals = list(future.globals.maxSize = 850*1024^2))))
saveRDS(loo_mw_lana, "loo_mw_lana.RDS")

loo_m0_hapa <- loo(m0_hapa$Model, reloo = TRUE, 
                   reloo_args = list(recompile = TRUE, 
                                     future_args = list(globals = list(future.globals.maxSize = 850*1024^2))))
saveRDS(loo_m0_hapa, "loo_m0_hapa.RDS")

loo_m0_lapa <- loo(m0_lapa$Model, reloo = TRUE, 
                   reloo_args = list(recompile = TRUE, 
                                     future_args = list(globals = list(future.globals.maxSize = 850*1024^2))))
saveRDS(loo_m0_lapa, "loo_m0_lapa.RDS")

loo_m0_hana <- loo(m0_hana$Model, reloo = TRUE, 
                   reloo_args = list(recompile = TRUE, 
                                     future_args = list(globals = list(future.globals.maxSize = 850*1024^2))))
saveRDS(loo_m0_hana, "loo_m0_hana.RDS")

loo_m0_lana <- loo(m0_lana$Model, reloo = TRUE, 
                   reloo_args = list(recompile = TRUE, 
                                     future_args = list(globals = list(future.globals.maxSize = 850*1024^2))))
saveRDS(loo_m0_lana, "loo_m0_lana.RDS")
