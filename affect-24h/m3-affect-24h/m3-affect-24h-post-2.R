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

m_hapa_24h <- readRDS(paste0("m_hapa_24h", ".RDS"))
m_lapa_24h <- readRDS(paste0("m_lapa_24h", ".RDS"))
m_hana_24h <- readRDS(paste0("m_hana_24h", ".RDS"))
m_lana_24h <- readRDS(paste0("m_lana_24h", ".RDS"))

# posthoc hana --------------------
d0 <- model.frame(m_hana_24h)
y0 <- as.data.table(fitted(
  m_hana_24h,
  newdata = d0,
  re_formula = NULL,
  summary = FALSE
))
y0 <- dcast(y0, V1 + V2 ~ V3, value.var = "value")

# between hana effect
db <- as.data.table(d0)[, BNegAffHADay := BNegAffHADay + 1]
yb <- as.data.table(fitted(
  m_hana_24h,
  newdata = db,
  re_formula = NULL,
  summary = FALSE
))
yb <- dcast(yb, V1 + V2 ~ V3, value.var = "value")

ilr0 <- y0[, colnames(m_hana_24h$CompILR$TotalILR), with = FALSE]
m_hana_24h_0 <- ilrInv(ilr0, V = m_hana_24h$CompILR$psi)
m_hana_24h_0 <- as.data.table(clo(m_hana_24h_0, total = m_hana_24h$CompILR$total))
names(m_hana_24h_0) <- part_ss

ilrb <- yb[, colnames(m_hana_24h$CompILR$TotalILR), with = FALSE]
m_hana_24h_b <- ilrInv(ilrb, V = m_hana_24h$CompILR$psi)
m_hana_24h_b <- as.data.table(clo(m_hana_24h_b, total = m_hana_24h$CompILR$total))
names(m_hana_24h_b) <- part_ss

m_hana_24h_delta_b <- m_hana_24h_b - m_hana_24h_0
(m_hana_24h_delta_b <- describe_posterior(m_hana_24h_delta_b, centrality = "mean"))

saveRDS(m_hana_24h_delta_b, paste0("m_hana_24h_delta_b", ".RDS"))

# within hana effect
dw <- as.data.table(d0)[, WNegAffHADay := WNegAffHADay + 1]
yw <- as.data.table(fitted(
  m_hana_24h,
  newdata = dw,
  re_formula = NULL,
  summary = FALSE
))
yw <- dcast(yw, V1 + V2 ~ V3, value.var = "value")

ilr0 <- y0[, colnames(m_hana_24h$CompILR$TotalILR), with = FALSE]
m_hana_24h_0 <- ilrInv(ilr0, V = m_hana_24h$CompILR$psi)
m_hana_24h_0 <- as.data.table(clo(m_hana_24h_0, total = m_hana_24h$CompILR$total))
names(m_hana_24h_0) <- part_ss

ilrw <- yw[, colnames(m_hana_24h$CompILR$TotalILR), with = FALSE]
m_hana_24h_w <- ilrInv(ilrw, V = m_hana_24h$CompILR$psi)
m_hana_24h_w <- as.data.table(clo(m_hana_24h_w, total = m_hana_24h$CompILR$total))
names(m_hana_24h_w) <- part_ss

m_hana_24h_delta_w <- m_hana_24h_w - m_hana_24h_0
(m_hana_24h_delta_w <- describe_posterior(m_hana_24h_delta_w, centrality = "mean"))

saveRDS(m_hana_24h_delta_w, paste0("m_hana_24h_delta_w", ".RDS"))

# posthoc lana --------------------
d0 <- model.frame(m_lana_24h)
y0 <- as.data.table(fitted(
  m_lana_24h,
  newdata = d0,
  re_formula = NULL,
  summary = FALSE
))
y0 <- dcast(y0, V1 + V2 ~ V3, value.var = "value")

# between lana effect
db <- as.data.table(d0)[, BNegAffLADay := BNegAffLADay + 1]
yb <- as.data.table(fitted(
  m_lana_24h,
  newdata = db,
  re_formula = NULL,
  summary = FALSE
))
yb <- dcast(yb, V1 + V2 ~ V3, value.var = "value")

ilr0 <- y0[, colnames(m_lana_24h$CompILR$TotalILR), with = FALSE]
m_lana_24h_0 <- ilrInv(ilr0, V = m_lana_24h$CompILR$psi)
m_lana_24h_0 <- as.data.table(clo(m_lana_24h_0, total = m_lana_24h$CompILR$total))
names(m_lana_24h_0) <- part_ss

ilrb <- yb[, colnames(m_lana_24h$CompILR$TotalILR), with = FALSE]
m_lana_24h_b <- ilrInv(ilrb, V = m_lana_24h$CompILR$psi)
m_lana_24h_b <- as.data.table(clo(m_lana_24h_b, total = m_lana_24h$CompILR$total))
names(m_lana_24h_b) <- part_ss

m_lana_24h_delta_b <- m_lana_24h_b - m_lana_24h_0
(m_lana_24h_delta_b <- describe_posterior(m_lana_24h_delta_b, centrality = "mean"))

saveRDS(m_lana_24h_delta_b, paste0("m_lana_24h_delta_b", ".RDS"))

# within lana effect
dw <- as.data.table(d0)[, WNegAffLADay := WNegAffLADay + 1]
yw <- as.data.table(fitted(
  m_lana_24h,
  newdata = dw,
  re_formula = NULL,
  summary = FALSE
))
yw <- dcast(yw, V1 + V2 ~ V3, value.var = "value")

ilr0 <- y0[, colnames(m_lana_24h$CompILR$TotalILR), with = FALSE]
m_lana_24h_0 <- ilrInv(ilr0, V = m_lana_24h$CompILR$psi)
m_lana_24h_0 <- as.data.table(clo(m_lana_24h_0, total = m_lana_24h$CompILR$total))
names(m_lana_24h_0) <- part_ss

ilrw <- yw[, colnames(m_lana_24h$CompILR$TotalILR), with = FALSE]
m_lana_24h_w <- ilrInv(ilrw, V = m_lana_24h$CompILR$psi)
m_lana_24h_w <- as.data.table(clo(m_lana_24h_w, total = m_lana_24h$CompILR$total))
names(m_lana_24h_w) <- part_ss

m_lana_24h_delta_w <- m_lana_24h_w - m_lana_24h_0
(m_lana_24h_delta_w <- describe_posterior(m_lana_24h_delta_w, centrality = "mean"))

saveRDS(m_lana_24h_delta_w, paste0("m_lana_24h_delta_w", ".RDS"))
