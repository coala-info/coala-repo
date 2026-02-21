# Code example from 'ceu1kg' vignette. See references/ for full tutorial.

### R code from vignette source 'ceu1kg.Rnw'

###################################################
### code chunk number 1: lkd
###################################################
library(ceu1kg)
dir(system.file("parts", package="ceu1kg"))
lk = load(dir(system.file("parts", package="ceu1kg"),full=TRUE)[1])
c1gt = get(lk)
c1gt


###################################################
### code chunk number 2: lkm
###################################################
library(SNPlocs.Hsapiens.dbSNP.20101109)
if (!exists("c1loc")) c1loc = getSNPlocs("ch1", as.GRanges=TRUE)
c1loc
rsn1 = paste("rs", elementMetadata(c1loc)$RefSNP_id, sep="")
length(intersect(rsn1, colnames(c1gt)))
ext1 = grep("chr", colnames(c1gt))
ext1 = as.numeric(gsub("chr1:", "", colnames(c1gt)[ext1]))
length(intersect(ext1, start(c1loc)))


###################################################
### code chunk number 3: lkg (eval = FALSE)
###################################################
## c20 = getSS("ceu1kg", "chr20")
## c20


###################################################
### code chunk number 4: dodo
###################################################
data(eset) # assume ceu1kg is first in line, yields ex in global
c1m = c1gt[sampleNames(ex),]
c1ss = make_smlSet( ex, list(chr1=c1m) )
c1ss


###################################################
### code chunk number 5: lks
###################################################
sessionInfo()


