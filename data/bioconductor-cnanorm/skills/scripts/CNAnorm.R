# Code example from 'CNAnorm' vignette. See references/ for full tutorial.

### R code from vignette source 'CNAnorm.Snw'

###################################################
### code chunk number 1: CNAnorm.Snw:31-35
###################################################
library(CNAnorm)
data(LS041)
# show the data
LS041[1:5,]


###################################################
### code chunk number 2: CNAnorm.Snw:50-53
###################################################
# set a seed for reproducible comparison
set.seed(31)
CN <- dataFrame2object(LS041)


###################################################
### code chunk number 3: CNAnorm.Snw:67-69
###################################################
toSkip <- c("chrY", "chrM")
CN <- gcNorm(CN, exclude=toSkip)


###################################################
### code chunk number 4: CNAnorm.Snw:78-79
###################################################
CN <- addSmooth(CN, lambda=7)


###################################################
### code chunk number 5: CNAnorm.Snw:84-85
###################################################
CN <- peakPloidy(CN, exclude=toSkip, method='closest')


###################################################
### code chunk number 6: CNAnorm.Snw:99-100
###################################################
plotPeaks(CN)


###################################################
### code chunk number 7: CNAnorm.Snw:110-113
###################################################
CN <- validation(CN)
CN <- addDNACopy(CN)
CN <- discreteNorm(CN)


###################################################
### code chunk number 8: CNAnorm.Snw:119-124
###################################################
# re-set seed for reproducible results
set.seed(31)
CNauto <- CNAnormWorkflow(LS041, gc.do=TRUE, gc.exclude=toSkip, 
    peak.exclude=toSkip)
identical(CN, CNauto)


###################################################
### code chunk number 9: CNAnorm.Snw:131-132
###################################################
plotGenome(CN, superimpose='DNACopy', show.centromeres=FALSE)


###################################################
### code chunk number 10: CNAnorm.Snw:141-144
###################################################
toPlot <- c('chr10', 'chr11', 'chr12')
subSet <- chrs(CN) %in% toPlot
plotGenome(CN[subSet], superimpose='DNACopy')


###################################################
### code chunk number 11: CNAnorm.Snw:153-160
###################################################
data(gPar)
gPar$genome$colors$gain.dot <- 'darkorange'
gPar$genome$colors$grid <- NULL
gPar$genome$cex$gain.dot <- .4
gPar$genome$cex$loss.dot <- .4
plotGenome(CN[subSet], superimpose='DNACopy', gPar=gPar, 
    colorful=TRUE)


###################################################
### code chunk number 12: CNAnorm.Snw:165-166
###################################################
exportTable(CN, file = "CNAnorm_table.tab", show = 'center')


###################################################
### code chunk number 13: CNAnorm.Snw:181-183
###################################################
CN <- peakPloidy(CN, exclude=toSkip, method='density')
plotPeaks(CN)


###################################################
### code chunk number 14: CNAnorm.Snw:203-210
###################################################
CN <- validation(CN)
data(hg19_hs_ideogr)
CN <- addDNACopy(CN, DNAcopy.weight='poisson', 
    DNAcopy.segment=list(alpha=0.001), independent.arms=TRUE, 
    ideograms=hg19_hs_ideogr)
CN <- discreteNorm(CN)
plotGenome(CN, superimpose='DNACopy')


###################################################
### code chunk number 15: CNAnorm.Snw:225-227
###################################################
CN <- validation(CN, ploidy = (sugg.ploidy(CN) - 1))
plotPeaks(CN, show='validated')


###################################################
### code chunk number 16: CNAnorm.Snw:235-237
###################################################
CN <- discreteNorm(CN)
plotGenome(CN, superimpose='DNACopy')


