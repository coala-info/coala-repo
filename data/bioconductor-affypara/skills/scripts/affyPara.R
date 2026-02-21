# Code example from 'affyPara' vignette. See references/ for full tutorial.

### R code from vignette source 'affyPara.Rnw'

###################################################
### code chunk number 1: affyPara.Rnw:59-60
###################################################
library(affyPara)


###################################################
### code chunk number 2: affyPara.Rnw:117-118
###################################################
library(affyPara)


###################################################
### code chunk number 3: affyPara.Rnw:122-125
###################################################
library(affydata)
data(Dilution)
Dilution


###################################################
### code chunk number 4: affyPara.Rnw:139-140
###################################################
cl <- makeCluster(4, type='SOCK')


###################################################
### code chunk number 5: stopCluster
###################################################
stopCluster(cl)


###################################################
### code chunk number 6: makeCluster
###################################################
cl <- makeCluster(2, type='SOCK')


###################################################
### code chunk number 7: ReadAffy (eval = FALSE)
###################################################
## AffyBatch <- ReadAffy()


###################################################
### code chunk number 8: BGmethods
###################################################
bgcorrect.methods()


###################################################
### code chunk number 9: affyBatchBGC (eval = FALSE)
###################################################
## affyBatchBGC <- bgCorrectPara(Dilution,
## 				method="rma", verbose=TRUE)


###################################################
### code chunk number 10: affyBatchBGCfiles (eval = FALSE)
###################################################
## files <- list.celfiles(full.names=TRUE)
## affyBatchGBC <- bgCorrectPara(files, 
## 				method="rma", cluster=cl)


###################################################
### code chunk number 11: affyBatchNORM (eval = FALSE)
###################################################
## affyBatchNORM <- normalizeAffyBatchQuantilesPara(
## 		Dilution, type = "pmonly", verbose=TRUE)


###################################################
### code chunk number 12: affyBatchGBCfiles (eval = FALSE)
###################################################
## files <- list.celfiles(full.names=TRUE)
## affyBatchNORM <- normalizeAffyBatchQuantilesPara(
## 		files, type = "pmonly")


###################################################
### code chunk number 13: affyPara.Rnw:290-292
###################################################
express.summary.stat.methods()
pmcorrect.methods()


###################################################
### code chunk number 14: computeExprSetPara (eval = FALSE)
###################################################
## esset <- computeExprSetPara(
## 	Dilution,
## 	pmcorrect.method = "pmonly",
## 	summary.method = "avgdiff")


###################################################
### code chunk number 15: computeExprSetParafiles (eval = FALSE)
###################################################
## files <- list.celfiles(full.names=TRUE)
## esset <- normalizeAffyBatchQuantilesPara(
## 	files, 
## 	pmcorrect.method = "pmonly",
## 	summary.method = "avgdiff")


###################################################
### code chunk number 16: preproPara (eval = FALSE)
###################################################
## esset <- preproPara(
## 	Dilution, 
## 	bgcorrect = TRUE, bgcorrect.method = "rma",
## 	normalize = TRUE, normalize.method = "quantil",
## 	pmcorrect.method = "pmonly",
## 	summary.method = "avgdiff")


###################################################
### code chunk number 17: preproParafiles (eval = FALSE)
###################################################
## files <- list.celfiles(full.names=TRUE)
## esset <- preproPara(
## 	files, 
## 	bgcorrect = TRUE, bgcorrect.method = "rma",
## 	normalize = TRUE, normalize.method = "quantil",
## 	pmcorrect.method = "pmonly",
## 	summary.method = "avgdiff")


###################################################
### code chunk number 18: rmaPara (eval = FALSE)
###################################################
## esset <- rmaPara(Dilution)


###################################################
### code chunk number 19: rmaParaFiles (eval = FALSE)
###################################################
## files <- list.celfiles(full.names=TRUE)
## esset <- rmaPara(files)


###################################################
### code chunk number 20: qc (eval = FALSE)
###################################################
## boxplotPara(Dilution)
## MAplotPara(Dilution)


###################################################
### code chunk number 21: distributeFiles (eval = FALSE)
###################################################
## path <- "tmp/CELfiles" # path at local computer system (master)
## files <- list.files(path,full.names=TRUE)
## distList <- distributeFiles(CELfiles, protocol="RCP")
## eset <- rmaPara(distList$CELfiles)


###################################################
### code chunk number 22: removeDistributedFiles (eval = FALSE)
###################################################
## removeDistributedFiles("/usr1/tmp/CELfiles")


###################################################
### code chunk number 23: identical_bgc (eval = FALSE)
###################################################
## affybatch1 <- bg.correct(Dilution,
## 		method="rma") 
##  affybatch2 <- bgCorrectPara(Dilution,
## 		method="rma")
## identical(exprs(affybatch1),exprs(affybatch2))
## all.equal(exprs(affybatch1),exprs(affybatch2))


###################################################
### code chunk number 24: identical_loess (eval = FALSE)
###################################################
## set.seed(1234)
## affybatch1 <- normalize.AffyBatch.loess(Dilution)
## set.seed(1234)
## affybatch2 <- normalizeAffyBatchLoessPara(Dilution, verbose=TRUE) 
## identical(exprs(affybatch1),exprs(affybatch2))


###################################################
### code chunk number 25: affyPara.Rnw:505-506
###################################################
stopCluster()


