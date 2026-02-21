# Code example from 'ecolitk' vignette. See references/ for full tutorial.

### R code from vignette source 'ecolitk.Rnw'

###################################################
### code chunk number 1: ecolitk.Rnw:58-59
###################################################
library(ecolitk)


###################################################
### code chunk number 2: ecolitk.Rnw:70-72
###################################################
data(ecoligenomeSYMBOL2AFFY)
data(ecoligenomeCHRLOC)


###################################################
### code chunk number 3: ecolitk.Rnw:81-87
###################################################
lac.i <- grep("^lac", ls(ecoligenomeSYMBOL2AFFY))
lac.symbol <- ls(ecoligenomeSYMBOL2AFFY)[lac.i]
lac.affy <- unlist(lapply(lac.symbol, get, envir=ecoligenomeSYMBOL2AFFY))

beg.end <- lapply(lac.affy, get, envir=ecoligenomeCHRLOC)
beg.end <- matrix(unlist(beg.end), nc=2, byrow=TRUE)


###################################################
### code chunk number 4: ecolitk.Rnw:92-126
###################################################
par(mfrow=c(2,2))
n <- 10
thetas <- rev(seq(0, 2 * pi, length=n))

rhos <- rev(seq(1, n) / n)

xy <- polar2xy(rhos, thetas)
colo <- heat.colors(n)

plot(0, 0, xlim=c(-2, 2), ylim=c(-2, 2), type="n")
for (i in 1:n)
  linesCircle(rhos[i]/2, xy$x[i], xy$y[i])

plot(0, 0, xlim=c(-2, 2), ylim=c(-2, 2), type="n")
for (i in 1:n)
  polygonDisk(rhos[i]/2, xy$x[i], xy$y[i], col=colo[i])

plot(0, 0, xlim=c(-2, 2), ylim=c(-2, 2), type="n", xlab="", ylab="")
for (i in 1:n)
  polygonArc(0, thetas[i],
             rhos[i]/2, rhos[i],
             center.x = xy$x[i], center.y = xy$y[i], col=colo[i])

plot(0, 0, xlim=c(-2, 2), ylim=c(-2, 2), type="n", xlab="", ylab="")
for (i in (1:n)[-1]) {
  linesCircle(rhos[i-1], col="gray", lty=2)
  polygonArc(thetas[i-1], thetas[i],
             rhos[i-1], rhos[i], col=colo[i],
             edges=20)
  arrowsArc(thetas[i-1], thetas[i],
             rhos[i] + 1, col=colo[i],
             edges=20)
}
  


###################################################
### code chunk number 5: ecolitk.Rnw:134-135
###################################################
cPlotCircle(main.inside = "E. coli - K12")


###################################################
### code chunk number 6: ecolitk.Rnw:146-152
###################################################
lac.o <- order(beg.end[, 1])

lac.i <- lac.i[lac.o]
lac.symbol <- lac.symbol[lac.o]
lac.affy <- lac.affy[lac.o]
beg.end <- beg.end[lac.o, ]


###################################################
### code chunk number 7: ecolitk.Rnw:156-158
###################################################
cPlotCircle(main.inside = "E. coli - K12", main = "lac genes")
polygonChrom(beg.end[, 1], beg.end[, 2], ecoli.len, 1, 1.4)


###################################################
### code chunk number 8: ecolitk.Rnw:162-166
###################################################
l <- data.frame(x=c(0.470, 0.48), y=c(0.87, 0.90))
cPlotCircle(xlim=range(l$x), ylim=range(l$y), main = "lac genes")
polygonChrom(beg.end[, 1], beg.end[, 2], ecoli.len, 1, 1.007, col=rainbow(4))
legend(0.47, 0.9, legend=lac.symbol, fill=rainbow(4))


###################################################
### code chunk number 9: ecolitk.Rnw:177-211
###################################################
library(Biobase)
data(ecoligenomeBNUM2STRAND)
data(ecoligenomeBNUM)
data(ecoligenomeBNUM2MULTIFUN)
data(ecoligenomeCHRLOC)

