# Code example from 'ACME' vignette. See references/ for full tutorial.

### R code from vignette source 'ACME.Rnw'

###################################################
### code chunk number 1: ACME.Rnw:37-38
###################################################
library(ACME)


###################################################
### code chunk number 2: ACME.Rnw:45-49
###################################################
datdir <- system.file('extdata',package='ACME')
fnames <- dir(datdir)
example.agff <- read.resultsGFF(fnames,path=datdir)
example.agff


###################################################
### code chunk number 3: ACME.Rnw:54-55
###################################################
calc <- do.aGFF.calc(example.agff,window=1000,thresh=0.95)


###################################################
### code chunk number 4: ACME.Rnw:62-63
###################################################
plot(calc,chrom='chr1',sample=1)


###################################################
### code chunk number 5: ACME.Rnw:68-70
###################################################
regs <- findRegions(calc)
regs[1:5,]


###################################################
### code chunk number 6: ACME.Rnw:77-81
###################################################
# write both calculated values and raw data
write.sgr(calc)
# OR write only calculated data
write.sgr(calc,raw=FALSE)


###################################################
### code chunk number 7: ACME.Rnw:86-88
###################################################
# or for the UCSC genome browser
write.bedGraph(calc)


