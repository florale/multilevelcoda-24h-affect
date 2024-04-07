source("24h-affect-utils.R")

# set up plots ----------------
col <- c(`Sleepg` = "#647F9A",
         `WAKEg` = "#A1B2C2",
         `MVPAg` = "#978787",
         `LPAg` = "#BEACA2",
         `SBg` = "#C99696")

colf <- c(`Sleepg` = "#647F9A",
          `WAKEg` = "#A1B2C2",
          `MVPAg` = "#ab8b8b",
          `LPAg` = "#D1ACA5",
          `SBg` = "#C99696")

names <- c(`Sleepg` = "Sleep",
           `WAKEg` = "Wake Time in Bed",
           `MVPAg` = "MVPA",
           `LPAg` = "LPA",
           `SBg` = "SB")
labeller <- function(variable,value){
  return(names[value])
}
alpha <- 1/10

# read models
m_hapa_sub <- readRDS(paste0(outputdir, "m_hapa_sub", ".RDS"))
m_lapa_sub <- readRDS(paste0(outputdir, "m_lapa_sub", ".RDS"))
m_hana_sub <- readRDS(paste0(outputdir, "m_hana_sub", ".RDS"))
m_lana_sub <- readRDS(paste0(outputdir, "m_lana_sub", ".RDS"))

# read models
m_hapa_sub <- readRDS(paste0(outputdir, "m_hapa_sub", ".RDS"))
m_lapa_sub <- readRDS(paste0(outputdir, "m_lapa_sub", ".RDS"))
m_hana_sub <- readRDS(paste0(outputdir, "m_hana_sub", ".RDS"))
m_lana_sub <- readRDS(paste0(outputdir, "m_lana_sub", ".RDS"))

m_hapa_sub <- as.data.table(summary(m_hapa_sub, delta = c(-60:60), digits = "asis"))
m_lapa_sub <- as.data.table(summary(m_lapa_sub, delta = c(-60:60), digits = "asis"))
m_hana_sub <- as.data.table(summary(m_hana_sub, delta = c(-60:60), digits = "asis"))
m_lana_sub <- as.data.table(summary(m_lana_sub, delta = c(-60:60), digits = "asis"))

m_hapa_sub$sig <- between(0, m_hapa_sub$CI_low, m_hapa_sub$CI_high)
m_lapa_sub$sig <- between(0, m_lapa_sub$CI_low, m_lapa_sub$CI_high)
m_hana_sub$sig <- between(0, m_hana_sub$CI_low, m_hana_sub$CI_high)
m_lana_sub$sig <- between(0, m_lana_sub$CI_low, m_lana_sub$CI_high)

m_hapa_sub[, Sig := NA]
m_lapa_sub[, Sig := NA]
m_hana_sub[, Sig := NA]
m_lana_sub[, Sig := NA]

m_hapa_sub[, Sig := ifelse(sig == FALSE & Delta %in% c(-55, 55), "*", "")]
m_lapa_sub[, Sig := ifelse(sig == FALSE & Delta %in% c(-55, 55), "*", "")]
m_hana_sub[, Sig := ifelse(sig == FALSE & Delta %in% c(-55, 55), "*", "")]
m_lana_sub[, Sig := ifelse(sig == FALSE & Delta %in% c(-55, 55), "*", "")]

# make a grid to loop plots
sub_models   <- c("m_hapa_sub", "m_lapa_sub", "m_hana_sub",  "m_lana_sub")
resp         <- c("High Arousal Positive Affect", "Low Arousal Positive Affect", 
                  "High Arousal Negative Affect", "Low Arousal Negative Affect")
level        <- c("between", "within")
level_labels <- c("Between-person ", "Within-person ")
parts        <- c("Sleepg" , "WAKEg", "MVPAg", "LPAg", "SBg")
part_labels  <- c("Sleep", "Wake Time in Bed", "Moderate-to-Vigorous Physical Activity", "Light Physical Activity", "Sedentary Behaviour")

rg <- expand.grid.df(data.frame(sub_models, resp), 
                     data.frame(level, level_labels),
                     data.frame(parts, part_labels))
rg <- rg[order(rg$level, rg$sub_models), ]

