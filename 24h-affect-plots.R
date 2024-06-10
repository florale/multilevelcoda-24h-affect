source("24h-affect-utils.R")

# set up plots ----------------
col <- c(`Sleep` = "#647F9A",
         `Awake` = "#A1B2C2",
         `MVPA` = "#978787",
         `LPA` = "#B87474", #B87474
         `SB` = "#D2A7A7")

colf <- c(`Sleep` = "#647F9A",
          `Awake` = "#A1B2C2",
          `MVPA` = "#ab8b8b",
          `LPA` = "#C08585",
          `SB` = "#D2A7A7")

protan <- dichromat::dichromat(col, type = "protan")
deutan <- dichromat::dichromat(col, type = "deutan")
tritan <- dichromat::dichromat(col, type = "tritan")

# plot for comparison
layout(matrix(1:4, nrow = 4)); par(mar = rep(1, 4))
recolorize::plotColorPalette(col, main = "Trichromacy")
recolorize::plotColorPalette(protan, main = "Protanopia")
recolorize::plotColorPalette(deutan, main = "Deutanopia")
recolorize::plotColorPalette(tritan, main = "Tritanopia")

names <- c(`Sleepg` = "Sleep",
           `WAKEg` = "Awake",
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

# make a grid to loop plots
sub_models   <- c("m_hapa_sub", "m_lapa_sub", "m_hana_sub",  "m_lana_sub")
resp         <- c("High Arousal Positive Affect", "Low Arousal Positive Affect", 
                  "High Arousal Negative Affect", "Low Arousal Negative Affect")
level        <- c("between", "within")
level_labels <- c("Between-person ", "Within-person ")
parts        <- c("Sleep" , "Awake", "MVPA", "LPA", "SB")
part_labels  <- c("Sleep", "Awake", "Moderate-to-Vigorous Physical Activity", "Light Physical Activity", "Sedentary Behaviour")

rg <- expand.grid.df(data.frame(sub_models, resp), 
                     data.frame(level, level_labels),
                     data.frame(parts, part_labels))
rg <- rg[order(rg$level, rg$sub_models), ]

# standarised coefs
rg$smean <- NA
rg$smean <- ifelse(level == "between" & sub_models == "m_hapa_sub", sd(dw[Survey == "Evening"]$BPosAffHADayLead, na.rm = T), rg$smean)
rg$smean <- ifelse(level == "between" & sub_models == "m_lapa_sub", sd(dw[Survey == "Evening"]$BPosAffLADayLead, na.rm = T), rg$smean)
rg$smean <- ifelse(level == "between" & sub_models == "m_hana_sub", sd(dw[Survey == "Evening"]$BNegAffHADayLead, na.rm = T), rg$smean)
rg$smean <- ifelse(level == "between" & sub_models == "m_lana_sub", sd(dw[Survey == "Evening"]$BNegAffLADayLead, na.rm = T), rg$smean)

rg$smean <- ifelse(level == "within" & sub_models == "m_hapa_sub", sd(dw[Survey == "Evening"]$WPosAffHADayLead, na.rm = T), rg$smean)
rg$smean <- ifelse(level == "within" & sub_models == "m_lapa_sub", sd(dw[Survey == "Evening"]$WPosAffLADayLead, na.rm = T), rg$smean)
rg$smean <- ifelse(level == "within" & sub_models == "m_hana_sub", sd(dw[Survey == "Evening"]$WNegAffHADayLead, na.rm = T), rg$smean)
rg$smean <- ifelse(level == "within" & sub_models == "m_lana_sub", sd(dw[Survey == "Evening"]$WNegAffLADayLead, na.rm = T), rg$smean)

# between -------------------
sub_models_b <- list()

for(i in seq_along(sub_models)) {
  
  model_tmp <- get(sub_models[[i]])
  
  model_tmp <- as.data.table(summary(model_tmp, delta = c(-60:60), level = "between", digits = "asis"))
  
  model_tmp[, From := ifelse(From == "Sleepg", "Sleep", From)]
  model_tmp[, From := ifelse(From == "WAKEg", "Awake", From)]
  model_tmp[, From := ifelse(From == "MVPAg", "MVPA", From)]
  model_tmp[, From := ifelse(From == "LPAg", "LPA", From)]
  model_tmp[, From := ifelse(From == "SBg", "SB", From)]
  model_tmp[, From := factor(From, ordered = TRUE,
                             levels = c("Sleep",
                                        "Awake",
                                        "SB",
                                        "MVPA",
                                        "LPA"))]
  
  model_tmp[, To := ifelse(To == "Sleepg", "Sleep", To)]
  model_tmp[, To := ifelse(To == "WAKEg", "Awake", To)]
  model_tmp[, To := ifelse(To == "MVPAg", "MVPA", To)]
  model_tmp[, To := ifelse(To == "LPAg", "LPA", To)]
  model_tmp[, To := ifelse(To == "SBg", "SB", To)]
  model_tmp[, To := factor(To, ordered = TRUE,
                           levels = c("Sleep",
                                      "Awake",
                                      "SB",
                                      "MVPA",
                                      "LPA"))]
  
  model_tmp$sig <- between(0, model_tmp$CI_low, model_tmp$CI_high)
  model_tmp[, Sig := NA]
  model_tmp[, Sig := ifelse(sig == FALSE & Delta %in% c(-55, 55), "*", "")]
  
  sub_models_b[[i]] <- model_tmp
}
names(sub_models_b) <- (sub_models)

h24_affect_plot_b <- foreach(i = 1:20,
                             .packages = "multilevelcoda") %dopar% {
                               
                               ggplot(sub_models_b[[rg[i, "sub_models"]]][To == eval(rg[i, "parts"]) & Level == eval(rg[i, "level"])], 
                                      aes(x = Delta, y = Mean)) +
                                 geom_hline(yintercept = 0, linewidth = 0.2, linetype = 2) +
                                 geom_vline(xintercept = 0, linewidth = 0.2, linetype = 2) +    
                                 geom_ribbon(aes(ymin = CI_low,
                                                 ymax = CI_high, fill = From),
                                             alpha = alpha) +
                                 geom_line(aes(colour = From), linewidth = 1) +
                                 geom_text(aes(label = Sig, colour = From), 
                                           size = 6, nudge_x = 0.05, nudge_y = 0.2, 
                                           show.legend = FALSE) +
                                 scale_colour_manual(values = col) +
                                 scale_fill_manual(values = colf) +
                                 labs(x = paste0("Difference in ", rg[i, "parts"], " at Between-person Level"),
                                      y = paste0("Estimated Difference")) +
                                 facet_wrap(ggplot2::vars(From, To),
                                            labeller = label_bquote(cols = .(as.character(From)) %<-% minutes %->% .(as.character(To))),
                                            strip.position = "bottom", ncol = 4) +
                                 scale_x_continuous(limits = c(-60, 60),
                                                    breaks = c(-60, 0, 60)) +
                                 scale_y_continuous(limits = c(-2.4, 2.4),
                                                    breaks = c(-2, -1, 0, 1, 2),
                                                    sec.axis = sec_axis(~ . / rg[i, "smean"], name = paste0("Standardised Estimated Difference"))
                                 ) +
                                 hrbrthemes::theme_ipsum() +
                                 theme(
                                   axis.ticks         = element_blank(),
                                   panel.background   = element_blank(),
                                   panel.border       = element_blank(),
                                   panel.grid.major   = element_blank(),
                                   panel.grid.minor   = element_blank(),
                                   plot.background    = element_rect(fill = "transparent", colour = NA),
                                   strip.background   = element_rect(fill = "transparent", colour = NA),
                                   strip.text         = element_text(size = 11, hjust = .5),
                                   strip.placement    = "outside",
                                   axis.title.x       = element_blank(),
                                   axis.title.y       = element_text(size = 12, hjust = .5),
                                   axis.title.y.right = element_text(size = 12, hjust = .5, angle = 270),
                                   # plot.title         = element_text(size = 12, face = "bold"),
                                   # plot.title.position= "plot",
                                   plot.margin        = margin(.5, .5, .5, .5, "cm"),
                                   legend.position    = "none"
                                 )
                             }

names(h24_affect_plot_b) <- foreach(i = 1:20) %dopar% {
  paste0(rg[i, "level_labels"], "Reallocation of ", rg[i, "part_labels"], " and ", rg[i, "resp"])
}

saveRDS(h24_affect_plot_b, paste0(outputdir, "h24_affect_plot_b", ".RDS"))

# within -------------------
sub_models_w <- list()

for(i in seq_along(sub_models)) {
  
  model_tmp <- get(sub_models[[i]])
  
  model_tmp <- as.data.table(summary(model_tmp, delta = c(-60:60), level = "within", digits = "asis"))
  
  model_tmp[, From := ifelse(From == "Sleepg", "Sleep", From)]
  model_tmp[, From := ifelse(From == "WAKEg", "Awake", From)]
  model_tmp[, From := ifelse(From == "MVPAg", "MVPA", From)]
  model_tmp[, From := ifelse(From == "LPAg", "LPA", From)]
  model_tmp[, From := ifelse(From == "SBg", "SB", From)]
  model_tmp[, From := factor(From, ordered = TRUE,
                             levels = c("Sleep",
                                        "Awake",
                                        "SB",
                                        "MVPA",
                                        "LPA"))]
  
  model_tmp[, To := ifelse(To == "Sleepg", "Sleep", To)]
  model_tmp[, To := ifelse(To == "WAKEg", "Awake", To)]
  model_tmp[, To := ifelse(To == "MVPAg", "MVPA", To)]
  model_tmp[, To := ifelse(To == "LPAg", "LPA", To)]
  model_tmp[, To := ifelse(To == "SBg", "SB", To)]
  model_tmp[, To := factor(To, ordered = TRUE,
                           levels = c("Sleep",
                                      "Awake",
                                      "SB",
                                      "MVPA",
                                      "LPA"))]
  
  model_tmp$sig <- between(0, model_tmp$CI_low, model_tmp$CI_high)
  model_tmp[, Sig := NA]
  model_tmp[, Sig := ifelse(sig == FALSE & Delta %in% c(-55, 55), "*", "")]
  
  sub_models_w[[i]] <- model_tmp
}
names(sub_models_w) <- (sub_models)

h24_affect_plot_w <- foreach(i = 21:40,
                             .packages = "multilevelcoda") %dopar% {
                               
                               ggplot(sub_models_w[[rg[i, "sub_models"]]][To == eval(rg[i, "parts"]) & Level == eval(rg[i, "level"])], 
                                      aes(x = Delta, y = Mean)) +
                                 geom_hline(yintercept = 0, linewidth = 0.2, linetype = 2) +
                                 geom_vline(xintercept = 0, linewidth = 0.2, linetype = 2) +    
                                 geom_ribbon(aes(ymin = CI_low,
                                                 ymax = CI_high, fill = From),
                                             alpha = alpha) +
                                 geom_line(aes(colour = From), linewidth = 1) +
                                 geom_text(aes(label = Sig, colour = From), 
                                           size = 6, nudge_x = 0.05, nudge_y = 0.025, 
                                           show.legend = FALSE) +
                                 scale_colour_manual(values = col) +
                                 scale_fill_manual(values = colf) +
                                 labs(x = paste0("Difference in ", rg[i, "parts"], " at Within-person Level"),
                                      y = paste0("Estimated Difference")) +
                                 facet_wrap(ggplot2::vars(From, To),
                                            labeller = label_bquote(cols = .(as.character(From)) %<-% minutes %->% .(as.character(To))),
                                            strip.position = "bottom", ncol = 4) +
                                 scale_x_continuous(limits = c(-60, 60),
                                                    breaks = c(-60, 0, 60)) +
                                 scale_y_continuous(limits = c(-0.35, 0.35),
                                                    breaks = c(-0.25, 0, 0.25),
                                                    sec.axis = sec_axis(~ . / rg[i, "smean"], name = paste0("Standardised Estimated Difference"))
                                 ) +
                                 hrbrthemes::theme_ipsum() +
                                 theme(
                                   axis.ticks         = element_blank(),
                                   panel.background   = element_blank(),
                                   panel.border       = element_blank(),
                                   panel.grid.major   = element_blank(),
                                   panel.grid.minor   = element_blank(),
                                   plot.background    = element_rect(fill = "transparent", colour = NA),
                                   strip.background   = element_rect(fill = "transparent", colour = NA),
                                   strip.text         = element_text(size = 11, hjust = .5),
                                   strip.placement    = "outside",
                                   axis.title.x       = element_blank(),
                                   axis.title.y       = element_text(size = 12, hjust = .5),
                                   axis.title.y.right = element_text(size = 12, hjust = .5, angle = 270),
                                   # plot.title         = element_text(size = 12, face = "bold"),
                                   # plot.title.position= "plot",
                                   plot.margin        = margin(.5, .5, .5, .5, "cm"),
                                   legend.position    = "none"
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

# grDevices::cairo_pdf(
#   file = paste0(outputdir, "plotw_hapa_lpa", ".pdf"),
#   width = 9,
#   height = 4,
# )
# h24_affect_plot_w[[9]]
# dev.off()
# 
# grDevices::cairo_pdf(
#   file = paste0(outputdir, "plotw_lana_mvpa", ".pdf"),
#   width = 9,
#   height = 4,
# )
# h24_affect_plot_w[[13]]
# dev.off()

grDevices::cairo_pdf(
  file = paste0(outputdir, "plot_24h_affect", ".pdf"),
  width = 10,
  height = 8,
)
ggarrange(h24_affect_plot_w[[9]], h24_affect_plot_w[[13]], nrow = 2, legend = "none",
          labels = c("A. High Arousal Positive Affect at Within-person level", 
                     "B. Low Arousal Negative Affect at Within-person level"),
          hjust = 0,
          font.label = list(size = 12, color = "black", family = "Arial Narrow")
)
dev.off()

# FOR SUPPLEMENTARY ---------------------
h24_affect_plot_b_supp <- foreach(i = 1:20,
                                  .packages = "multilevelcoda") %dopar% {
                                    
                                    ggplot(sub_models_b[[rg[i, "sub_models"]]][To == eval(rg[i, "parts"]) & Level == eval(rg[i, "level"])], 
                                           aes(x = Delta, y = Mean)) +
                                      geom_hline(yintercept = 0, linewidth = 0.2, linetype = 2) +
                                      geom_vline(xintercept = 0, linewidth = 0.2, linetype = 2) +    
                                      geom_ribbon(aes(ymin = CI_low,
                                                      ymax = CI_high, fill = From),
                                                  alpha = alpha) +
                                      geom_line(aes(colour = From), linewidth = 1) +
                                      geom_text(aes(label = Sig, colour = From), 
                                                size = 6, nudge_x = 0.05, nudge_y = 0.2, 
                                                show.legend = FALSE) +
                                      scale_colour_manual(values = col) +
                                      scale_fill_manual(values = colf) +
                                      labs(x = paste0("Difference in ", rg[i, "parts"], " at Between-person Level"),
                                           y = paste0("Estimated Difference"),
                                           title =  paste0("Reallocation of ", rg[i, "parts"], " and ", rg[i, "resp"], " at Between-person Level")) +
                                      facet_wrap(ggplot2::vars(From, To),
                                                 labeller = label_bquote(cols = .(as.character(From)) %<-% minutes %->% .(as.character(To))),
                                                 strip.position = "bottom", ncol = 4) +
                                      scale_x_continuous(limits = c(-60, 60),
                                                         breaks = c(-60, 0, 60)) +
                                      scale_y_continuous(limits = c(-2.4, 2.4),
                                                         breaks = c(-2, -1, 0, 1, 2),
                                                         sec.axis = sec_axis(~ . / rg[i, "smean"], name = paste0("Standardised Estimated Difference"))
                                      ) +
                                      hrbrthemes::theme_ipsum() +
                                      theme(
                                        axis.ticks         = element_blank(),
                                        panel.background   = element_blank(),
                                        panel.border       = element_blank(),
                                        panel.grid.major   = element_blank(),
                                        panel.grid.minor   = element_blank(),
                                        plot.background    = element_rect(fill = "transparent", colour = NA),
                                        strip.background   = element_rect(fill = "transparent", colour = NA),
                                        strip.text         = element_text(size = 11, hjust = .5),
                                        strip.placement    = "outside",
                                        axis.title.x       = element_blank(),
                                        axis.title.y       = element_text(size = 12, hjust = .5),
                                        axis.title.y.right = element_text(size = 12, hjust = .5, angle = 270),
                                        plot.title         = element_text(size = 12, hjust = .5, face = "italic"),
                                        plot.title.position= "plot",
                                        plot.margin        = margin(.5, .5, .5, .5, "cm"),
                                        legend.position    = "none"
                                      )
                                  }

names(h24_affect_plot_b_supp) <- foreach(i = 1:20) %dopar% {
  paste0(rg[i, "level_labels"], "Reallocation of ", rg[i, "part_labels"], " and ", rg[i, "resp"])
}

saveRDS(h24_affect_plot_b_supp, paste0(outputdir, "h24_affect_plot_b_supp", ".RDS"))

h24_affect_plot_w_supp <- foreach(i = 21:40,
                                  .packages = "multilevelcoda") %dopar% {
                                    
                                    ggplot(sub_models_w[[rg[i, "sub_models"]]][To == eval(rg[i, "parts"]) & Level == eval(rg[i, "level"])], 
                                           aes(x = Delta, y = Mean)) +
                                      geom_hline(yintercept = 0, linewidth = 0.2, linetype = 2) +
                                      geom_vline(xintercept = 0, linewidth = 0.2, linetype = 2) +    
                                      geom_ribbon(aes(ymin = CI_low,
                                                      ymax = CI_high, fill = From),
                                                  alpha = alpha) +
                                      geom_line(aes(colour = From), linewidth = 1) +
                                      geom_text(aes(label = Sig, colour = From), 
                                                size = 6, nudge_x = 0.05, nudge_y = 0.025, 
                                                show.legend = FALSE) +
                                      scale_colour_manual(values = col) +
                                      scale_fill_manual(values = colf) +
                                      labs(x = paste0("Difference in ", rg[i, "parts"], " at Between-person Level"),
                                           y = paste0("Estimated Difference"),
                                           title =  paste0("Reallocation of ", rg[i, "parts"], " and ", rg[i, "resp"], " at Between-person Level")) +
                                      facet_wrap(ggplot2::vars(From, To),
                                                 labeller = label_bquote(cols = .(as.character(From)) %<-% minutes %->% .(as.character(To))),
                                                 strip.position = "bottom", ncol = 4) +
                                      scale_x_continuous(limits = c(-60, 60),
                                                         breaks = c(-60, 0, 60)) +
                                      scale_y_continuous(limits = c(-0.35, 0.35),
                                                         breaks = c(-0.25, 0, 0.25),
                                                         sec.axis = sec_axis(~ . / rg[i, "smean"], name = paste0("Standardised Estimated Difference"))
                                      ) +
                                      hrbrthemes::theme_ipsum() +
                                      theme(
                                        axis.ticks         = element_blank(),
                                        panel.background   = element_blank(),
                                        panel.border       = element_blank(),
                                        panel.grid.major   = element_blank(),
                                        panel.grid.minor   = element_blank(),
                                        plot.background    = element_rect(fill = "transparent", colour = NA),
                                        strip.background   = element_rect(fill = "transparent", colour = NA),
                                        strip.text         = element_text(size = 11, hjust = .5),
                                        strip.placement    = "outside",
                                        axis.title.x       = element_blank(),
                                        axis.title.y       = element_text(size = 12, hjust = .5),
                                        axis.title.y.right = element_text(size = 12, hjust = .5, angle = 270),
                                        plot.title         = element_text(size = 12, hjust = .5, face = "italic"),
                                        plot.title.position= "plot",
                                        plot.margin        = margin(.5, .5, .5, .5, "cm"),
                                        legend.position    = "none"
                                      )
                                  }


names(h24_affect_plot_w_supp) <- foreach(i = 21:40) %dopar% {
  paste0(rg[i, "level_labels"], "Reallocation of ", rg[i, "part_labels"], " and ", rg[i, "resp"])
}

saveRDS(h24_affect_plot_w_supp, paste0(outputdir, "h24_affect_plot_w_supp", ".RDS"))


# presentation
h24_affect_plot_b_slides <- foreach(i = 1:20,
                                   .packages = "multilevelcoda") %dopar% {
                                     
                                     ggplot(sub_models_b[[rg[i, "sub_models"]]][To == eval(rg[i, "parts"]) & Level == eval(rg[i, "level"])], 
                                            aes(x = Delta, y = Mean)) +
                                       geom_hline(yintercept = 0, linewidth = 0.2, linetype = 2) +
                                       geom_vline(xintercept = 0, linewidth = 0.2, linetype = 2) +    
                                       geom_ribbon(aes(ymin = CI_low,
                                                       ymax = CI_high, fill = From),
                                                   alpha = alpha) +
                                       geom_line(aes(colour = From), linewidth = 1) +
                                       geom_text(aes(label = Sig, colour = From), 
                                                 size = 6, nudge_x = 0.05, nudge_y = 0.2, 
                                                 show.legend = FALSE) +
                                       scale_colour_manual(values = col) +
                                       scale_fill_manual(values = colf) +
                                       labs(x = paste0("Difference in ", rg[i, "parts"], " at Between-person Level"),
                                            y = paste0("Estimated Difference")) +
                                       facet_wrap(ggplot2::vars(From, To),
                                                  labeller = label_bquote(cols = .(as.character(From)) %<-% minutes %->% .(as.character(To))),
                                                  strip.position = "bottom", ncol = 4) +
                                       scale_x_continuous(limits = c(-60, 60),
                                                          breaks = c(-60, 0, 60)) +
                                       scale_y_continuous(limits = c(-2.4, 2.4),
                                                          breaks = c(-2, -1, 0, 1, 2),
                                                          sec.axis = sec_axis(~ . / rg[i, "smean"], name = paste0("Standardised Estimated Difference"))
                                       ) +
                                       hrbrthemes::theme_ipsum() +
                                       theme(
                                         axis.ticks         = element_blank(),
                                         panel.background   = element_blank(),
                                         panel.border       = element_blank(),
                                         panel.grid.major   = element_blank(),
                                         panel.grid.minor   = element_blank(),
                                         plot.background    = element_rect(fill = "transparent", colour = NA),
                                         strip.background   = element_rect(fill = "transparent", colour = NA),
                                         strip.text         = element_text(size = 16, hjust = .5),
                                         strip.placement    = "outside",
                                         axis.title.x       = element_blank(),
                                         axis.title.y       = element_text(size = 16, hjust = .5),
                                         axis.title.y.right = element_text(size = 16, hjust = .5, angle = 270),
                                         # plot.title         = element_text(size = 12, face = "bold"),
                                         # plot.title.position= "plot",
                                         plot.margin        = margin(.5, .5, .5, .5, "cm"),
                                         legend.position    = "none"
                                       )
                                   }

h24_affect_plot_w_slides <- foreach(i = 21:40,
                             .packages = "multilevelcoda") %dopar% {
                               
                               ggplot(sub_models_w[[rg[i, "sub_models"]]][To == eval(rg[i, "parts"]) & Level == eval(rg[i, "level"])], 
                                      aes(x = Delta, y = Mean)) +
                                 geom_hline(yintercept = 0, linewidth = 0.2, linetype = 2) +
                                 geom_vline(xintercept = 0, linewidth = 0.2, linetype = 2) +    
                                 geom_ribbon(aes(ymin = CI_low,
                                                 ymax = CI_high, fill = From),
                                             alpha = alpha) +
                                 geom_line(aes(colour = From), linewidth = 1) +
                                 geom_text(aes(label = Sig, colour = From), 
                                           size = 6, nudge_x = 0.05, nudge_y = 0.025, 
                                           show.legend = FALSE) +
                                 scale_colour_manual(values = col) +
                                 scale_fill_manual(values = colf) +
                                 labs(x = paste0("Difference in ", rg[i, "parts"], " at Within-person Level"),
                                      y = paste0("Estimated Difference")) +
                                 facet_wrap(ggplot2::vars(From, To),
                                            labeller = label_bquote(cols = .(as.character(From)) %<-% minutes %->% .(as.character(To))),
                                            strip.position = "bottom", ncol = 4) +
                                 scale_x_continuous(limits = c(-60, 60),
                                                    breaks = c(-60, 0, 60)) +
                                 scale_y_continuous(limits = c(-0.35, 0.35),
                                                    breaks = c(-0.25, 0, 0.25),
                                                    sec.axis = sec_axis(~ . / rg[i, "smean"], name = paste0("Standardised Estimated Difference"))
                                 ) +
                                 hrbrthemes::theme_ipsum() +
                                 theme(
                                   axis.ticks         = element_blank(),
                                   panel.background   = element_blank(),
                                   panel.border       = element_blank(),
                                   panel.grid.major   = element_blank(),
                                   panel.grid.minor   = element_blank(),
                                   plot.background    = element_rect(fill = "transparent", colour = NA),
                                   strip.background   = element_rect(fill = "transparent", colour = NA),
                                   strip.text         = element_text(size = 16, hjust = .5),
                                   strip.placement    = "outside",
                                   axis.title.x       = element_blank(),
                                   axis.title.y       = element_text(size = 16, hjust = .5),
                                   axis.title.y.right = element_text(size = 16, hjust = .5, angle = 270),
                                   # plot.title         = element_text(size = 12, face = "bold"),
                                   # plot.title.position= "plot",
                                   plot.margin        = margin(.5, .5, .5, .5, "cm"),
                                   legend.position    = "none"
                                 )
                             }

grDevices::cairo_pdf(
  file = paste0(outputdir, "plot_24h_affect_lpa_slides", ".pdf"),
  width = 12,
  height = 8,
)
ggarrange(h24_affect_plot_w_slides[[9]],h24_affect_plot_b_slides[[9]], nrow = 2, legend = "none"
          # labels = c("A. High Arousal Positive Affect at Within-person level", 
                     # "B. Low Arousal Negative Affect at Within-person level"),
          # hjust = 0,
          # font.label = list(size = 12, color = "black", family = "Arial Narrow")
)
dev.off()

grDevices::cairo_pdf(
  file = paste0(outputdir, "plot_24h_affect_mvpa_slides", ".pdf"),
  width = 12,
  height = 8,
)
ggarrange(h24_affect_plot_w_slides[[13]],h24_affect_plot_b_slides[[13]], nrow = 2, legend = "none"
          # labels = c("A. High Arousal Positive Affect at Within-person level", 
          # "B. Low Arousal Negative Affect at Within-person level"),
          # hjust = 0,
          # font.label = list(size = 12, color = "black", family = "Arial Narrow")
)
dev.off()

grDevices::cairo_pdf(
  file = paste0(outputdir, "plot_24h_affect_slides", ".pdf"),
  width = 12,
  height = 8,
)
ggarrange(h24_affect_plot_w_slides[[9]],h24_affect_plot_w[[13]], nrow = 2, legend = "none"
          # labels = c("A. High Arousal Positive Affect at Within-person level", 
          # "B. Low Arousal Negative Affect at Within-person level"),
          # hjust = 0,
          # font.label = list(size = 12, color = "black", family = "Arial Narrow")
)
dev.off()
grDevices::cairo_pdf(
  file = paste0(outputdir, "plotw_hapa_lpa", ".pdf"),
  width = 12,
  height = 4,
)
h24_affect_plot_w[[9]]
dev.off()

grDevices::cairo_pdf(
  file = paste0(outputdir, "plotw_lana_mvpa", ".pdf"),
  width = 12,
  height = 4,
)
h24_affect_plot_w[[13]]
dev.off()

h24_affect_plot_b[[13]]
