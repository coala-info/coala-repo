# Code example from 'GateFinder' vignette. See references/ for full tutorial.

### R code from vignette source 'GateFinder.Rnw'

###################################################
### code chunk number 1: c1
###################################################
library(GateFinder)
library(flowCore)

data(LPSData)
targetpop <- (exprs(rawdata)[,34] > 3.5)
plot(exprs(rawdata)[ , c(2,34)], pch='.', col=targetpop+1, 
     xlab='Cell Length', ylab='p-p38')
abline(h=3.5, col=3, lwd=2, lty=2)


###################################################
### code chunk number 2: c12
###################################################
x=exprs(rawdata)[ , prop.markers]
colnames(x)=marker.names[prop.markers]
results=GateFinder(x, targetpop)


###################################################
### code chunk number 3: c13
###################################################
plot (x, results, c(2,3), targetpop)


###################################################
### code chunk number 4: c14
###################################################
plot(results)


###################################################
### code chunk number 5: c2
###################################################
results=GateFinder(x, targetpop, outlier.percentile=0.5)     
plot (x, results, c(2,3), targetpop)
plot(results)


###################################################
### code chunk number 6: c21
###################################################
results=GateFinder(x, targetpop, beta=0.5)     
plot (x, results, c(2,3), targetpop)
plot(results)


