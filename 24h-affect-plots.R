source("24h-affect-utils.R")

# read models ----------------
# m_hapa <- readRDS(paste0(outputdir, "m_hapa", ".RDS"))
# m_lapa <- readRDS(paste0(outputdir, "m_lapa", ".RDS"))
# m_hana <- readRDS(paste0(outputdir, "m_hana", ".RDS"))
# m_lana <- readRDS(paste0(outputdir, "m_lana", ".RDS"))

mhapa_ww_lag_sub_adj <- readRDS(paste0(outputdir, "mhapa_ww_lag_sub_adj", ".RDS"))
mlapa_ww_lag_sub_adj <- readRDS(paste0(outputdir, "mlapa_ww_lag_sub_adj", ".RDS"))
mhana_ww_lag_sub_adj <- readRDS(paste0(outputdir, "mhana_ww_lag_sub_adj", ".RDS"))
mlana_ww_lag_sub_adj <- readRDS(paste0(outputdir, "mlana_ww_lag_sub_adj", ".RDS"))

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
           `WAKEg` = "Time Awake in Bed",
           `MVPAg` = "MVPA",
           `LPAg` = "LPA",
           `SBg` = "SB")
labeller <- function(variable,value){
  return(names[value])
}
alpha <- 5/10

# between hapa -------------------
(plotb_hapa_wake <- 
   plot(mhapa_ww_lag_sub_adj, ref = "grandmean", level = "between", to = "WAKEg") +
   scale_colour_manual(values = col) +
   scale_fill_manual(values = colf) +
   labs(x = "Change in Minutes in Awake in Bed at Between-person level",
        y = "Change in High Arousal Positive Affect") +
   facet_grid(~From, labeller = labeller) +
   scale_x_continuous(breaks = c(-60, 0, 60)) +
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
     axis.title.x      = element_text(size = 14),
     axis.title.y      = element_text(size = 14, hjust = .5),
     plot.margin = margin(.5, .5, .5, .5, "cm"),
     legend.position = "none"
   ))

