source("24h-affect-utils.R")

behaviour <- c("Awake in Bed", "Sleep", "Moderate-to-vigorous Physical Activity", "Sedentary Behaviour", "Light Physical Activity")
composition_a <- data.frame("behaviour" = behaviour,
                                  "prop" = c(1/24, 8/24, 1/24, 8/24, 6/24), 
                                  "prop_labels" = c("1h", "8h", "1h", "8h", "6h"),
                                  label = "A")
composition_b <- data.frame("behaviour" = behaviour,
                                  "prop" = c(1/24, 7/24, 2/24, 8/24, 6/24), 
                                  "prop_labels" = c("1h", "7h", "2h", "8h", "6h"),
                                  label = "B")
composition_c <- data.frame("behaviour" = behaviour,
                                  "prop" = c(1/24, 8/24, 2/24, 7/24, 6/24), 
                                  "prop_labels" = c("1h", "8h", "2h", "7h", "6h"),
                                  label = "C")
composition <- rbind(composition_a,
                           composition_b,
                           composition_c)

composition$behaviour <- factor(composition$behaviour, ordered = TRUE,
                                levels = c(
                                  "Moderate-to-vigorous Physical Activity",
                                  "Sleep",
                                  "Awake in Bed",
                                  "Light Physical Activity",
                                  "Sedentary Behaviour"
                                ))

col <- c(`Awake in Bed` = "#CFDAE2",
         `Sleep` = "#8399AE",
         `Moderate-to-vigorous Physical Activity` = "#978787", 
         `Sedentary Behaviour` = "#EFE3E0", 
         `Light Physical Activity` = "#FAF7F3"
         )
family <- "Arial Narrow"

grDevices::cairo_pdf(
  file = paste0(outputdir, "composition_media", ".pdf"),
  width = 9,
  height = 4.5,
)

ggplot(composition, aes(x = "", y = prop, fill = behaviour)) +
  geom_bar(stat = "identity", width = 1.3, linewidth = 1.3) +
  coord_polar("y", start = 0.25) +
  geom_text(
    aes(label = prop_labels),
    position = position_stack(vjust = 0.5),
    size = 3.5,
    family = family
  ) +
  facet_wrap(~ label) +
  scale_fill_manual(values = alpha(col, 0.8), name = "Minutes in") +
  hrbrthemes::theme_ipsum() +
  theme(
    panel.background   = element_blank(),
    panel.border       = element_blank(),
    panel.grid.major   = element_blank(),
    panel.grid.minor   = element_blank(),
    plot.background    = element_rect(fill = "transparent", colour = NA),
    strip.background   = element_rect(fill = "transparent", colour = NA),
    axis.title.x       = element_blank(),
    axis.title.y       = element_blank(),
    axis.text.x        = element_blank(),
    axis.text.y        = element_blank(),
    strip.text         = element_text(size = 13, hjust = 0, face = "bold"),
    legend.title       = element_text(size = 12, face = "bold"),
    legend.text       = element_text(size = 12),
    plot.margin        = margin(.5, .5, .5, .5, "cm"),
    legend.position    = "bottom"
  )

dev.off()

ggplot(composition, aes(x = "", y = prop, fill = behaviour)) +
  geom_bar(stat = "identity", width = 1.3, size = 1.3) +
  coord_polar("y", start = 180) +
  geom_text(
    aes(label = prop_labels),
    position = position_stack(vjust = 0.5),
    size = 3.5,
    family = family
  ) +
  facet_wrap(~ label) +
  scale_fill_manual(values = alpha(col, 0.8), name = "Minutes in") +
  hrbrthemes::theme_ipsum() +
  theme(
    panel.background   = element_blank(),
    panel.border       = element_blank(),
    panel.grid.major   = element_blank(),
    panel.grid.minor   = element_blank(),
    plot.background    = element_rect(fill = "transparent", colour = NA),
    strip.background   = element_rect(fill = "transparent", colour = NA),
    axis.title.x       = element_blank(),
    axis.title.y       = element_blank(),
    axis.text.x        = element_blank(),
    axis.text.y        = element_blank(),
    strip.text         = element_text(size = 13, hjust = 0, face = "bold"),
    legend.title       = element_text(size = 12, face = "bold"),
    legend.text       = element_text(size = 12),
    plot.margin        = margin(.5, .5, .5, .5, "cm"),
    legend.position    = "bottom"
  )
