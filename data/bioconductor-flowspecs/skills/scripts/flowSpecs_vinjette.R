# Code example from 'flowSpecs_vinjette' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results='hide', message=FALSE-------------------------
library(BiocStyle)
library(knitr)
library(flowCore)
opts_chunk$set(error=FALSE, message=FALSE, warning=FALSE)
knitr::opts_chunk$set(echo = TRUE)

## ----eval = FALSE-------------------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("flowSpecs")

## -----------------------------------------------------------------------------
library(flowSpecs)
library(flowCore)
data("unmixCtrls")
unmixCtrls
data('fullPanel')
fullPanel[,seq(4,7)]

## -----------------------------------------------------------------------------
sampleNames(unmixCtrls)

## -----------------------------------------------------------------------------
specMat <- specMatCalc(unmixCtrls, groupNames = c("Beads_", "Dead_"), 
                        autoFluoName = "PBMC_unstained.fcs")
str(specMat)

## -----------------------------------------------------------------------------
fullPanelUnmix <- specUnmix(fullPanel, specMat)
fullPanelUnmix

## -----------------------------------------------------------------------------
fullPanelTrans <- arcTrans(fullPanelUnmix, transNames = 
                            colnames(fullPanelUnmix)[6:18])
par(mfrow=c(1,2))
hist(exprs(fullPanelUnmix)[,7], main = "Pre transformation", 
     xlab = "AF700_CD4", breaks = 200)
hist(exprs(fullPanelTrans)[,7], main = "Post transformation", 
     xlab = "AF700_CD4", breaks = 200)

## -----------------------------------------------------------------------------
oneVsAllPlot(fullPanelTrans, "AF647_IgM", saveResult = FALSE)

## -----------------------------------------------------------------------------
corrMat <- corrMatCreate(specMat)

## -----------------------------------------------------------------------------
corrMat["BV650_CD56", "AF647_IgM"] <- -0.1
fullPanelCorr <- correctUnmix(fullPanelUnmix, corrMat)
oneVsAllPlot(fullPanelCorr, "AF647_IgM", saveResult = FALSE)

## -----------------------------------------------------------------------------
corrMat["BV650_CD56", "AF647_IgM"] <- -0.03
fullPanelCorr <- correctUnmix(fullPanelUnmix, corrMat)
oneVsAllPlot(fullPanelCorr, "AF647_IgM", saveResult = FALSE)

## -----------------------------------------------------------------------------
fullPanelFs <- flowSet(fullPanelTrans)
sampleNames(fullPanelFs) <- "PBMC_full_panel_d1.fcs"

## -----------------------------------------------------------------------------
fullPanelDf <- flowSet2LongDf(fullPanelFs, idInfo =
        list("Tissue" = "|_full_panel_..\\.fcs", 
             "Donor" = "...._full_panel_|\\.fcs"))
str(fullPanelDf)

## -----------------------------------------------------------------------------
sessionInfo()

