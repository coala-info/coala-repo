# Code example from 'weaver_howTo' vignette. See references/ for full tutorial.

### R code from vignette source 'weaver_howTo.Rnw'

###################################################
### code chunk number 1: basicProc
###################################################
library("weaver")
testDocPath <- system.file("extdata/doc1.Rnw", package="weaver")
curDir <- getwd()
setwd(tempdir())
z <- capture.output(Sweave(testDocPath, driver=weaver()), 
                    file=tempfile())
setwd(curDir)


###################################################
### code chunk number 2: another
###################################################
testDocPath <- system.file("extdata/doc2.Rnw", package="weaver")
curDir <- getwd()
setwd(tempdir())
z <- capture.output(Sweave(testDocPath, driver=weaver()), 
                    file=tempfile())
setwd(curDir)


###################################################
### code chunk number 3: again
###################################################
testDocPath <- system.file("extdata/doc1.Rnw", package="weaver")
curDir <- getwd()
setwd(tempdir())
z <- capture.output(Sweave(testDocPath, driver=weaver()), 
                    file=tempfile())
setwd(curDir)


###################################################
### code chunk number 4: sessionInfo
###################################################
toLatex(sessionInfo())


