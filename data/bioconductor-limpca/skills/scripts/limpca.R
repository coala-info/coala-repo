# Code example from 'limpca' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    out.width = "70%",
    fig.align = "center",
    eval = TRUE
)
rm(list = ls())
library("limpca")

if (!requireNamespace("SummarizedExperiment", quietly = TRUE)) {
    stop("Install 'SummarizedExperiment' to knit this vignette")
}
library(SummarizedExperiment)

## ----Install, eval=FALSE------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("limpca")

## ----Load, results=FALSE, message=FALSE---------------------------------------
library("limpca")

## -----------------------------------------------------------------------------
data("UCH")
str(UCH)

## ----message = TRUE-----------------------------------------------------------
UCH2 <- data2LmpDataList(
   outcomes = UCH$outcomes,
   design = UCH$design, 
   formula = UCH$formula
 )

## ----message = TRUE-----------------------------------------------------------
se <- SummarizedExperiment(
   assays = list(
     counts = t(UCH$outcomes)), colData = UCH$design,
   metadata = list(formula = UCH$formula)
 )

UCH3 <- data2LmpDataList(se, assay_name = "counts")

## ----dataVisu-----------------------------------------------------------------
# design
plotDesign(
    design = UCH$design, x = "Hippurate",
    y = "Citrate", rows = "Time",
    title = "Design of the UCH dataset"
)

# row 3 of outcomes
plotLine(
    Y = UCH$outcomes,
    title = "H-NMR spectrum",
    rows = c(3),
    xlab = "ppm",
    ylab = "Intensity"
)

## ----PCA----------------------------------------------------------------------
ResPCA <- pcaBySvd(UCH$outcomes)
pcaScreePlot(ResPCA, nPC = 6)
pcaScorePlot(
    resPcaBySvd = ResPCA, axes = c(1, 2),
    title = "PCA scores plot: PC1 and PC2",
    design = UCH$design,
    color = "Hippurate", shape = "Citrate",
    points_labs_rn = FALSE
)

## ----modelEst-----------------------------------------------------------------
# Model matrix generation
resMM <- lmpModelMatrix(UCH)

# Model estimation and effect matrices decomposition
resEM <- lmpEffectMatrices(resMM)

## ----effectImpSign------------------------------------------------------------
# Effects importance
resEM$varPercentagesPlot

# Bootstrap tests
resBT <- lmpBootstrapTests(resLmpEffectMatrices = resEM, nboot = 100)
resBT$resultsTable

## ----ASCA---------------------------------------------------------------------
# ASCA decomposition
resASCA <- lmpPcaEffects(resLmpEffectMatrices = resEM, method = "ASCA")

# Scores Plot for the hippurate
lmpScorePlot(resASCA,
    effectNames = "Hippurate",
    color = "Hippurate", shape = "Hippurate"
)

# Loadings Plot for the hippurate
lmpLoading1dPlot(resASCA,
    effectNames = c("Hippurate"),
    axes = 1, xlab = "ppm"
)

# Scores ScatterPlot matrix
lmpScoreScatterPlotM(resASCA,
    PCdim = c(1, 1, 1, 1, 1, 1, 1, 2),
    modelAbbrev = TRUE,
    varname.colorup = "Citrate",
    varname.colordown = "Time",
    varname.pchup = "Hippurate",
    varname.pchdown = "Time",
    title = "ASCA scores scatterplot matrix"
)

## -----------------------------------------------------------------------------
sessionInfo()

