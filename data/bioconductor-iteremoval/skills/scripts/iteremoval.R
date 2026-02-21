# Code example from 'iteremoval' vignette. See references/ for full tutorial.

## ----eval=FALSE----------------------------------------------------------
#  # try http:// if https:// URLs are not supported
#  if (!requireNamespace("BiocManager", quietly=TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("iteremoval")

## ------------------------------------------------------------------------
library(iteremoval)
# input two datasets
removal.stat <- feature_removal(SWRG1, SWRG0, cutoff1=0.95, cutoff0=0.95, 
								 offset=c(0.25, 0.5, 2, 4))

## ----eval=TRUE-----------------------------------------------------------
# input SummarizedExperiment object
removal.stat <- feature_removal(SummarizedData, SummarizedData$Group==0, 
								 cutoff1=0.95, cutoff0=0.95, 
								 offset=c(0.25, 0.5, 2, 4))

## ----echo=TRUE-----------------------------------------------------------
ggiteration_trace(removal.stat) + theme_bw()

## ----echo=TRUE-----------------------------------------------------------
features <- feature_prevalence(removal.stat, index=255, hist.plot=TRUE)
features

## ----echo=TRUE-----------------------------------------------------------
feature_screen(features, prevalence=4)

