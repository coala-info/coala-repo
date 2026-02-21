# Code example from 'fedup_singleTest' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    fig.path = "vignettes/figures/",
    out.width = "100%"
)

## ----eval = FALSE, message = FALSE--------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("fedup")

## ----message = FALSE----------------------------------------------------------
devtools::install_github("rosscm/fedup", quiet = TRUE)

## ----message = FALSE----------------------------------------------------------
library(fedup)
library(dplyr)
library(tidyr)
library(ggplot2)

## -----------------------------------------------------------------------------
data(geneSingle)
data(pathwaysGMT)

## -----------------------------------------------------------------------------
str(geneSingle)
str(head(pathwaysGMT))

## -----------------------------------------------------------------------------
fedupRes <- runFedup(geneSingle, pathwaysGMT)

## -----------------------------------------------------------------------------
set <- "FASN_negative"
print(head(fedupRes[[set]][which(fedupRes[[set]]$status == "enriched"),]))
print(head(fedupRes[[set]][which(fedupRes[[set]]$status == "depleted"),]))

## -----------------------------------------------------------------------------
fedupPlot <- fedupRes %>%
    bind_rows(.id = "set") %>%
    separate(col = "set", into = c("set", "sign"), sep = "_") %>%
    subset(qvalue < 0.05) %>%
    mutate(log10qvalue = -log10(qvalue)) %>%
    mutate(pathway = gsub("\\%.*", "", pathway)) %>%
    mutate(status = factor(status, levels = c("enriched", "depleted"))) %>%
    as.data.frame()

## ----fedupDotPlot, fig.width = 11, fig.height = 7-----------------------------
p <- plotDotPlot(
        df = fedupPlot,
        xVar = "log10qvalue",
        yVar = "pathway",
        xLab = "-log10(qvalue)",
        fillVar = "status",
        fillLab = "Enrichment\nstatus",
        sizeVar = "fold_enrichment",
        sizeLab = "Fold enrichment") +
    facet_grid("status", scales = "free", space = "free") +
    theme(strip.text.y = element_blank())
print(p)

## ----fedupDotplot_signCol, fig.width = 11, fig.height = 7---------------------
p <- plotDotPlot(
        df = fedupPlot,
        xVar = "log10qvalue",
        yVar = "pathway",
        xLab = "-log10(qvalue)",
        fillVar = "sign",
        fillLab = "Genetic interaction",
        fillCol = "#6D90CA",
        sizeVar = "fold_enrichment",
        sizeLab = "Fold enrichment") +
    facet_grid("status", scales = "free", space = "free") +
    theme(strip.text.y = element_blank())
print(p)

## -----------------------------------------------------------------------------
resultsFolder <- tempdir()
writeFemap(fedupRes, resultsFolder)

## -----------------------------------------------------------------------------
gmtFile <- tempfile("pathwaysGMT", fileext = ".gmt")
writePathways(pathwaysGMT, gmtFile)

## ----fedupEM, eval = FALSE----------------------------------------------------
# netFile <- tempfile("fedupEM_geneSingle", fileext = ".png")
# plotFemap(
#     gmtFile = gmtFile,
#     resultsFolder = resultsFolder,
#     qvalue = 0.05,
#     chartData = "NES_VALUE",
#     hideNodeLabels = TRUE,
#     netName = "fedupEM_geneSingle",
#     netFile = netFile
# )

## -----------------------------------------------------------------------------
sessionInfo()

