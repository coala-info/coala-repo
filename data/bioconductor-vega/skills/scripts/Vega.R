# Code example from 'Vega' vignette. See references/ for full tutorial.

### R code from vignette source 'Vega.Rnw'

###################################################
### code chunk number 1: loadVega
###################################################
library(Vega)


###################################################
### code chunk number 2: loadG519Data
###################################################
data(G519)


###################################################
### code chunk number 3: printG519Data
###################################################
G519[1:16,]


###################################################
### code chunk number 4: runVegaWithSexChromosomes
###################################################
seg <- vega(CNVdata=G519, chromosomes=c(1:22,"X","Y"))


###################################################
### code chunk number 5: runVegaChromosomes_1_and_X
###################################################
seg_1X <- vega(CNVdata=G519, chromosomes=c(1,"X"))


###################################################
### code chunk number 6: printResults
###################################################
seg[1:5,]


###################################################
### code chunk number 7: plotAllChromosomes_LRR
###################################################
plotSegmentation(G519, seg, chromosomes=c(1:22,"X","Y"), opt=0)


###################################################
### code chunk number 8: PlotChromosome1_LRR
###################################################
plotSegmentation(G519, seg, chromosomes=c(1), opt=0)


###################################################
### code chunk number 9: PlotChromosome1_Label
###################################################
plotSegmentation(G519, seg, chromosomes=c(1), opt=1)


