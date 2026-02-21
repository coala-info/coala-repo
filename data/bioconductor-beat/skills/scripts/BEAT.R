# Code example from 'BEAT' vignette. See references/ for full tutorial.

### R code from vignette source 'BEAT.Rnw'

###################################################
### code chunk number 1: showInput
###################################################
library(BEAT)
localpath <- system.file('extdata', package = 'BEAT')
positions <- read.csv(file.path(localpath, "sample.positions.csv"))
head(positions)


###################################################
### code chunk number 2: setFilepath
###################################################
sampNames <- c('reference','sample')
sampNames
is.reference <- c(TRUE, FALSE)


###################################################
### code chunk number 3: setSampleData
###################################################
pplus <- c(0.2, 0.5)
convrates <- 1 - pplus


###################################################
### code chunk number 4: setConfig
###################################################
params <- makeParams(localpath, sampNames, convrates,
is.reference, pminus = 0.2, regionSize = 10000, minCounts = 5)
params


###################################################
### code chunk number 5: doConvert
###################################################
positions_to_regions(params)


###################################################
### code chunk number 6: doModel
###################################################
generate_results(params)


###################################################
### code chunk number 7: doEpimutations
###################################################
epiCalls <- epimutation_calls(params)
head(epiCalls$methSites$singlecell,3)
head(epiCalls$demethSites$singlecell,3)