affyids <- ls(ecoligenomeCHRLOC)
affypos <- mget(affyids, ecoligenomeCHRLOC, ifnotfound=NA)
## 'unlist' as the mapping is one-to-one
bnums <- unlist(mget(affyids, ecoligenomeBNUM, ifnotfound=NA)) 
strands <- unlist(mget(bnums, ecoligenomeBNUM2STRAND, ifnotfound=NA))
##
multifun <- mget(bnums, ecoligenomeBNUM2MULTIFUN, ifnotfound=NA)

## select the entries in the categorie "1.6"
## ("Macromolecules (cellular constituent)  biosynthesis")
f <- function(x) {
  if (all(is.na(x)))
    return(FALSE)
  length(grep("^1\\.6", x) > 0)
}

is.selected <- unlist(lapply(multifun, f))
                              
cPlotCircle(main.inside="E.coli K12")
beg.end <- matrix(unlist(affypos), nc=2, byrow=TRUE)
## plot 'bnums'... strand +
good <- strands == ">" & is.selected
linesChrom(beg.end[good, 1], beg.end[good, 2],
             ecoli.len, 1.4, col="red", lwd=3)
## plot 'bnums'... strand -
good <- strands == "<" & is.selected
linesChrom(beg.end[good, 1], beg.end[good, 2],
           ecoli.len, 1.5, col="blue", lwd=3)


###################################################
### code chunk number 10: ecolitk.Rnw:280-289
###################################################
library(Biobase)
data(ecoligenome.operon)
data(ecoligenomeSYMBOL2AFFY)

tmp <- mget(ecoligenome.operon$gene.name,
         ecoligenomeSYMBOL2AFFY, ifnotfound=NA)
ecoligenome.operon$affyid <- unname(unlist(tmp))
# clean up NAs
ecoligenome.operon <- subset(ecoligenome.operon, !is.na(affyid))


###################################################
### code chunk number 11: ecolitk.Rnw:298-304
###################################################
attach(ecoligenome.operon)
affyoperons <- split(affyid, operon.name)
detach(ecoligenome.operon)

## a sample of 5 operons
affyoperons[18:22]


###################################################
### code chunk number 12: ecolitk.Rnw:308-309
###################################################
library(affy)


###################################################
### code chunk number 13: ecolitk.Rnw:313-316
###################################################
library(ecoliLeucine)

data(ecoliLeucine)


###################################################
### code chunk number 14: ecolitk.Rnw:320-321
###################################################
abatch.nqt <- normalize(ecoliLeucine, method="quantiles")


###################################################
### code chunk number 15: ecolitk.Rnw:325-333
###################################################
## the operon taken as an example:
names(affyoperons)[18]
#colnames(abatch.nqt@exprs) <- NULL
eset <- computeExprSet(abatch.nqt, 
                       pmcorrect.method="pmonly", 
                       summary.method="medianpolish", 
                       ids = affyoperons[[18]])



###################################################
### code chunk number 16: computeExprSetOperon
###################################################
operons.eset <- computeExprSet(abatch.nqt, 
                               pmcorrect.method="pmonly", 
                               summary.method="medianpolish", 
                               ids = unlist(affyoperons))



###################################################
### code chunk number 17: ecolitk.Rnw:348-365
###################################################
library(multtest)

my.ttest <- function(x, i, j) {
  pval <- t.test(x[i], x[j])$p.value
  return(pval)
}

is.lrpplus <- pData(operons.eset)$strain == "lrp+"
is.lrpmoins <- pData(operons.eset)$strain == "lrp-"

operons.ttest <- esApply(operons.eset, 1, my.ttest, is.lrpplus, is.lrpmoins)

## adjustment for multiple testing.
operons.ttest.adj <- mt.rawp2adjp(operons.ttest, "BY")$adjp

## flag whether or not the probeset can be considered differentially expressed
operons.diff.expr <- operons.ttest.adj < 0.01


###################################################
### code chunk number 18: ecolitk.Rnw:370-371
###################################################
operons.i <- split(seq(along=operons.ttest), ecoligenome.operon$operon.name)


