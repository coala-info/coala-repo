# Code example from 'frmaTools' vignette. See references/ for full tutorial.

### R code from vignette source 'frmaTools.Rnw'

###################################################
### code chunk number 1: frmaTools.Rnw:67-68 (eval = FALSE)
###################################################
## library(frmaTools)


###################################################
### code chunk number 2: frmaTools.Rnw:71-72 (eval = FALSE)
###################################################
## files <- dir()


###################################################
### code chunk number 3: frmaTools.Rnw:76-77 (eval = FALSE)
###################################################
## vectors <- makeVectorsAffyBatch(files, batch.id)


###################################################
### code chunk number 4: frmaTools.Rnw:103-104
###################################################
library(frmaTools)


###################################################
### code chunk number 5: frmaTools.Rnw:107-109
###################################################
library(frmaExampleData)
data(list="AffyBatch133atag")


###################################################
### code chunk number 6: frmaTools.Rnw:112-113
###################################################
object <- convertPlatform(AffyBatch133atag, "hgu133a")


