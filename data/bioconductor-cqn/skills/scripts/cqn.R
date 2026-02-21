# Code example from 'cqn' vignette. See references/ for full tutorial.

### R code from vignette source 'cqn.Rnw'

###################################################
### code chunk number 1: cqn.Rnw:7-8
###################################################
options(width=70)


###################################################
### code chunk number 2: load
###################################################
library(cqn)
library(scales)


###################################################
### code chunk number 3: data1
###################################################
data(montgomery.subset)
dim(montgomery.subset)
montgomery.subset[1:4,1:4]
colnames(montgomery.subset)


###################################################
### code chunk number 4: data2
###################################################
data(sizeFactors.subset)
sizeFactors.subset[1:4]


###################################################
### code chunk number 5: data3
###################################################
data(uCovar)
head(uCovar)


###################################################
### code chunk number 6: checkdata
###################################################
stopifnot(all(rownames(montgomery.subset) == rownames(uCovar)))
stopifnot(colnames(montgomery.subset) == names(sizeFactors.subset))


###################################################
### code chunk number 7: cqncall
###################################################
cqn.subset <- cqn(montgomery.subset, lengths = uCovar$length, 
                  x = uCovar$gccontent, sizeFactors = sizeFactors.subset,
                  verbose = TRUE)
cqn.subset


###################################################
### code chunk number 8: cqnplot1
###################################################
par(mfrow=c(1,2))
cqnplot(cqn.subset, n = 1, xlab = "GC content", lty = 1, ylim = c(1,7))
cqnplot(cqn.subset, n = 2, xlab = "length", lty = 1, ylim = c(1,7))


###################################################
### code chunk number 9: normalizedvalues
###################################################
RPKM.cqn <- cqn.subset$y + cqn.subset$offset
RPKM.cqn[1:4,1:4]


###################################################
### code chunk number 10: rpkmvalues
###################################################
RPM <- sweep(log2(montgomery.subset + 1), 2, log2(sizeFactors.subset/10^6))
RPKM.std <- sweep(RPM, 1, log2(uCovar$length / 10^3))


###################################################
### code chunk number 11: groups
###################################################
grp1 <- c("NA06985", "NA06994", "NA07037", "NA10847", "NA11920")
grp2 <- c("NA11918", "NA11931", "NA12003", "NA12006", "NA12287")


###################################################
### code chunk number 12: whGenes
###################################################
whGenes <- which(rowMeans(RPKM.std) >= 2 & uCovar$length >= 100)
M.std <- rowMeans(RPKM.std[whGenes, grp1]) - rowMeans(RPKM.std[whGenes, grp2])
A.std <- rowMeans(RPKM.std[whGenes,])
M.cqn <- rowMeans(RPKM.cqn[whGenes, grp1]) - rowMeans(RPKM.cqn[whGenes, grp2])
A.cqn <- rowMeans(RPKM.cqn[whGenes,])


###################################################
### code chunk number 13: maplots
###################################################
par(mfrow = c(1,2))
plot(A.std, M.std, cex = 0.5, pch = 16, xlab = "A", ylab = "M", 
     main = "Standard RPKM", ylim = c(-4,4), xlim = c(0,12), 
     col = alpha("black", 0.25))
plot(A.cqn, M.cqn, cex = 0.5, pch = 16, xlab = "A", ylab = "M", 
     main = "CQN normalized RPKM", ylim = c(-4,4), xlim = c(0,12), 
     col = alpha("black", 0.25))


###################################################
### code chunk number 14: gcmaplots
###################################################
par(mfrow = c(1,2))
gccontent <- uCovar$gccontent[whGenes]
whHigh <- which(gccontent > quantile(gccontent, 0.9))
whLow <- which(gccontent < quantile(gccontent, 0.1))
plot(A.std[whHigh], M.std[whHigh], cex = 0.2, pch = 16, xlab = "A", 
     ylab = "M", main = "Standard RPKM", 
     ylim = c(-4,4), xlim = c(0,12), col = "red")
points(A.std[whLow], M.std[whLow], cex = 0.2, pch = 16, col = "blue")
plot(A.cqn[whHigh], M.cqn[whHigh], cex = 0.2, pch = 16, xlab = "A", 
     ylab = "M", main = "CQN normalized RPKM", 
     ylim = c(-4,4), xlim = c(0,12), col = "red")
points(A.cqn[whLow], M.cqn[whLow], cex = 0.2, pch = 16, col = "blue")


###################################################
### code chunk number 15: edgeRconstructor
###################################################
library(edgeR)
d.mont <- DGEList(counts = montgomery.subset, lib.size = sizeFactors.subset, 
                  group = rep(c("grp1", "grp2"), each = 5), genes = uCovar)


###################################################
### code chunk number 16: cqn.Rnw:225-227 (eval = FALSE)
###################################################
## ## Not run
## d.mont$offset <- cqn.subset$glm.offset


###################################################
### code chunk number 17: edgeRdisp
###################################################
design <- model.matrix(~ d.mont$sample$group)
d.mont$offset <- cqn.subset$glm.offset
d.mont.cqn <- estimateGLMCommonDisp(d.mont, design = design) 


###################################################
### code chunk number 18: edgeRfit
###################################################
efit.cqn <- glmFit(d.mont.cqn, design = design)
elrt.cqn <- glmLRT(efit.cqn, coef = 2)
topTags(elrt.cqn, n = 2)


###################################################
### code chunk number 19: cqn.Rnw:264-265
###################################################
summary(decideTests(elrt.cqn))


###################################################
### code chunk number 20: edgeRstd
###################################################
d.mont.std <- estimateGLMCommonDisp(d.mont, design = design)
efit.std <- glmFit(d.mont.std, design = design)
elrt.std <- glmLRT(efit.std, coef = 2)
summary(decideTests(elrt.std))


###################################################
### code chunk number 21: cqn.Rnw:327-328 (eval = FALSE)
###################################################
## cqn$y + cqn$offset


###################################################
### code chunk number 22: sessionInfo
###################################################
toLatex(sessionInfo())


