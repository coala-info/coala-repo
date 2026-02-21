# Code example from 'gcapc' vignette. See references/ for full tutorial.

## ----para, echo = FALSE, results='hide'---------------------------------------
BiocStyle::markdown()
knitr::opts_chunk$set(dev="png",fig.show="hold",
               fig.width=8,fig.height=4.5,fig.align="center",
               message=FALSE,collapse=TRUE)
set.seed(1)

## ----library------------------------------------------------------------------
library(gcapc)

## ----data---------------------------------------------------------------------
bam <- system.file("extdata", "chipseq.bam", package="gcapc")

## ----rc5end-------------------------------------------------------------------
cov <- read5endCoverage(bam)
cov

## ----bdwidth1-----------------------------------------------------------------
bdw <- bindWidth(cov, range=c(50L,300L), step=10L)
bdw

## ----gcbias-------------------------------------------------------------------
layout(matrix(1:2,1,2))
gcb <- gcEffects(cov, bdw, sampling=c(0.25,1), plot=TRUE, model='poisson')

## ----gcapc, results='hide'----------------------------------------------------
layout(matrix(1:2,1,2))
peaks <- gcapcPeaks(cov, gcb, bdw, plot=TRUE, permute=100L)
peaks <- gcapcPeaks(cov, gcb, bdw, plot=TRUE, permute=50L)

## ----gcapcpeaks---------------------------------------------------------------
peaks

## ----refine, results='hide', fig.width=4.5------------------------------------
newpeaks <- refinePeaks(cov, gcb, bdw, peaks=peaks, permute=50L)
plot(newpeaks$es,newpeaks$newes,xlab='old score',ylab='new score')

## ----refinepeaks--------------------------------------------------------------
newpeaks

