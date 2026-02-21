# Code example from 'genotyping' vignette. See references/ for full tutorial.

### R code from vignette source 'genotyping.Rnw'

###################################################
### code chunk number 1: setup
###################################################
options(width=60)
options(continue=" ")
options(prompt="R> ")


###################################################
### code chunk number 2: crlmm
###################################################
require(oligoClasses)
library(crlmm)
library(hapmapsnp6)
path <- system.file("celFiles", package="hapmapsnp6")
celFiles <- list.celfiles(path, full.names=TRUE)
system.time(crlmmResult <- crlmm(celFiles, verbose=FALSE))


###################################################
### code chunk number 3: out
###################################################
calls(crlmmResult)[1:10,]
confs(crlmmResult)[1:10,]
crlmmResult[["SNR"]]


###################################################
### code chunk number 4: genotyping.Rnw:81-82
###################################################
sessionInfo()


