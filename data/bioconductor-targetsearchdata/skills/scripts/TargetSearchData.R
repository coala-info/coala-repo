# Code example from 'TargetSearchData' vignette. See references/ for full tutorial.

### R code from vignette source 'TargetSearchData.Rnw'

###################################################
### code chunk number 1: options
###################################################
require(TargetSearchData)
options(width=80)


###################################################
### code chunk number 2: f1
###################################################
path <- tsd_path()
path


###################################################
### code chunk number 3: f2
###################################################
path <- tsd_data_path()
dir(path)


###################################################
### code chunk number 4: f3
###################################################
tsd_file_path(c('samples.txt','library.txt'))


###################################################
### code chunk number 5: f4
###################################################
cdf <- tsd_cdffiles()
ri <- tsd_rifiles()


###################################################
### code chunk number 6: sessionInfo
###################################################
sessionInfo()


