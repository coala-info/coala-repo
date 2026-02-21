# Code example from 'FISHalyseR' vignette. See references/ for full tutorial.

## ----SetParameters,include=FALSE,eval=TRUE------------------------------------
library(knitr)
opts_chunk$set(
concordance=TRUE
)
TempDir<-dirname(system.file( "extdata", "SampleFISHgray.jpg", package="FISHalyseR"))

## ----LoadPackage--------------------------------------------------------------
library(FISHalyseR)

## ----ComputeProbeMask,results='hide'------------------------------------------
f = system.file( "extdata", "SampleFISHgray.jpg", package="FISHalyseR")
img = readImage(f)

t = calculateMaxEntropy(img)
img[img<t] <- 0
img[img>=t] <- 1


## ----echo=FALSE, results='hide'-----------------------------------------------
TargetFileName<-paste(TempDir,'exImgMaxEntropyProbes1.jpg',sep='/')
writeImage(img, TargetFileName)

## ----ComputeCellMask,results='hide'-------------------------------------------
f = system.file( "extdata", "SampleFISHgray.jpg", package="FISHalyseR")
img = readImage(f)

t = calculateThreshold(img)
img[img<t] <- 0
img[img>=t] <- 1


## ----echo=FALSE, results='hide'-----------------------------------------------
TargetFileName<-paste(TempDir,'exImgOtsuCellMask.jpg',sep='/')
writeImage(img, TargetFileName)

## ----RemoveSmallParticlesProbeMask,results='hide'-----------------------------
fProbes1 = paste(TempDir,'/',"exImgMaxEntropyProbes1.jpg",sep='')
img = readImage(fProbes1)

anaImg <- analyseParticles(img, 20, 5,0)

## ----echo=FALSE, results='hide'-----------------------------------------------
TargetFileName<-paste(TempDir,'exImgProbes1Clean.jpg',sep='/')
writeImage(anaImg, TargetFileName)

## ----RemoveSmallParticlesCellMask,results='hide'------------------------------
f = paste(TempDir,'/',"exImgOtsuCellMask.jpg", sep='')
img = readImage(f)

anaImg <- analyseParticles(img, 20000, 1000,0)

## ----echo=FALSE, results='hide'-----------------------------------------------
TargetFileName2<-paste(TempDir,'exImgCellMaskClean.jpg',sep='/')
writeImage(anaImg, TargetFileName2)

## ----ExampleGaussianBlurring,results='hide'-----------------------------------
bgCorrMethod = list(1,100)

## ----ExampleSepcifiedIlluminationImage,results='hide'-------------------------
# path to illumination image
illumPath = "../IllCorr.jpg"
bgCorrMethod = list(2,illumPath)

## ----ExampleMultidimensionalIlluminationCorrection,results='hide'-------------
bgCorrMethod = list(3,"/path/to/stack","*.jpg",6)

## ----SelectProbeChannels,results='hide'---------------------------------------
red_Og   <- system.file( "extdata", "SampleFISH_R.jpg", package="FISHalyseR")
green_Gn <- system.file( "extdata", "SampleFISH_G.jpg", package="FISHalyseR")
#Create colour vector list
channelColours = list(R=c(255,0,0),G=c(0,255,0))
channelSignals = list(red_Og,green_Gn)

## ----UseRGBImageAsProbeSource-------------------------------------------------
combinedImage <- system.file( "extdata", "SampleFISH.jpg", package="FISHalyseR")
channelSignals = list(combinedImage)

## ----RunProcessFISH,results='hide'--------------------------------------------
illuCorrection = system.file( "extdata", "SampleFISHillu.jpg", package="FISHalyseR")

combinedImage <- system.file( "extdata", "SampleFISH.jpg", package="FISHalyseR")
red_Og   <- system.file( "extdata", "SampleFISH_R.jpg", package="FISHalyseR")
green_Gn <- system.file( "extdata", "SampleFISH_G.jpg", package="FISHalyseR")

# directory where all the files will be saved
writedir = paste(TempDir,sep='')

bgCorrMethod = list(0,'')

channelColours = list(R=c(255,0,0),G=c(0,255,0))
channelSignals = list(red_Og,green_Gn)
sizecell = c(1000,20000)
sizeprobe= c(5,20)


processFISH(combinedImage,writedir,bgCorrMethod,channelSignals,
            channelColours,sizecell,sizeprobe)

## ----results='hide',echo=FALSE------------------------------------------------
OverlayFile<-paste(TempDir,'SampleFISH.jpg/SampleFISH',sep='')
TargetFileName<-paste(TempDir,'SampleFISH.jpg',sep='/')


