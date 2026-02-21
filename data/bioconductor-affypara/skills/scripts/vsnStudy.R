# Code example from 'vsnStudy' vignette. See references/ for full tutorial.

### R code from vignette source 'vsnStudy.Rnw'

###################################################
### code chunk number 1: vsnStudy.Rnw:78-80 (eval = FALSE)
###################################################
## library(ArrayExpress)
## getAE(c('E-GEOD-11121','E-GEOD-12093'), extract=FALSE)


###################################################
### code chunk number 2: vsnStudy.Rnw:86-91 (eval = FALSE)
###################################################
## library(arrayQualityMetrics)
## celDir <- 'PATH'
## celf <- list.celfiles(celDir, full.names=T)
## ab <- read.affybatch(celf)
## arrayQualityMetrics(ab, outdir='QA')


###################################################
### code chunk number 3: vsnStudy.Rnw:124-127 (eval = FALSE)
###################################################
## library(vsn)
## fit <- vsn2(ab, subsample=100000)
## x <- predict(fit, newdata=ab)


###################################################
### code chunk number 4: vsnStudy.Rnw:180-186 (eval = FALSE)
###################################################
## set.seed(1234)
## fit_ref <- vsn2(ab[,1:20])
## fit_add1 <- vsn2(ab[,21:40], reference=fit_ref)
## fit_add2 <- vsn2(ab[,41:60], reference=fit_ref)
## set.seed(1234)
## fit_comp <- vsn2(ab)


