# Code example from 'HiTC' vignette. See references/ for full tutorial.

### R code from vignette source 'HiTC.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex(use.unsrturl=FALSE)


###################################################
### code chunk number 2: head
###################################################
library(HiTC)
showClass("HTCexp")
showClass("HTClist")


###################################################
### code chunk number 3: importSimple
###################################################
require(Matrix)
## Two genome intervals objects with primers informations
reverse <- GRanges(seqnames=c("chr1","chr1"), 
                   ranges = IRanges(start=c(98831149, 98837507), 
                   end=c(98834145, 98840771), 
                   names=c("REV_2","REV_4")))

forward <- GRanges(seqnames=c("chr1","chr1"), 
                   ranges = IRanges(start=c(98834146, 98840772), 
                   end=c(98837506, 98841227), 
                   names=c("FOR_3","FOR_5")))

## A matrix of interaction counts
interac <- Matrix(c(8463, 7144, 2494, 8310), ncol=2)
colnames(interac) <- c("REV_2","REV_4")
rownames(interac) <- c("FOR_3","FOR_5")

z <- HTCexp(interac, xgi=reverse, ygi=forward)
detail(z)

## Access to the slots
x_intervals(z)
y_intervals(z)
intdata(z)

## Methods
range(z)
isBinned(z)
isIntraChrom(z)
seqlevels(z)


###################################################
### code chunk number 4: importMatrix
###################################################
## Load Lieberman et al. Chromosome 12 to 14 data (from GEO GSE18199)
exDir <- system.file("extdata", package="HiTC")
l <- sapply(list.files(exDir, pattern=paste("HIC_gm06690_"), full.names=TRUE),
            import.my5C)
hiC <- HTClist(l)
show(hiC)
names(hiC)

## Methods
ranges(hiC)
range(hiC)
isBinned(hiC)
isIntraChrom(hiC)
isComplete(hiC)
seqlevels(hiC)
summary(hiC)


###################################################
### code chunk number 5: qcc
###################################################
par(mfrow=c(2,2))
CQC(hiC, winsize = 1e+06, dev.new=FALSE, hist.dist=FALSE)


###################################################
### code chunk number 6: importNora
###################################################
## Load Nora et al 5C dataset
data(Nora_5C)
show(E14)
show(MEF)


###################################################
### code chunk number 7: mapC (eval = FALSE)
###################################################
## mapC(E14$chrXchrX)


###################################################
### code chunk number 8: norm5CEval
###################################################
png(file="HiTC-mapC.png", res=300, units="in", width=5, height=5)
mapC(E14$chrXchrX)
graphics.off()


###################################################
### code chunk number 9: bin5C
###################################################
## Focus on a subset chrX:100295000:102250000
E14subset<-extractRegion(E14$chrXchrX, c(1,2),
                         chr="chrX", from=100295000, to=102250000)

## Binning of 5C interaction map
E14subset.binned <- binningC(E14subset, binsize=100000, method="median", step=3)
mapC(E14subset.binned)


###################################################
### code chunk number 10: norm5Cexp (eval = FALSE)
###################################################
## ## Look at exptected counts
## E14exp <- getExpectedCounts(E14subset.binned, method="loess", stdev=TRUE, plot=TRUE)


###################################################
### code chunk number 11: norm5CexpEval
###################################################
png(file="HiTC-expint.png", res=300, units="in", width=6, height=6)
E14exp <- getExpectedCounts(E14subset.binned, method="loess", stdev=TRUE, plot=TRUE)
graphics.off()


###################################################
### code chunk number 12: norm5Cznorm
###################################################
E14norm.binned <- normPerExpected(E14subset.binned, method="loess", stdev=TRUE)
mapC(E14norm.binned)


###################################################
### code chunk number 13: annot5C
###################################################
E14.binned <- binningC(E14$chrXchrX, binsize=100000, method="median", step=3)
require(rtracklayer)
gene <- import(file.path(exDir,"refseq_mm9_chrX_98831149_103425150.bed"), 
               format="bed")
ctcf <- import(file.path(exDir,"CTCF_chrX_98892125_102969775.bed"), 
               format="bed")
mapC(E14.binned, 
     tracks=list(RefSeqGene=gene, CTCF=ctcf), 
     maxrange=10)


###################################################
### code chunk number 14: comp5C
###################################################
MEF.binned <- binningC(MEF$chrXchrX, binsize=100000, method="median", step=3)
mapC(E14.binned, MEF.binned,
     tracks=list(RefSeqGene=gene, CTCF=ctcf), 
     maxrange=10)


###################################################
### code chunk number 15: mapClist
###################################################
mapC(hiC, maxrange=100)


###################################################
### code chunk number 16: mapChic
###################################################
## Extract region of interest and plot the interaction map
hiC14 <- extractRegion(hiC$chr14chr14, 
                     chr="chr14", from=1.8e+07, to=106368584)
mapC(HTClist(hiC14), maxrange=100)


###################################################
### code chunk number 17: mapNormhic
###################################################
## Data Normalization by Expected number of Counts
hiC14norm <- normPerExpected(hiC14, method="loess")
mapC(HTClist(hiC14norm), log.data=TRUE)


###################################################
### code chunk number 18: mapCorhic
###################################################
## Correlation Map of Chromosome 14
#intdata(hiC14norm) <- as(cor(as.matrix(intdata(hiC14norm))),"Matrix")
intdata(hiC14norm) <- HiTC:::sparseCor(intdata(hiC14norm))
mapC(HTClist(hiC14norm), maxrange=1, minrange=-1, 
     col.pos=c("black", "red"), col.neg=c("blue","black"))


###################################################
### code chunk number 19: mapPCAhic
###################################################
## Principal Component Analysis
pc <- pca.hic(hiC14, normPerExpected=TRUE, method="loess", npc=1)
plot(start(pc$PC1), score(pc$PC1), type="h", 
     xlab="chr14", ylab="PC1vec", frame=FALSE)



###################################################
### code chunk number 20: sessionInfo
###################################################
toLatex(sessionInfo(), locale=FALSE)


