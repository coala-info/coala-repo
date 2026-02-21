# Code example from 'tigre' vignette. See references/ for full tutorial.

### R code from vignette source 'tigre.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: tigre.Rnw:41-42
###################################################
options(width = 60)


###################################################
### code chunk number 3: tigre.Rnw:60-63 (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("tigre")


###################################################
### code chunk number 4: tigre.Rnw:72-73
###################################################
library(tigre)


###################################################
### code chunk number 5: tigre.Rnw:89-102 (eval = FALSE)
###################################################
## # Names of CEL files
## expfiles <- c(paste("embryo_tc_4_", 1:12, ".CEL", sep=""),
##               paste("embryo_tc_6_", 1:12, ".CEL", sep=""),
##               paste("embryo_tc_8_", 1:12, ".CEL", sep=""))
## # Load the CEL files
## expdata <- ReadAffy(filenames=expfiles,
##                     celfile.path="embryo_tc_array_data")
## # Setup experimental data (observation times)
## pData(expdata) <- data.frame("time.h" = rep(1:12, 3),
##                              row.names=rownames(pData(expdata)))
## # Run mmgMOS processing (requires several minutes to complete)
## drosophila_mmgmos_exprs <- mmgmos(expdata)
## drosophila_mmgmos_fragment <- drosophila_mmgmos_exprs


###################################################
### code chunk number 6: tigre.Rnw:107-110 (eval = FALSE)
###################################################
## drosophila_gpsim_fragment <-
##   processData(drosophila_mmgmos_fragment,
##               experiments=rep(1:3, each=12))


###################################################
### code chunk number 7: tigre.Rnw:118-119
###################################################
data(drosophila_gpsim_fragment)


###################################################
### code chunk number 8: tigre.Rnw:126-157
###################################################
# FBgn names of target genes
targets <- c('FBgn0003486', 'FBgn0033188', 'FBgn0035257')

# Load gene annotations
library(annotate)
aliasMapping <- getAnnMap("ALIAS2PROBE",
                  annotation(drosophila_gpsim_fragment))
# Get the probe identifier for TF 'twi'
twi <- get('twi', env=aliasMapping)
# Load alternative gene annotations
fbgnMapping <- getAnnMap("FLYBASE2PROBE",
                 annotation(drosophila_gpsim_fragment))
# Get the probe identifiers for target genes
targetProbes <- mget(targets, env=fbgnMapping)

st_models <- list()
# Learn single-target models for each gene individually
for (i in seq(along=targetProbes)) {
  st_models[[i]] <- GPLearn(drosophila_gpsim_fragment,
                            TF=twi, targets=targetProbes[i],
                            quiet=TRUE)
}
# Learn a joint model for all targets
mt_model <- GPLearn(drosophila_gpsim_fragment, TF=twi,
                    targets=targetProbes,
                    quiet=TRUE)
# Display the joint model parameters
show(mt_model)
# Learn a model without TF mRNA and TF protein translation
nt_model <- GPLearn(drosophila_gpsim_fragment,
                    targets=c(twi, targetProbes[1:2]), quiet=TRUE)


###################################################
### code chunk number 9: tigre.Rnw:163-169 (eval = FALSE)
###################################################
## GPPlot(st_models[[1]], nameMapping=getAnnMap("FLYBASE",
##                         annotation(drosophila_gpsim_fragment)))
## GPPlot(mt_model, nameMapping=getAnnMap("FLYBASE",
##                   annotation(drosophila_gpsim_fragment)))
## GPPlot(nt_model, nameMapping=getAnnMap("FLYBASE",
##                   annotation(drosophila_gpsim_fragment)))


###################################################
### code chunk number 10: tigre.Rnw:174-176
###################################################
GPPlot(st_models[[1]], nameMapping=getAnnMap("FLYBASE",
                         annotation(drosophila_gpsim_fragment)))


###################################################
### code chunk number 11: tigre.Rnw:185-187
###################################################
GPPlot(mt_model, nameMapping=getAnnMap("FLYBASE",
                   annotation(drosophila_gpsim_fragment)))


###################################################
### code chunk number 12: tigre.Rnw:196-198
###################################################
GPPlot(nt_model, nameMapping=getAnnMap("FLYBASE",
                   annotation(drosophila_gpsim_fragment)))


###################################################
### code chunk number 13: tigre.Rnw:209-218
###################################################
## Rank the targets, filtering weakly expressed genes with average
## expression z-score below 1.8
scores <- GPRankTargets(drosophila_gpsim_fragment, TF=twi,
                        testTargets=targetProbes,
                        options=list(quiet=TRUE),
                        filterLimit=1.8)
## Sort the returned list according to log-likelihood
scores <- sort(scores, decreasing=TRUE)
write.scores(scores)


###################################################
### code chunk number 14: tigre.Rnw:225-228
###################################################
topmodel <- generateModels(drosophila_gpsim_fragment,
                           scores[1])
show(topmodel)


###################################################
### code chunk number 15: tigre.Rnw:235-245
###################################################
## Rank the targets, filtering weakly expressed genes with average
## expression z-score below 1.8
scores <- GPRankTargets(drosophila_gpsim_fragment, TF=twi,
                        knownTargets=targetProbes[1],
                        testTargets=targetProbes[2:3],
                        options=list(quiet=TRUE),
                        filterLimit=1.8)
## Sort the returned list according to log-likelihood
scores <- sort(scores, decreasing=TRUE)
write.scores(scores)


###################################################
### code chunk number 16: tigre.Rnw:259-277 (eval = FALSE)
###################################################
## for (i in seq(1, 3)) {
##   targetIndices <- seq(i,
##     length(featureNames(drosophila_gpsim_fragment)), by=3)
##   outfile <- paste('ranking_results_', i, '.Rdata', sep='')
##   scores <- GPrankTargets(preprocData, TF=twi,
##                           testTargets=targetIndices,
##                           scoreSaveFile=outfile)
## }
## 
## for (i in seq(1, 3)) {
##   outfile <- paste('ranking_results_', i, '.Rdata', sep='')
##   load(outfile)
##   if (i==1)
##     scores <- scoreList
##   else
##     scores <- c(scores, scoreList)
## }
## show(scores)


###################################################
### code chunk number 17: tigre.Rnw:299-301 (eval = FALSE)
###################################################
## procData <- processRawData(data, times=c(...),
##                            experiments=c(...))


###################################################
### code chunk number 18: tigre.Rnw:321-327 (eval = FALSE)
###################################################
## export.scores(scores, datasetName='Drosophila',
##               experimentSet='GPSIM/GPDISIM',
##               database='database.sqlite',
##               preprocData=drosophila_gpsim_fragment,
##               models=models,
##               aliasTypes=c('SYMBOL', 'GENENAME', 'FLYBASE', 'ENTREZID'))


###################################################
### code chunk number 19: sessionInfo
###################################################
sessionInfo()


