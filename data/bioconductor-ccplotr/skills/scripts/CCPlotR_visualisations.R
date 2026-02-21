# Code example from 'CCPlotR_visualisations' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# 
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("CCPlotR")
# 
# ## or for development version:
# 
# devtools::install_github("Sarah145/CCPlotR")
# 

## ----preview_data-------------------------------------------------------------
library(CCPlotR)
data(toy_data, toy_exp, package = 'CCPlotR')
head(toy_data)
head(toy_exp)

## ----heatmaps, fig.width=7, fig.height=7--------------------------------------
cc_heatmap(toy_data)
cc_heatmap(toy_data, option = "B", n_top_ints = 10)
cc_heatmap(toy_data, option = "CellPhoneDB")

## ----dotplots, fig.width=7, fig.height=5--------------------------------------
cc_dotplot(toy_data)
cc_dotplot(toy_data, option = "B", n_top_ints = 10)
cc_dotplot(toy_data, option = "Liana", n_top_ints = 15)

## ----network, fig.width=8, fig.height=7.5-------------------------------------
cc_network(toy_data)
cc_network(toy_data, colours = c("orange", "cornflowerblue", "hotpink"), option = "B")

## ----circos1, fig.width=5, fig.height=5---------------------------------------
cc_circos(toy_data)

## ----circos2, fig.width=8, fig.height=8---------------------------------------
cc_circos(toy_data, option = "B", n_top_ints = 10, cex = 0.75)
cc_circos(toy_data, option = "C", n_top_ints = 15, exp_df = toy_exp, cell_cols = c(`B` = "hotpink", `NK` = "orange", `CD8 T` = "cornflowerblue"), palette = "PuRd", cex = 0.75)

## ----arrows, fig.width=8, fig.height=5.5--------------------------------------
cc_arrow(toy_data, cell_types = c("B", "CD8 T"), colours = c(`B` = "hotpink", `CD8 T` = "orange"))
cc_arrow(toy_data, cell_types = c("NK", "CD8 T"), option = "B", exp_df = toy_exp, n_top_ints = 10, palette = "OrRd")

## ----sigmoid, fig.height=6, fig.width=8---------------------------------------
cc_sigmoid(toy_data)

## ----palette, fig.height=5, fig.width=5---------------------------------------
scales::show_col(paletteMartin())

## ----themes, fig.height=12, fig.width=12--------------------------------------
library(ggplot2)
library(patchwork)
p1 <- cc_network(toy_data, option = "B") + labs(title = "Default")
p2 <- cc_network(toy_data, option = "B") + scale_fill_manual(values = rainbow(3)) + labs(title = "Update colours")
p3 <- cc_network(toy_data, option = "B") + theme_grey() + labs(title = "Update theme")
p4 <- cc_network(toy_data, option = "B") + theme(legend.position = "top") + labs(title = "Update legend position")

p1 + p2 + p3 + p4

## -----------------------------------------------------------------------------
sessionInfo()

