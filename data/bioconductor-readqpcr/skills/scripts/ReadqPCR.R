# Code example from 'ReadqPCR' vignette. See references/ for full tutorial.

### R code from vignette source 'ReadqPCR.Rnw'

###################################################
### code chunk number 1: ReadqPCR
###################################################
library(ReadqPCR)


###################################################
### code chunk number 2: read.LC480
###################################################
path <- system.file("exData", package = "ReadqPCR")
LC480.example <- file.path(path, "LC480_Example.txt")
cycData <- read.LC480(file = LC480.example)
## Fluorescence data
head(exprs(cycData))
## Pheno data
head(pData(cycData))
## Feature data
head(fData(cycData))


###################################################
### code chunk number 3: CyclesSet
###################################################
cycData
## Information about class CyclesSet
getClass("CyclesSet")


###################################################
### code chunk number 4: read.LC480SampleInfo
###################################################
LC480.SamInfo <- file.path(path, "LC480_Example_SampleInfo.txt")
samInfo <- read.LC480SampleInfo(file = LC480.SamInfo)
## Additional sample information
head(pData(samInfo))


###################################################
### code chunk number 5: merge
###################################################
cycData1 <- merge(cycData, samInfo)
## Extended pheno data
phenoData(cycData1)
head(pData(cycData1))
varMetadata(phenoData(cycData1))


###################################################
### code chunk number 6: read.qPCR
###################################################
path <- system.file("exData", package = "ReadqPCR")
qPCR.example <- file.path(path, "qPCR.example.txt")
qPCRBatch.qPCR <- read.qPCR(qPCR.example)


###################################################
### code chunk number 7: read.qPCR.tech.reps
###################################################
qPCR.example.techReps <- file.path(path, "qPCR.techReps.txt")
qPCRBatch.qPCR.techReps <- read.qPCR(qPCR.example.techReps)
rownames(exprs(qPCRBatch.qPCR.techReps))[1:8]


###################################################
### code chunk number 8: read.taqman
###################################################
taqman.example <- file.path(path, "example.txt")
qPCRBatch.taq <- read.taqman(taqman.example)


###################################################
### code chunk number 9: read.taqman.two
###################################################
path <- system.file("exData", package = "ReadqPCR")
taqman.example <- file.path(path, "example.txt")
taqman.example.second.file <- file.path(path, "example2.txt")
qPCRBatch.taq.two.files <- read.taqman(taqman.example, 
                             taqman.example.second.file)


###################################################
### code chunk number 10: read.taqman.tech.reps
###################################################
taqman.example.tech.reps <- file.path(path, "exampleTechReps.txt")
qPCRBatch.taq.tech.reps <- read.taqman(taqman.example.tech.reps)
rownames(exprs(qPCRBatch.taq.tech.reps))[1:8]


###################################################
### code chunk number 11: taqman.qPCRBatch
###################################################
qPCRBatch.taq


###################################################
### code chunk number 12: taqman.pData
###################################################
pData(qPCRBatch.taq)


###################################################
### code chunk number 13: taqman.exprs.well.order
###################################################
head(exprs.well.order(qPCRBatch.taq))


###################################################
### code chunk number 14: taqman.exprs.well.order.plate.names
###################################################
taqman.example.plateNames <- file.path(path, "exampleWithPlateNames.txt")

qPCRBatch.taq.plateNames <- read.taqman(taqman.example.plateNames)
head(exprs.well.order(qPCRBatch.taq.plateNames))


###################################################
### code chunk number 15: taqman.exprs.well.order.plate.and.not
###################################################
taqman.example <- file.path(path, "example.txt")
taqman.example.plateNames <- file.path(path, "exampleWithPlateNames.txt")
qPCRBatch.taq.mixedPlateNames <- read.taqman(taqman.example, 
                                    taqman.example.plateNames)
head(exprs.well.order(qPCRBatch.taq.mixedPlateNames))


###################################################
### code chunk number 16: qPCR.exprs.well.order.withPlateId
###################################################
head(exprs.well.order(qPCRBatch.qPCR))


###################################################
### code chunk number 17: qPCR.exprs.well.order.noPlateId
###################################################
qPCR.example.noPlateOrWell <- file.path(path, "qPCR.noPlateOrWell.txt")
qPCRBatch.qPCR.noPlateOrWell <- read.qPCR(qPCR.example.noPlateOrWell)
exprs.well.order(qPCRBatch.qPCR.noPlateOrWell)


