# Code example from 'MPFE' vignette. See references/ for full tutorial.

### R code from vignette source 'MPFE.Rnw'

###################################################
### code chunk number 1: MPFE.Rnw:52-56
###################################################
library(MPFE)
data(patternsExample)
patternsExample
estimatePatterns(patternsExample, epsilon=0.01, column=2)


###################################################
### code chunk number 2: MPFE.Rnw:66-70
###################################################
estimates <- estimatePatterns(patternsExample,
                              epsilon=0.01,
                              eta=c(0.008, 0.01, 0.01, 0.01, 0.008))
estimates


###################################################
### code chunk number 3: MPFE.Rnw:79-80
###################################################
plotPatterns(estimates[[2]])


###################################################
### code chunk number 4: MPFE.Rnw:89-109
###################################################
par(mfrow=c(2, 2))
patternMap(estimates[[1]],
           maxFreq=0.5,
           main='Estimated frequencies')
patternMap(estimates[[1]],
           estimatedDistribution=FALSE,
           maxFreq=0.5,
           topDown=FALSE,
           main='Observed frequencies')
patternMap(estimates[[1]],
           maxFreq=0.5,
           methCol=colorRampPalette(c('red', 'blue')),
           unMethCol='lightgrey',
           main='Estimated frequencies')
patternMap(estimates[[1]],
           estimatedDistribution=FALSE,
           maxFreq=0.5,
           methCol=c('bisque4', 'azure4'),
           unMethCol=c('beige', 'azure'),
           main='Observed frequencies')


