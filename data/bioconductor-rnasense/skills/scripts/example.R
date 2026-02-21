# Code example from 'example' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----installation, eval=FALSE-------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("RNAsense")

## ----load data, message=TRUE--------------------------------------------------
library(RNAsense)
data("MZsox") # load MZsox.RData in variable mydata
print(MZsox)
mydata <- MZsox

## ----initialization, message=FALSE, eval=TRUE---------------------------------
analyzeConditions <- c("WT", "MZsox")
thCount <- 100
nrcores <- 1
library(SummarizedExperiment)
#if(Sys.info()[[1]]=="Windows"){nrcores <- 1} # use parallelization only on Linux and Mac
mydata <- mydata[seq(1,nrow(mydata), by=4),]
vec2Keep <- which(vapply(1:dim(mydata)[1],function(i)
  !Reduce("&",assays(mydata)[[1]][i,]<thCount), c(TRUE)))
mydata <- mydata[vec2Keep,] # threshold is applied
times <- unique(sort(as.numeric(colData(mydata)$time))) # get measurement times from input data

## ----fc_analysis, message=TRUE, eval=TRUE-------------------------------------
resultFC <- getFC(dataset = mydata, 
                  myanalyzeConditions = analyzeConditions, 
                  cores = nrcores, 
                  mytimes = times)
head(resultFC)

## ----vulcano, message=FALSE, eval=TRUE, fig.height = 4.5, fig.width = 7-------
library(ggplot2)
ggplot(subset(resultFC, FCdetect!="none"), 
       aes(x=logFoldChange, y=-log10(pValue), color=FCdetect)) + 
       xlab("log2(Fold Change)") + geom_point(shape=20)

## ----switch_analysis, message=FALSE, eval=TRUE--------------------------------
resultSwitch <- getSwitch(dataset = mydata,
                          experimentStepDetection = "WT",
                          cores = nrcores,
                          mytimes = times)
head(resultSwitch)

## ----combination, message=FALSE, eval=TRUE------------------------------------
resultCombined <- combineResults(resultSwitch, resultFC)
head(resultCombined)

## ----plot, message = FALSE, eval = TRUE, fig.height = 5, fig.width = 7--------
plotSSGS(resultCombined, times[-length(times)])

## ----output, message=FALSE, eval=TRUE-----------------------------------------
outputGeneTables(resultCombined)

## ----session------------------------------------------------------------------
sessionInfo()

