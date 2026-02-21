# Code example from 'TSSi' vignette. See references/ for full tutorial.

### R code from vignette source 'TSSi.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: TSSi.Rnw:21-22
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: settings
###################################################
set.seed(1)
options(width=65, SweaveHooks=list(fig=function() par(mar=c(5.1, 5.1, 4.1, 1.5))))


###################################################
### code chunk number 3: load_package
###################################################
library(TSSi)


###################################################
### code chunk number 4: load_data
###################################################
data(physcoCounts)
head(physcoCounts)
table(physcoCounts$chromosome, physcoCounts$strand)


###################################################
### code chunk number 5: segmentize
###################################################
attach(physcoCounts)
x <- segmentizeCounts(counts=counts, start=start, chr=chromosome, region=region, strand=strand)
detach(physcoCounts)
x


###################################################
### code chunk number 6: get_segments
###################################################
segments(x)
names(x)


###################################################
### code chunk number 7: get_reads
###################################################
head(reads(x, 3))
head(start(x, 3))
head(start(x, names(x)[3]))


###################################################
### code chunk number 8: normalize_ratio
###################################################
yRatio <- normalizeCounts(x)


###################################################
### code chunk number 9: normalize_fit
###################################################
yFit <- normalizeCounts(x, fit=TRUE)
yFit
head(reads(yFit, 3))


###################################################
### code chunk number 10: plot_normalize_fit
###################################################
getOption("SweaveHooks")[["fig"]]()
plot(yFit, 3)


###################################################
### code chunk number 11: identify
###################################################
z <- identifyStartSites(yFit)
z
head(segments(z))
head(tss(z, 3))
head(reads(z, 3))


###################################################
### code chunk number 12: plot_identify
###################################################
getOption("SweaveHooks")[["fig"]]()
plot(z, 3)


###################################################
### code chunk number 13: plot_custom
###################################################
getOption("SweaveHooks")[["fig"]]()
plot(z, 4,
ratio=FALSE,
threshold=FALSE,
baseline=FALSE,
expect=TRUE, expectArgs=list(type="l"), extend=TRUE,
countsArgs=list(type="h", col="darkgray", pch=NA),
plotArgs=list(xlab="Genomic position", main="TSS for segment 's1_-_155'"))


###################################################
### code chunk number 14: convert_iranges
###################################################
readsRd <- readsAsRangedData(z)
segmentsRd <- segmentsAsRangedData(z)
tssRd <- tssAsRangedData(z)


###################################################
### code chunk number 15: export_rtracklayer
###################################################
#library(rtracklayer)
#tmpFile <- tempfile()
#export.gff3(readsRd, paste(tmpFile, "gff", sep="."))
#export.bed(segmentsRd, paste(tmpFile, "bed", sep="."))
#export.bed(tssRd, paste(tmpFile, "bed", sep="."))


###################################################
### code chunk number 16: sessionInfo
###################################################
toLatex(sessionInfo(), locale=FALSE)


