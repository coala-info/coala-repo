# Code example from 'qc-streamlined' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
suppressMessages(require(hdxmsqc))
require(S4Vectors)
suppressMessages(require(dplyr))
require(tidyr)
require(QFeatures)
require(RColorBrewer)
require(ggplot2)
require(MASS)
require(pheatmap)
require(Spectra)
require(patchwork)


## -----------------------------------------------------------------------------
BRD4uncurated <- data.frame(read.csv(system.file("extdata", "ELN55049_AllResultsTables_Uncurated.csv", package = "hdxmsqc", mustWork = TRUE)))

## -----------------------------------------------------------------------------
BRD4uncurated_wide <- processHDE(HDExaminerFile = BRD4uncurated,
                                 proteinStates = c("wt", "iBET"))

## -----------------------------------------------------------------------------
i <- grep(pattern = "X..Deut",
          x = names(BRD4uncurated_wide))

## -----------------------------------------------------------------------------
BRD4df <- readQFeatures(assayData = BRD4uncurated_wide,
                        ecol = i,
                        names = "Deuteration",
                        fnames = "fnames")

## -----------------------------------------------------------------------------
pheatmap(assay(BRD4df), cluster_rows = FALSE, scale = "row")

## -----------------------------------------------------------------------------
plotMissing(object = BRD4df)

## -----------------------------------------------------------------------------
BRD4df_filtered <- isMissingAtRandom(object = BRD4df)

## -----------------------------------------------------------------------------
plotMissing(object = BRD4df_filtered)

## -----------------------------------------------------------------------------
BRD4df_filtered_imputed <- impute(BRD4df_filtered, method = "zero", i = 1)

## -----------------------------------------------------------------------------
massError <- computeMassError(object = BRD4df_filtered_imputed)
plotMassError(object = BRD4df_filtered_imputed)

## -----------------------------------------------------------------------------
intensityOutlier <- intensityOutliers(object = BRD4df_filtered_imputed)
plotIntensityOutliers(object = BRD4df_filtered_imputed)

## -----------------------------------------------------------------------------
dfrt <- rTimeOutliers(object = BRD4df_filtered_imputed)
plotrTimeOutliers(object = BRD4df_filtered_imputed)

## -----------------------------------------------------------------------------
experiment <- c("wt", "iBET")
timepoints <- rep(c(0, 15, 60, 600, 3600, 14000), each = 3)

## -----------------------------------------------------------------------------
monoStat <- computeMonotoneStats(object = BRD4df_filtered_imputed,
                                 experiment = experiment, 
                                 timepoints = timepoints)
out <- plotMonotoneStat(object = BRD4df_filtered_imputed,
                                 experiment = experiment, 
                                 timepoints = timepoints)
out

## -----------------------------------------------------------------------------
imTimeOut <- imTimeOutlier(object = BRD4df_filtered_imputed)
plotImTimeOutlier(object = BRD4df_filtered_imputed)

## -----------------------------------------------------------------------------
csCor <- chargeCorrelationHdx(object = BRD4df_filtered_imputed,
                              experiment = experiment,
                              timepoints = timepoints)
csCor

## -----------------------------------------------------------------------------
replicateVar <- replicateCorrelation(object = BRD4df_filtered_imputed,
                                     experiment = experiment,
                                     timepoints = timepoints)

replicateOut <- replicateOutlier(object = BRD4df_filtered_imputed,
                                     experiment = experiment,
                                     timepoints = timepoints)



## -----------------------------------------------------------------------------
tocheck <- compatibleUptake(object = BRD4df_filtered_imputed,
                 experiment = experiment,
                 timepoints = timepoints)

## -----------------------------------------------------------------------------

hdxsite <- data.frame(read.csv(system.file("extdata", "BRD4_RowChecked_20220628_HDsite.csv",
                                           package = "hdxmsqc", mustWork = TRUE),
                               header = TRUE, fileEncoding = 'UTF-8-BOM'))
BRD4matched <- read.csv(system.file("extdata", "BRD4_RowChecked_20220628_HDE.csv",
                                           package = "hdxmsqc", mustWork = TRUE),
                               header = TRUE, fileEncoding = 'UTF-8-BOM')

## -----------------------------------------------------------------------------
spectraCompare <- spectraSimilarity(peaks = hdxsite,
                                    object = BRD4matched, 
                                    experiment = experiment,
                                    numSpectra = NULL)

## -----------------------------------------------------------------------------
head(spectraCompare$observedSpectra$score)

## -----------------------------------------------------------------------------
plotSpectraMirror(spectraCompare$observedSpectra[1,], spectraCompare$matchedSpectra[1,], ppm = 300)

## -----------------------------------------------------------------------------
qctable <- qualityControl(object = BRD4df_filtered_imputed, 
                           massError = massError,
                           intensityOutlier = intensityOutlier,
                           retentionOutlier = dfrt,
                           monotonicityStat = monoStat,
                           mobilityOutlier = imTimeOut,
                           chargeCorrelation = csCor,
                           replicateCorrelation = replicateVar,
                           replicateOutlier = replicateOut,
                           sequenceCheck = tocheck,
                           spectraCheck = spectraCompare,
                           experiment = experiment,
                           timepoints = timepoints )

## -----------------------------------------------------------------------------
sessionInfo()

