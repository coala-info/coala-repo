# Code example from 'sscore' vignette. See references/ for full tutorial.

### R code from vignette source 'sscore.Rnw'

###################################################
### code chunk number 1: sscore.Rnw:71-74
###################################################
library(sscore)
options(width=60)
library(affydata)


###################################################
### code chunk number 2: sscore.Rnw:97-104
###################################################
data(Dilution)  ## get the example data
## get the path to the package directory
pathname <- system.file("doc",package="sscore")
cel <- Dilution[,c(1,3)] 
## only need the first 2 samples per condition
SScore.basic <- SScore(cel,celfile.path=pathname,
SF=c(4.46,5.72),SDT=c(57.241,63.581),rm.extra=FALSE)


###################################################
### code chunk number 3: sscore.Rnw:109-110
###################################################
exprs(SScore.basic)[1:20]


###################################################
### code chunk number 4: sscore.Rnw:216-217
###################################################
labels <- c(0,0,0,1,1,1)


###################################################
### code chunk number 5: sscore.Rnw:227-233
###################################################
data(Dilution)
pathname <- system.file("doc",package="sscore")
cel <- Dilution
SScore.multi <- SScore(cel,classlabel=c(0,0,1,1),
SF=c(4.46,6.32,5.72,9.22),SDT=c(57.241,53.995,63.581,
69.636),celfile.path=pathname,rm.extra=FALSE)


###################################################
### code chunk number 6: sscore.Rnw:238-239
###################################################
exprs(SScore.multi)[1:20]


###################################################
### code chunk number 7: sscore.Rnw:285-291
###################################################
data(Dilution)
pathname <- system.file("doc",package="sscore")
compare <- matrix(c(1,2,1,3,1,4),ncol=2,byrow=TRUE)
SScoreBatch.basic <- SScoreBatch(Dilution,compare=compare,
SF=c(4.46,6.32,5.72,9.22),SDT=c(57.241,53.995,63.58,169.636),
celfile.path=pathname,rm.extra=FALSE)


###################################################
### code chunk number 8: sscore.Rnw:296-297
###################################################
exprs(SScoreBatch.basic)[1:10,] 


###################################################
### code chunk number 9: sscore.Rnw:331-334
###################################################
sscores <- exprs(SScore.basic) ## extract the S-Score values
## find those greater than 3 SD
signif <- geneNames(Dilution)[abs(sscores) >= 3]


###################################################
### code chunk number 10: sscore.Rnw:339-344
###################################################
sscores <- exprs(SScore.basic) ## extract the S-Score values
p.values.1 <- 1 - pnorm(abs(sscores)) ## find the corresponding
                        ## one-sided p-values
p.values.2 <- 2*(1 - pnorm(abs(sscores))) ## find the corresponding
                        ## two-sided p-values


