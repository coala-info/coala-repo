# Code example from 'disco_workflow_vignette' vignette. See references/ for full tutorial.

## ----echo=F-------------------------------------------------------------------
suppressPackageStartupMessages({
  suppressWarnings({
    library(DiscoRhythm)
  })
})

indata <- discoGetSimu()
knitr::kable(head(indata[,1:6]),format = "markdown") # Inspect the data

## ----echo=F-------------------------------------------------------------------
kableExtra::column_spec(knitr::kable(head(indata[,1:6])),
              1, background = "#FDB813")

## ----echo=F-------------------------------------------------------------------
kableExtra::column_spec(knitr::kable(head(indata[,1:6])),
              2:6, background = "#FDB813")

## ----echo=F-------------------------------------------------------------------
kableExtra::column_spec(
kableExtra::row_spec(
  knitr::kable(head(indata[,1:6])),
              0, background = "#FDB813"),
1, background = "inherit")

## ----echo=F,message=FALSE-----------------------------------------------------
knitr::kable(head(SummarizedExperiment::colData(
  discoDFtoSE(indata)
)), format = "markdown")

## ----interface, echo=F, fig.cap="Screenshot of the initial DiscoRhythm landing page."----
knitr::include_graphics("IntroductionSS.jpg")

## ----echo=FALSE---------------------------------------------------------------
# Figure caption template
figcap="Screenshot of the '%s' section of the DiscoRhythm interface."


## ----selectData, echo=FALSE, fig.cap=sprintf(figcap,'Select Data')------------
knitr::include_graphics("selectDataSS.jpg")

## ----corQC, echo=FALSE, fig.cap=sprintf(figcap,'Inter-sample Correlation')----
knitr::include_graphics("IntersampleCorrelationSS.jpg")

## ----pcaQC, echo=F, fig.cap=sprintf(figcap,'PCA')-----------------------------
knitr::include_graphics("PCASS.jpg")

## ----filteringSummary, echo=F, fig.cap=sprintf(figcap,'Filtering Summary')----
knitr::include_graphics("FilteringSummarySS.jpg")

## ----repAnalysis, echo=F, fig.cap=sprintf(figcap,'Row Selection')-------------
knitr::include_graphics("RowSelectionSS.jpg")

## ----domPer, echo=F, fig.cap=sprintf(figcap,'Period Detection')---------------
knitr::include_graphics("PeriodDetectionSS.jpg")

## ----PCfits, echo=F, fig.cap=sprintf(figcap,'PC Cosinor Fits')----------------
knitr::include_graphics("PCfitsSS.jpg")

## ----detOsc, echo=F, fig.cap=sprintf(figcap,'Oscillation Detection (Preview)')----
knitr::include_graphics("OscillationDetectionPrevSS.jpg")

## ----echo=FALSE---------------------------------------------------------------
mat <- t(DiscoRhythm::discoODAexclusionMatrix)
knitr::kable(mat,format = "markdown")

## ----detOscResults, echo=F, fig.cap=sprintf(figcap,'Oscillation Detection')----
knitr::include_graphics("OscillationDetectionSS.jpg")

## -----------------------------------------------------------------------------
library(DiscoRhythm)
indata <- discoGetSimu()
knitr::kable(head(indata[,1:6]), format = "markdown") # Inspect the data

## -----------------------------------------------------------------------------
se <- discoDFtoSE(indata)

## -----------------------------------------------------------------------------
selectDataSE <- discoCheckInput(se)

## ----message=FALSE------------------------------------------------------------
library(SummarizedExperiment)
Metadata <- colData(selectDataSE)
knitr::kable(discoDesignSummary(Metadata),format = "markdown")

## -----------------------------------------------------------------------------
CorRes <- discoInterCorOutliers(selectDataSE,
                                cor_method="pearson",
                                threshold=3,
                                thresh_type="sd")

## -----------------------------------------------------------------------------
PCAres <- discoPCAoutliers(selectDataSE,
                           threshold=3,
                           scale=TRUE,
                           pcToCut = c("PC1","PC2","PC3","PC4"))

## -----------------------------------------------------------------------------
discoPCAres <- discoPCA(selectDataSE)

## -----------------------------------------------------------------------------
FilteredSE <- selectDataSE[,!PCAres$outliers & !CorRes$outliers]

DT::datatable(as.data.frame(
  colData(selectDataSE)[PCAres$outliers | CorRes$outliers,]
))

knitr::kable(discoDesignSummary(colData(FilteredSE)),format = "markdown")

## -----------------------------------------------------------------------------
ANOVAres <- discoRepAnalysis(FilteredSE,
                             aov_method="Equal Variance",
                             aov_pcut=0.05,
                             aov_Fcut=1,
                             avg_method="Median")

FinalSE <- ANOVAres$se

## -----------------------------------------------------------------------------
PeriodRes <- discoPeriodDetection(FinalSE,
                                  timeType="linear",
                                  main_per=24)

## -----------------------------------------------------------------------------
OVpca <- discoPCA(FinalSE)
OVpcaSE <- discoDFtoSE(data.frame("PC"=1:ncol(OVpca$x),t(OVpca$x)),
                                  colData(FinalSE))
knitr::kable(discoODAs(OVpcaSE,period = 24,method = "CS")$CS,
             format = "markdown")

## -----------------------------------------------------------------------------
discoODAres <- discoODAs(FinalSE,
                         period=24,
                         method="CS",
                         ncores=1,
                         circular_t=FALSE)


## ----echo=F-------------------------------------------------------------------
batchscript=system.file("", "DiscoRhythm_batch.R",
                               package = "DiscoRhythm",
                               mustWork = TRUE)

## ----code = readLines(batchscript), eval= FALSE-------------------------------
# ######################################################################
# # Intended for use by discoBatch or through the DiscoRhythm_report.Rmd
# # Includes all R code for the DiscoRhythm data processing
# # Expects all arguments to discoBatch in the environment
# #####################################################################
# 
# library(DiscoRhythm)
# 
# # Preprocess inputs
# selectDataSE <- discoCheckInput(discoDFtoSE(indata))
# 
# # Intersample correlations
# CorRes <- discoInterCorOutliers(selectDataSE,cor_method,
#                                 cor_threshold,cor_threshType)
# 
# # PCA for outlier detection
# PCAres <- discoPCAoutliers(selectDataSE,pca_threshold,pca_scale,pca_pcToCut)
# PCAresAfter <- discoPCA(selectDataSE[,!PCAres$outliers])
# 
# # Removing the outliers from the main data.frame and metadata data.frame
# FilteredSE <- selectDataSE[,!PCAres$outliers & !CorRes$outliers]
# 
# # Running ANOVA and merging replicates
# ANOVAres <- discoRepAnalysis(FilteredSE, aov_method,
#                              aov_pcut, aov_Fcut, avg_method)
# 
# # Data to be used for Period Detection and Oscillation Detection
# FinalSE <- ANOVAres$se
# 
# # Perform PCA on the final dataset
# OVpca <- discoPCA(FinalSE)
# 
# # Period Detection
# PeriodRes <- discoPeriodDetection(FinalSE,
#                      timeType,
#                      main_per)
# 
# # Oscillation Detection
# discoODAres <- discoODAs(FinalSE,
#                         circular_t = timeType=="circular",
#                         period=osc_period,
#                         osc_method,ncores)

## -----------------------------------------------------------------------------
sessionInfo()

