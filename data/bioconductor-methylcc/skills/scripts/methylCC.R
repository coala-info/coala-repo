# Code example from 'methylCC' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide", message=FALSE--------------------------------
require(knitr)
opts_chunk$set(error=FALSE, message=FALSE, warning=FALSE)

## ----style, echo=FALSE, results='asis'----------------------------------------
BiocStyle::markdown()

## ----loadlibs, message=FALSE, warning=FALSE-----------------------------------
library(FlowSorted.Blood.450k)
library(methylCC)
library(minfi)
library(tidyr)
library(dplyr)
library(ggplot2)

## ----data-load, message=FALSE-------------------------------------------------
# Phenotypic information about samples
head(pData(FlowSorted.Blood.450k))

# RGChannelSet
rgset <- FlowSorted.Blood.450k[,
                pData(FlowSorted.Blood.450k)$CellTypeLong %in% "Whole blood"]

## ----run-estimatecc1, message=FALSE-------------------------------------------
set.seed(12345)
est <- estimatecc(object = rgset) 
est

## ----run-estimatecc-summaries-------------------------------------------------
cell_counts(est)

## ----run-minfi-estimateCellCounts---------------------------------------------
sampleNames(rgset) <- paste0("Sample", 1:6)

est_minfi <- minfi::estimateCellCounts(rgset)
est_minfi

## ----compare-estimates--------------------------------------------------------
df_minfi = gather(cbind("samples" = rownames(cell_counts(est)),
                        as.data.frame(est_minfi)),
                  celltype, est, -samples)

df_methylCC = gather(cbind("samples" = rownames(cell_counts(est)),
                           cell_counts(est)),
                     celltype, est, -samples)

dfcombined <- full_join(df_minfi, df_methylCC, 
                               by = c("samples", "celltype"))

ggplot(dfcombined, aes(x=est.x, y = est.y, color = celltype)) +
    geom_point() + xlim(0,1) + ylim(0,1) +
    geom_abline(intercept = 0, slope = 1) +
    xlab("Using minfi::estimateCellCounts()") + 
    ylab("Using methylCC::estimatecc()") +
    labs(title = "Comparing cell composition estimates")

## ----sessionInfo, results='markup'--------------------------------------------
sessionInfo()

