# Code example from 'fedup_doubleTest' vignette. See references/ for full tutorial.

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
data(geneDouble)
data(pathwaysGMT)

## -----------------------------------------------------------------------------
str(geneDouble)
str(head(pathwaysGMT))

## -----------------------------------------------------------------------------
fedupRes <- runFedup(geneDouble, pathwaysGMT)

## -----------------------------------------------------------------------------
set <- "FASN_negative"
print(head(fedupRes[[set]][which(fedupRes[[set]]$status == "enriched"),]))
print(head(fedupRes[[set]][which(fedupRes[[set]]$status == "depleted"),]))

## -----------------------------------------------------------------------------
set <- "FASN_positive"
print(head(fedupRes[[set]][which(fedupRes[[set]]$status == "enriched"),]))
print(head(fedupRes[[set]][which(fedupRes[[set]]$status == "depleted"),]))

## -----------------------------------------------------------------------------
fedupPlot <- fedupRes %>%
    bind_rows(.id = "set") %>%
    separate(col = "set", into = c("set", "sign"), sep = "_") %>%
    subset(qvalue < 0.05) %>%
    mutate(log10qvalue = -log10(qvalue)) %>%
    mutate(pathway = gsub("\\%.*", "", pathway)) %>%
    as.data.frame()

## ----fedupDotPlot, fig.width = 11, fig.height = 15.5--------------------------
p <- plotDotPlot(
        df = fedupPlot,
        xVar = "log10qvalue",
        yVar = "pathway",
        xLab = "-log10(qvalue)",
        fillVar = "sign",
        fillLab = "Genetic interaction",
        fillCol = c("#6D90CA", "#F6EB13"),
        sizeVar = "fold_enrichment",
        sizeLab = "Fold enrichment") +
    facet_grid("sign", scales = "free", space = "free") +
    theme(strip.text.y = element_blank())
print(p)

## -----------------------------------------------------------------------------
resultsFolder <- tempdir()
writeFemap(fedupRes, resultsFolder)

## -----------------------------------------------------------------------------
gmtFile <- tempfile("pathwaysGMT", fileext = ".gmt")
writePathways(pathwaysGMT, gmtFile)

## ----fedupEM_geneDouble, eval = FALSE-----------------------------------------
# netFile <- tempfile("fedupEM_geneDouble", fileext = ".png")
# plotFemap(
#     gmtFile = gmtFile,
#     resultsFolder = resultsFolder,
#     qvalue = 0.05,
#     chartData = "DATA_SET",
#     hideNodeLabels = TRUE,
#     netName = "fedupEM_geneDouble",
#     netFile = netFile
# )

## -----------------------------------------------------------------------------
sessionInfo()

