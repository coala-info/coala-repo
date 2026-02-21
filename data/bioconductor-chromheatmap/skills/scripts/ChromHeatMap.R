# Code example from 'ChromHeatMap' vignette. See references/ for full tutorial.

### R code from vignette source 'ChromHeatMap.Rnw'

###################################################
### code chunk number 1: ChromHeatMap.Rnw:57-64
###################################################
library('ALL')
data('ALL')
selSamples <- ALL$mol.biol %in% c('ALL1/AF4', 'E2A/PBX1')
ALLs <- ALL[, selSamples]

library('ChromHeatMap')
chrdata<-makeChrStrandData(exprs(ALLs), lib='hgu95av2')


###################################################
### code chunk number 2: ChromHeatMap.Rnw:87-89
###################################################
groupcol <- ifelse( ALLs$mol.biol == 'ALL1/AF4', 'red', 'green' )
plotChrMap(chrdata, 19, strands='both', RowSideColors=groupcol)


###################################################
### code chunk number 3: ChromHeatMap.Rnw:98-99
###################################################
plotmap<-plotChrMap(chrdata, 1, cytoband='q23', interval=50000, srtCyto=0, cexCyto=1.2)


###################################################
### code chunk number 4: ChromHeatMap.Rnw:135-137 (eval = FALSE)
###################################################
## probes <- grabChrMapProbes( plotmap )
## genes <- unlist(mget(probes, envir=hgu95av2SYMBOL, ifnotfound=NA))


###################################################
### code chunk number 5: ChromHeatMap.Rnw:156-157
###################################################
sessionInfo()


