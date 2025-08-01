library(data.table)
library(JWileymisc)
library(extraoperators)
library(multilevelcoda)
library(multilevelTools)
library(emmeans)
library(doFuture)
library(compositions)
library(zCompositions)

library(bayestestR)
library(brms)
library(lme4)
library(loo)
library(performance)

library(ggplot2)
library(scales)
library(cowplot)
library(visreg)
library(ggthemes)
library(viridis)
library(tidyr)
library(gt)
library(gridExtra) 
library(ggpubr)
library(wesanderson)
library(hrbrthemes)
library(ggsci)
library(stats)
library(patchwork)
library(hrbrthemes)
library(latex2exp)
library(posterior)

library(htmltools)
library(purrr)
library(kableExtra)

expand.grid.df <- function(...) Reduce(function(...) merge.data.frame(..., by = NULL, all = TRUE), list(...))

if (Sys.info()[["user"]] %in% c("florale")) {
outputdir <- "/Users/florale/Library/CloudStorage/OneDrive-Personal/monash/projects/multilevelcoda-24h/multilevelcoda-24h-affect/data/"
} else if (Sys.info()[["user"]] %in% c("flee0016")) {
outputdir <- "/Users/flee0016/Library/CloudStorage/OneDrive-Personal/monash/projects/multilevelcoda-24h/multilevelcoda-24h-affect/data/"
}

options(mc.cores = 8)
