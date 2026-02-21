# Code example from 'sizepower' vignette. See references/ for full tutorial.

### R code from vignette source 'sizepower.Rnw'

###################################################
### code chunk number 1: R.hide
###################################################
library(sizepower)


###################################################
### code chunk number 2: sizepower.Rnw:375-376
###################################################
sampleSize.randomized(ER0=1, G0=2000, power=0.9, absMu1=1, sigmad=0.566)


###################################################
### code chunk number 3: sizepower.Rnw:385-386
###################################################
power.randomized(ER0=1, G0=2000, absMu1=1, sigmad=0.566, n=8)


###################################################
### code chunk number 4: sizepower.Rnw:398-399
###################################################
sampleSize.matched(ER0=1, G0=2000, power=0.9, absMu1=1, sigmad=0.495)


###################################################
### code chunk number 5: sizepower.Rnw:404-405
###################################################
power.matched(ER0=1, G0=2000, absMu1=1, sigmad=0.495, n=6)


###################################################
### code chunk number 6: sizepower.Rnw:418-419
###################################################
power.multi(ER0=1, G0=2000, numTrt=5, absMu1=1, sigma=0.4, n=6)


###################################################
### code chunk number 7: sizepower.Rnw:426-427
###################################################
power.multi(ER0=1, G0=5000, numTrt=6, absMu1=0.9, sigma=0.5, n=9)


