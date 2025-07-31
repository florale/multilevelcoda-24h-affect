source("24h-affect-setup.R")

m_hapa <- readRDS(paste0(outputdir, "m_hapa", ".RDS"))
m_lapa <- readRDS(paste0(outputdir, "m_lapa", ".RDS"))
m_hana <- readRDS(paste0(outputdir, "m_hana", ".RDS"))
m_lana <- readRDS(paste0(outputdir, "m_lana", ".RDS"))

# MCMC sampling diagnostics

plot_mcmc_hapa <- plot(m_hapa, variable = c("b_Intercept", 
                                            "b_bilr1", "b_bilr2", "b_bilr3", "b_bilr4", 
                                            "b_wilr1", "b_wilr2", "b_wilr3", "b_wilr4"
                                            #   "sd_ID__Intercept",
                                            #   "sd_ID__wilr1", "sd_ID__wilr2", "sd_ID__wilr3", "sd_ID__wilr4"
), regex = TRUE)

saveRDS(plot_mcmc_hapa, paste0(outputdir, "plot_mcmc_hapa.RDS"))

plot_mcmc_lapa <- plot(m_lapa, variable = c("b_Intercept", 
                                            "b_bilr1", "b_bilr2", "b_bilr3", "b_bilr4", 
                                            "b_wilr1", "b_wilr2", "b_wilr3", "b_wilr4"
                                            #   "sd_ID__Intercept",
                                            #   "sd_ID__wilr1", "sd_ID__wilr2", "sd_ID__wilr3", "sd_ID__wilr4"
), regex = TRUE)
saveRDS(plot_mcmc_lapa, paste0(outputdir, "plot_mcmc_lapa.RDS"))

plot_mcmc_hana <- plot(m_hana, variable = c("b_Intercept", 
                                            "b_bilr1", "b_bilr2", "b_bilr3", "b_bilr4", 
                                            "b_wilr1", "b_wilr2", "b_wilr3", "b_wilr4"
                                            #   "sd_ID__Intercept",
                                            #   "sd_ID__wilr1", "sd_ID__wilr2", "sd_ID__wilr3", "sd_ID__wilr4"
), regex = TRUE)
saveRDS(plot_mcmc_hana, paste0(outputdir, "plot_mcmc_hana.RDS"))

plot_mcmc_lana <- plot(m_lana, variable = c("b_Intercept", 
                                            "b_bilr1", "b_bilr2", "b_bilr3", "b_bilr4", 
                                            "b_wilr1", "b_wilr2", "b_wilr3", "b_wilr4"
                                            #   "sd_ID__Intercept",
                                            #   "sd_ID__wilr1", "sd_ID__wilr2", "sd_ID__wilr3", "sd_ID__wilr4"
), regex = TRUE)
saveRDS(plot_mcmc_lana, paste0(outputdir, "plot_mcmc_lana.RDS"))

# Extract R-hat values from brms models
# R-hat values assess convergence - values close to 1.0 indicate good convergence
# Values > 1.1 typically indicate poor convergence

# Function to extract R-hat values and summary statistics
extract_rhat <- function(model, model_name) {
  # Get R-hat values
  rhat_values <- rhat(model$model, 
                      pars = c("b_Intercept", 
                               "b_bilr1", "b_bilr2", "b_bilr3", "b_bilr4", 
                               "b_wilr1", "b_wilr2", "b_wilr3", "b_wilr4"))
  # Create summary
  rhat_summary <- data.frame(
    Model = model_name,
    Min = min(rhat_values, na.rm = TRUE),
    Max = max(rhat_values, na.rm = TRUE),
    Mean = mean(rhat_values, na.rm = TRUE),
    Median = median(rhat_values, na.rm = TRUE),
    N_above_1.01 = sum(rhat_values > 1.01, na.rm = TRUE)
    #  N_above_1.1 = sum(rhat_values > 1.1, na.rm = TRUE),
    #  Total_params = length(rhat_values)
  )
  
  return(list(
    summary = rhat_summary,
    values = rhat_values
  ))
}

# Extract R-hat values for each model
cat("Extracting R-hat values...\n")

rhat_hapa <- extract_rhat(m_hapa, "High arousal positive affect")
rhat_lapa <- extract_rhat(m_lapa, "Low arousal positive affect")
rhat_hana <- extract_rhat(m_hana, "High arousal negative affect")
rhat_lana <- extract_rhat(m_lana, "Low arousal negative affect")

# Combine summaries
rhat_summary <- rbind(
  rhat_hapa$summary,
  rhat_lapa$summary,
  rhat_hana$summary,
  rhat_lana$summary
)

# Print R-hat summary
cat("\n=== R-hat Summary ===\n")
print(rhat_summary)

saveRDS(rhat_summary, paste0(outputdir, "rhat_summary.RDS"))

# --- ESS (Effective Sample Size) summary for brms models ---
# Function to extract ESS values and summary statistics
extract_ess <- function(model, model_name) {
  ess_values <- effective_sample(model$model, 
                                 parameters = c("b_Intercept", 
                                                "b_bilr1", "b_bilr2", "b_bilr3", "b_bilr4", 
                                                "b_wilr1", "b_wilr2", "b_wilr3", "b_wilr4"))
  ess_bulk_summary <- data.frame(
    Model = model_name,
    Min = min(ess_values$ESS, na.rm = TRUE),
    Max = max(ess_values$ESS, na.rm = TRUE),
    Mean = mean(ess_values$ESS, na.rm = TRUE),
    Median = median(ess_values$ESS, na.rm = TRUE),
    N_below_800 = sum(ess_values$ESS < 800, na.rm = TRUE)
  )
  ess_tail_summary <- data.frame(
    Model = model_name,
    Min = min(ess_values$ESS_tail, na.rm = TRUE),
    Max = max(ess_values$ESS_tail, na.rm = TRUE),
    Mean = mean(ess_values$ESS_tail, na.rm = TRUE),
    Median = median(ess_values$ESS_tail, na.rm = TRUE),
    N_below_800 = sum(ess_values$ESS_tail < 800, na.rm = TRUE)
  )
  return(list(
    bulk_summary = ess_bulk_summary,
    tail_summary = ess_tail_summary,
    values = ess_values
  ))
}

# Extract ESS values for each model
cat("Extracting ESS values...\n")
ess_hapa <- extract_ess(m_hapa, "High arousal positive affect")
ess_lapa <- extract_ess(m_lapa, "Low arousal positive affect")
ess_hana <- extract_ess(m_hana, "High arousal negative affect")
ess_lana <- extract_ess(m_lana, "Low arousal negative affect")

# Combine summaries
ess_bulk_summary <- rbind(
  ess_hapa$bulk_summary,
  ess_lapa$bulk_summary,
  ess_hana$bulk_summary,
  ess_lana$bulk_summary
)
ess_tail_summary <- rbind(
  ess_hapa$tail_summary,
  ess_lapa$tail_summary,
  ess_hana$tail_summary,
  ess_lana$tail_summary
)

# Print ESS summary
cat("\n=== ESS Summary ===\n")
print(ess_bulk_summary)
print(ess_tail_summary)

saveRDS(ess_bulk_summary, paste0(outputdir, "ess_bulk_summary.RDS"))
saveRDS(ess_tail_summary, paste0(outputdir, "ess_tail_summary.RDS"))
