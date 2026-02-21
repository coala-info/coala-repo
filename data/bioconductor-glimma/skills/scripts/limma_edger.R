# Code example from 'limma_edger' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## pre-load to avoid load messages in report
library(Glimma)
library(limma)
library(edgeR)

## -----------------------------------------------------------------------------
library(Glimma)
library(limma)
library(edgeR)

dge <- readRDS(system.file("RNAseq123/dge.rds", package = "Glimma"))

## -----------------------------------------------------------------------------
glimmaMDS(dge)

## -----------------------------------------------------------------------------
design <- readRDS(
  system.file("RNAseq123/design.rds", package = "Glimma"))
contr.matrix <- readRDS(
  system.file("RNAseq123/contr.matrix.rds", package = "Glimma"))

## -----------------------------------------------------------------------------
v <- voom(dge, design)
vfit <- lmFit(v, design)
vfit <- contrasts.fit(vfit, contrasts = contr.matrix)
efit <- eBayes(vfit)

## -----------------------------------------------------------------------------
dge <- estimateDisp(dge, design)
gfit <- glmFit(dge, design)
glrt <- glmLRT(gfit, design, contrast = contr.matrix)

## -----------------------------------------------------------------------------
glimmaMA(efit, dge = dge) # glimmaMA(glrt, dge = dge) to use edgeR results

## -----------------------------------------------------------------------------
glimmaVolcano(efit, dge = dge)

## ----eval = FALSE-------------------------------------------------------------
# htmlwidgets::saveWidget(glimmaMA(efit, dge = dge), "ma-plot.html")
# # you can link to it in Rmarkdown using [MA-plot](ma-plot.html)

## -----------------------------------------------------------------------------
sessionInfo()

