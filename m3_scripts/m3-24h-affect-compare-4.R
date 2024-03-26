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

# BF -------
comparison_hapa <- bayesfactor_models(m_hapa$Model, mb_hapa$Model, mw_hapa$Model, denominator = m0_hapa$Model)
comparison_lapa <- bayesfactor_models(m_lapa$Model, mb_lapa$Model, mw_lapa$Model, denominator = m0_lapa$Model)
comparison_hana <- bayesfactor_models(m_hana$Model, mb_hana$Model, mw_hana$Model, denominator = m0_hana$Model)
comparison_lana <- bayesfactor_models(m_lana$Model, mb_lana$Model, mw_lana$Model, denominator = m0_lana$Model)

comparison_hapa
comparison_lapa
comparison_hana
comparison_lana