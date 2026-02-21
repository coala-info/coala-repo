# Code example from 'runLC' vignette. See references/ for full tutorial.

### R code from vignette source 'runLC.Rnw'

###################################################
### code chunk number 1: runLC.Rnw:50-53
###################################################
library(metaMS)
data(FEMsettings)
Synapt.RP


###################################################
### code chunk number 2: runLC.Rnw:78-82
###################################################
library(metaMSdata)
cdfpath <- system.file("extdata", package = "metaMSdata")
files <- list.files(cdfpath, "_RP_", full.names=TRUE)
files


###################################################
### code chunk number 3: runLC.Rnw:89-91
###################################################
library(metaMS)
data(exptable)


###################################################
### code chunk number 4: runLC.Rnw:94-95
###################################################
head(exptable)


###################################################
### code chunk number 5: runLC.Rnw:127-129
###################################################
exptable$stdFile <- sapply(exptable$stdFile, grep, files, value = TRUE)
exptable$stdFile


###################################################
### code chunk number 6: runLC.Rnw:141-142
###################################################
metaSetting(Synapt.RP, "PeakPicking")


###################################################
### code chunk number 7: runLC.Rnw:157-158
###################################################
metaSetting(Synapt.RP, "DBconstruction")


###################################################
### code chunk number 8: runLC.Rnw:178-179
###################################################
exptable$compound


###################################################
### code chunk number 9: runLC.Rnw:183-189
###################################################
library(metaMSdata)
cdfpath <- system.file("extdata", package = "metaMSdata")
files <- list.files(cdfpath, "_RP_", full.names=TRUE)
exptable$stdFile <- sapply(exptable$stdFile,
                           function(x)
                           files[grep(x,files)])


###################################################
### code chunk number 10: runLC.Rnw:193-194
###################################################
metaSetting(Synapt.RP, "DBconstruction.minfeat")  <- 2


###################################################
### code chunk number 11: runLC.Rnw:198-202 (eval = FALSE)
###################################################
## LCDBtest <- createSTDdbLC(stdInfo=exptable, 
##                           settings = Synapt.RP,
##                           polarity = "positive",
##                           Ithr = 20)


###################################################
### code chunk number 12: runLC.Rnw:210-211
###################################################
data(LCDBtest)


###################################################
### code chunk number 13: runLC.Rnw:214-215
###################################################
names(LCDBtest)


###################################################
### code chunk number 14: runLC.Rnw:218-219
###################################################
head(LCDBtest$Reftable)


###################################################
### code chunk number 15: runLC.Rnw:222-223
###################################################
names(LCDBtest$Info)


###################################################
### code chunk number 16: runLC.Rnw:226-227
###################################################
head(LCDBtest$DB)


###################################################
### code chunk number 17: runLC.Rnw:241-242
###################################################
table(LCDBtest$DB$compound)


###################################################
### code chunk number 18: runLC.Rnw:310-311 (eval = FALSE)
###################################################
## LC <- runLC(files, settings = Synapt.RP, DB = LCDBtest$DB)


###################################################
### code chunk number 19: runLC.Rnw:318-319
###################################################
data(LCresults)


###################################################
### code chunk number 20: runLC.Rnw:324-325
###################################################
head(LCresults$Annotation$annotation.table)


###################################################
### code chunk number 21: runLC.Rnw:346-348
###################################################
LCresults$Annotation$compounds
LCresults$Annotation$ChemSpiderIDs


###################################################
### code chunk number 22: runLC.Rnw:352-353
###################################################
LCresults$Annotation$multiple.annotations


###################################################
### code chunk number 23: runLC.Rnw:357-358
###################################################
LCresults$Annotation$ann.features


###################################################
### code chunk number 24: runLC.Rnw:365-366
###################################################
head(LCresults$PeakTable)


