# Code example from 'pvac' vignette. See references/ for full tutorial.

### R code from vignette source 'pvac.Rnw'

###################################################
### code chunk number 1: install (eval = FALSE)
###################################################
##   if (!requireNamespace("BiocManager", quietly=TRUE))
##       install.packages("BiocManager")
##   BiocManager::install("pvac")


###################################################
### code chunk number 2: steps (eval = FALSE)
###################################################
##   library(affy)
##   abatch <- ReadAffy(celfile.path="/my/directory/celfiles")


###################################################
### code chunk number 3: steps (eval = FALSE)
###################################################
##   myeset <- rma(abatch)


###################################################
### code chunk number 4: steps (eval = FALSE)
###################################################
##   library(pvac)
##   ft <- pvacFilter(abatch)
##   myeset <- eset[ft$aset,]


###################################################
### code chunk number 5: <steps (eval = FALSE)
###################################################
##   library(genefilter)
##   myres  = rowttests(exprs(myeset), as.factor(group))


###################################################
### code chunk number 6: example
###################################################
library(affy)
library(pvac)
library(ALLMLL)
data(MLL.A)
myeset <- rma(MLL.A)
ft <- pvacFilter(MLL.A)
myeset.filtered <- myeset[ft$aset,]


###################################################
### code chunk number 7: plot (eval = FALSE)
###################################################
## plot(density(ft$pvac[ft$nullset]),xlab="PVAC score",main="",
##           col="gray",cex.lab=0.5,xlim=c(0,1))
## lines(density(ft$pvac),col=1)
## abline(v=ft$cutoff,lty=2,col="gray")


###################################################
### code chunk number 8: <
###################################################
  print(sessionInfo())


