# Code example from 'mBPCR' vignette. See references/ for full tutorial.

### R code from vignette source 'mBPCR.Rnw'

###################################################
### code chunk number 1: mBPCR.Rnw:64-65
###################################################
library(mBPCR)


###################################################
### code chunk number 2: mBPCR.Rnw:71-72
###################################################
data(rec10k)


###################################################
### code chunk number 3: mBPCR.Rnw:82-83
###################################################
maxProbeNumber <- 1000


###################################################
### code chunk number 4: mBPCR.Rnw:86-87
###################################################
A <- array(1, dim=(maxProbeNumber+1)*(maxProbeNumber+2)/2)


###################################################
### code chunk number 5: mBPCR.Rnw:94-95
###################################################
remove(A)


###################################################
### code chunk number 6: mBPCR.Rnw:104-105
###################################################
results <- estProfileWithMBPCR(rec10k$SNPname, rec10k$Chromosome, rec10k$PhysicalPosition, rec10k$log2ratio, chrToBeAnalyzed=c(3,5), maxProbeNumber=1000)


###################################################
### code chunk number 7: mBPCR.Rnw:115-116
###################################################
writeEstProfile(path='', sampleName='rec10k',rec10k$SNPname, rec10k$Chromosome, rec10k$PhysicalPosition, rec10k$log2ratio, chrToBeWritten=c(3,5), results$estPC, results$estBoundaries)


###################################################
### code chunk number 8: mBPCR.Rnw:119-121
###################################################
library(xtable)
temp <- writeEstProfile(path=NULL, sampleName='rec10k',rec10k$SNPname,rec10k$Chromosome,  rec10k$PhysicalPosition, rec10k$log2ratio,chrToBeWritten=c(3,5), results$estPC, results$estBoundaries) 


###################################################
### code chunk number 9: genTable1
###################################################
xx <- xtable(head(temp$mBPCRestimate))
label(xx) <- "tab_mBPCR"
caption(xx) <- "Example of table containing the profile estimated with mBPCR."
align(xx) <- c("|c|","|c|","c|","c|","c|","c|")
print(xx,latex.environments=c("center","small"),include.rownames=FALSE)


###################################################
### code chunk number 10: genTable2
###################################################
xx <- xtable(head(temp$mBPCRbreakpoints))
label(xx) <- "tab_bounds"
caption(xx) <- "Example of table containing a summary of the breakpoints estimated with mBPCR."
align(xx) <- c("|c|","|c|","c|","c|","c|","c|","c|","c|")
print(xx,latex.environments=c("center","small"),include.rownames=FALSE)


###################################################
### code chunk number 11: mBPCR.Rnw:149-150
###################################################
results <- estProfileWithMBPCR(rec10k$SNPname, rec10k$Chromosome, rec10k$PhysicalPosition, rec10k$log2ratio, chrToBeAnalyzed=3, regr='BRC', maxProbeNumber=1000)


###################################################
### code chunk number 12: mBPCR.Rnw:157-158
###################################################
plotEstProfile(sampleName='rec10k', rec10k$Chromosome, rec10k$PhysicalPosition, rec10k$log2ratio, chrToBePlotted=3, results$estPC, maxProbeNumber=2000, regrCurve=results$regrCurve, regr='BRC')


###################################################
### code chunk number 13: mBPCR.Rnw:172-173 (eval = FALSE)
###################################################
## data(jekoChr11Array250Knsp)


###################################################
### code chunk number 14: mBPCR.Rnw:176-177 (eval = FALSE)
###################################################
## maxProbeNumber <- 9000


###################################################
### code chunk number 15: mBPCR.Rnw:180-181 (eval = FALSE)
###################################################
## A <- array(1, dim=(maxProbeNumber+1)*(maxProbeNumber+2)/2)


###################################################
### code chunk number 16: mBPCR.Rnw:185-186 (eval = FALSE)
###################################################
## remove(A)


