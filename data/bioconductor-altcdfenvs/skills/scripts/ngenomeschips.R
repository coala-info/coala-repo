# Code example from 'ngenomeschips' vignette. See references/ for full tutorial.

### R code from vignette source 'ngenomeschips.Rnw'

###################################################
### code chunk number 1: ngenomeschips.Rnw:35-36
###################################################
library(altcdfenvs)


###################################################
### code chunk number 2: ngenomeschips.Rnw:39-40
###################################################
library(plasmodiumanophelescdf)


###################################################
### code chunk number 3: ngenomeschips.Rnw:47-49
###################################################
planocdf <- wrapCdfEnvAffy(plasmodiumanophelescdf, 712, 712, "plasmodiumanophelescdf")
print(planocdf)


###################################################
### code chunk number 4: ngenomeschips.Rnw:60-62
###################################################
ids <- geneNames(planocdf)
ids.pf <- ids[grep("^Pf", ids)]


###################################################
### code chunk number 5: ngenomeschips.Rnw:66-69
###################################################
## subset the object to only keep probe sets of interest
plcdf <- planocdf[ids.pf]
print(plcdf)


###################################################
### code chunk number 6: ngenomeschips.Rnw:77-82
###################################################
filename <- system.file("exampleData", "Plasmodium-Probeset-IDs.txt",
                             package="altcdfenvs")
ids.pf <- scan(file = filename, what = "")
plcdf <- planocdf[ids.pf]
print(plcdf)


###################################################
### code chunk number 7: ngenomeschips.Rnw:86-88
###################################################
plcdf@envName <- "Plasmodium ids only"
print(plcdf)


