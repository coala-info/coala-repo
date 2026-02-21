# Code example from 'dinoR-vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----install-pkg, eval = FALSE------------------------------------------------
# if (!require("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# BiocManager::install("dinoR")

## ----setup--------------------------------------------------------------------
suppressPackageStartupMessages({
    library(dinoR)
    library(ggplot2)
    library(dplyr)
})

## ----load data----------------------------------------------------------------
data(NomeData)
NomeData

## ----reads--------------------------------------------------------------------
assays(NomeData)[["reads"]][1, 1]

## ----fig.height=6,fig.width=8-------------------------------------------------
avePlotData <- metaPlots(NomeData = NomeData, nr = 10, ROIgroup = "motif")

# plot average plots
ggplot(avePlotData, aes(x = position, y = protection)) +
    geom_point(alpha = 0.5) +
    geom_line(aes(x = position, y = loess), col = "darkblue", lwd = 2) +
    theme_classic() +
    facet_grid(rows = vars(type), cols = vars(sample), scales = "free") +
    ylim(c(0, 100)) +
    geom_hline(
        yintercept = c(10, 20, 30, 40, 50, 60, 70, 80, 90),
        alpha = 0.5, color = "grey", linetype = "dashed"
    )

## ----fragment classification--------------------------------------------------
NomeData <- footprintCalc(NomeData)
NomeData

## ----fragment classification example------------------------------------------
assays(NomeData)[["footprints"]][[1, 1]][1:10]

## ----fragment class counts----------------------------------------------------
NomeData <- footprintQuant(NomeData)
assays(NomeData)[7:12]

## ----diNOMe-------------------------------------------------------------------
res <- diNOMeTest(NomeData,
    WTsamples = c("WT_1", "WT_2"),
    KOsamples = c("AdnpKO_1", "AdnpKO_2")
)
res

## ----nregulated, fig.height=4,fig.width=7-------------------------------------
res %>%
    group_by(contrasts, motif, regulated) %>%
    summarize(n = n()) %>%
    ggplot(aes(x = motif, y = n, fill = regulated)) +
    geom_bar(stat = "identity") +
    facet_grid(~contrasts) +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) +
    scale_fill_manual(values = c("orange", "grey", "blue3"))

## ----MAplot,fig.height=2,fig.width=10-----------------------------------------
ggplot(res, aes(y = logFC, x = logCPM, col = regulated)) +
    geom_point() +
    facet_grid(~contrasts) +
    theme_bw() +
    scale_color_manual(values = c("orange", "grey", "blue3"))

## ----percentages,fig.height=5,fig.width=7-------------------------------------
footprint_percentages <- footprintPerc(NomeData)
fpPercHeatmap(footprint_percentages)

## ----comparison,fig.height=4,fig.width=8--------------------------------------
compareFootprints(footprint_percentages, res,
    WTsamples = c("WT_1", "WT_2"),
    KOsamples = c("AdnpKO_1", "AdnpKO_2"), plotcols = 
        c("#f03b20", "#a8ddb5", "#bdbdbd")
)

## ----fig.height=2,fig.width=8-------------------------------------------------
res <- diNOMeTest(NomeData,
    WTsamples = c("WT_1", "WT_2"),
    KOsamples = c("AdnpKO_1", "AdnpKO_2"), combineNucCounts = TRUE
)
footprint_percentages <- footprintPerc(NomeData, combineNucCounts = TRUE)
compareFootprints(footprint_percentages, res,
    WTsamples = c("WT_1", "WT_2"),
    KOsamples = c("AdnpKO_1", "AdnpKO_2"), plotcols = 
        c("#f03b20", "#a8ddb5", "#bdbdbd")
)

## -----------------------------------------------------------------------------
sessionInfo()

