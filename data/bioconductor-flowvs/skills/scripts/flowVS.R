# Code example from 'flowVS' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, results='hide'----------------------------------------
library("knitr")
#opts_chunk$set(fig.align="center", fig.width=7, fig.height=7)
#options(width=90)

## ----lib, message=FALSE, results='hide', warning=FALSE------------------------
library(flowVS) #load library

## ----HD, echo=TRUE, warning=FALSE, fig.keep='high', fig.show='hold', out.width='.49\\linewidth', fig.cap='Transforming two fluorescence channels in the HD data. Bartlett\'s statistics (Y-axis) is computed from density peaks after data is transformed by different cofactors (X-axis). An optimum cofactor is obtained where Bartlett\'s statistics is minimum (indicated by red circles).'----
## Example 1: Healthy data from flowVS package
data(HD)
## identify optimum cofactor for CD3 and CD4 channels 
cofactors = estParamFlowVS(HD[1:5],channels=c('CD3', 'CD4'))

## ----densityHD, echo=TRUE, warning=FALSE, fig.cap='The density plots after the data is transformed by asins transformation with the optimum cofactors.'----
## transform CD3 and CD4 channels in all samples
HD.VS = transFlowVS(HD, channels=c('CD3', 'CD4'), cofactors)
## density plot (from flowViz package)
densityplot(~CD3+CD4, HD.VS, main="Transfromed CD3 and CD4 channels in HD data")

## ----ITN, echo=TRUE, warning=FALSE, fig.keep='high', fig.show='hold', out.width='.49\\linewidth', fig.cap='Transforming two fluorescence channels in the ITN data. Bartlett\'s statistics (Y-axis) is computed from density peaks after data is transformed by different cofactors (X-axis). An optimum cofactor is obtained where Bartlett\'s statistics is minimum (indicated by red circles).'----
## Example 2: ITN data from flowStats package
suppressMessages(library(flowStats))
data(ITN)
# identify lymphocytes
ITN.lymphs = fsApply(ITN,lymphs, list("FS"=c(200, 600),"SS"=c(0, 400)), "FSC", "SSC",FALSE)
## identify optimum cofactor for CD3 and CD4 channels
cofactors = estParamFlowVS(ITN.lymphs[1:5],channels=c('CD3', 'CD4'))

## ----densityITN, echo=TRUE, warning=FALSE, fig.cap='The density plots after the data is transformed by asins transformation with the optimum cofactors.'----
## transform CD4 channel in all samples
ITN.VS = transFlowVS(ITN.lymphs, channels=c('CD3', 'CD4'), cofactors)
## density plot (from flowViz package)
densityplot(~CD3+CD4, ITN.VS, main="Transfromed CD3 and CD4 channels in ITN data")

## ----microVS, echo=TRUE, warning=FALSE, fig.width=5, fig.height=5-------------
suppressMessages(library(vsn))
data(kidney)
kidney.microVS = microVS(exprs(kidney)) #variance stabilization

## ----vsn, echo=TRUE, warning=FALSE, fig.width=4.5, fig.height=4, fig.show='hold', fig.align='center', fig.cap='Variance stabilization of the Kidney microarray data by flowVs and vsn packages.'----
suppressMessages(library(vsn))
data(kidney)
kidney.vsn = vsn2(exprs(kidney)) #variance stabilization by vsn
plotMeanSd(kidney.microVS, main="Kidney data: VS by flowVS")
plotMeanSd(exprs(kidney.vsn), main="Kidney data: VS by vsn")

## ----sessionInfo, results = 'asis', eval = TRUE, echo = TRUE------------------
toLatex(sessionInfo())

