# Code example from 'ffpe' vignette. See references/ for full tutorial.

### R code from vignette source 'ffpe.Rnw'

###################################################
### code chunk number 1: foo
###################################################
options(keep.source = TRUE)
options(width = 60)
options(eps = FALSE)
foo <- packageDescription("ffpe")


###################################################
### code chunk number 2: prelim
###################################################
options(device="pdf")


###################################################
### code chunk number 3: sortediqrplot
###################################################
library(ffpe)
library(ffpeExampleData)
data(lumibatch.GSE17565)
sortedIqrPlot(lumibatch.GSE17565,dolog2=TRUE)


###################################################
### code chunk number 4: sampleqc
###################################################
QC <- sampleQC(lumibatch.GSE17565,xaxis="index",cor.to="pseudochip",QCmeasure="IQR")


###################################################
### code chunk number 5: dotchart
###################################################
QCvsRNA <- data.frame(inputRNA.ng=lumibatch.GSE17565$inputRNA.ng,
                      rejectQC=QC$rejectQC)
QCvsRNA <- QCvsRNA[order(QCvsRNA$rejectQC,-QCvsRNA$inputRNA.ng),]
par(mgp=c(4,2,0))
dotchart(log10(QCvsRNA$inputRNA.ng),
         QCvsRNA$rejectQC,
         xlab="log10(RNA conc. in ng)", 
         ylab="rejected?",
         col=ifelse(QCvsRNA$rejectQC,"red","black"))


###################################################
### code chunk number 6: sampleqc2
###################################################
QC <- sampleQC(lumibatch.GSE17565,xaxis="index",cor.to="pseudochip",QCmeasure=log10(lumibatch.GSE17565$inputRNA.ng),labelnote="log10(RNA concentration)")


###################################################
### code chunk number 7: keepQC
###################################################
lumibatch.QC <- lumibatch.GSE17565[,!QC$rejectQC]


###################################################
### code chunk number 8: process_rep
###################################################
##replicate 1
lumibatch.rep1 <- lumibatch.QC[,lumibatch.QC$replicate==1]
lumbiatch.rep1 <- lumiT(lumibatch.rep1,"log2")
lumbiatch.rep1 <- lumiN(lumibatch.rep1,"quantile")
##replicate 2
lumibatch.rep2 <- lumibatch.QC[,lumibatch.QC$replicate==2]
lumibatch.rep2 <- lumiT(lumibatch.rep2,"log2")
lumibatch.rep2 <- lumiN(lumibatch.rep2,"quantile")


###################################################
### code chunk number 9: keepsamples
###################################################
available.samples <- intersect(lumibatch.rep1$source,lumibatch.rep2$source)
lumibatch.rep1 <- lumibatch.rep1[,na.omit(match(available.samples,lumibatch.rep1$source))]
lumibatch.rep2 <- lumibatch.rep2[,na.omit(match(available.samples,lumibatch.rep2$source))]
all.equal(lumibatch.rep1$source,lumibatch.rep2$source)


###################################################
### code chunk number 10: repcor
###################################################
probe.var <- apply(exprs(lumibatch.rep1),1,var)

rowCors = function(x, y) {  ##rowCors function borrowed from the arrayMagic Bioconductor package
  sqr = function(x) x*x
  if(!is.matrix(x)||!is.matrix(y)||any(dim(x)!=dim(y)))
    stop("Please supply two matrices of equal size.")
  x   = sweep(x, 1, rowMeans(x))
  y   = sweep(y, 1, rowMeans(y))
  cor = rowSums(x*y) /  sqrt(rowSums(sqr(x))*rowSums(sqr(y)))
}
probe.cor <- rowCors(exprs(lumibatch.rep1),exprs(lumibatch.rep2))

##the plot will be easier to see if we bin variance into deciles:
quants <- seq(from=0,to=1,by=0.1)
probe.var.cut <- cut(probe.var,breaks=quantile(probe.var,quants),include.lowest=TRUE,labels=FALSE)
boxplot(probe.cor~probe.var.cut,
        xlab="decile",
        ylab="Pearson correlation between technical replicate probes")


###################################################
### code chunk number 11: medianvar
###################################################
lumibatch.rep1 <- lumibatch.rep1[probe.var > median(probe.var),]
lumibatch.rep2 <- lumibatch.rep2[probe.var > median(probe.var),]


###################################################
### code chunk number 12: ttest
###################################################
library(genefilter)
ttests.rep1 <- rowttests(exprs(lumibatch.rep1),fac=factor(lumibatch.rep1$cell.type))
ttests.rep2 <- rowttests(exprs(lumibatch.rep2),fac=factor(lumibatch.rep2$cell.type))
pvals.rep1 <- ttests.rep1$p.value;names(pvals.rep1) <- rownames(ttests.rep1)
pvals.rep2 <- ttests.rep2$p.value;names(pvals.rep2) <- rownames(ttests.rep2)


###################################################
### code chunk number 13: catplot
###################################################
x <- CATplot(pvals.rep1,pvals.rep2,maxrank=1000,xlab="Size of top-ranked gene lists",ylab="Concordance")
legend("topleft",lty=1:2,legend=c("Actual concordance","Concordance expected by chance"), bty="n")


