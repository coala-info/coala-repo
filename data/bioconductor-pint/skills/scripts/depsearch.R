# Code example from 'depsearch' vignette. See references/ for full tutorial.

### R code from vignette source 'depsearch.Rnw'

###################################################
### code chunk number 1: depsearch.Rnw:81-83
###################################################
library(pint)
data(chromosome17)


###################################################
### code chunk number 2: depsearch.Rnw:116-117
###################################################
models <- screen.cgh.mrna(geneExp, geneCopyNum, windowSize = 10, chr = 17, arm = 'q')


###################################################
### code chunk number 3: depsearch.Rnw:150-151
###################################################
plot(models, showTop = 10)


###################################################
### code chunk number 4: depsearch.Rnw:165-166
###################################################
topGenes(models, 5)


###################################################
### code chunk number 5: depsearch.Rnw:185-187
###################################################
model <- topModels(models)
plot(model, geneExp, geneCopyNum)


###################################################
### code chunk number 6: details
###################################################
sessionInfo()             


