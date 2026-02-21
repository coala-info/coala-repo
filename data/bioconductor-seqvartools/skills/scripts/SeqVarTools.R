# Code example from 'SeqVarTools' vignette. See references/ for full tutorial.

### R code from vignette source 'SeqVarTools.Rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: SeqVarTools.Rnw:37-43
###################################################
library(SeqVarTools)
vcffile <- seqExampleFileName("vcf")
gdsfile <- "tmp.gds"
seqVCF2GDS(vcffile, gdsfile, verbose=FALSE)
gds <- seqOpen(gdsfile)
gds


###################################################
### code chunk number 3: SeqVarTools.Rnw:48-50
###################################################
head(refChar(gds))
head(altChar(gds))


###################################################
### code chunk number 4: SeqVarTools.Rnw:54-55
###################################################
table(nAlleles(gds))


###################################################
### code chunk number 5: SeqVarTools.Rnw:61-65
###################################################
multi.allelic <- which(nAlleles(gds) > 2)
altChar(gds)[multi.allelic]
altChar(gds, n=1)[multi.allelic]
altChar(gds, n=2)[multi.allelic]


###################################################
### code chunk number 6: SeqVarTools.Rnw:69-71
###################################################
table(isSNV(gds))
isSNV(gds)[multi.allelic]


###################################################
### code chunk number 7: SeqVarTools.Rnw:76-79
###################################################
head(seqGetData(gds, "chromosome"))
head(seqGetData(gds, "position"))
granges(gds)


###################################################
### code chunk number 8: SeqVarTools.Rnw:83-85
###################################################
head(seqGetData(gds, "sample.id"))
head(seqGetData(gds, "variant.id"))


###################################################
### code chunk number 9: SeqVarTools.Rnw:93-96
###################################################
rsID <- seqGetData(gds, "annotation/id")
head(rsID)
length(unique(rsID)) == length(rsID)


###################################################
### code chunk number 10: SeqVarTools.Rnw:101-105
###################################################
seqClose(gds)
setVariantID(gdsfile, rsID)
gds <- seqOpen(gdsfile)
head(seqGetData(gds, "variant.id"))


###################################################
### code chunk number 11: SeqVarTools.Rnw:113-116
###################################################
geno <- getGenotype(gds)
dim(geno)
geno[1:10, 1:5]


###################################################
### code chunk number 12: SeqVarTools.Rnw:120-122
###################################################
geno <- getGenotypeAlleles(gds)
geno[1:10, 1:5]


###################################################
### code chunk number 13: SeqVarTools.Rnw:136-139
###################################################
samp.id <- seqGetData(gds, "sample.id")[1:10]
var.id <- seqGetData(gds, "variant.id")[1:5]
applyMethod(gds, getGenotype, variant=var.id, sample=samp.id)


###################################################
### code chunk number 14: SeqVarTools.Rnw:144-148
###################################################
library(GenomicRanges)
gr <- GRanges(seqnames="22", IRanges(start=1, end=250000000))
geno <- applyMethod(gds, getGenotype, variant=gr)
dim(geno)


###################################################
### code chunk number 15: SeqVarTools.Rnw:158-160
###################################################
titv(gds)
head(titv(gds, by.sample=TRUE))


###################################################
### code chunk number 16: SeqVarTools.Rnw:166-174
###################################################
binVar <- function(var, names, breaks) {
  names(var) <- names
  var <- sort(var)
  mids <- breaks[1:length(breaks)-1] + 
    (breaks[2:length(breaks)] - breaks[1:length(breaks)-1])/2
  bins <- cut(var, breaks, labels=mids, right=FALSE)
  split(names(var), bins)
}


###################################################
### code chunk number 17: SeqVarTools.Rnw:177-187
###################################################
variant.id <- seqGetData(gds, "variant.id")
afreq <- alleleFrequency(gds)
maf <- pmin(afreq, 1-afreq)
maf.bins <- binVar(maf, variant.id, seq(0,0.5,0.02))
nbins <- length(maf.bins)
titv.maf <- rep(NA, nbins)
for (i in 1:nbins) {
  capture.output(titv.maf[i] <- applyMethod(gds, titv, variant=maf.bins[[i]]))
}
plot(as.numeric(names(maf.bins)), titv.maf, xlab="MAF", ylab="TiTv")


