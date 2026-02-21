# Code example from 'chromPlot' vignette. See references/ for full tutorial.

### R code from vignette source 'chromPlot.Rnw'

###################################################
### code chunk number 1: createGraphminus1
###################################################
library("chromPlot")
data(hg_gap)
head(hg_gap)

chromPlot(gaps=hg_gap)


###################################################
### code chunk number 2: createGraph0
###################################################
library("TxDb.Hsapiens.UCSC.hg19.knownGene")
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

library(GenomicFeatures)
txgr <- transcripts(txdb)
txgr


###################################################
### code chunk number 3: createGraph0_plot
###################################################
chromPlot(gaps=hg_gap, annot1=txgr)


###################################################
### code chunk number 4: createGraph1
###################################################
data(hg_cytoBandIdeo)
head(hg_cytoBandIdeo)


###################################################
### code chunk number 5: createGraph2
###################################################
chromPlot(bands=hg_cytoBandIdeo, gaps=hg_gap, chr=c("1", "2", "3", "4", "5",
"6"), figCols=6)


###################################################
### code chunk number 6: createGraph3
###################################################
data_file1       <- system.file("extdata", "hg19_refGeneChr19-21.txt",
package = "chromPlot")
refGeneHg        <- read.table(data_file1, sep="\t", header=TRUE,
stringsAsFactors=FALSE)
refGeneHg$Colors <- "red"
head(refGeneHg)


###################################################
### code chunk number 7: createGraph4
###################################################
chromPlot(gaps=hg_gap, bands=refGeneHg, chr=c(19, 20, 21), figCols=3)


###################################################
### code chunk number 8: createGraph5
###################################################
data_file2 <- system.file("extdata", "Fst_CEU-YRI-W200Chr19-21.bed", package
= "chromPlot")
fst  <- read.table(data_file2, sep="\t", stringsAsFactors=FALSE, header=TRUE)
head(fst)
fst$Colors <-
ifelse(fst$win.FST >= 0     & fst$win.FST  < 0.025, "gray66",
ifelse(fst$win.FST >= 0.025 & fst$win.FST  < 0.05,  "grey55",
ifelse(fst$win.FST >= 0.05  & fst$win.FST  < 0.075, "grey35",
ifelse(fst$win.FST >= 0.075 & fst$win.FST  < 0.1,   "black",
ifelse(fst$win.FST >= 0.1   & fst$win.FST  < 1,     "red","red")))))
head(fst)


###################################################
### code chunk number 9: createGraph6
###################################################
chromPlot(gaps=hg_gap, chr=c(19, 20, 21), bands=fst, figCols=3)


###################################################
### code chunk number 10: createGraph7
###################################################
fst$Group <-
ifelse(fst$win.FST >= 0     & fst$win.FST < 0.025, "Fst 0-0.025",
ifelse(fst$win.FST >= 0.025 & fst$win.FST < 0.05,  "Fst 0.025-0.05",
ifelse(fst$win.FST >= 0.05  & fst$win.FST < 0.075, "Fst 0.05-0.075",
ifelse(fst$win.FST >= 0.075 & fst$win.FST < 0.1,   "Fst 0.075-0.1",
ifelse(fst$win.FST >= 0.1   & fst$win.FST < 1,     "Fst 0.1-1","na")))))
head(fst)


###################################################
### code chunk number 11: createGraph8
###################################################
chromPlot(gaps=hg_gap, chr=c(19, 20, 21), bands=fst, figCols=3)


###################################################
### code chunk number 12: createGraph9
###################################################
data_file3 <- system.file("extdata", "sinteny_Hg-mm10Chr19-21.txt", package =
"chromPlot")
sinteny    <- read.table(data_file3, sep="\t", stringsAsFactors=FALSE,
header=TRUE)
head(sinteny) 


###################################################
### code chunk number 13: createGraph10
###################################################
chromPlot(gaps=hg_gap, bands=sinteny, chr=c(19:21), figCols=3)


###################################################
### code chunk number 14: createGraph11
###################################################
refGeneHg$Colors <- NULL
head(refGeneHg)


###################################################
### code chunk number 15: createGraph12
###################################################
chromPlot(gaps=hg_gap, bands=hg_cytoBandIdeo, annot1=refGeneHg, chr=c(19:21),
figCols=3)


###################################################
### code chunk number 16: createGraph13
###################################################
data_file4 <-system.file("extdata", "mm10_refGeneChr2-11-17-19.txt", package= "chromPlot")
ref_mm10   <-read.table(data_file4, sep="\t", stringsAsFactors=FALSE, header
=TRUE)
data_file5 <- system.file("extdata", "arrayChr17-19.txt", package = "chromPlot")
array      <- read.table(data_file5, sep="\t", header=TRUE, stringsAsFactors=FALSE)
head(ref_mm10)
head(array, 4)


