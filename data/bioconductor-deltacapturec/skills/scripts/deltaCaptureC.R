# Code example from 'deltaCaptureC' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----fig.width=7, fig.height=4, echo=FALSE------------------------------------
      load('../data/binnedDeltaPlot.rda')
      print(binnedDeltaPlot)

## ----message=FALSE------------------------------------------------------------
library(deltaCaptureC)
significantRegionsPlot = plotSignificantRegions(significantRegions,
                                                significanceType,
                                                plotTitle)

## ----fig.width=7, fig.height=4, echo=FALSE------------------------------------
      load('../data/significantRegionsPlot.rda')
      significantRegionsPlot = significantRegionsPlot +
      ggplot2::theme(axis.text=ggplot2::element_text(size=8))
       print(significantRegionsPlot)

## ----message=FALSE------------------------------------------------------------
library(SummarizedExperiment)
library(deltaCaptureC)
se = miniSE
counts = assays(se)[['counts']]
sizeFactors = DESeq2::estimateSizeFactorsForMatrix(counts)
colData(se)$sizeFactors = sizeFactors
assays(se)[['normalizedCounts']] = counts
for(i in seq_len(ncol(assays(se)[['normalizedCounts']])))
{
	assays(se)[['normalizedCounts']][,i] =
            assays(se)[['normalizedCounts']][,i] /
	    colData(se)$sizeFactors[i]
}

## ----message=FALSE------------------------------------------------------------
library(SummarizedExperiment)
library(deltaCaptureC)
meanNormalizedCountsSE = getMeanNormalizedCountsSE(miniSE)
meanCounts = assay(meanNormalizedCountsSE)
delta = matrix(meanCounts[,1] - meanCounts[,2],ncol=1)
colData = data.frame(delta=sprintf('%s - %s',
                                    as.character(colData(meanNormalizedCountsSE)$treatment[1]),
                                    as.character(colData(meanNormalizedCountsSE)$treatment[2])),
                                    stringsAsFactors=FALSE)
deltaSE = SummarizedExperiment(assay=list(delta=delta),
                                          colData=colData)
rowRanges(deltaSE) = rowRanges(meanNormalizedCountsSE)

## ----message=FALSE------------------------------------------------------------
library(deltaCaptureC)
print(length(smallSetOfSmallBins))
print(length(smallerDeltaSE))
tictoc::tic('binning into small bins')
binnedSummarizedExperiment = binSummarizedExperiment(smallSetOfSmallBins,smallerDeltaSE)
tictoc::toc()

## ----message=FALSE------------------------------------------------------------
library(deltaCaptureC)
tictoc::tic('rebinning to larger bin size')
rebinnedSummarizedExperiment =
      rebinToMultiple(binnedSummarizedExperiment,10)
tictoc::toc()

