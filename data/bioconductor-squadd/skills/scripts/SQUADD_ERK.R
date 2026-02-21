# Code example from 'SQUADD_ERK' vignette. See references/ for full tutorial.

### R code from vignette source 'SQUADD_ERK.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: source package
###################################################
library(SQUADD)


###################################################
### code chunk number 2: instance
###################################################
# construct instance of SquadSimResServiceImpl
fpath <- system.file("extdata", package="SQUADD")
folder <- file.path(fpath,"data_ERK")
sim <- simResService (folder=folder,
			  time= 20,
			  ncolor=5,
     		 legend= c("EGF", "ERK", "MEK", "RAF"),
  			 indexDeno=1,
			 method="lowess")


###################################################
### code chunk number 3: SimMatrix
###################################################
sim["selectNode"] <-c("ERK", "MEK", "RAF")
plotSimMatrix(sim)


###################################################
### code chunk number 4: fittedValues
###################################################
tab <- getFittedTable(sim)


###################################################
### code chunk number 5: PredMap
###################################################
plotPredMap(sim)


###################################################
### code chunk number 6: FigPredMap
###################################################
plotPredMap(sim)


###################################################
### code chunk number 7: SQUADD_ERK.Rnw:167-168
###################################################
sessionInfo()


