# Code example from 'rnaseqcomp' vignette. See references/ for full tutorial.

## ----para, echo = FALSE, results='hide'---------------------------------------
BiocStyle::markdown()
knitr::opts_chunk$set(dev="png",fig.show="hold",
               fig.width=4,fig.height=4.5,fig.align="center",
               message=FALSE,collapse=TRUE)

## ----library------------------------------------------------------------------
library(rnaseqcomp)

## ----data---------------------------------------------------------------------
# load the dataset in this package
data(simdata)
class(simdata)
names(simdata)

## ----meta---------------------------------------------------------------------
condInfo <- factor(simdata$samp$condition)
repInfo <- factor(simdata$samp$replicate)
evaluationFeature <- rep(TRUE, nrow(simdata$meta))
calibrationFeature <- simdata$meta$house & simdata$meta$chr == 'chr1'
unitReference <- 1

## ----filter-------------------------------------------------------------------
dat <- signalCalibrate(simdata$quant, condInfo, repInfo, evaluationFeature,
     calibrationFeature, unitReference, 
     calibrationFeature2 = calibrationFeature)
class(dat)
show(dat)

## ----sd-----------------------------------------------------------------------
plotSD(dat,ylim=c(0,1.4))

## ----nonexpplot---------------------------------------------------------------
plotNE(dat,xlim=c(0.5,1))

## ----tx2----------------------------------------------------------------------
plot2TX(dat,genes=simdata$meta$gene,ylim=c(0,0.6))

## ----diffroc------------------------------------------------------------------
plotROC(dat,simdata$meta$positive,simdata$meta$fcsign,ylim=c(0,0.8))

## ----difffc-------------------------------------------------------------------
simdata$meta$fcsign[simdata$meta$fcstatus == "off.on"] <- NA
plotFC(dat,simdata$meta$positive,simdata$meta$fcsign,ylim=c(0,1.2))

