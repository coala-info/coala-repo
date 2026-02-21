# Code example from 'systemPipeTools' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', eval=TRUE-------------------------
BiocStyle::markdown()
options(width = 80, max.print = 1000)
knitr::opts_chunk$set(
  eval = as.logical(Sys.getenv("KNITR_EVAL", "TRUE")),
  cache = as.logical(Sys.getenv("KNITR_CACHE", "TRUE")),
  tidy.opts = list(width.cutoff = 80), tidy = TRUE
)

## ----setup, echo=FALSE, messages=FALSE, warnings=FALSE, eval=TRUE-------------
suppressPackageStartupMessages({
    library(systemPipeTools)
    library(systemPipeR)
})

## ----install, eval=FALSE------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# BiocManager::install("systemPipeTools")
# BiocManager::install("systemPipeR")

## ----documentation, eval=FALSE------------------------------------------------
# library("systemPipeTools")  # Loads the package
# library(help = "systemPipeTools")  # Lists package info
# vignette("systemPipeTools")  # Opens vignette

## ----targets_counts, eval=TRUE------------------------------------------------
## Targets file
targetspath <- system.file("extdata", "targets.txt", package = "systemPipeR")
targets <- read.delim(targetspath, comment = "#")
cmp <- systemPipeR::readComp(file = targetspath, format = "matrix", 
                             delim = "-")
## Count table file
countMatrixPath <- system.file("extdata", "countDFeByg.xls",
                               package = "systemPipeR")
countMatrix <- read.delim(countMatrixPath, row.names = 1)
showDT(countMatrix)

## ----exploreDDS, eval=TRUE, warning=FALSE-------------------------------------
exploredds <- exploreDDS(countMatrix, targets, cmp = cmp[[1]], preFilter = NULL, 
                         transformationMethod = "rlog")
exploredds

## ----exploreDDSplot, eval=FALSE, warning=FALSE, message=FALSE-----------------
# exploreDDSplot(countMatrix, targets, cmp = cmp[[1]], preFilter = NULL,
#                samples = c("M12A", "M12A", "A12A", "A12A"),
#                scattermatrix = TRUE)

## ----hclustplot, eval=TRUE----------------------------------------------------
hclustplot(exploredds, method = "spearman")

## ----heatMaplot_samples, eval=TRUE--------------------------------------------
## Samples plot
heatMaplot(exploredds, clust = "samples", plotly = FALSE)

## ----heatMaplot_DEG, eval=TRUE, warning=FALSE---------------------------------
## Individuals genes identified in DEG analysis
### DEG analysis with `systemPipeR`
degseqDF <- systemPipeR::run_DESeq2(countDF = countMatrix, targets = targets, 
                                    cmp = cmp[[1]], independent = FALSE)
DEG_list <- systemPipeR::filterDEGs(degDF = degseqDF, 
                                    filter = c(Fold = 2, FDR = 10))
### Plot
heatMaplot(exploredds, clust = "ind", 
           DEGlist = unique(as.character(unlist(DEG_list[[1]]))))

## ----PCAplot, eval=TRUE-------------------------------------------------------
PCAplot(exploredds, plotly = FALSE)

## ----MDSplot, eval=TRUE-------------------------------------------------------
 MDSplot(exploredds, plotly = FALSE)

## ----GLMplot, eval=TRUE, warning=FALSE, message=FALSE-------------------------
exploredds_r <- exploreDDS(countMatrix, targets, cmp = cmp[[1]], 
                         preFilter = NULL, transformationMethod = "raw")
GLMplot(exploredds_r, plotly = FALSE)

## ----MAplot, eval=TRUE--------------------------------------------------------
MAplot(degseqDF, comparison = "M12-A12", filter = c(Fold = 1, FDR = 20), 
            genes = "ATCG00280")

## ----tSNEplot, eval=TRUE------------------------------------------------------
tSNEplot(countMatrix, targets, perplexity = 5)

## ----volcanoplot, eval=TRUE---------------------------------------------------
volcanoplot(degseqDF, comparison = "M12-A12", filter = c(Fold = 1, FDR = 20), 
            genes = "ATCG00280")

## ----sessionInfo, eval=TRUE---------------------------------------------------
sessionInfo()

