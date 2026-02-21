# Code example from 'methVisual' vignette. See references/ for full tutorial.

### R code from vignette source 'methVisual.Rnw'

###################################################
### code chunk number 1: methVisual.Rnw:22-30
###################################################
library(methVisual)
library(Biostrings)
library(gridBase) 
library(ca)
library(sqldf)
library(plotrix)
ps.options(pointsize=12)
options(width=60)


###################################################
### code chunk number 2: methVisual.Rnw:91-92
###################################################
library(methVisual)  


###################################################
### code chunk number 3: methVisual.Rnw:102-103
###################################################
dir.create(file.path(R.home(component="home"),"/BiqAnalyzer/"))


###################################################
### code chunk number 4: methVisual.Rnw:106-107
###################################################
makeLocalExpDir(dataPath="/examples/BiqAnalyzer",localDir=file.path(R.home(component="home"),"/BiqAnalyzer/"))


###################################################
### code chunk number 5: methVisual.Rnw:111-112
###################################################
methData <-MethDataInput(file.path(R.home(component="home"),"/BiqAnalyzer","/PathFileTab.txt"))


###################################################
### code chunk number 6: methVisual.Rnw:116-117
###################################################
methData


###################################################
### code chunk number 7: methVisual.Rnw:121-122
###################################################
refseq <- selectRefSeq(file.path(R.home(component="home"),"/BiqAnalyzer","/Master_Sequence.txt"))


###################################################
### code chunk number 8: methVisual.Rnw:132-133
###################################################
QCdata <- MethylQC(refseq, methData,makeChange=TRUE,identity=80,conversion=90)


###################################################
### code chunk number 9: methVisual.Rnw:138-139
###################################################
QCdata


###################################################
### code chunk number 10: methVisual.Rnw:146-148
###################################################
methData <- MethAlignNW( refseq , QCdata)
methData


###################################################
### code chunk number 11: methVisual.Rnw:158-160 (eval = FALSE)
###################################################
## plotAbsMethyl(methData,real=TRUE)
## 


###################################################
### code chunk number 12: Absolute-Methylation-Plot
###################################################
plotAbsMethyl(methData,real=TRUE)


###################################################
### code chunk number 13: methVisual.Rnw:185-187 (eval = FALSE)
###################################################
## MethLollipops(methData)
## 


###################################################
### code chunk number 14: Lollipops-plot
###################################################
MethLollipops(methData)


###################################################
### code chunk number 15: methVisual.Rnw:211-213 (eval = FALSE)
###################################################
## file <- file.path(R.home(component="home"),"/BiqAnalyzer/","Cooccurrence.pdf")
## Cooccurrence(methData,file=file)


###################################################
### code chunk number 16: methVisual.Rnw:219-223 (eval = FALSE)
###################################################
## 
## summery <- matrixSNP(methData)
## plotMatrixSNP(summery,methData)
## 


###################################################
### code chunk number 17: Distant-cooccurrence
###################################################
summery <- matrixSNP(methData)
plotMatrixSNP(summery,methData)


###################################################
### code chunk number 18: methVisual.Rnw:249-252 (eval = FALSE)
###################################################
## 
## methFisherTest(methData, c(2,3,5), c(1,4,6))
## 


###################################################
### code chunk number 19: Fisher-Test
###################################################
methFisherTest(methData, c(2,3,5), c(1,4,6))


###################################################
### code chunk number 20: methVisual.Rnw:274-275
###################################################
methWhitneyUTest(methData, c(2,3,5), c(1,4,6))


###################################################
### code chunk number 21: methVisual.Rnw:281-284 (eval = FALSE)
###################################################
## 
## heatMapMeth(methData)
## 


###################################################
### code chunk number 22: Heat-Map
###################################################
heatMapMeth(methData)


###################################################
### code chunk number 23: methVisual.Rnw:306-309 (eval = FALSE)
###################################################
## 
## methCA(methData)
## 


###################################################
### code chunk number 24: CA
###################################################
methCA(methData)


