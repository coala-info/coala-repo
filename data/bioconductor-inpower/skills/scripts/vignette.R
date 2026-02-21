# Code example from 'vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'vignette.Rnw'

###################################################
### code chunk number 1: start
###################################################
library(INPower)


###################################################
### code chunk number 2: data file
###################################################
datafile <- system.file("sampleData", "data.rda", package="INPower")


###################################################
### code chunk number 3: load data
###################################################
load(datafile)
data


###################################################
### code chunk number 4: SNPs
###################################################
MAFs  <- data[, "MAF"]
betas <- data[, "Beta"]
pow   <- data[, "Power"] 


###################################################
### code chunk number 5: call1
###################################################
INPower(MAFs, betas, pow, span=0.5, binary.outcome=FALSE, 
        sample.size=seq(25000,125000,by=25000), 
        signif.lvl=10^(-7), tgv=0.8, k=seq(25,125,by=25))


###################################################
### code chunk number 6: call2
###################################################
INPower(MAFs, betas, pow, span=0.5, binary.outcome=FALSE, 
        sample.size=seq(25000,125000,by=25000), 
        signif.lvl=10^(-7), k=seq(25,125,by=25))


###################################################
### code chunk number 7: call3
###################################################
INPower(MAFs, betas, pow, span=0.5, binary.outcome=FALSE,
        sample.size=seq(25000,125000,by=25000), 
        signif.lvl=10^(-7), multi.stage.option=list(al=5*10^(-5), pi=0.3),
        tgv=0.8 , k=seq(25,125,by=25))


###################################################
### code chunk number 8: sessionInfo
###################################################
sessionInfo()


