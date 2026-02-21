# Code example from 'cgdv' vignette. See references/ for full tutorial.

### R code from vignette source 'cgdv.Rnw'

###################################################
### code chunk number 1: lkd
###################################################
library(cgdv17)
data(popvec)
popvec[1:5]
table(popvec)


###################################################
### code chunk number 2: lkh
###################################################
data(h1)
h1
h1[[1]]$Sample
h1[[1]]$Header$META
h1[[1]]$Header$INFO
h1[[1]]$Header$FORMAT


###################################################
### code chunk number 3: lkd
###################################################
rv = getRVS("cgdv17")
rv


###################################################
### code chunk number 4: lkd1
###################################################
R85 = getrd(rv, "NA06985")
length(R85)
summary(elementMetadata(R85)$QUAL)
kp = which(elementMetadata(R85)$QUAL >= 166)
R85hiq = R85[kp]


###################################################
### code chunk number 5: lkty
###################################################
elementMetadata(R85hiq)[11:20,]
refs = elementMetadata(R85hiq)$REF
alts = elementMetadata(R85hiq)$ALT
genos = elementMetadata(R85hiq)$geno
table(nchar(refs))
alts[grep(",",unlist(alts))]


###################################################
### code chunk number 6: getlocs
###################################################
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
tx19 = TxDb.Hsapiens.UCSC.hg19.knownGene
library(org.Hs.eg.db)
get("ORMDL3", revmap(org.Hs.egSYMBOL))
ortx = transcriptsBy(tx19, "gene")$"94103"
seqlevels(R85hiq) = "chr17"
aro = subsetByOverlaps(R85hiq, ortx+100000)
table(elementMetadata(aro)$geno)
alts = unlist(elementMetadata(aro)$ALT)
alts[nchar(alts)>1]


###################################################
### code chunk number 7: getd
###################################################
suppressPackageStartupMessages(library(GGtools))
data(CY17)
CY17
sn = sampleNames(CY17)


###################################################
### code chunk number 8: getse
###################################################
rv17 = rv[, sn]
rv17


###################################################
### code chunk number 9: lkco
###################################################
if (length(ortx)>1) ortx = ortx[2]
ortss = end(ortx)
ortup50 = GRanges("chr17", IRanges(ortss, width=50000))
cv50k = countVariants(rv17, ortup50, 160, lapply )


###################################################
### code chunk number 10: lkcnt
###################################################
cv50k


###################################################
### code chunk number 11: drops
###################################################
if (length(sampleNames(rv17))==12) rv17 = rv17[,-2]
if (length(sampleNames(CY17))==12) CY17 = CY17[,-2]
#redo


###################################################
### code chunk number 12: doagain
###################################################
cv50k = countVariants(rv17, ortup50, 160, lapply )


###################################################
### code chunk number 13: lkv
###################################################
vv50k = variantGRanges( rv17, ortup50, 160, lapply )


###################################################
### code chunk number 14: domolk
###################################################
vv50k[[1]][1:5]
sapply(vv50k,length)


###################################################
### code chunk number 15: lkdis
###################################################
ORMDL3ex = as.numeric(exprs(CY17[genesym("ORMDL3"),]))
ygr = ifelse((1:11)<=4, "red", "green")
plot(ORMDL3ex~cv50k, col=ygr, pch=19, 
      ylab="variant count from 50kb upstream to TSS")
legend(10, 8.5, pch=19, col=c("red", "green"), legend=c("CEU", "YRI"))
summary(lm(ORMDL3ex~cv50k*factor(ygr)))


###################################################
### code chunk number 16: purerng
###################################################
library(parallel)
options(mc.cores=max(c(2, parallel::detectCores()-2)))
vv = variantGRanges( rv17, ortx, 160, mclapply )
vvv = lapply(vv, function(x) renameSeqlevels(x, c("17"="chr17")))
mycache = new.env(hash=TRUE)
locs = lapply(vvv, function(x) {
  locateVariants(x, tx19, CodingVariants(),cache=mycache)
})


