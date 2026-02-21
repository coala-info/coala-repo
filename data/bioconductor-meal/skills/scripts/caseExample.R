# Code example from 'caseExample' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE)

## ----Load_Packages, message = FALSE-------------------------------------------
library(MEAL)
library(brgedata)
library(MultiDataSet)
library(missMethyl)
library(minfi)
library(GenomicRanges)
library(ggplot2)

## ----Methylation_Data---------------------------------------------------------
data(brge_methy)
brge_methy
colData(brge_methy)

## ----Expression_Data----------------------------------------------------------
data(brge_gexp)
brge_gexp
lapply(pData(brge_gexp), table)

## -----------------------------------------------------------------------------
targetRange <- GRanges("chr11:102600000-103300000")

## ----Meth_Analysis------------------------------------------------------------
cellCounts <- colnames(colData(brge_methy))[3:9]
methRes <- runDiffMeanAnalysis(set = brge_methy, 
                       model = formula(paste("~ sex +", paste(cellCounts, collapse = "+"))))
methRes
names(methRes)

## ----Plot QQ 1----------------------------------------------------------------
plot(methRes, rid = "DiffMean", type = "qq")

## ----Manhattans---------------------------------------------------------------
targetRangeNum <- GRanges("11:102600000-103300000")
plot(methRes, rid = "DiffMean", type = "manhattan", main = "Differences in Means", highlight = targetRangeNum)

## ----Exp show-----------------------------------------------------------------
targetRange <- GRanges("chr11:102600000-103300000")
gexpRes <- runDiffMeanAnalysis(set = brge_gexp, model = ~ sex)
names(gexpRes)

## ----Plot QQ exp 1------------------------------------------------------------
plot(gexpRes, rid = "DiffMean", type = "qq")

## ----Volcano gexp-------------------------------------------------------------
plot(gexpRes, rid = "DiffMean", type = "volcano") + ggtitle("Differences in Means")

## ----Manhattans gexp----------------------------------------------------------
targetRange <- GRanges("chr11:102600000-103300000")
plot(gexpRes, rid = "DiffMean", type = "manhattan", main = "Differences in Means", highlight = targetRangeNum)

## ----Regional plot 2 exp------------------------------------------------------
plotRegion(rset = methRes, rset2 = gexpRes, range = targetRange)

## ----New Multi Meth Exp-------------------------------------------------------
multi <- createMultiDataSet()
multi <- add_genexp(multi, brge_gexp)
multi <- add_methy(multi, brge_methy)

## -----------------------------------------------------------------------------
multi.filt <- multi[, , targetRange]

## ----Corr Meth Exp------------------------------------------------------------
methExprs <- correlationMethExprs(multi.filt)
head(methExprs)

## ----SessionInfo--------------------------------------------------------------
sessionInfo()