###################################################
### code chunk number 17: createGraph14
###################################################
data(mm10_gap)
data_file6  <- system.file("extdata", "GenesDEChr17-19.bed", package =
"chromPlot")
GenesDE     <- read.table(data_file6, sep="\t", header=TRUE, 
stringsAsFactors=FALSE)
head(GenesDE)
DEpos       <- subset(GenesDE, nivel%in%"+")
DEneg       <- subset(GenesDE, nivel%in%"-")
head(DEpos, 4)
head(DEneg, 4)


###################################################
### code chunk number 18: createGraph15
###################################################
chromPlot(gaps=mm10_gap, bands=mm10_cytoBandIdeo, annot1=ref_mm10,
annot2=array, annot3=DEneg, annot4=DEpos, chr=c( "17", "18", "19"), figCols=3, 
chrSide=c(-1, -1, -1, 1, -1, 1, -1, 1), noHist=FALSE)


###################################################
### code chunk number 19: createGraph16
###################################################
data_file7 <- system.file("extdata", "monocitosDEChr19-21.txt", package =
"chromPlot")
monocytes  <- read.table(data_file7, sep="\t", header=TRUE,
stringsAsFactors=FALSE)
head(monocytes)


###################################################
### code chunk number 20: createGraph17
###################################################
chromPlot(gaps=hg_gap, bands=hg_cytoBandIdeo, annot1=refGeneHg,
segment=monocytes, chrSide=c(-1,1,1,1,1,1,1,1), figCols=3, chr=c(19:21))


###################################################
### code chunk number 21: createGraph18
###################################################
head(fst)


###################################################
### code chunk number 22: createGraph19
###################################################
chromPlot(bands=hg_cytoBandIdeo, gaps=hg_gap, stat=fst, statCol="win.FST",
statName="win.FST", statTyp="p", chr=c(19:21), figCols=3, scex=0.7, spty=20,
statSumm="none")


###################################################
### code chunk number 23: createGraph20
###################################################
chromPlot(bands=hg_cytoBandIdeo, gaps=hg_gap, stat=fst, statCol="win.FST",
statName="win.FST", statTyp="p", chr=c(19:21), figCols=3, scex=0.7, spty=20,
statSumm="mean")


###################################################
### code chunk number 24: createGraph21
###################################################
chromPlot( bands=hg_cytoBandIdeo, gaps=hg_gap, stat=fst, statCol="win.FST",
statName="win.FST", statTyp="l", chr=c(19:21), figCols=3, statSumm="none")


###################################################
### code chunk number 25: createGraph22
###################################################
chromPlot( bands=hg_cytoBandIdeo, gaps=hg_gap, stat=fst, statCol="win.FST",
statName="win.FST", statTyp="l", chr=c(19:21), figCols=3, statSumm="mean")


###################################################
### code chunk number 26: createGraph23
###################################################
data_file8 <- system.file("extdata", "iHS_CEUChr19-21", package = "chromPlot")
ihs <- read.table(data_file8, sep="\t", stringsAsFactors=FALSE, header=TRUE)
head(ihs)
data_file9 <-system.file("extdata", "XPEHH_CEU-YRIChr19-21", package="chromPlot")
xpehh <-read.table(data_file9, sep="\t", stringsAsFactors=FALSE, header=TRUE)
head(xpehh)


###################################################
### code chunk number 27: createGraph23-2
###################################################
xpehh$ID <- ""
xpehh[which.max(xpehh$XP),"ID"] <- xpehh[which.max(xpehh$XP),"Name"]
head(xpehh)


###################################################
### code chunk number 28: createGraph24
###################################################
chromPlot(gaps=hg_gap, bands=fst, stat=ihs, stat2=xpehh, statCol="iHS",
statCol2="XP", statName="iHS", statName2="normxpehh", colStat="red", colStat2="blue", statTyp="p", scex=2, spty=20, statThreshold=1.2, statThreshold2=1.5, chr=c(19:21),
bin=1e6, figCols=3, cex=0.7, statSumm="none", legChrom=19, stack=FALSE)


###################################################
### code chunk number 29: createGraphQTL
###################################################
library(qtl)
data(hyper)
hyper <- calc.genoprob(hyper, step=1)
hyper <- scanone(hyper)
QTLs <- hyper
colnames(QTLs) <- c("Chrom", "cM", "LOD")
QTLs$Start <- 1732273 + QTLs$cM * 1895417
chromPlot(gaps=mm10_gap, bands=mm10_cytoBandIdeo, annot1=ref_mm10, stat=QTLs,
statCol="LOD", chrSide=c(-1,1,1,1,1,1,1,1), statTyp="l", chr=c(2,17:18), figCols=3)


