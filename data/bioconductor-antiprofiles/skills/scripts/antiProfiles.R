# Code example from 'antiProfiles' vignette. See references/ for full tutorial.

### R code from vignette source 'antiProfiles.Rnw'

###################################################
### code chunk number 1: options (eval = FALSE)
###################################################
## options(width=70)


###################################################
### code chunk number 2: libload
###################################################
# these are libraries used by this vignette
require(antiProfiles)
require(antiProfilesData)
require(RColorBrewer)


###################################################
### code chunk number 3: loaddata
###################################################
data(apColonData)
show(apColonData)

# look at sample types by experiment and status
table(apColonData$Status, apColonData$SubType, apColonData$ExperimentID)


###################################################
### code chunk number 4: dropadenomas
###################################################
drop=apColonData$SubType=="adenoma"
apColonData=apColonData[,!drop]


###################################################
### code chunk number 5: getstats
###################################################
trainSamples=pData(apColonData)$ExperimentID=="GSE4183"
colonStats=apStats(exprs(apColonData)[,trainSamples], 
                   pData(apColonData)$Status[trainSamples],minL=5)
head(getProbeStats(colonStats))


###################################################
### code chunk number 6: plotstat
###################################################
hist(getProbeStats(colonStats)$stat, nc=100, 
     main="Histogram of log variance ratio", xlab="log2 variance ratio")


###################################################
### code chunk number 7: buildap
###################################################
ap=buildAntiProfile(colonStats, tissueSpec=FALSE, sigsize=100)
show(ap)


###################################################
### code chunk number 8: plotscore
###################################################
counts=apCount(ap, exprs(apColonData)[,!trainSamples])
palette(brewer.pal(8,"Dark2"))

# plot in score order
o=order(counts)
dotchart(counts[o],col=pData(apColonData)$Status[!trainSamples][o]+1,
         labels="",pch=19,xlab="anti-profile score", 
         ylab="samples",cex=1.3)
legend("bottomright", legend=c("Cancer","Normal"),pch=19,col=2:1)


###################################################
### code chunk number 9: sessionInfo
###################################################
toLatex(sessionInfo())


