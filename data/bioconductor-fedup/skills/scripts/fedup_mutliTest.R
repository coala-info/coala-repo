# Code example from 'fedup_mutliTest' vignette. See references/ for full tutorial.

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
data(geneMulti)
data(pathwaysGMT)

## -----------------------------------------------------------------------------
str(geneMulti)
str(head(pathwaysGMT))

## -----------------------------------------------------------------------------
fedupRes <- runFedup(geneMulti, pathwaysGMT)

## -----------------------------------------------------------------------------
set <- "FASN_negative"
print(head(fedupRes[[set]][which(fedupRes[[set]]$status == "enriched"),]))
print(head(fedupRes[[set]][which(fedupRes[[set]]$status == "depleted"),]))

## -----------------------------------------------------------------------------
set <- "FASN_positive"
print(head(fedupRes[[set]][which(fedupRes[[set]]$status == "enriched"),]))
print(head(fedupRes[[set]][which(fedupRes[[set]]$status == "depleted"),]))

## -----------------------------------------------------------------------------
names(fedupRes)

## -----------------------------------------------------------------------------
fedupPlot <- fedupRes %>%
    bind_rows(.id = "set") %>%
    separate(col = "set", into = c("set", "sign"), sep = "_") %>%
    subset(qvalue < 0.05) %>%
    mutate(log10qvalue = -log10(qvalue)) %>%
    mutate(pathway = gsub("\\%.*", "", pathway)) %>%
    as.data.frame()

## ----fedupDotPlot, fig.width = 18, fig.height = 15.5--------------------------
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
    facet_grid("sign ~ set", scales = "free_y", space = "free") +
    theme(strip.text.y = element_blank())
print(p)

## -----------------------------------------------------------------------------
topPath <- fedupRes %>%
    bind_rows(.id = "set") %>%
    arrange(desc(fold_enrichment)) %>%
    slice(1:20) %>%
    select(pathway) %>%
    unlist() %>%
    as.character()

## -----------------------------------------------------------------------------
print(topPath)

## -----------------------------------------------------------------------------
fedupPlot <- fedupRes %>%
    bind_rows(.id = "set") %>%
    separate(col = "set", into = c("set", "sign"), sep = "_") %>%
    subset(pathway %in% topPath) %>%
    mutate(pathway = gsub("\\%.*", "", pathway)) %>%
    mutate(sign = ifelse(status == "depleted", "none", sign)) %>%
    mutate(sign = factor(sign, levels = c("negative", "positive", "none"))) %>%
    group_by(set, pathway) %>%
    top_n(1, wt = fold_enrichment) %>%
    as.data.frame()

## ----fedupDotPlot_sum, fig.width = 9.5, fig.height = 5------------------------
p <- plotDotPlot(
        df = fedupPlot,
        xVar = "set",
        yVar = "pathway",
        xLab = NULL,
        fillVar = "sign",
        fillLab = "Genetic interaction",
        fillCol = c("#6D90CA", "#F6EB13", "grey80"),
        sizeVar = "fold_enrichment",
        sizeLab = "Fold enrichment") +
    theme(
        panel.grid.major.y = element_blank(),
        axis.text.x = element_text(face = "italic", angle = 90,
        vjust = 0.5, hjust = 1))
print(p)

## -----------------------------------------------------------------------------
resultsFolder <- tempdir()
writeFemap(fedupRes, resultsFolder)

## -----------------------------------------------------------------------------
gmtFile <- tempfile("pathwaysGMT", fileext = ".gmt")
writePathways(pathwaysGMT, gmtFile)

## ----fedupEM_geneMulti, eval = FALSE------------------------------------------
# netFile <- tempfile("fedupEM_geneMulti", fileext = ".png")
# plotFemap(
#     gmtFile = gmtFile,
#     resultsFolder = resultsFolder,
#     qvalue = 0.05,
#     chartData = "DATA_SET",
#     hideNodeLabels = TRUE,
#     netName = "fedupEM_geneMulti",
#     netFile = netFile
# )

## -----------------------------------------------------------------------------
sessionInfo()

