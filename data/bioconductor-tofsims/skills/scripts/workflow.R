# Code example from 'workflow' vignette. See references/ for full tutorial.

## ----global_options, include=FALSE---------------------------------------
knitr::opts_chunk$set(fig.width=3.5, fig.height=3.5, fig.path='Figs/',
                      echo=TRUE, warning=FALSE, message=FALSE)

## ---- message=FALSE------------------------------------------------------
library(tofsims)
library(tofsimsData)

### get path to raw data file
rawData<-system.file('rawdata', 'trift_test_001.RAW', package="tofsimsData")
### the following param will cause to run non parallel
library(BiocParallel)
register(SnowParam(workers=0), default=TRUE)
spectraImport<-MassSpectra(select = 'ulvacraw', analysisName = rawData)

## ------------------------------------------------------------------------
show(spectraImport)
plot(spectraImport, mzRange=c(1,150), type='l')

## ---- message=FALSE------------------------------------------------------
spectraImport <- calibPointNew(object = spectraImport, mz = 15, value = 15.0113)
spectraImport <- calibPointNew(object = spectraImport, mz = 181, value = 181.0444)
spectraImport <- recalibrate(spectraImport)

## ---- tidy=FALSE, message=FALSE------------------------------------------

spectraImport <- unitMassPeaks(object = spectraImport, 
              mzRange = c(1,250), 
              widthAt = c(15,181), 
              factor = c(0.4, 0.6),
              lower = c(14.96283,15.05096), 
              upper = c(180.80902,181.43538))

plot(spectraImport, mzRange=c(35,45), type='l')

## ------------------------------------------------------------------------
library(RColorBrewer)
imageImport<-MassImage(select = 'ulvacrawpeaks', 
                       analysisName = rawData, 
                       PeakListobj = spectraImport)
imageImport <- poissonScaling(imageImport)
image(imageImport, col=brewer.pal(9, 'PuRd'))

## ---- fig.width=7, fig.height=2, results="hide"--------------------------
imageImport <- PCAnalysis(imageImport, nComp = 4)
imageImport <- MAF(imageImport, nComp = 4)
par(mar=c(0,0,0,0), oma=c(0,0,0,0), mfrow=c(2,4))
for(iii in 1:4) image(analysis(imageImport, 1), comp=iii)
for(iii in 1:4) image(analysis(imageImport, 2), comp=iii)

## ---- fig.width=3.5, fig.height=3.5--------------------------------------
library(EBImage)
pcaScore3<-imageMatrix(analysis(imageImport, 1), comp=3)
pcaScore3Mask<-thresh(x = pcaScore3, h = 30, w = 30)
par(mar=c(0,0,0,0), oma=c(0,0,0,0))
image(pcaScore3Mask, col=c('white', 'black'))

## ------------------------------------------------------------------------
paste(round(100/(xy(imageImport)[1]*xy(imageImport)[2])*sum(pcaScore3Mask),2), 
      ' % of the image is Cell Wall')

## ---- fig.width=7, fig.height=3.5----------------------------------------
opened<-opening(pcaScore3Mask, kern = makeBrush(3, shape = 'diamond'))
closed<-closing(pcaScore3Mask, kern = makeBrush(3, shape = 'diamond'))
par(mar=c(0,0,0,0), oma=c(0,0,0,0), mfcol=c(1,2))
image(opened, col = c('white', 'black'))
image(closed, col = c('white','black'))

## ---- fig.width=7, fig.height=3.5----------------------------------------
cellWall<-bwApply(imageImport,(opened-1)^2)
par(mar=c(0,0,0,0), oma=c(0,0,0,0), mfcol=c(1,2))
image(cellWall,col=brewer.pal(9, 'PuRd'))
image(imageImport,col=brewer.pal(9, 'PuRd'))

