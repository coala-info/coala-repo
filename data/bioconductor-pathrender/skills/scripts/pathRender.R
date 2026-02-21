# Code example from 'pathRender' vignette. See references/ for full tutorial.

### R code from vignette source 'pathRender.Rnw'

###################################################
### code chunk number 1: do1
###################################################
library(pathRender)
plot(G1 <- graphcMAP("p53pathway"))
G1
nodes(G1)[1:5]


###################################################
### code chunk number 2: do2
###################################################
plot(G2 <- graphcMAP("raspathway"))


