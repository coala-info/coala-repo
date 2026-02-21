# Code example from 'methylumi' vignette. See references/ for full tutorial.

## ----init, echo=FALSE---------------------------
options(width=50)
library(knitr)
library(lattice)
library(xtable)

## ----cache=TRUE---------------------------------
suppressPackageStartupMessages(library(methylumi,quietly=TRUE))
samps <- read.table(system.file("extdata/samples.txt",
                                package = "methylumi"),sep="\t",header=TRUE)
mldat <- methylumiR(system.file('extdata/exampledata.samples.txt',package='methylumi'),
                    qcfile=system.file('extdata/exampledata.controls.txt',package="methylumi"),
                    sampleDescriptions=samps)

## ----cache=FALSE--------------------------------
mldat

## ----cache=TRUE---------------------------------
getAssayDataNameSubstitutions()

## ----cache=TRUE---------------------------------
md <- cmdscale(dist(t(exprs(mldat)[fData(mldat)$CHROMOSOME=='X',])),2)

## ----cache=FALSE--------------------------------
plot(md,pch=c('F','M')[pData(mldat)$Gender],col=c('red','blue')[pData(mldat)$Gender])

## ----cache=FALSE--------------------------------
avgPval <- colMeans(pvals(mldat))
par(las=2)
barplot(avgPval,ylab="Average P-Value")

## ----cache=FALSE--------------------------------
controlTypes(mldat)

## ----cache=FALSE--------------------------------
qcplot(mldat,"FIRST HYBRIDIZATION")

## ----cache=TRUE---------------------------------
toKeep <- (avgPval<0.05)
pData(mldat)$Gender[9] <- "F"
mldat.norm <- normalizeMethyLumiSet(mldat[,toKeep])

## ----cache=TRUE---------------------------------
library(limma)
dm <- model.matrix(~1+Gender,data=pData(mldat.norm))
colnames(dm)
fit1 <- lmFit(exprs(mldat.norm),dm)
fit2 <- eBayes(fit1)
tt <- topTable(fit2,coef=2,genelist=fData(mldat.norm)[,c('SYMBOL','CHROMOSOME')],number=1536)
x <- aggregate(tt$adj.P.Val,by=list(tt$CHROMOSOME),median)
colnames(x) <- c('Chromosome','Median adjusted P-value')

## ----results='asis'-----------------------------
library(xtable)
xt <- xtable(x,label="tab:chromosomepvals",caption="The median adjusted p-value for each chromosome showing that the X-chromosome is highly significantly different between males and females")
digits(xt) <- 6
print(xt,include.rownames=FALSE,align="cr")

## ----genderProbesByChrom,fig.keep='high'--------
print(xyplot(-log10(adj.P.Val)~CHROMOSOME,
       tt,ylab="-log10(Adjusted P-value)",
       main="P-values for probes\ndistinguising males from females"))

## ----results='asis'-----------------------------
toLatex(sessionInfo())

