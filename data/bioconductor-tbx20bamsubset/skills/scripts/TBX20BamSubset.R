# Code example from 'TBX20BamSubset' vignette. See references/ for full tutorial.

### R code from vignette source 'TBX20BamSubset.Rnw'

###################################################
### code chunk number 1: TBX20BamSubset.Rnw:54-59
###################################################
library("TBX20BamSubset")
fn <- system.file("extdata", "phenoData.txt", 
                  package="TBX20BamSubset")
pd <- read.table(fn, header=TRUE,
                 stringsAsFactors=FALSE)


###################################################
### code chunk number 2: TBX20BamSubset.Rnw:63-66
###################################################
library(xtable)
pd <- xtable(pd, caption="Design of the TBX20 experiment")
print(pd)


###################################################
### code chunk number 3: TBX20BamSubset.Rnw:71-74
###################################################
library("Rsamtools")
fls <- getBamFileList()
bfs <- BamFileList(fls)


###################################################
### code chunk number 4: SessionInfo
###################################################
sessionInfo()