###################################################
### code chunk number 17: mBPCR.Rnw:189-190 (eval = FALSE)
###################################################
## results <- estProfileWithMBPCR(jekoChr11Array250Knsp$SNPname, jekoChr11Array250Knsp$Chromosome, jekoChr11Array250Knsp$PhysicalPosition, jekoChr11Array250Knsp$log2ratio, chrToBeAnalyzed=11, maxProbeNumber=9000, rhoSquare=0.0479, nu=-3.012772e-10, sigmaSquare=0.0699)


###################################################
### code chunk number 18: mBPCR.Rnw:193-194 (eval = FALSE)
###################################################
## plotEstProfile(sampleName='jeko250Knsp', jekoChr11Array250Knsp$Chromosome, jekoChr11Array250Knsp$PhysicalPosition, jekoChr11Array250Knsp$log2ratio, chrToBePlotted=11, results$estPC, maxProbeNumber=9000)


###################################################
### code chunk number 19: mBPCR.Rnw:204-205
###################################################
data(rec10k)


###################################################
### code chunk number 20: mBPCR.Rnw:208-209
###################################################
estGlobParam(rec10k$log2ratio)


###################################################
### code chunk number 21: mBPCR.Rnw:222-223
###################################################
data(jekoChr11Array250Knsp)


###################################################
### code chunk number 22: mBPCR.Rnw:229-230
###################################################
y <- jekoChr11Array250Knsp$log2ratio[10600:11200]


###################################################
### code chunk number 23: mBPCR.Rnw:233-234
###################################################
p <- jekoChr11Array250Knsp$PhysicalPosition[10600:11200]


###################################################
### code chunk number 24: mBPCR.Rnw:241-242
###################################################
results <- computeMBPCR(y, nu=-3.012772e-10, rhoSquare=0.0479, sigmaSquare=0.0699, regr='BRC')


###################################################
### code chunk number 25: mBPCR.Rnw:248-252
###################################################
plot(p,y)
points(p, results$estPC, type='l', col='red')
points(p, results$regrCurve, type='l', col='green')
legend(x='bottomleft', legend=c('mBPCR', 'BRC with K_2'), lty=c(1, 1), col=c(4, 2))


###################################################
### code chunk number 26: mBPCR.Rnw:293-294
###################################################
path <- system.file("extdata", "rec10k.txt", package = "mBPCR")


###################################################
### code chunk number 27: mBPCR.Rnw:306-307
###################################################
rec10k <- importCNData(path, NRowSkip=1)


###################################################
### code chunk number 28: mBPCR.Rnw:314-315
###################################################
plot(rec10k$position[rec10k$chr == 3], rec10k$logratio[rec10k$chr == 3], xlab='Chromosome 3', ylab='log2ratio')        


###################################################
### code chunk number 29: mBPCR.Rnw:326-327
###################################################
data(oligoSetExample, package="oligoClasses")


###################################################
### code chunk number 30: mBPCR.Rnw:334-335
###################################################
library(mBPCR)


###################################################
### code chunk number 31: mBPCR.Rnw:338-339
###################################################
r <-estProfileWithMBPCRforOligoSnpSet(oligoSet, sampleToBeAnalyzed=1, chrToBeAnalyzed=2, maxProbeNumber=1000, ifLogRatio=0, rhoSquare=0.0889637)


###################################################
### code chunk number 32: mBPCR.Rnw:343-344
###################################################
cc <- r$estPC


###################################################
### code chunk number 33: mBPCR.Rnw:346-347
###################################################
cc1 <- cc[chromosome(cc) == "2",1]


###################################################
### code chunk number 34: mBPCR.Rnw:349-350
###################################################
par(las=1)


###################################################
### code chunk number 35: mBPCR.Rnw:352-353
###################################################
plot(position(cc1), copyNumber(cc1), ylim=c(-0.23, 0.1), ylab="copy number", xlab="base position")