(plotb_hapa_sleep <- 
    plot(mhapa_ww_lag_sub_adj, ref = "grandmean", level = "between", to = "Sleepg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in Sleep Duration at Between-person level",
         y = "Change in High Arousal Positive Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

(plotb_hapa_lpa <- 
    plot(mhapa_ww_lag_sub_adj, ref = "grandmean", level = "between", to = "LPAg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in LPA at Between-person level",
         y = "Change in High Arousal Positive Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

(plotb_hapa_mvpa <- 
    plot(mhapa_ww_lag_sub_adj, ref = "grandmean", level = "between", to = "MVPAg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in MVPA at Between-person level",
         y = "Change in High Arousal Positive Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

(plotb_hapa_sb <- 
    plot(mhapa_ww_lag_sub_adj, ref = "grandmean", level = "between", to = "SBg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in SB at Between-person level",
         y = "Change in High Arousal Positive Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

# between lapa -------------------
(plotb_lapa_wake <- 
   plot(mlapa_ww_lag_sub_adj, ref = "grandmean", level = "between", to = "WAKEg") +
   scale_colour_manual(values = col) +
   scale_fill_manual(values = colf) +
   labs(x = "Change in Minutes in Awake in Bed at Between-person level",
        y = "Change in Low Arousal Positive Affect") +
   facet_grid(~From, labeller = labeller) +
   scale_x_continuous(breaks = c(-60, 0, 60)) +
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
     axis.title.x      = element_text(size = 14),
     axis.title.y      = element_text(size = 14, hjust = .5),
     plot.margin = margin(.5, .5, .5, .5, "cm"),
     legend.position = "none"
   ))

(plotb_lapa_sleep <- 
    plot(mlapa_ww_lag_sub_adj, ref = "grandmean", level = "between", to = "Sleepg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in Sleep Duration at Between-person level",
         y = "Change in Low Arousal Positive Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

(plotb_lapa_lpa <- 
    plot(mlapa_ww_lag_sub_adj, ref = "grandmean", level = "between", to = "LPAg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in LPA at Between-person level",
         y = "Change in Low Arousal Positive Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

(plotb_lapa_mvpa <- 
    plot(mlapa_ww_lag_sub_adj, ref = "grandmean", level = "between", to = "MVPAg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in MVPA at Between-person level",
         y = "Change in Low Arousal Positive Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

(plotb_lapa_sb <- 
    plot(mlapa_ww_lag_sub_adj, ref = "grandmean", level = "between", to = "SBg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in SB at Between-person level",
         y = "Change in Low Arousal Positive Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

# between hana -------------------
(plotb_hana_wake <- 
   plot(mhana_ww_lag_sub_adj, ref = "grandmean", level = "between", to = "WAKEg") +
   scale_colour_manual(values = col) +
   scale_fill_manual(values = colf) +
   labs(x = "Change in Minutes in Awake in Bed at Between-person level",
        y = "Change in High Arousal Negative Affect") +
   facet_grid(~From, labeller = labeller) +
   scale_x_continuous(breaks = c(-60, 0, 60)) +
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
     axis.title.x      = element_text(size = 14),
     axis.title.y      = element_text(size = 14, hjust = .5),
     plot.margin = margin(.5, .5, .5, .5, "cm"),
     legend.position = "none"
   ))

(plotb_hana_sleep <- 
    plot(mhana_ww_lag_sub_adj, ref = "grandmean", level = "between", to = "Sleepg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in Sleep Duration at Between-person level",
         y = "Change in High Arousal Negative Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

(plotb_hana_lpa <- 
    plot(mhana_ww_lag_sub_adj, ref = "grandmean", level = "between", to = "LPAg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in LPA at Between-person level",
         y = "Change in High Arousal Negative Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

(plotb_hana_mvpa <- 
    plot(mhana_ww_lag_sub_adj, ref = "grandmean", level = "between", to = "MVPAg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in MVPA at Between-person level",
         y = "Change in High Arousal Negative Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

(plotb_hana_sb <- 
    plot(mhana_ww_lag_sub_adj, ref = "grandmean", level = "between", to = "SBg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in SB at Between-person level",
         y = "Change in High Arousal Negative Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

# between lana -------------------
(plotb_lana_wake <- 
   plot(mlana_ww_lag_sub_adj, ref = "grandmean", level = "between", to = "WAKEg") +
   scale_colour_manual(values = col) +
   scale_fill_manual(values = colf) +
   labs(x = "Change in Minutes in Awake in Bed at Between-person level",
        y = "Change in Low Arousal Negative Affect") +
   facet_grid(~From, labeller = labeller) +
   scale_x_continuous(breaks = c(-60, 0, 60)) +
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
     axis.title.x      = element_text(size = 14),
     axis.title.y      = element_text(size = 14, hjust = .5),
     plot.margin = margin(.5, .5, .5, .5, "cm"),
     legend.position = "none"
   ))

(plotb_lana_sleep <- 
    plot(mlana_ww_lag_sub_adj, ref = "grandmean", level = "between", to = "Sleepg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in Sleep Duration at Between-person level",
         y = "Change in Low Arousal Negative Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

(plotb_lana_lpa <- 
    plot(mlana_ww_lag_sub_adj, ref = "grandmean", level = "between", to = "LPAg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in LPA at Between-person level",
         y = "Change in Low Arousal Negative Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

(plotb_lana_mvpa <- 
    plot(mlana_ww_lag_sub_adj, ref = "grandmean", level = "between", to = "MVPAg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in MVPA at Between-person level",
         y = "Change in Low Arousal Negative Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

(plotb_lana_sb <- 
    plot(mlana_ww_lag_sub_adj, ref = "grandmean", level = "between", to = "SBg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in SB at Between-person level",
         y = "Change in Low Arousal Negative Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))


# within hapa -------------------
(plotw_hapa_wake <- 
   plot(mhapa_ww_lag_sub_adj, ref = "grandmean", level = "within", to = "WAKEg") +
   scale_colour_manual(values = col) +
   scale_fill_manual(values = colf) +
   labs(x = "Change in Minutes in Awake in Bed at Within-person level",
        y = "Change in High Arousal Positive Affect") +
   facet_grid(~From, labeller = labeller) +
   scale_x_continuous(breaks = c(-60, 0, 60)) +
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
     axis.title.x      = element_text(size = 14),
     axis.title.y      = element_text(size = 14, hjust = .5),
     plot.margin = margin(.5, .5, .5, .5, "cm"),
     legend.position = "none"
   ))

(plotw_hapa_sleep <- 
    plot(mhapa_ww_lag_sub_adj, ref = "grandmean", level = "within", to = "Sleepg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in Sleep Duration at Within-person level",
         y = "Change in High Arousal Positive Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

(plotw_hapa_lpa <- 
    plot(mhapa_ww_lag_sub_adj, ref = "grandmean", level = "within", to = "LPAg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in LPA at Within-person level",
         y = "Change in High Arousal Positive Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

(plotw_hapa_mvpa <- 
    plot(mhapa_ww_lag_sub_adj, ref = "grandmean", level = "within", to = "MVPAg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in MVPA at Within-person level",
         y = "Change in High Arousal Positive Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

(plotw_hapa_sb <- 
    plot(mhapa_ww_lag_sub_adj, ref = "grandmean", level = "within", to = "SBg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in SB at Within-person level",
         y = "Change in High Arousal Positive Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

# within lapa -------------------
(plotw_lapa_wake <- 
   plot(mlapa_ww_lag_sub_adj, ref = "grandmean", level = "within", to = "WAKEg") +
   scale_colour_manual(values = col) +
   scale_fill_manual(values = colf) +
   labs(x = "Change in Minutes in Awake in Bed at Within-person level",
        y = "Change in Low Arousal Positive Affect") +
   facet_grid(~From, labeller = labeller) +
   scale_x_continuous(breaks = c(-60, 0, 60)) +
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
     axis.title.x      = element_text(size = 14),
     axis.title.y      = element_text(size = 14, hjust = .5),
     plot.margin = margin(.5, .5, .5, .5, "cm"),
     legend.position = "none"
   ))

(plotw_lapa_sleep <- 
    plot(mlapa_ww_lag_sub_adj, ref = "grandmean", level = "within", to = "Sleepg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in Sleep Duration at Within-person level",
         y = "Change in Low Arousal Positive Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

(plotw_lapa_lpa <- 
    plot(mlapa_ww_lag_sub_adj, ref = "grandmean", level = "within", to = "LPAg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in LPA at Within-person level",
         y = "Change in Low Arousal Positive Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

(plotw_lapa_mvpa <- 
    plot(mlapa_ww_lag_sub_adj, ref = "grandmean", level = "within", to = "MVPAg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in MVPA at Within-person level",
         y = "Change in Low Arousal Positive Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

(plotw_lapa_sb <- 
    plot(mlapa_ww_lag_sub_adj, ref = "grandmean", level = "within", to = "SBg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in SB at Within-person level",
         y = "Change in Low Arousal Positive Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

# within hana -------------------
(plotw_hana_wake <- 
   plot(mhana_ww_lag_sub_adj, ref = "grandmean", level = "within", to = "WAKEg") +
   scale_colour_manual(values = col) +
   scale_fill_manual(values = colf) +
   labs(x = "Change in Minutes in Awake in Bed at Within-person level",
        y = "Change in High Arousal Negative Affect") +
   facet_grid(~From, labeller = labeller) +
   scale_x_continuous(breaks = c(-60, 0, 60)) +
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
     axis.title.x      = element_text(size = 14),
     axis.title.y      = element_text(size = 14, hjust = .5),
     plot.margin = margin(.5, .5, .5, .5, "cm"),
     legend.position = "none"
   ))

(plotw_hana_sleep <- 
    plot(mhana_ww_lag_sub_adj, ref = "grandmean", level = "within", to = "Sleepg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in Sleep Duration at Within-person level",
         y = "Change in High Arousal Negative Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

(plotw_hana_lpa <- 
    plot(mhana_ww_lag_sub_adj, ref = "grandmean", level = "within", to = "LPAg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in LPA at Within-person level",
         y = "Change in High Arousal Negative Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

(plotw_hana_mvpa <- 
    plot(mhana_ww_lag_sub_adj, ref = "grandmean", level = "within", to = "MVPAg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in MVPA at Within-person level",
         y = "Change in High Arousal Negative Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

(plotw_hana_sb <- 
    plot(mhana_ww_lag_sub_adj, ref = "grandmean", level = "within", to = "SBg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in SB at Within-person level",
         y = "Change in High Arousal Negative Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

# within lana -------------------
(plotw_lana_wake <- 
   plot(mlana_ww_lag_sub_adj, ref = "grandmean", level = "within", to = "WAKEg") +
   scale_colour_manual(values = col) +
   scale_fill_manual(values = colf) +
   labs(x = "Change in Minutes in Awake in Bed at Within-person level",
        y = "Change in Low Arousal Negative Affect") +
   facet_grid(~From, labeller = labeller) +
   scale_x_continuous(breaks = c(-60, 0, 60)) +
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
     axis.title.x      = element_text(size = 14),
     axis.title.y      = element_text(size = 14, hjust = .5),
     plot.margin = margin(.5, .5, .5, .5, "cm"),
     legend.position = "none"
   ))

(plotw_lana_sleep <- 
    plot(mlana_ww_lag_sub_adj, ref = "grandmean", level = "within", to = "Sleepg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in Sleep Duration at Within-person level",
         y = "Change in Low Arousal Negative Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

(plotw_lana_lpa <- 
    plot(mlana_ww_lag_sub_adj, ref = "grandmean", level = "within", to = "LPAg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in LPA at Within-person level",
         y = "Change in Low Arousal Negative Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

(plotw_lana_mvpa <- 
    plot(mlana_ww_lag_sub_adj, ref = "grandmean", level = "within", to = "MVPAg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in MVPA at Within-person level",
         y = "Change in Low Arousal Negative Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))

(plotw_lana_sb <- 
    plot(mlana_ww_lag_sub_adj, ref = "grandmean", level = "within", to = "SBg") +
    scale_colour_manual(values = col) +
    scale_fill_manual(values = colf) +
    labs(x = "Change in Minutes in SB at Within-person level",
         y = "Change in Low Arousal Negative Affect") +
    facet_grid(~From, labeller = labeller) +
    scale_x_continuous(breaks = c(-60, 0, 60)) +
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
      axis.title.x      = element_text(size = 14),
      axis.title.y      = element_text(size = 14, hjust = .5),
      plot.margin = margin(.5, .5, .5, .5, "cm"),
      legend.position = "none"
    ))


# print plots --------------------------
extrafont::loadfonts()

#sig
grDevices::cairo_pdf(
  file = paste0(outputdir, "plotw_hapa_lpa", ".pdf"),
  width = 8,
  height = 4,
)
plotw_hapa_lpa
dev.off()

grDevices::cairo_pdf(
  file = paste0(outputdir, "plotw_lana_mvpa", ".pdf"),
  width = 8,
  height = 4,
)
plotw_lana_mvpa
dev.off()


