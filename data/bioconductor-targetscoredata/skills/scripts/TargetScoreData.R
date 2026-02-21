# Code example from 'TargetScoreData' vignette. See references/ for full tutorial.

### R code from vignette source 'TargetScoreData.Rnw'

###################################################
### code chunk number 1: miRNA_transfection_data
###################################################
library(TargetScoreData)

transfection_data <- get_miRNA_transfection_data()$transfection_data

datasummary <- 
list(  `MicroRNA` = table(names(transfection_data)),
		`GEO Series` = table(sapply(transfection_data, function(df) df$Series[1])),
		`Platform` = table(sapply(transfection_data, function(df) df$platform[1])),
		`Cell/Tissue` = table(sapply(transfection_data, function(df) df$cell[1])))		

print(lapply(datasummary, length))


###################################################
### code chunk number 2: targetScan
###################################################

targetScanCS <- get_TargetScanHuman_contextScore()

targetScanPCT <- get_TargetScanHuman_PCT()

head(targetScanCS)

dim(targetScanCS)

head(targetScanPCT)

dim(targetScanPCT)


###################################################
### code chunk number 3: targetScore
###################################################
targetScoreMatrix <- get_precomputed_targetScores()

head(names(targetScoreMatrix))

head(targetScoreMatrix[[1]])


###################################################
### code chunk number 4: getTargetScores demo (eval = FALSE)
###################################################
## library(TargetScore)
## library(gplots)
## 
## myTargetScores <- getTargetScores("hsa-miR-1", tol=1e-3, maxiter=200)
## 
## table((myTargetScores$targetScore > 0.1), myTargetScores$validated) # a very lenient cutoff
## 
## # obtain all of targetScore for all of the 112 miRNA
## 
## logFC.imputed <- get_precomputed_logFC()
## 
## mirIDs <- unique(colnames(logFC.imputed))
## 
## # takes time
## 
## # targetScoreMatrix <- mclapply(mirIDs, getTargetScores)
## 
## # names(targetScoreMatrix) <- mirIDs


###################################################
### code chunk number 5: sessi
###################################################
sessionInfo()


