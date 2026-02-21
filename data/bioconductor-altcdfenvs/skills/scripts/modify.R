# Code example from 'modify' vignette. See references/ for full tutorial.

### R code from vignette source 'modify.Rnw'

###################################################
### code chunk number 1: modify.Rnw:35-36
###################################################
library(altcdfenvs)


###################################################
### code chunk number 2: modify.Rnw:39-40
###################################################
library(plasmodiumanophelescdf)


###################################################
### code chunk number 3: modify.Rnw:47-49
###################################################
planocdf <- wrapCdfEnvAffy(plasmodiumanophelescdf, 712, 712, "plasmodiumanophelescdf")
print(planocdf)


###################################################
### code chunk number 4: modify.Rnw:68-69
###################################################
#indexProbes(planocdf, "pm", "")


