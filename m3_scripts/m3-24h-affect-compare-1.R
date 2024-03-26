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

loo_m_hapa <- loo(m_hapa$Model, cores = 20)
loo_m_hapa <- reloo(m_hapa$Model, loo_m_hapa, future_args = list(globals = list(future.globals.maxSize = 850*1024^2)))
saveRDS(loo_m_hapa, "loo_m_hapa.RDS")

loo_m_lapa <- loo(m_lapa$Model, cores = 20)
loo_m_lapa <- reloo(m_lapa$Model, loo_m_lapa, future_args = list(globals = list(future.globals.maxSize = 850*1024^2)))
saveRDS(loo_m_lapa, "loo_m_lapa.RDS")

loo_m_hana <- loo(m_hana$Model, cores = 20)
loo_m_hana <- reloo(m_hana$Model, loo_m_hana, future_args = list(globals = list(future.globals.maxSize = 850*1024^2)))
saveRDS(loo_m_hana, "loo_m_hana.RDS")

loo_m_lana <- loo(m_lana$Model, cores = 20)
loo_m_lana <- reloo(m_lana$Model, loo_m_lana, future_args = list(globals = list(future.globals.maxSize = 850*1024^2)))
saveRDS(loo_m_lana, "loo_m_lana.RDS")

loo_mb_hapa <- loo(mb_hapa$Model, cores = 20)
loo_mb_hapa<- reloo(mb_hapa$Model, loo_mb_hapa, future_args = list(globals = list(future.globals.maxSize = 850*1024^2)))
saveRDS(loo_mb_hapa, "loo_mb_hapa.RDS")

loo_mb_lapa <- loo(mb_lapa$Model, cores = 20)
loo_mb_lapa<- reloo(mb_lapa$Model, loo_mb_lapa, future_args = list(globals = list(future.globals.maxSize = 850*1024^2)))
saveRDS(loo_mb_lapa, "loo_mb_lapa.RDS")

loo_mb_hana <- loo(mb_hana$Model, cores = 20)
loo_mb_hana<- reloo(mb_hana$Model, loo_mb_hana, future_args = list(globals = list(future.globals.maxSize = 850*1024^2)))
saveRDS(loo_mb_hana, "loo_mb_hana.RDS")

loo_mb_lana <- loo(mb_lana$Model, cores = 20)
loo_mb_lana<- reloo(mb_lana$Model, loo_mb_lana, future_args = list(globals = list(future.globals.maxSize = 850*1024^2)))
saveRDS(loo_mb_lana, "loo_mb_lana.RDS")