###################################################
### code chunk number 18: SeqVarTools.Rnw:190-198
###################################################
miss <- missingGenotypeRate(gds)
miss.bins <- binVar(miss, variant.id, c(seq(0,0.5,0.05),1))
nbins <- length(miss.bins)
titv.miss <- rep(NA, nbins)
for (i in 1:nbins) {
  capture.output(titv.miss[i] <- applyMethod(gds, titv, variant=miss.bins[[i]]))
}
plot(as.numeric(names(miss.bins)), titv.miss, xlab="missing rate", ylab="TiTv")


###################################################
### code chunk number 19: SeqVarTools.Rnw:201-210
###################################################
depth <- seqApply(gds, "annotation/format/DP", mean, margin="by.variant", 
                  as.is="double", na.rm=TRUE)
depth.bins <- binVar(depth, variant.id, seq(0,200,20))
nbins <- length(depth.bins)
titv.depth <- rep(NA, nbins)
for (i in 1:nbins) {
  capture.output(titv.depth[i] <- applyMethod(gds, titv, variant=depth.bins[[i]]))
}
plot(as.numeric(names(depth.bins)), titv.depth, xlab="mean depth", ylab="TiTv")


###################################################
### code chunk number 20: SeqVarTools.Rnw:217-220
###################################################
miss.var <- missingGenotypeRate(gds, margin="by.variant")
het.var <- heterozygosity(gds, margin="by.variant")
filt <- seqGetData(gds, "variant.id")[miss.var <= 0.1 & het.var <= 0.6]


###################################################
### code chunk number 21: SeqVarTools.Rnw:225-229
###################################################
seqSetFilter(gds, variant.id=filt)
hethom <- hethom(gds)
hist(hethom, main="", xlab="Het/Hom Non-Ref")
seqSetFilter(gds)


###################################################
### code chunk number 22: SeqVarTools.Rnw:237-240
###################################################
pc <- pca(gds)
names(pc)
plot(pc$eigenvect[,1], pc$eigenvect[,2])


###################################################
### code chunk number 23: SeqVarTools.Rnw:251-257
###################################################
hw <- hwe(gds)
pval <- -log10(sort(hw$p))
hw.perm <- hwe(gds, permute=TRUE)
x <- -log10(sort(hw.perm$p))
plot(x, pval, xlab="-log10(expected P)", ylab="-log10(observed P)")	
abline(0,1,col="red")


###################################################
### code chunk number 24: SeqVarTools.Rnw:262-263
###################################################
hist(hw$f)


###################################################
### code chunk number 25: SeqVarTools.Rnw:267-269
###################################################
ic <- inbreedCoeff(gds, margin="by.sample")
range(ic)


###################################################
### code chunk number 26: SeqVarTools.Rnw:277-282
###################################################
data(pedigree)
pedigree[pedigree$family == 1463,]
err <- mendelErr(gds, pedigree, verbose=FALSE)
table(err$by.variant)
err$by.trio


###################################################
### code chunk number 27: SeqVarTools.Rnw:294-313
###################################################
library(Biobase)
sample.id <- seqGetData(gds, "sample.id")
pedigree <- pedigree[match(sample.id, pedigree$sample.id),]
n <- length(sample.id)
pedigree$phenotype <- rnorm(n, mean=10)
pedigree$case.status <- rbinom(n, 1, 0.3)
sample.data <- AnnotatedDataFrame(pedigree)

seqData <- SeqVarData(gds, sample.data)

## continuous phenotype
assoc <- regression(seqData, outcome="phenotype", covar="sex",
                    model.type="linear")
head(assoc)
pval <- -log10(sort(assoc$Wald.Pval))
n <- length(pval)
x <- -log10((1:n)/n)
plot(x, pval, xlab="-log10(expected P)", ylab="-log10(observed P)")
abline(0, 1, col = "red")


###################################################
### code chunk number 28: SeqVarTools.Rnw:323-331
###################################################
assoc <- regression(seqData, outcome="case.status", covar="sex",
                    model.type="firth")
head(assoc)
pval <- -log10(sort(assoc$PPL.Pval))
n <- length(pval)
x <- -log10((1:n)/n)
plot(x, pval, xlab="-log10(expected P)", ylab="-log10(observed P)")
abline(0, 1, col = "red")


###################################################
### code chunk number 29: SeqVarTools.Rnw:336-337
###################################################
seqClose(gds)


###################################################
### code chunk number 30: SeqVarTools.Rnw:340-341
###################################################
unlink(gdsfile)


