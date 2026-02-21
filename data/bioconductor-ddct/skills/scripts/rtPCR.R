# Code example from 'rtPCR' vignette. See references/ for full tutorial.

### R code from vignette source 'rtPCR.Rnw'

###################################################
### code chunk number 1: specifyFiles
###################################################
library(Biobase)
library(lattice)
library(RColorBrewer)
library(ddCt)
datadir <- function(x) system.file("extdata", x, package="ddCt")
savedir <- function(x) file.path(tempdir(), x)

file.names <- c(datadir("Experiment1.txt"),datadir("Experiment2.txt"))
info <- datadir("sampleData.txt")
warningFile <- savedir("warnings.txt")


###################################################
### code chunk number 2: readingData
###################################################
name.reference.sample <- c("Sample1", "Sample2")
name.reference.gene <- c("Gene2")


###################################################
### code chunk number 3: readData
###################################################
library(Biobase)  
CtData <- SDMFrame(file.names)
sampleInformation <- read.AnnotatedDataFrame(info,header=TRUE, row.names=NULL)


###################################################
### code chunk number 4: calculating
###################################################
result <- ddCtExpression(CtData,
                         calibrationSample=name.reference.sample,
                         housekeepingGene=name.reference.gene,
                         sampleInformation=sampleInformation,
                         warningStream=warningFile)


###################################################
### code chunk number 5: showMAD
###################################################
CtErr(result)


###################################################
### code chunk number 6: vis
###################################################
br <- errBarchart(result)
print(br)


###################################################
### code chunk number 7: write Tables
###################################################
elistWrite(result,file=savedir("allValues.txt"))


###################################################
### code chunk number 8: sessionInfo
###################################################
toLatex(sessionInfo(), locale=FALSE)


