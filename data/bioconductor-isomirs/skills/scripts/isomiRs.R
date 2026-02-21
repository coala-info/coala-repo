# Code example from 'isomiRs' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, results="hide"----------------------------------------
library(BiocStyle)
knitr::opts_chunk$set(tidy=FALSE, cache=FALSE,
                      dev="png",
                      message=FALSE, error=FALSE,
                      warning=TRUE)

## ----package-select,message=FALSE---------------------------------------------
library(isomiRs)
data(mirData)
head(isoSelect(mirData, mirna="hsa-let-7a-5p", 1000))

## ----package-load,message=FALSE-----------------------------------------------
library(isomiRs)
data(mirData)

## ----package-plot-iso,message=FALSE,eval=FALSE--------------------------------
# ids <- IsomirDataSeqFromFiles(fn_list, design=de)

## ----package-plot-iso-t5,message=FALSE----------------------------------------
ids <- isoCounts(mirData)
isoPlot(ids, type="all")

## ----package-count,message=FALSE----------------------------------------------
head(counts(ids))

## ----package-norm,message=FALSE-----------------------------------------------
library(pheatmap)
ids = isoNorm(ids, formula = ~ condition)
pheatmap(counts(ids, norm=TRUE)[1:100,], 
         annotation_col = data.frame(colData(ids)[,1,drop=FALSE]),
         show_rownames = FALSE, scale="row")

## ----package-isoannotation----------------------------------------------------
head(isoAnnotate(ids))

## ----package-de,message=FALSE-------------------------------------------------
dds <- isoDE(ids, formula=~condition)
library(DESeq2)
plotMA(dds)
head(results(dds, format="DataFrame"))

## ----package-de-iso5,message=FALSE--------------------------------------------
dds = isoDE(ids, formula=~condition, ref=TRUE, iso5=TRUE)
head(results(dds, tidy=TRUE))

## ----package-de-with-deseq2---------------------------------------------------
dds = DESeqDataSetFromMatrix(counts(ids),
                             colData(ids), design = ~condition)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

