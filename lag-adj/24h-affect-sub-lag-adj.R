m_hapa_lag_adj <- readRDS(paste0(outputdir, "m_hapa_lag_adj", ".RDS"))

plan(multisession, workers = 5)
m_hapa_lag_adj_sub <- substitution(
  m_hapa,
  # delta = c(1:60),
  delta = c(30),
  level = c("between", "within"),
  ref = "grandmean")
plan(sequential)
summary(m_hapa_lag_adj_sub, delta = 30)
