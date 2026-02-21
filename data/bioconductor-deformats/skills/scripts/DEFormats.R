# Code example from 'DEFormats' vignette. See references/ for full tutorial.

## ----library, message=FALSE---------------------------------------------------
library(DESeq2)
library(edgeR)
library(DEFormats)

## ----counts-------------------------------------------------------------------
counts = simulateRnaSeqData()

## ----headcounts---------------------------------------------------------------
head(counts)

## ----dge----------------------------------------------------------------------
group = rep(c("A", "B"), each = 3)

dge = DGEList(counts, group = group)
dge

## ----dds----------------------------------------------------------------------
dds = as.DESeqDataSet(dge)
dds

## ----dgedds-------------------------------------------------------------------
identical(dge, as.DGEList(dds))

## ----identicalDDS-------------------------------------------------------------
dds1 = DESeqDataSetFromMatrix(counts, data.frame(condition=group), ~ condition)
dds2 = DESeqDataSetFromMatrix(counts, data.frame(condition=group), ~ condition)

identical(dds1, dds2)

## ----se-----------------------------------------------------------------------
se = simulateRnaSeqData(output = "RangedSummarizedExperiment")
se

## ----dds_se-------------------------------------------------------------------
dds = DESeqDataSet(se, design = ~ condition)

## ----dgedds2------------------------------------------------------------------
dge = as.DGEList(dds)
dge

## ----dgeSE--------------------------------------------------------------------
names(colData(se)) = "group"
dge = DGEList(se)
dge

## ----rse----------------------------------------------------------------------
dds = as.DESeqDataSet(dge)
rse = as(dds, "RangedSummarizedExperiment")
rse

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

