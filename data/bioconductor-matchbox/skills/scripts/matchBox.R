# Code example from 'matchBox' vignette. See references/ for full tutorial.

### R code from vignette source 'matchBox.Rnw'

###################################################
### code chunk number 1: start
###################################################
options(width=85)
options(continue=" ")
rm(list=ls())


###################################################
### code chunk number 2: matchBox.Rnw:151-154 (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("matchBox")


###################################################
### code chunk number 3: matchBox.Rnw:158-159
###################################################
require(matchBox)


###################################################
### code chunk number 4: loadmatchBoxExpression
###################################################
data(matchBoxExpression)


###################################################
### code chunk number 5: matchBox.Rnw:174-177
###################################################
sapply(matchBoxExpression, class)
sapply(matchBoxExpression, dim)
str(matchBoxExpression)


###################################################
### code chunk number 6: matchBox.Rnw:208-211
###################################################
sapply(matchBoxExpression, function(x) any(duplicated(x[, 1])) )
allDataBySymbolAndT <- lapply(matchBoxExpression, filterRedundant, 
			      idCol="SYMBOL", byCol="t", absolute=TRUE)


###################################################
### code chunk number 7: matchBox.Rnw:215-217
###################################################
sapply(allDataBySymbolAndT, dim)
sapply(allDataBySymbolAndT, function(x) any(duplicated(x[, 1])) )


###################################################
### code chunk number 8: matchBox.Rnw:225-228
###################################################
sapply(matchBoxExpression, function(x) any(duplicated(x[, 1])) )
allDataByEGIDAndLogFC <- lapply(matchBoxExpression, filterRedundant, 
				idCol="ENTREZID", byCol="logFC", absolute=FALSE)


###################################################
### code chunk number 9: matchBox.Rnw:232-234
###################################################
sapply(allDataByEGIDAndLogFC, dim)
sapply(allDataByEGIDAndLogFC, function(x) any(duplicated(x[, 1])) )


###################################################
### code chunk number 10: matchBox.Rnw:243-247
###################################################
sapply(matchBoxExpression, function(x) any(duplicated(x[, 1])) )
allDataByEGIDAndMedianFDR <- lapply(matchBoxExpression, filterRedundant, 
				    idCol="ENTREZID", byCol="adj.P.Val", absolute=FALSE,
				    method="median")


###################################################
### code chunk number 11: matchBox.Rnw:251-253
###################################################
sapply(allDataByEGIDAndMedianFDR, dim)
sapply(allDataByEGIDAndMedianFDR, function(x) any(duplicated(x[, 1])) )


###################################################
### code chunk number 12: matchBox.Rnw:264-265
###################################################
data <- mergeData(allDataBySymbolAndT, idCol="SYMBOL", byCol="t")


###################################################
### code chunk number 13: matchBox.Rnw:273-276
###################################################
sapply(allDataBySymbolAndT, dim)
dim(data)
str(data)


###################################################
### code chunk number 14: matchBox.Rnw:319-321
###################################################
catHigh2LowNoRefByEqualRanks <- computeCat(data = data, idCol = 1, 
					   method="equalRank", decreasing=TRUE)


###################################################
### code chunk number 15: matchBox.Rnw:328-330
###################################################
catLow2HighNoRefByEqualRanks <- computeCat(data = data, idCol = 1, 
					   method="equalRank", decreasing=FALSE)


###################################################
### code chunk number 16: matchBox.Rnw:339-341
###################################################
catHigh2LowWithRefByEqualRanks <- computeCat(data = data, idCol = 1, 
					     ref="dataSetA.t",  method="equalRank", decreasing=TRUE)


###################################################
### code chunk number 17: matchBox.Rnw:347-348
###################################################
str(catHigh2LowWithRefByEqualRanks)


###################################################
### code chunk number 18: matchBox.Rnw:354-356
###################################################
catHigh2LowWithRefByEqualStats <- computeCat(data = data, idCol = 1, ref="dataSetA.t",
					     method="equalStat", decreasing=TRUE)


###################################################
### code chunk number 19: matchBox.Rnw:362-363
###################################################
str(catHigh2LowWithRefByEqualStats)


###################################################
### code chunk number 20: matchBox.Rnw:409-410
###################################################
PIbyRefEqualRanks <- calcHypPI(data=data)


###################################################
### code chunk number 21: matchBox.Rnw:416-417
###################################################
head(PIbyRefEqualRanks)


###################################################
### code chunk number 22: matchBox.Rnw:423-424
###################################################
PIbyRefEqualRanks03 <- calcHypPI(data=data, expectedProp=0.3)


###################################################
### code chunk number 23: matchBox.Rnw:430-431
###################################################
head(PIbyRefEqualRanks03)


###################################################
### code chunk number 24: matchBox.Rnw:438-439
###################################################
PIbyRefEqualRanksQuant <- calcHypPI(data=data, prob=c(0.75, 0.9, 0.95, 0.99) )


###################################################
### code chunk number 25: matchBox.Rnw:445-446
###################################################
head(PIbyRefEqualRanksQuant)


###################################################
### code chunk number 26: matchBox.Rnw:452-453
###################################################
PIbyRefEqualRanksNoExpectedProp <- calcHypPI(data=data, expectedProp=NULL)


###################################################
### code chunk number 27: matchBox.Rnw:459-460
###################################################
head(PIbyRefEqualRanksNoExpectedProp)


###################################################
### code chunk number 28: fig1
###################################################
plotCat(catData = catHigh2LowWithRefByEqualRanks, 
	preComputedPI=PIbyRefEqualRanks03,
	cex=1.2, lwd=1.2, cexPts=1.2, spacePts=30, col=c("red", "blue"),
	main="CAT curves for decreasing t-statistics",
	where="center", legend=TRUE, legCex=1, ncol=1,
	plotLayout = layout(matrix(1:2, ncol = 2), widths = c(2,1)))


###################################################
### code chunk number 29: fig2
###################################################
plotCat(catData = catHigh2LowWithRefByEqualStats, 
	cex=1.2, lwd=1.2, cexPts=1.2, spacePts=30, col=c("red", "blue"), 
	main="CAT curves for decreasing t-statistics",
	where="center", legend=TRUE, legCex=1, ncol=1,
	plotLayout = layout(matrix(1:2, ncol = 2), widths = c(2,1)))


###################################################
### code chunk number 30: fig3
###################################################
plotCat(catData = catHigh2LowNoRefByEqualRanks, 
	preComputedPI=PIbyRefEqualRanks,
	cex=1.2, lwd=1.2, cexPts=1.2, spacePts=30,
	main="CAT curves for decreasing t-statistics",
	where="center", legend=TRUE, legCex=1, ncol=1,
	plotLayout = layout(matrix(1:2, ncol = 2), widths = c(2,1)))


###################################################
### code chunk number 31: fig4
###################################################
plotCat(catData = catHigh2LowNoRefByEqualRanks, 
	preComputedPI=PIbyRefEqualRanksNoExpectedProp,
	cex=1.2, lwd=1.2, cexPts=1.2, spacePts=30,
	main="CAT curves for decreasing t-statistics",
	where="center", legend=TRUE, legCex=1, ncol=1,
	plotLayout = layout(matrix(1:2, ncol = 2), widths = c(2,1)))


###################################################
### code chunk number 32: sessioInfo
###################################################
toLatex(sessionInfo())


