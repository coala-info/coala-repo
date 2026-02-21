# Code example from 'flowFitExampleData' vignette. See references/ for full tutorial.

### R code from vignette source 'flowFitExampleData.Rnw'

###################################################
### code chunk number 1: flowFitExampleData.Rnw:31-32
###################################################
options(width=70)


###################################################
### code chunk number 2: Loading
###################################################
library(flowFitExampleData)
data(PKH26data)
PKH26data

data(QuahAndParish)
QuahAndParish



###################################################
### code chunk number 3: flowFitExampleData.Rnw:68-85 (eval = FALSE)
###################################################
## 
## require(flowCore)
## 
## flowData <- read.flowSet(path = ".", phenoData = "annotationfig2.txt", transformation=FALSE)
## 
## wf <- workFlow(flowData, name = "FACSCANTO LOG workflow")
## 
## trunTrans <- truncateTransform(transformationId="truncate", a=1)
## tr <- transformList(c("<FITC-A>","<PE-A>", "<PE-Cy5-A>", "<Alexa Fluor 405-A>", "<Alexa Fluor 430-A>", "<APC-A>", "<APC-Cy7-A>"), trunTrans, transformationId = "truncate")
## add(wf,tr)
## 
## logTrans <- logTransform(transformationId="log10-transformation", logbase=10, r=1, d=1)
## tf <- transformList(c("<FITC-A>","<PE-A>", "<PE-Cy5-A>", "<Alexa Fluor 405-A>", "<Alexa Fluor 430-A>", "<APC-A>", "<APC-Cy7-A>"), logTrans, transformationId = "log")
## add(wf, tf, parent="truncate")
## 
## mDataLog <- Data(wf[["log"]])
## 


