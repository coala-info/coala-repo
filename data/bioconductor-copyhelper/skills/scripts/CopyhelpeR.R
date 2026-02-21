# Code example from 'CopyhelpeR' vignette. See references/ for full tutorial.

### R code from vignette source 'CopyhelpeR.Rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: getPathHelperFiles
###################################################
library(CopyhelpeR)
getPathHelperFiles("hg19")


###################################################
### code chunk number 3: getPathHelperFiles2
###################################################
cat(CopyhelpeR:::.wrap(getPathHelperFiles("hg19")))


