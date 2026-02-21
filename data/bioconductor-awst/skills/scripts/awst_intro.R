# Code example from 'awst_intro' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL
)

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE----------------
## Track time spent on making the vignette
startTime <- Sys.time()

## Bib setup
library("RefManageR")

## Write bibliography information
bib <- c(
    R = citation(),
    BiocStyle = citation("BiocStyle")[1],
    knitr = citation("knitr")[1],
    RefManageR = citation("RefManageR")[1],
    rmarkdown = citation("rmarkdown")[1],
    sessioninfo = citation("sessioninfo")[1],
    testthat = citation("testthat")[1],
    awst = citation("awst")[1]
)

## ----"install", eval = FALSE--------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("awst")
# 
# ## Check that you have a valid Bioconductor installation
# BiocManager::valid()

## ----"citation"---------------------------------------------------------------
## Citation info
citation("awst")

## ----"start", message=FALSE, warning=FALSE------------------------------------
library(awst)
library(airway)
library(SummarizedExperiment)
library(EDASeq)
library(ggplot2)

## ----reading------------------------------------------------------------------
data(airway)
airway

## ----filtering----------------------------------------------------------------
filter <- rowMeans(assay(airway)) >= 10
table(filter)

se <- airway[filter,]

## ----raw_awst-----------------------------------------------------------------
se <- awst(se)
se
plot(density(assay(se, "awst")[,1]), main = "Sample 1")

## ----genefilter---------------------------------------------------------------
filtered <- gene_filter(se)
dim(filtered)

## ----pca----------------------------------------------------------------------
res_pca <- prcomp(t(assay(filtered, "awst")))
df <- as.data.frame(cbind(res_pca$x, colData(airway)))
ggplot(df, aes(x = PC1, y = PC2, color = dex, shape = cell)) +
    geom_point() + theme_classic()

## ----full---------------------------------------------------------------------
assay(se, "fq") <- betweenLaneNormalization(assay(se), which="full")
se <- awst(se, expr_values = "fq")

res_pca <- prcomp(t(assay(se, "awst")))
df <- as.data.frame(cbind(res_pca$x, colData(airway)))
ggplot(df, aes(x = PC1, y = PC2, color = dex, shape = cell)) +
    geom_point() + theme_classic()

## ----createVignette, eval=FALSE-----------------------------------------------
# ## Create the vignette
# library("rmarkdown")
# system.time(render("awst_intro.Rmd", "BiocStyle::html_document"))
# 
# ## Extract the R code
# library("knitr")
# knit("awst_intro.Rmd", tangle = TRUE)

## ----reproduce1, echo=FALSE---------------------------------------------------
## Date the vignette was generated
Sys.time()

## ----reproduce2, echo=FALSE---------------------------------------------------
## Processing time in seconds
totalTime <- diff(c(startTime, Sys.time()))
round(totalTime, digits = 3)

## ----reproduce3, echo=FALSE-------------------------------------------------------------------------------------------
## Session info
library("sessioninfo")
options(width = 120)
session_info()

## ----vignetteBiblio, results="asis", echo=FALSE, warning=FALSE, message=FALSE-----------------------------------------
## Print bibliography
PrintBibliography(bib, .opts = list(hyperlink = "to.doc", style = "html"))

