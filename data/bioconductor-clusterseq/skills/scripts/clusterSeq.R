# Code example from 'clusterSeq' vignette. See references/ for full tutorial.

### R code from vignette source 'clusterSeq.Rnw'

###################################################
### code chunk number 1: <style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: clusterSeq.Rnw:24-27 (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("clusterSeq")


###################################################
### code chunk number 3: clusterSeq.Rnw:30-31
###################################################
library(clusterSeq)


###################################################
### code chunk number 4: clusterSeq.Rnw:40-42
###################################################
data(ratThymus, package = "clusterSeq")
head(ratThymus)


###################################################
### code chunk number 5: clusterSeq.Rnw:46-50
###################################################
replicates <- c("2week","2week","2week","2week",
                "6week","6week","6week","6week",
                "21week","21week","21week","21week",
                "104week","104week","104week","104week")


###################################################
### code chunk number 6: clusterSeq.Rnw:55-57
###################################################
  library(baySeq)
  libsizes <- getLibsizes(data = ratThymus)


###################################################
### code chunk number 7: clusterSeq.Rnw:63-65
###################################################
ratThymus[ratThymus == 0] <- 1
normRT <- log2(ratThymus %*% diag(1/libsizes) * mean(libsizes))


###################################################
### code chunk number 8: clusterSeq.Rnw:69-70
###################################################
normRT <- normRT[1:1000,]


###################################################
### code chunk number 9: clusterSeq.Rnw:79-81
###################################################
kClust <- kCluster(normRT, matrixFile = "kclust_matrix.txt.gz", B = 1000)
head(kClust)


###################################################
### code chunk number 10: clusterSeq.Rnw:85-86
###################################################
mkClust <- makeClusters(kClust, normRT, threshold = 1)


###################################################
### code chunk number 11: clusterSeq.Rnw:91-93
###################################################
kClustR <- kCluster(normRT, replicates = replicates, matrixFile = "kclust_matrix_newForceReps.txt.gz", B = 1000)
mkClustR <- makeClusters(kClustR, normRT, threshold = 1)


###################################################
### code chunk number 12: clusterSeq.Rnw:97-98
###################################################
mkClustRC <- makeClustersFF("kclust_matrix_newForceReps.txt.gz", method = "complete", cut.height = 5)


###################################################
### code chunk number 13: clusterSeq.Rnw:112-117
###################################################
library(baySeq)
cD.ratThymus <- new("countData", data = ratThymus, replicates = c(1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4))
densityFunction(cD.ratThymus) <- nbinomDensity
libsizes(cD.ratThymus) <- getLibsizes(cD.ratThymus)
cD.ratThymus <- allModels(cD.ratThymus)


###################################################
### code chunk number 14: clusterSeq.Rnw:121-126
###################################################
#cl <- makeCluster(4)
#cD.ratThymus <- getPriors(cD.ratThymus, consensus = TRUE, cl = cl)
#cD.ratThymus <- getLikelihoods(cD.ratThymus, cl = cl)

data(cD.ratThymus, package = "clusterSeq")


###################################################
### code chunk number 15: clusterSeq.Rnw:131-134
###################################################
cD.ratThymus <- cD.ratThymus[1:1000,]
aM <- associatePosteriors(cD.ratThymus)
sX <- makeClusters(aM, cD.ratThymus, threshold = 0.5)


###################################################
### code chunk number 16: clusterSeq.Rnw:138-139
###################################################
wallace(sX, mkClustRC)


###################################################
### code chunk number 17: plotClusterBS
###################################################
par(mfrow = c(2,3))
plotCluster(sX[1:6], cD.ratThymus)


###################################################
### code chunk number 18: clusterSeq.Rnw:160-161
###################################################
sessionInfo()


