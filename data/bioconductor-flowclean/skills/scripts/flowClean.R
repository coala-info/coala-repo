# Code example from 'flowClean' vignette. See references/ for full tutorial.

### R code from vignette source 'flowClean.Rnw'

###################################################
### code chunk number 1: flowClean.Rnw:9-10
###################################################
options(width=70)


###################################################
### code chunk number 2: load
###################################################
library(flowClean)
library(flowViz)
library(grid)
library(gridExtra)


###################################################
### code chunk number 3: data1
###################################################
data(synPerturbed)
synPerturbed


###################################################
### code chunk number 4: cleancall
###################################################
synPerturbed.c <- clean(synPerturbed, vectMarkers=c(5:16), 
                   filePrefixWithDir="sample_out", ext="fcs", diagnostic=TRUE)
synPerturbed.c


###################################################
### code chunk number 5: fig1plot
###################################################
lgcl <- estimateLogicle(synPerturbed.c, unname(parameters(synPerturbed.c)$name[5:16]))
synPerturbed.cl <- transform(synPerturbed.c, lgcl)
p1 <- xyplot(`<V705-A>` ~ `Time`, data=synPerturbed.cl, 
             abs=TRUE, smooth=FALSE, alpha=0.5, xlim=c(0, 100))
p2 <- xyplot(`GoodVsBad` ~ `Time`, data=synPerturbed.cl, 
             abs=TRUE, smooth=FALSE, alpha=0.5, xlim=c(0, 100), ylim=c(0, 20000))
rg <- rectangleGate(filterId="gvb", list("GoodVsBad"=c(0, 9999)))
idx <- filter(synPerturbed.cl, rg)
synPerturbed.clean <- Subset(synPerturbed.cl, idx)
p3 <- xyplot(`<V705-A>` ~ `Time`, data=synPerturbed.clean,
             abs=TRUE, smooth=FALSE, alpha=0.5, xlim=c(0, 100))
grid.arrange(p1, p2, p3, ncol=3)


###################################################
### code chunk number 6: fig1
###################################################
lgcl <- estimateLogicle(synPerturbed.c, unname(parameters(synPerturbed.c)$name[5:16]))
synPerturbed.cl <- transform(synPerturbed.c, lgcl)
p1 <- xyplot(`<V705-A>` ~ `Time`, data=synPerturbed.cl, 
             abs=TRUE, smooth=FALSE, alpha=0.5, xlim=c(0, 100))
p2 <- xyplot(`GoodVsBad` ~ `Time`, data=synPerturbed.cl, 
             abs=TRUE, smooth=FALSE, alpha=0.5, xlim=c(0, 100), ylim=c(0, 20000))
rg <- rectangleGate(filterId="gvb", list("GoodVsBad"=c(0, 9999)))
idx <- filter(synPerturbed.cl, rg)
synPerturbed.clean <- Subset(synPerturbed.cl, idx)
p3 <- xyplot(`<V705-A>` ~ `Time`, data=synPerturbed.clean,
             abs=TRUE, smooth=FALSE, alpha=0.5, xlim=c(0, 100))
grid.arrange(p1, p2, p3, ncol=3)


###################################################
### code chunk number 7: sessionInfo
###################################################
toLatex(sessionInfo())


