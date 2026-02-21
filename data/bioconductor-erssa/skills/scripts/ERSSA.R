# Code example from 'ERSSA' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("ERSSA")

## ----out.width = "500px", echo=FALSE, fig.align = "center"--------------------
knitr::include_graphics("Figures/GTEx/ERSSA_plot_1_NumOfDEGenes_N10_title.png")

## ----out.width = "500px", echo=FALSE, fig.align = "center"--------------------
knitr::include_graphics("Figures/GTEx/ERSSA_plot_1_NumOfDEGenes_N25_title.png")

## -----------------------------------------------------------------------------
library(ERSSA)

# GTEx dataset with 10 heart and 10 muscle samples
# "full"" dataset contains all ensembl genes
data(condition_table.full)
data(count_table.full)

# For test purposes and faster run time, we will use a smaller "partial" dataset
# 4 heart and 4 muscle samples
# partial dataset contains 1000 genes
data(condition_table.partial)
data(count_table.partial)

# NOTE: the figures are generated from the "full" dataset

## -----------------------------------------------------------------------------
head(count_table.full[,1:2])

## -----------------------------------------------------------------------------
condition_table.full

## ----message=FALSE, warning=FALSE---------------------------------------------
set.seed(1) # for reproducible subsample generation

ssa = erssa(count_table.partial, condition_table.partial, DE_ctrl_cond='heart')

# Running full dataset is skipped in the interest of run time
# ssa = erssa(count_table.full, condition_table.full, DE_ctrl_cond='heart')

## ----out.width = "500px", echo=FALSE, fig.align = "center"--------------------
knitr::include_graphics("Figures/GTEx/ERSSA_plot_1_NumOfDEGenes.png")

## ----out.width = "500px", echo=FALSE, fig.align = "center"--------------------
knitr::include_graphics("Figures/GTEx/ERSSA_plot_2_MarginalNumOfDEGenes.png")

## ----out.width = "500px", echo=FALSE, fig.align = "center"--------------------
knitr::include_graphics("Figures/GTEx/ERSSA_plot_3_IntersectDEGenes.png")

## ----out.width = "500px", echo=FALSE, fig.align = "center"--------------------
knitr::include_graphics("Figures/GTEx/ERSSA_plot_4_FPRvTPRPlot.png")

## ----message=FALSE, warning=FALSE---------------------------------------------
library(ggplot2)

# Parse out plot 1
de_plot = ssa$gg.dotPlot.obj$gg_object 
# Change y-axis label to be more descriptive
de_plot = de_plot + ylab('Number of differentially expressed genes')

# Save the plot in the current working directory with new dimensions and a
# lower resolution.
ggsave(filename='ERSSA_plot_1_NumOfDEGenes.png',
     plot=de_plot, dpi=100, width = 15,
     height = 10, units = "cm")

## ----out.width = "500px", echo=FALSE, fig.align = "center"--------------------
knitr::include_graphics("Figures/GTEx/ERSSA_plot_1_NumOfDEGenes_lowRes.png")

## ----out.width = "500px", echo=FALSE, fig.align = "center"--------------------
knitr::include_graphics("Figures/MP/ERSSA_plot_1_NumOfDEGenes.png")
knitr::include_graphics("Figures/MP/ERSSA_plot_2_MarginalNumOfDEGenes.png")
knitr::include_graphics("Figures/MP/ERSSA_plot_3_IntersectDEGenes.png")
knitr::include_graphics("Figures/MP/ERSSA_plot_4_FPRvTPRPlot.png")

## ----out.width = "500px", echo=FALSE, fig.align = "center"--------------------
knitr::include_graphics("Figures/Fossum/ERSSA_plot_1_NumOfDEGenes_AbslogFC1_title.png")

## ----out.width = "500px", echo=FALSE, fig.align = "center"--------------------
knitr::include_graphics("Figures/Fossum/ERSSA_plot_1_NumOfDEGenes_AbslogFC0.5_title.png")
knitr::include_graphics("Figures/Fossum/ERSSA_plot_2_MarginalNumOfDEGenes.png")
knitr::include_graphics("Figures/Fossum/ERSSA_plot_3_IntersectDEGenes.png")
knitr::include_graphics("Figures/Fossum/ERSSA_plot_4_FPRvTPRPlot.png")

## -----------------------------------------------------------------------------
sessionInfo()