###################################################
### code chunk number 30: createGraph25
###################################################
data_file10 <- system.file("extdata",
"CLG_AIMs_150_chr_hg19_v2_SNP_rs_rn.csv",
package = "chromPlot")
AIMS    <- read.csv(data_file10, sep=",")
head(AIMS)


###################################################
### code chunk number 31: createGraph26
###################################################
chromPlot(gaps=hg_gap, bands=hg_cytoBandIdeo, stat=AIMS, statCol="Value",
statName="Value", noHist=TRUE, figCols=4, cex=0.7, chr=c(1:8), statTyp="n",
chrSide=c(1,1,1,1,1,1,-1,1))


###################################################
### code chunk number 32: createGraph27
###################################################
data_file12 <-system.file("extdata", "QTL.csv", package = "chromPlot")
qtl        <-read.table(data_file12, sep=",", header =TRUE,
stringsAsFactors=FALSE)
head(qtl)


###################################################
### code chunk number 33: createGraph28
###################################################
chromPlot(gaps=mm10_gap, segment=qtl, noHist=TRUE, annot1=ref_mm10,
chrSide=c(-1,1,1,1,1,1,1,1), chr=c(2,11,17), stack=TRUE, figCol=3,
bands=mm10_cytoBandIdeo)


###################################################
### code chunk number 34: createGraph29
###################################################
data_file11 <- system.file("extdata", "phenogram-ancestry-sample.txt",
package = "chromPlot")
pheno_ancestry    <- read.csv(data_file11, sep="\t", header=TRUE)
head(pheno_ancestry)


###################################################
### code chunk number 35: createGraph30
###################################################
chromPlot(bands=hg_cytoBandIdeo, gaps=hg_gap, segment=pheno_ancestry,
noHist=TRUE, chr=c(3:5), figCols=3, legChrom=5)


###################################################
### code chunk number 36: createGraph31
###################################################
pheno_ancestry$Start<-pheno_ancestry$Start-5e6
pheno_ancestry$End<-pheno_ancestry$End+5e6
head(pheno_ancestry)


###################################################
### code chunk number 37: createGraph32
###################################################
chromPlot(bands=hg_cytoBandIdeo, gaps=hg_gap, segment=pheno_ancestry,
noHist=TRUE, chr=c(3:5), figCols=3, legChrom=5)


###################################################
### code chunk number 38: createGraph33
###################################################
data_file13 <- system.file("extdata", "ancestry_humanChr19-21.txt", package =
"chromPlot")
ancestry    <- read.table(data_file13, sep="\t",stringsAsFactors=FALSE,
header=TRUE)
head(ancestry)


###################################################
### code chunk number 39: createGraph34
###################################################
chromPlot(gaps=hg_gap, bands=hg_cytoBandIdeo, chrSide=c(-1,1,1,1,1,1,1,1),
noHist=TRUE, annot1=refGeneHg, figCols=3, segment=ancestry, colAnnot1="blue",
chr=c(19:21), legChrom=21)


###################################################
### code chunk number 40: createGraph35
###################################################
chromPlot(stat=fst, statCol="win.FST", statName="win.FST", gaps=hg_gap,
bands=hg_cytoBandIdeo, statTyp="l", noHist=TRUE, annot1=refGeneHg,
chrSide=c(-1, 1, 1, 1, 1, 1, 1, 1), chr = c(19:21), figCols=3, cex=1)


###################################################
### code chunk number 41: createGraph36
###################################################
options(stringsAsFactors = FALSE);
data_file14<-system.file("extdata", "donor_regions.csv", package = "chromPlot")
region<-read.csv(data_file14, sep=",")
region$Colors    <- "darkred"
head(region)
head(qtl)


###################################################
### code chunk number 42: createGraph37
###################################################
chromPlot(gaps=mm10_gap, segment=qtl, noHist=TRUE, annot1=ref_mm10,
chrSide=c(-1,1,1,1,1,1,1,1), chr=c(2,11,17), stack=TRUE, figCol=3,
bands=region, colAnnot1="blue")


###################################################
### code chunk number 43: createGraph38
###################################################
chromPlot(gaps=mm10_gap, bands=mm10_cytoBandIdeo, annot1=ref_mm10,
annot2=ref_mm10, chrSide=c(-1, 1, 1, 1, 1, 1, 1, 1), chr=c(17:19), figCols=3)


