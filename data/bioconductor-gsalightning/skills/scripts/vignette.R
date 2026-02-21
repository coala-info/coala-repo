# Code example from 'vignette' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(cache=TRUE)

## ----eval = FALSE-------------------------------------------------------------
# library(devtools)
# install_github("billyhw/GSALightning")

## -----------------------------------------------------------------------------
library(GSALightning)

## -----------------------------------------------------------------------------
data(expression)
data(sampleInfo)

## -----------------------------------------------------------------------------
data(targetGenes)

## -----------------------------------------------------------------------------
expression <- expression[apply(expression,1,sd) != 0,]

## -----------------------------------------------------------------------------
GSALightResults <- GSALight(eset = expression, fac = factor(sampleInfo$TN), gs = targetGenes, 
		   		   	       nperm = 1000, minsize = 10, rmGSGenes = 'gene')
head(GSALightResults)

## ----eval=FALSE---------------------------------------------------------------
# ? GSALight

## -----------------------------------------------------------------------------
data(expression)
expression[1:4,1:3]

## -----------------------------------------------------------------------------
data(sampleInfo)
head(sampleInfo$TN)

## -----------------------------------------------------------------------------
data(targetGenes)
targetGenes[1:3]

## ----error=TRUE---------------------------------------------------------------
try({
data(expression)
data(sampleInfo)
data(targetGenes)
GSALightResults <- GSALight(eset = expression, fac = factor(sampleInfo$TN), gs = targetGenes)
})

## ----error=TRUE---------------------------------------------------------------
try({
expression <- expression[apply(expression,1,sd) != 0,]
GSALightResults <- GSALight(eset = expression, fac = factor(sampleInfo$TN), gs = targetGenes)
})

## -----------------------------------------------------------------------------
GSALightResults <- GSALight(eset = expression, fac = factor(sampleInfo$TN), gs = targetGenes, 
		   		   	       nperm = 1000, rmGSGenes = 'gene')
head(GSALightResults)

## -----------------------------------------------------------------------------
GSALightResults <- GSALight(eset = expression, fac = factor(sampleInfo$TN), gs = targetGenes, 
		   		   	       nperm = 1000, method = 'maxmean', restandardize = FALSE, minsize = 10, 
					       maxsize = 30, rmGSGenes = 'gene', verbose = FALSE)

## -----------------------------------------------------------------------------
GSALightResultsMean <- GSALight(eset = expression, fac = factor(sampleInfo$TN), gs = targetGenes, 
		   		   	       nperm = 1000, method = 'mean', restandardize = FALSE, minsize = 10, 
					       maxsize = 30, rmGSGenes = 'gene', verbose = FALSE)

## -----------------------------------------------------------------------------
GSALightResultsAbs <- GSALight(eset = expression, fac = factor(sampleInfo$TN), gs = targetGenes, 
		   		   	       nperm = 1000, method = 'absmean', restandardize = FALSE, minsize = 10, 
					       maxsize = 30, rmGSGenes = 'gene', verbose = FALSE)

## -----------------------------------------------------------------------------
head(GSALightResults)
head(GSALightResultsMean)

## -----------------------------------------------------------------------------
head(GSALightResultsAbs)

## -----------------------------------------------------------------------------
GSALightResults <- GSALight(eset = expression, fac = factor(sampleInfo$TN), gs = targetGenes, 
		   		   	       nperm = NULL, method = 'maxmean', restandardize = FALSE, minsize = 10, 
					       rmGSGenes = 'gene', verbose = FALSE)

## -----------------------------------------------------------------------------
hist(GSALightResults[,'p-value:up-regulated in Control'], main=NULL, xlab='p-value')

## -----------------------------------------------------------------------------
GSALightResultsReStand <- GSALight(eset = expression, fac = factor(sampleInfo$TN), gs = targetGenes, 
		   		   	       nperm = NULL, method = 'maxmean', restandardize = TRUE, minsize = 10, 
					       rmGSGenes = 'gene', verbose = FALSE)
hist(GSALightResultsReStand[,'p-value:up-regulated in Control'], main=NULL, xlab='p-value')

## -----------------------------------------------------------------------------
GSALightResultsReStand[order(GSALightResultsReStand[,'p-value:up-regulated in Control'],decreasing=F)[1:10], c(2,4)]

## -----------------------------------------------------------------------------
singleGeneAnalysis <- permTestLight(eset = expression, fac = factor(sampleInfo$TN),
		   		  	   	             nperm = 1000,  method = 'mean', verbose = TRUE)
head(singleGeneAnalysis)

## -----------------------------------------------------------------------------
singleWilcox <- wilcoxTest(eset = expression, fac = factor(sampleInfo$TN),
		   		  	   	             tests = "unpaired")
head(singleWilcox)

## -----------------------------------------------------------------------------
fac <- 1:(ncol(expression)/2)
fac <- c(fac, -fac)
head(fac)
tail(fac)

## -----------------------------------------------------------------------------
GSALightResultsPaired <- GSALight(eset = expression, fac = fac, gs = targetGenes, 
		   		   	       nperm = 1000, tests = 'paired', method = 'maxmean', restandardize = TRUE, minsize = 10, 
					       rmGSGenes = 'gene', verbose = FALSE)
head(GSALightResultsPaired)

