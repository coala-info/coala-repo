# Code example from 'aracne.networks' vignette. See references/ for full tutorial.

### R code from vignette source 'aracne.networks.Rnw'

###################################################
### code chunk number 1: aracne.networks.Rnw:21-22
###################################################
library(aracne.networks)


###################################################
### code chunk number 2: aracne.networks.Rnw:37-39
###################################################
library(aracne.networks)
data(package="aracne.networks")$results[, "Item"]


###################################################
### code chunk number 3: aracne.networks.Rnw:47-49
###################################################
data(regulonblca)
write.regulon(regulonblca, n = 10)


###################################################
### code chunk number 4: aracne.networks.Rnw:52-54
###################################################
data(regulonblca)
write.regulon(regulonblca, regulator="399")


