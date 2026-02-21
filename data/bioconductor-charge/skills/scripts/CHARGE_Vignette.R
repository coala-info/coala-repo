# Code example from 'CHARGE_Vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'CHARGE_Vignette.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: load the gene expression data
###################################################
library(CHARGE)
library(GenomicRanges)
library(SummarizedExperiment)
library(EnsDb.Hsapiens.v86)
data(datExprs)
datExprs


###################################################
### code chunk number 2: subset for genes on chromosome 21
###################################################
chr21 <- seqlengths(EnsDb.Hsapiens.v86)["21"]
chr21Ranges <-  GRanges("21", IRanges(end = chr21, width=chr21))
cvExpr.out <- cvExpr(se = datExprs, region = chr21Ranges)


###################################################
### code chunk number 3: plot the CV of gene expression
###################################################
plotcvExpr(cvExpr = cvExpr.out)


###################################################
### code chunk number 4: fig1
###################################################
plotcvExpr(cvExpr = cvExpr.out)


###################################################
### code chunk number 5: plot the CV of gene expression
###################################################
datExprs <- clusterExpr(se = datExprs, cvExpr = cvExpr.out,
                        threshold = "25%")


###################################################
### code chunk number 6: check sample classification
###################################################
data.frame(colData(datExprs))[c("Group", "Ploidy")]


###################################################
### code chunk number 7: plot the pca of clustering
###################################################
pcaExpr(se = datExprs, cvExpr = cvExpr.out, threshold = "25%")


###################################################
### code chunk number 8: fig2
###################################################
pcaExpr(se = datExprs, cvExpr = cvExpr.out, threshold = "25%")


###################################################
### code chunk number 9: bimodal test
###################################################
bimodalTest.out <- bimodalTest(se = datExprs, cvExpr = cvExpr.out,
                               threshold = "25%")
bimodalTest.out[[1]]


###################################################
### code chunk number 10: plot the density plot of Z scores
###################################################
plot(bimodalTest.out[[2]])


###################################################
### code chunk number 11: fig3
###################################################
plot(bimodalTest.out[[2]])


###################################################
### code chunk number 12: Expression Finder
###################################################
chrLengths <- GRanges(seqinfo(EnsDb.Hsapiens.v86)[c(1:22, "X", "Y")])
exprFinder.out <- exprFinder(se = datExprs, ranges = chrLengths,
                             binWidth = 1e+9, binStep = 1e+9, threshold = "25%")
exprFinder.out[1:3 ,c(1,6:10)]


###################################################
### code chunk number 13: annotation
###################################################
sessionInfo()


