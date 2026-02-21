# Code example from 'CNVtools-vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'CNVtools-vignette.Rnw'

###################################################
### code chunk number 1: load.data
###################################################
#source("../CNVtools.r"); dyn.load("../../src/CNVtools.so"); load("../../CNVtools/data/A112.RData")
library(CNVtools) 
data(A112)
head(A112)
raw.signal <- as.matrix(A112[, -c(1,2)])
dimnames(raw.signal)[[1]] <- A112$subject
  

mean.signal <- apply(raw.signal, MAR=1, FUN=mean)
pca.signal <- apply.pca(raw.signal)

dir.create("fig")
pdf("fig/mean_pca_signal.pdf", width=10, height=5)
par(mfrow=c(1,2))
hist(mean.signal, breaks=50, main='Mean signal', cex.lab=1.3)
hist(pca.signal, breaks=50, main='First PCA signal', cex.lab=1.3)  
dev.off()


###################################################
### code chunk number 2: model.select
###################################################
batches <- factor(A112$cohort)
sample <- factor(A112$subject)
set.seed(0)
results <- CNVtest.select.model(signal=pca.signal, batch = batches, sample = sample, n.H0 = 3, method="BIC", v.ncomp = 1:5, v.model.component = rep('gaussian',5), v.model.mean = rep("~ strata(cn)",5), v.model.var = rep("~1", 5))
ncomp <- results$selected
pdf("fig/modelselect.pdf",width=5,height=5)
plot(-results$BIC, xlab="n comp", ylab="-BIC", type="b", lty=2, col="red", pch = '+')
dev.off()


###################################################
### code chunk number 3: cluster.pca
###################################################
ncomp <- 3
batches <- factor(A112$cohort)
sample <- factor(A112$subject)
fit.pca <- CNVtest.binary ( signal = pca.signal, sample = sample, batch = batches, ncomp = ncomp, n.H0=3, n.H1=0, model.var= '~ strata(cn)')
print(fit.pca$status.H0)

pdf("fig/pca-fit.pdf", width=10, height=5)
par(mfrow=c(1,2))
cnv.plot(fit.pca$posterior.H0, batch = '58C', main = 'Cohort 58C', breaks = 50, col = 'red')
cnv.plot(fit.pca$posterior.H0, batch = 'NBS', main = 'Cohort NBS', breaks = 50, col = 'red')
dev.off()  


###################################################
### code chunk number 4: genotype.assignment
###################################################
head(fit.pca$posterior.H0)


###################################################
### code chunk number 5: ldf.improve
###################################################
ncomp <- 3
pca.posterior <- as.matrix((fit.pca$posterior.H0)[, paste('P',seq(1:ncomp),sep='')])
dimnames(pca.posterior)[[1]] <- (fit.pca$posterior.H0)$subject
ldf.signal <- apply.ldf(raw.signal, pca.posterior)

pdf("fig/ldf_pca_signal.pdf", width=10, height=5)
par(mfrow=c(1,2))
hist(pca.signal, breaks=50, main='First PCA signal', cex.lab=1.3)  
hist(ldf.signal, breaks=50, main='LDF signal', cex.lab=1.3)  
dev.off()


###################################################
### code chunk number 6: test.association
###################################################
ncomp <- 3
trait <- ifelse( A112$cohort == '58C', 0, 1)
fit.ldf <- CNVtest.binary ( signal = ldf.signal, sample = sample, batch = batches, disease.status = trait, ncomp = ncomp, n.H0=3, n.H1=1, model.var = "~cn")
print(fit.ldf$status.H0)
print(fit.ldf$status.H1)

pdf("fig/ldf-fit.pdf", width=10, height=5)
par(mfrow=c(1,2))
cnv.plot(fit.ldf$posterior.H0, batch = '58C', main = 'Cohort 58C', breaks = 50, col = 'red')
cnv.plot(fit.ldf$posterior.H0, batch = 'NBS', main = 'Cohort NBS', breaks = 50, col = 'red')
dev.off()

LR.statistic <- -2*(fit.ldf$model.H0$lnL - fit.ldf$model.H1$lnL)
print(LR.statistic)


###################################################
### code chunk number 7: test.association.allelic
###################################################
fit.ldf <- CNVtest.binary ( signal = ldf.signal, sample = sample, batch = batches, disease.status = trait, ncomp = 3, n.H0=3, n.H1=1, model.disease = " ~ as.factor(cn)")
print(fit.ldf$status.H0)
print(fit.ldf$status.H1)
LR.statistic <- -2*(fit.ldf$model.H0$lnL - fit.ldf$model.H1$lnL)
print(LR.statistic)


###################################################
### code chunk number 8: test.association.qt
###################################################
batches <- rep("ALL",length(sample))
qt <- rnorm(length(sample), mean=9.0, sd=1.0)
fit.ldf <- CNVtest.qt(signal = ldf.signal, sample = sample, batch = batches, qt = qt, ncomp = ncomp, n.H0=3, n.H1=1, model.var = "~strata(cn)")
print(fit.ldf$status.H0)
print(fit.ldf$status.H1)
LR.statistic <- -2*(fit.ldf$model.H0$lnL - fit.ldf$model.H1$lnL)
print(LR.statistic)
pdf("fig/qt-fit.pdf", width=15, height=5)
qt.plot(fit.ldf) 
dev.off()


