# Code example from 'DSS' vignette. See references/ for full tutorial.

## ----message=FALSE------------------------------------------------------------
library(DSS)
counts1 = matrix(rnbinom(300, mu=10, size=10), ncol=3)
counts2 = matrix(rnbinom(300, mu=50, size=10), ncol=3)
X1 = cbind(counts1, counts2)
X2 = matrix(rnbinom(11400, mu=10, size=10), ncol=6)
X = rbind(X1,X2)  ## these are 100 DE genes
designs = c(0,0,0,1,1,1)
seqData = newSeqCountSet(X, designs)
seqData

## -----------------------------------------------------------------------------
seqData = estNormFactors(seqData)

## -----------------------------------------------------------------------------
seqData = estDispersion(seqData)

## -----------------------------------------------------------------------------
result=waldTest(seqData, 0, 1)
head(result,5)

## -----------------------------------------------------------------------------
counts = matrix(rpois(600, 10), ncol=6)
designs = c(0,0,0,1,1,1)
result = DSS.DE(counts, designs)
head(result)

## ----message=FALSE------------------------------------------------------------
library(DSS)
library(edgeR)
counts = matrix(rpois(800, 10), ncol=8)
design = data.frame(gender=c(rep("M",4), rep("F",4)), 
                    strain=rep(c("WT", "Mutant"),4))
X = model.matrix(~gender+strain, data=design)

## -----------------------------------------------------------------------------
seqData = newSeqCountSet(counts, as.data.frame(X))
seqData = estNormFactors(seqData)
seqData = estDispersion(seqData)

## -----------------------------------------------------------------------------
fit.edgeR = glmFit(counts, X, dispersion=dispersion(seqData))

## -----------------------------------------------------------------------------
lrt.edgeR = glmLRT(glmfit=fit.edgeR, coef=2)
head(lrt.edgeR$table)

## -----------------------------------------------------------------------------
library(DSS)
require(bsseq)
path = file.path(system.file(package="DSS"), "extdata")
dat1.1 = read.table(file.path(path, "cond1_1.txt"), header=TRUE)
dat1.2 = read.table(file.path(path, "cond1_2.txt"), header=TRUE)
dat2.1 = read.table(file.path(path, "cond2_1.txt"), header=TRUE)
dat2.2 = read.table(file.path(path, "cond2_2.txt"), header=TRUE)
BSobj = makeBSseqData( list(dat1.1, dat1.2, dat2.1, dat2.2),
     c("C1","C2", "N1", "N2") )[1:1000,]
BSobj

## ----results=FALSE, eval=FALSE------------------------------------------------
# dmlTest = DMLtest(BSobj, group1=c("C1", "C2"), group2=c("N1", "N2"))

## ----results=FALSE, eval=FALSE------------------------------------------------
# dmlTest.sm = DMLtest(BSobj, group1=c("C1", "C2"), group2=c("N1", "N2"),
#                      smoothing=TRUE)

## ----echo=FALSE, result=FALSE, include=FALSE, prompt=FALSE--------------------
  dmlTest = DMLtest(BSobj, group1=c("C1", "C2"), group2=c("N1", "N2"),
                    ncores=1)

## -----------------------------------------------------------------------------
  dmls = callDML(dmlTest, p.threshold=0.001)
  head(dmls)

## -----------------------------------------------------------------------------
  dmls2 = callDML(dmlTest, delta=0.1, p.threshold=0.001)
  head(dmls2)

## -----------------------------------------------------------------------------
dmrs = callDMR(dmlTest, p.threshold=0.01)
head(dmrs)

## -----------------------------------------------------------------------------
  dmrs2 = callDMR(dmlTest, delta=0.1, p.threshold=0.05)
  head(dmrs2)

## ----eval=FALSE---------------------------------------------------------------
#   showOneDMR(dmrs[1,], BSobj)

## -----------------------------------------------------------------------------
Strain = rep(c("A", "B", "C"), 4)
Sex = rep(c("M", "F"), each=6)
design = data.frame(Strain,Sex)
design

## -----------------------------------------------------------------------------
X = model.matrix(~Strain+ Sex, design)
X

## -----------------------------------------------------------------------------
L = cbind(c(0,1,0,0),c(0,0,1,0))
L

## -----------------------------------------------------------------------------
matrix(c(0,1,-1,0), ncol=1)

## -----------------------------------------------------------------------------
data(RRBS)
RRBS
design

## -----------------------------------------------------------------------------
DMLfit = DMLfit.multiFactor(RRBS, design=design, formula=~case+cell+case:cell)

## -----------------------------------------------------------------------------
DMLtest.cell = DMLtest.multiFactor(DMLfit, coef=3)

## -----------------------------------------------------------------------------
colnames(DMLfit$X)

## -----------------------------------------------------------------------------
DMLtest.cell = DMLtest.multiFactor(DMLfit, coef="cellrN")

## -----------------------------------------------------------------------------
ix=sort(DMLtest.cell[,"pvals"], index.return=TRUE)$ix
head(DMLtest.cell[ix,])

## -----------------------------------------------------------------------------
callDMR(DMLtest.cell, p.threshold=0.05)

## -----------------------------------------------------------------------------
## fit a model with additive effect only
DMLfit = DMLfit.multiFactor(RRBS, design, ~case+cell)
## test case effect
test1 = DMLtest.multiFactor(DMLfit, coef=2)
test2 = DMLtest.multiFactor(DMLfit, coef="caseSLE")
test3 = DMLtest.multiFactor(DMLfit, term="case")
Contrast = matrix(c(0,1,0), ncol=1)
test4 = DMLtest.multiFactor(DMLfit, Contrast=Contrast)
cor(cbind(test1$pval, test2$pval, test3$pval, test4$pval))

## -----------------------------------------------------------------------------
Treatment = factor(rep(c("Control","Treated"), 3))
pair = factor( rep(1:3, each=2) )
design = data.frame(Treatment, pair)
design

## ----eval=FALSE---------------------------------------------------------------
# BSobj=RRBS[,1:6]
# DMLfit = DMLfit.multiFactor(BSobj, design, formula = ~ Treatment + pair)
# dmlTest = DMLtest.multiFactor(DMLfit, term="Treatment")

## -----------------------------------------------------------------------------
sessionInfo()

