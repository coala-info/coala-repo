# Code example from 'affypdnn' vignette. See references/ for full tutorial.

### R code from vignette source 'affypdnn.Rnw'

###################################################
### code chunk number 1: citation
###################################################
citation(package="affypdnn")


###################################################
### code chunk number 2: init
###################################################
library(affypdnn)


###################################################
### code chunk number 3: afbatch
###################################################
library(affydata)
data(Dilution)
afbatch <- Dilution


###################################################
### code chunk number 4: hgu95av2Params
###################################################
data(hgu95av2.pdnn.params)

params.chiptype <- hgu95av2.pdnn.params


###################################################
### code chunk number 5: energyFiles
###################################################
dir(system.file("exampleData", package="affypdnn"))


###################################################
### code chunk number 6: experimentSpecific
###################################################
data("params.dilution", package="affypdnn")
params <- params.dilution
rm(params.dilution)


###################################################
### code chunk number 7: pmLevel
###################################################
ppset.name <- c("41206_r_at", "31620_at")
ppset <- probeset(afbatch, ppset.name)


###################################################
### code chunk number 8: pmLevelPlot
###################################################
par(mfrow=c(2,2))
for (i in 1:2) {
  probes.pdnn <- pmcorrect.pdnnpredict(ppset[[i]], params,
                                       params.chiptype = params.chiptype)

  plot(ppset[[i]], main=paste(ppset.name[i], "\n(raw intensities)"))
  matplotProbesPDNN(probes.pdnn, 
                    main = paste(ppset.name[i], 
                      "\n(predicted intensities)"))
}


###################################################
### code chunk number 9: expressopdnn
###################################################
ids <- ls(getCdfInfo(afbatch))[1:10]
eset <- expressopdnn(afbatch, 
                     bg.correct = FALSE,
                     normalize = FALSE,
                     findparams.param = list(params.chiptype = params.chiptype,
                       give.warnings=FALSE),
                     summary.subset=ids)


