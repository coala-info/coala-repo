# Code example from 'bcellViper' vignette. See references/ for full tutorial.

### R code from vignette source 'bcellViper.Rnw'

###################################################
### code chunk number 1: bcellViper.Rnw:22-25
###################################################
library(bcellViper)
data(bcellViper)
print(dset)


###################################################
### code chunk number 2: bcellViper.Rnw:32-35
###################################################
targets <- unlist(lapply(regulon, function(x) names(x$tfmode)), use.names = FALSE)
cat("Regulators: ", length(regulon), "\nTargets: ", length(unique(targets)),
    "\nInteractions: ", length(targets), "\n", sep="")


