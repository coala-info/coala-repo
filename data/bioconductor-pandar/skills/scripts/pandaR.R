# Code example from 'pandaR' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(pandaR)
data(pandaToyData)

## -----------------------------------------------------------------------------
pandaResult <- panda(pandaToyData$motif, pandaToyData$expression, pandaToyData$ppi)
pandaResult

## -----------------------------------------------------------------------------
topNet <- topedges(pandaResult, 1000)

## -----------------------------------------------------------------------------
targetedGenes(topNet, c("AR"))

## -----------------------------------------------------------------------------
topSubnet <- subnetwork(topNet, c("AR","ARID3A","ELK1"))

## -----------------------------------------------------------------------------
plotGraph(topSubnet)

## ----plotZ--------------------------------------------------------------------
panda.res1 <- with(pandaToyData, panda(motif, expression, ppi, hamming=1))
panda.res2 <- with(pandaToyData, panda(motif, expression + 
                   rnorm(prod(dim(expression)),sd=5), ppi, hamming=1))
plotZ(panda.res1, panda.res2,addLine=FALSE)

## -----------------------------------------------------------------------------
sessionInfo()

