# Code example from 'pedigree_plot' vignette. See references/ for full tutorial.

## ----setup, include = FALSE-----------------------------------------------------------------------
knitr::opts_chunk$set(
    echo = TRUE,
    fig.dim = c(8, 4),
    fig.align = "center"
)

## ----polygons, fig.alt = "Different polygons"-----------------------------------------------------
library(Pedixplorer)
types <- c(
    "square_1_1", # Whole square
    "circle_2_1", # Semi circle first division
    "diamond_3_2", # Third of diamond second division
    "triangle_4_3" # Fourth of triangle third division
)
df <- plot_df <- data.frame(
    x0 = c(1, 3, 5, 7), y0 = 1,
    type = types,
    fill = c("red", "blue", "green", "yellow"),
    border = "black",
    angle = c(NA, 90, 0, 45),
    density = c(NA, 10, 20, 40)
)
plot_fromdf(df, usr = c(0, 8, 0, 2))

## ----interactive_plot, fig.alt = "Interactive plot", eval = FALSE---------------------------------
# data(sampleped)
# pedi <- Pedigree(sampleped)
# 
# p <- plot(
#     pedi, ggplot_gen = TRUE,
#     tips = c("affection", "momid", "dadid"),
#     symbolsize = 1.5, cex = 0.8
# )
# plotly::layout(
#     plotly::ggplotly(p$ggplot, tooltip = "text"),
#     hoverlabel = list(bgcolor = "darkgrey")
# )

## -------------------------------------------------------------------------------------------------
sessionInfo()

