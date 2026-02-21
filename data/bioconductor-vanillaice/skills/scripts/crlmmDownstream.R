# Code example from 'crlmmDownstream' vignette. See references/ for full tutorial.

### R code from vignette source 'crlmmDownstream.Rnw'

###################################################
### code chunk number 1: loadData
###################################################
library(oligoClasses)
library(VanillaICE)
library(crlmm)
library(IRanges)
library(foreach)


###################################################
### code chunk number 2: data
###################################################
data(cnSetExample, package="crlmm")


###################################################
### code chunk number 3: parse_cnSet
###################################################
se <- as(cnSetExample, "SnpArrayExperiment")


###################################################
### code chunk number 4: windowselection (eval = FALSE)
###################################################
## library(ArrayTV)
## i <- seq_len(ncol(se))
## increms <- c(10,1000,100e3)
## wins <- c(100,10e3,1e6)
## res <- gcCorrect(lrr(se),
##                  increms=increms,
##                  maxwins=wins,
##                  returnOnlyTV=FALSE,
##                  verbose=TRUE,
##                  build="hg18",
##                  chr=chromosome(se),
##                  starts=start(se))
## se2 <- se
## assays(se2)[["cn"]] <- res$correctedVals


###################################################
### code chunk number 5: loesscorrection
###################################################
## TODO: correct for GC bias by loess
se2 <- se


###################################################
### code chunk number 6: hmm
###################################################
res <- hmm2(se2)


###################################################
### code chunk number 7: crlmmDownstream.Rnw:116-117
###################################################
toLatex(sessionInfo())