# between -------------------
h24_affect_plot_b <- foreach(i = 1:20,
                             .packages = "multilevelcoda") %dopar% {
                               
                               ggplot(get(rg[i, "sub_models"])[To == eval(rg[i, "parts"]) & Level == eval(rg[i, "level"])], 
                                      aes(x = Delta, y = Mean)) +
                                 geom_hline(yintercept = 0, linewidth = 0.2, linetype = 2) +
                                 geom_vline(xintercept = 0, linewidth = 0.2, linetype = 2) +    
                                 geom_ribbon(aes(ymin = CI_low,
                                                 ymax = CI_high, fill = From),
                                             alpha = alpha) +
                                 geom_line(aes(colour = From), linewidth = 1) +
                                 geom_text(aes(label = Sig), 
                                           size = 6, nudge_x = 0.05, nudge_y = 0.2, 
                                           show.legend = FALSE) +
                                 scale_colour_manual(values = col) +
                                 scale_fill_manual(values = colf) +
                                 labs(x = paste0("Difference in ", rg[i, "part_labels"], " at Between-person Level"),
                                      y = paste0("Difference in ", rg[i, "resp"])) +
                                 
                                 facet_grid( ~ From, labeller = labeller) +
                                 scale_x_continuous(limits = c(-60, 60),
                                                    breaks = c(-60, 0, 60)) +
                                 scale_y_continuous(limits = c(-2, 2),
                                                    breaks = c(-2, -1, 0, 1, 2)) +
                                 hrbrthemes::theme_ipsum() +
                                 theme(
                                   axis.ticks        = element_blank(),
                                   panel.background  = element_blank(),
                                   panel.border      = element_blank(),
                                   panel.grid.major  = element_blank(),
                                   panel.grid.minor  = element_blank(),
                                   plot.background   = element_rect(fill = "transparent", colour = NA),
                                   # strip.text = element_blank(),
                                   axis.title.x      = element_text(size = 14, face = "bold"),
                                   axis.title.y      = element_text(size = 14, face = "bold", hjust = .5),
                                   plot.margin = margin(.5, .5, .5, .5, "cm"),
                                   legend.position = "none"
                                 )
                             }

names(h24_affect_plot_b) <- foreach(i = 1:20) %dopar% {
  paste0(rg[i, "level_labels"], "Reallocation of ", rg[i, "part_labels"], " and ", rg[i, "resp"])
}

saveRDS(h24_affect_plot_b, paste0(outputdir, "h24_affect_plot_b", ".RDS"))

# within  -------------------
h24_affect_plot_w <- foreach(i = 21:40,
                             .packages = "multilevelcoda") %dopar% {
                               
                               ggplot(get(rg[i, "sub_models"])[To == eval(rg[i, "parts"]) & Level == eval(rg[i, "level"])], 
                                      aes(x = Delta, y = Mean)) +
                                 geom_hline(yintercept = 0, linewidth = 0.2, linetype = 2) +
                                 geom_vline(xintercept = 0, linewidth = 0.2, linetype = 2) +    
                                 geom_ribbon(aes(ymin = CI_low,
                                                 ymax = CI_high, fill = From),
                                             alpha = alpha) +
                                 geom_line(aes(colour = From), linewidth = 1) +
                                 geom_text(aes(label = Sig), 
                                           size = 6, nudge_x = 0.05, nudge_y = 0.025, 
                                           show.legend = FALSE) +
                                 scale_colour_manual(values = col) +
                                 scale_fill_manual(values = colf) +
                                 labs(x = paste0("Difference in ", rg[i, "part_labels"], " at Within-person Level"),
                                      y = paste0("Difference in ", rg[i, "resp"])) +
                                 facet_grid( ~ From, labeller = labeller) +
                                 scale_x_continuous(limits = c(-60, 60),
                                                    breaks = c(-60, 0, 60)) +
                                 scale_y_continuous(limits = c(-0.35, 0.35),
                                                    breaks = c(-0.25, 0, 0.25)) +
                                 hrbrthemes::theme_ipsum() +
                                 theme(
                                   axis.ticks        = element_blank(),
                                   panel.background  = element_blank(),
                                   panel.border      = element_blank(),
                                   panel.grid.major  = element_blank(),
                                   panel.grid.minor  = element_blank(),
                                   plot.background   = element_rect(fill = "transparent", colour = NA),
                                   # strip.text = element_blank(),
                                   axis.title.x      = element_text(size = 14, face = "bold"),
                                   axis.title.y      = element_text(size = 14, face = "bold", hjust = .5),
                                   plot.margin = margin(.5, .5, .5, .5, "cm"),
                                   legend.position = "none"
                                 )
                             }


names(h24_affect_plot_w) <- foreach(i = 21:40) %dopar% {
  paste0(rg[i, "level_labels"], "Reallocation of ", rg[i, "part_labels"], " and ", rg[i, "resp"])
}

saveRDS(h24_affect_plot_w, paste0(outputdir, "h24_affect_plot_w", ".RDS"))

# print plots --------------------------
extrafont::loadfonts()


#sig
h24_affect_plot_w[[9]]
h24_affect_plot_w[[13]]

grDevices::cairo_pdf(
  file = paste0(outputdir, "plotw_hapa_lpa", ".pdf"),
  width = 8,
  height = 4,
)
h24_affect_plot_w[[9]]
dev.off()

grDevices::cairo_pdf(
  file = paste0(outputdir, "plotw_lana_mvpa", ".pdf"),
  width = 8,
  height = 4,
)
h24_affect_plot_w[[13]]
dev.off()


