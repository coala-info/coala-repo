# Code example from 'DESeq2' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## pre-load to avoid load messages in report
library(Glimma)
library(edgeR)
library(DESeq2)

## -----------------------------------------------------------------------------
library(Glimma)
library(edgeR)
library(DESeq2)

dge <- readRDS(system.file("RNAseq123/dge.rds", package = "Glimma"))

dds <- DESeqDataSetFromMatrix(
  countData = dge$counts,
  colData = dge$samples,
  rowData = dge$genes,
  design = ~group
)

## -----------------------------------------------------------------------------
glimmaMDS(dds)

## -----------------------------------------------------------------------------
dds <- DESeq(dds, quiet=TRUE)

## -----------------------------------------------------------------------------
glimmaMA(dds)

## ----eval = FALSE-------------------------------------------------------------
# # creates ma-plot.html in working directory
# # link to it in Rmarkdown using [MA-plot](ma-plot.html)
# htmlwidgets::saveWidget(glimmaMA(dds), "ma-plot.html")

## -----------------------------------------------------------------------------
sessionInfo()

