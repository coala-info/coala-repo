# Code example from 'SCLCBam' vignette. See references/ for full tutorial.

### R code from vignette source 'SCLCBam.Rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: getPathBamFolder
###################################################
library(SCLCBam)
getPathBamFolder()


###################################################
### code chunk number 3: getPathBamFolder
###################################################
library(SCLCBam)
cat(SCLCBam:::.wrap(getPathBamFolder()))


