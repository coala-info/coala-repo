# Code example from 'Rqc' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(BiocStyle)

## ----load, message=FALSE------------------------------------------------------
library(Rqc)

## ----file_loc-----------------------------------------------------------------
folder <- system.file(package="ShortRead", "extdata/E-MTAB-1147")

## ----rqc, eval=FALSE----------------------------------------------------------
# rqc(path = folder, pattern = ".fastq.gz")

## ----example, echo=FALSE, message=FALSE---------------------------------------
fastqDir <- system.file(package="ShortRead", "extdata/E-MTAB-1147")
files <- list.files(fastqDir, "fastq.gz", full.names=TRUE)
qa <- rqcQA(files, workers=1)

## -----------------------------------------------------------------------------
knitr::kable(perFileInformation(qa))

## ----read-mean-dist-----------------------------------------------------------
rqcReadQualityBoxPlot(qa)

## ----average-quality-plot-----------------------------------------------------
rqcReadQualityPlot(qa)

## ----cycle-average-quality-plot-----------------------------------------------
rqcCycleAverageQualityPlot(qa)

## ----readfrequency------------------------------------------------------------
rqcReadFrequencyPlot(qa)

## ----heatmap-reads------------------------------------------------------------
rqcFileHeatmap(qa[[1]])

## ----read-width-plot----------------------------------------------------------
rqcReadWidthPlot(qa)

## ----cycle-gc-plot------------------------------------------------------------
rqcCycleGCPlot(qa)

## ----cycle-quality-plots------------------------------------------------------
rqcCycleQualityPlot(qa)

## ----biplot-------------------------------------------------------------------
rqcCycleAverageQualityPcaPlot(qa)

## ----cycle-quality-boxplots---------------------------------------------------
rqcCycleQualityBoxPlot(qa)

## ----cycle-basecall-plots-----------------------------------------------------
rqcCycleBaseCallsPlot(qa)

## ----cycle-basecall-lineplots-------------------------------------------------
rqcCycleBaseCallsLinePlot(qa)

## ----input--------------------------------------------------------------------
fastqDir <- system.file(package="ShortRead", "extdata/E-MTAB-1147")
files <- list.files(fastqDir, "fastq.gz", full.names=TRUE)

## ----rqcQA--------------------------------------------------------------------
qa <- rqcQA(files, workers=1)

## ----report, eval=FALSE-------------------------------------------------------
# reportFile <- rqcReport(qa)
# browseURL(reportFile)

## ----calc---------------------------------------------------------------------
df <- rqcCycleAverageQualityCalc(qa)
cycle <- as.numeric(levels(df$cycle))[df$cycle]
plot(cycle, df$quality, col = df$filename, xlab='Cycle', ylab='Quality Score')

## ----subset-------------------------------------------------------------------
sublist <- qa[1]
rqcCycleQualityPlot(sublist)

## ----default-report-path, eval=FALSE------------------------------------------
# system.file(package = "Rqc", "templates", "rqc_report.Rmd")

## ----rqc-report-custom-template, eval=FALSE-----------------------------------
# rqcReport(qa, templateFile = "custom_report.Rmd")

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

