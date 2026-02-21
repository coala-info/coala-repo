# Code example from 'CGHregions' vignette. See references/ for full tutorial.

### R code from vignette source 'CGHregions.Rnw'

###################################################
### code chunk number 1: CGHregions.Rnw:48-51
###################################################
library(CGHregions)
data(WiltingCalled)
WiltingCalled


###################################################
### code chunk number 2: CGHregions.Rnw:57-59
###################################################
regions <- CGHregions(WiltingCalled, averror=0.01)
regions


###################################################
### code chunk number 3: CGHregions.Rnw:67-68
###################################################
plot(regions)


