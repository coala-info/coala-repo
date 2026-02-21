# Code example from 'UCH' vignette. See references/ for full tutorial.

## ----Setup,include=FALSE------------------------------------------------------
# require(knitr)
knitr::opts_chunk$set(
    message = FALSE, warning = TRUE, comment = NA,
    crop = NULL,
    tidy.opts = list(width.cutoff = 60),
    tidy = TRUE, dpi = 50, dev = "png",
    fig.width = 5, fig.height = 3.5
)
rm(list = ls())

if (!requireNamespace("pander", quietly = TRUE)) {
    stop("Install 'pander' to knit this vignette")
}
library(pander)

library(ggplot2)
if (!requireNamespace("gridExtra", quietly = TRUE)) {
    stop("Install 'gridExtra' to knit this vignette")
}
library(gridExtra)

if (!requireNamespace("SummarizedExperiment", quietly = TRUE)) {
    stop("Install 'SummarizedExperiment' to knit this vignette")
}
library(SummarizedExperiment)

## ----eval=FALSE---------------------------------------------------------------
# 
# library(pander)
# library(gridExtra)
# library(ggplot2)
# library(SummarizedExperiment)

## ----Install, eval=FALSE------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("limpca")

## ----Load, results=FALSE, message=FALSE---------------------------------------
library("limpca")

## ----Data_Importation---------------------------------------------------------
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

## ----Design_visualization-----------------------------------------------------
pander(head(UCH$design))
plotDesign(
    design = UCH$design, x = "Hippurate",
    y = "Citrate", rows = "Time",
    title = "Design of the UCH dataset"
)

## ----Spectrum_visualization---------------------------------------------------
p1 <- plotLine(
    Y = UCH$outcomes,
    title = "H-NMR spectrum",
    rows = c(3),
    xlab = "ppm",
    ylab = "Intensity"
)

cit_peaks <- annotate("rect",
    xmin = c(2.509), xmax = c(2.709),
    ymin = -Inf, ymax = Inf, alpha = 0.2,
    fill = c("tomato")
)

hip_peaks <- annotate("rect",
    xmin = c(7.458, 3.881), xmax = c(7.935, 4.041),
    ymin = -Inf, ymax = Inf, alpha = 0.2,
    fill = c("yellowgreen")
)

p1 <- plotLine(
    Y = UCH$outcomes,
    title = "H-NMR spectrum",
    rows = c(3),
    xlab = "ppm",
    ylab = "Intensity"
)

p1 + cit_peaks + hip_peaks

## -----------------------------------------------------------------------------
# xy corresponds to citrate (453) and hippurate peaks (369)
plotScatter(
    Y = UCH$outcomes,
    xy = c(453, 369),
    design = UCH$design,
    color = "Hippurate",
    shape = "Citrate"
)
# Or refering to the variables names (ppm values here)
plotScatter(
    Y = UCH$outcomes,
    xy = c("2.6092056", "3.9811536"),
    design = UCH$design,
    color = "Hippurate",
    shape = "Citrate"
)

## ----fig.width=6,fig.height=7-------------------------------------------------
plotScatterM(
    Y = UCH$outcomes, cols = c(133, 145, 150, 369, 453),
    design = UCH$design, varname.colorup = "Hippurate",
    varname.colordown = "Citrate"
)

## -----------------------------------------------------------------------------
plotMeans(
    Y = UCH$outcomes,
    design = UCH$design,
    cols = c(453),
    x = c("Citrate"),
    w = c("Hippurate"),
    z = c("Time"),
    ylab = "Intensity",
    title = c("Mean reponse for main Citrate peak")
)

## ----PCA----------------------------------------------------------------------
ResPCA <- pcaBySvd(UCH$outcomes)
pcaScreePlot(ResPCA, nPC = 6)

## ----Scores-------------------------------------------------------------------
pcaScorePlot(
    resPcaBySvd = ResPCA, axes = c(1, 2),
    title = "PCA scores plot: PC1 and PC2",
    design = UCH$design,
    color = "Hippurate", shape = "Citrate",
    points_labs_rn = FALSE
)

pcaScorePlot(
    resPcaBySvd = ResPCA, axes = c(1, 2),
    title = "PCA scores plot: PC1 and PC2",
    design = UCH$design,
    color = "Time", shape = "Hippurate",
    points_labs_rn = FALSE
)

pcaScorePlot(
    resPcaBySvd = ResPCA, axes = c(3, 4),
    title = "PCA scores plot: PC3 and PC4",
    design = UCH$design,
    color = "Time", shape = "Citrate",
    points_labs_rn = FALSE
)

## ----Loadings-----------------------------------------------------------------
p2 <- pcaLoading1dPlot(
    resPcaBySvd = ResPCA, axes = c(1, 2),
    title = "PCA loadings plot UCH", xlab = "ppm",
    ylab = "Intensity"
)

p2 + hip_peaks + cit_peaks

## ----Formula------------------------------------------------------------------
UCH$formula <- "outcomes ~ Hippurate + Citrate + Time + Hippurate:Citrate +
                  Time:Hippurate + Time:Citrate + Hippurate:Citrate:Time"

## ----ModelMatrix--------------------------------------------------------------
resLmpModelMatrix <- lmpModelMatrix(UCH)
pander::pander(head(resLmpModelMatrix$modelMatrix))

## ----EffectMatrices-----------------------------------------------------------
resLmpEffectMatrices <- lmpEffectMatrices(resLmpModelMatrix)

## -----------------------------------------------------------------------------
pander(resLmpEffectMatrices$variationPercentages)
resLmpEffectMatrices$varPercentagesPlot

## ----Bootstrap----------------------------------------------------------------
resLmpBootstrapTests <-
    lmpBootstrapTests(
        resLmpEffectMatrices = resLmpEffectMatrices,
        nboot = 100
    )

# Print P-values
pander::pander(t(resLmpBootstrapTests$resultsTable))

## ----ASCA_PCA-----------------------------------------------------------------
resASCA <- lmpPcaEffects(
    resLmpEffectMatrices = resLmpEffectMatrices,
    method = "ASCA",
    combineEffects = list(c(
        "Hippurate", "Time",
        "Hippurate:Time"
    ))
)

## ----ASCA_Contrib-------------------------------------------------------------
resLmpContributions <- lmpContributions(resASCA)

## -----------------------------------------------------------------------------
pander::pander(resLmpContributions$totalContribTable)

## -----------------------------------------------------------------------------
pander::pander(resLmpContributions$effectTable)

## -----------------------------------------------------------------------------
pander::pander(resLmpContributions$combinedEffectTable)

## -----------------------------------------------------------------------------
pander::pander(resLmpContributions$contribTable)

## -----------------------------------------------------------------------------
pander("Ordered contributions per effect:")
resLmpContributions$plotTotal

pander("For each PC of the different effects:")
resLmpContributions$plotContrib

## ----include=TRUE-------------------------------------------------------------
all_loadings_pl <- lmpLoading1dPlot(resASCA,
    effectNames = c(
        "Hippurate", "Citrate", "Time",
        "Hippurate:Time",
        "Hippurate+Time+Hippurate:Time",
        "Residuals"
    ),
    axes = 1, xlab = "ppm"
)

## ----ASCA_ScoresXY------------------------------------------------------------
# Hippurate
hip_scores_pl <- lmpScorePlot(resASCA,
    effectNames = "Hippurate",
    color = "Hippurate", shape = "Hippurate"
)

hip_loadings_pl <- all_loadings_pl$Hippurate + hip_peaks

grid.arrange(hip_scores_pl, hip_loadings_pl, ncol = 2)

# Citrate
cit_scores_pl <- lmpScorePlot(resASCA,
    effectNames = "Citrate",
    color = "Citrate", shape = "Citrate"
)
cit_loadings_pl <- all_loadings_pl$Citrate + cit_peaks

grid.arrange(cit_scores_pl, cit_loadings_pl, ncol = 2)

# Time
tim_scores_pl <- lmpScorePlot(resASCA,
    effectNames = "Time", color = "Time",
    shape = "Time"
)

time_peaks <- annotate("rect",
    xmin = c(5.955364), xmax = c(6.155364),
    ymin = -Inf, ymax = Inf, alpha = 0.2,
    fill = c("royalblue")
)

tim_loadings_pl <- all_loadings_pl$Time + time_peaks

grid.arrange(tim_scores_pl, tim_loadings_pl, ncol = 2)

## -----------------------------------------------------------------------------
# Hippurate:Time
hiptim_scores_pl <- lmpScorePlot(resASCA,
    effectNames = "Hippurate:Time",
    color = "Hippurate", shape = "Time"
)
hiptim_loadings_pl <- all_loadings_pl$`Hippurate:Time` +
    time_peaks +
    hip_peaks

grid.arrange(hiptim_scores_pl, hiptim_loadings_pl, ncol = 2)

## -----------------------------------------------------------------------------
# Hippurate+Time+Hippurate:Time
hiptimInter_scores_pl <- lmpScorePlot(resASCA,
    effectNames = "Hippurate+Time+Hippurate:Time",
    color = "Hippurate", shape = "Time"
)

hiptimInter_loadings_pl <- all_loadings_pl$`Hippurate:Time` +
    time_peaks + hip_peaks

grid.arrange(hiptimInter_scores_pl, hiptimInter_loadings_pl, ncol = 2)

## ----Plot_Residuals-----------------------------------------------------------
resid_scores_pl <- lmpScorePlot(resASCA,
    effectNames = "Residuals",
    color = "Day", shape = "Day",
    drawShapes = "segment"
)


resid_loadings_pl <- all_loadings_pl$Residuals

grid.arrange(resid_scores_pl, resid_loadings_pl, ncol = 2)

## ----ASCA_ScoresMatrix, fig.height=7------------------------------------------
lmpScoreScatterPlotM(resASCA,
    PCdim = c(1, 1, 1, 1, 1, 1, 1, 2),
    modelAbbrev = TRUE,
    varname.colorup = "Citrate",
    varname.colordown = "Time",
    varname.pchup = "Hippurate",
    varname.pchdown = "Time",
    title = "ASCA scores scatterplot matrix"
)

## ----ASCA_loadings------------------------------------------------------------
lmpLoading2dPlot(
    resLmpPcaEffects = resASCA,
    effectNames = c("Hippurate"),
    axes = c(1, 2),
    addRownames = TRUE, pl_n = 10
)

# adding manually labels to points for the Hippurate peaks
labels <- substr(colnames(UCH$outcomes), 1, 4)
labels[-c(369, 132, 150, 133, 149, 144, 145, 368, 151)] <- ""

lmpLoading2dPlot(
    resLmpPcaEffects = resASCA,
    effectNames = c("Hippurate"),
    axes = c(1, 2), points_labs = labels
)

## -----------------------------------------------------------------------------
lmpEffectPlot(resASCA, effectName = "Hippurate", x = "Hippurate")

## -----------------------------------------------------------------------------
lmpEffectPlot(resASCA,
    effectName = "Hippurate:Time",
    x = "Hippurate", z = "Time"
)
lmpEffectPlot(resASCA,
    effectName = "Hippurate:Time",
    x = "Time", z = "Hippurate"
)

## ----ASCA_effects-------------------------------------------------------------
lmpEffectPlot(resASCA,
    effectName = "Hippurate+Time+Hippurate:Time",
    x = "Hippurate", z = "Time"
)
lmpEffectPlot(resASCA,
    effectName = "Hippurate+Time+Hippurate:Time",
    axes = c(2), x = "Time", z = "Hippurate"
)

## ----APCA_PCA-----------------------------------------------------------------
resAPCA <- lmpPcaEffects(
    resLmpEffectMatrices = resLmpEffectMatrices,
    method = "APCA"
)

## ----APCA_ScoresXY------------------------------------------------------------
# Hippurate main effect
lmpScorePlot(resAPCA,
    effectNames = "Hippurate",
    color = "Hippurate", shape = "Hippurate", drawShapes = "ellipse"
)

# Citrate main effect
lmpScorePlot(resAPCA,
    effectNames = "Citrate",
    color = "Citrate", shape = "Citrate", drawShapes = "ellipse"
)

# Time main effect
lmpScorePlot(resAPCA,
    effectNames = "Time",
    color = "Time", shape = "Time", drawShapes = "ellipse"
)
lmpScorePlot(resAPCA,
    effectNames = "Time",
    color = "Time", shape = "Time", drawShapes = "polygon"
)
lmpScorePlot(resAPCA,
    effectNames = "Time",
    color = "Time", shape = "Time", drawShapes = "segment"
)

# Interaction term
lmpScorePlot(resAPCA,
    effectNames = "Hippurate:Time",
    color = "Hippurate", shape = "Time", drawShapes = "segment"
)
lmpScorePlot(resAPCA,
    effectNames = "Hippurate:Time",
    color = "Hippurate", shape = "Time", drawShapes = "polygon"
)

## ----APCA_ScoresMatrix--------------------------------------------------------
lmpScoreScatterPlotM(resAPCA,
    effectNames = c(
        "Hippurate", "Citrate", "Time",
        "Hippurate:Time"
    ),
    modelAbbrev = TRUE,
    varname.colorup = "Citrate",
    varname.colordown = "Time",
    varname.pchup = "Hippurate",
    varname.pchdown = "Time",
    title = "APCA scores scatterplot matrix"
)

## ----APCA_loadings------------------------------------------------------------
lmpLoading1dPlot(resAPCA, effectNames = c(
    "Hippurate", "Citrate",
    "Time", "Hippurate:Time"
), axes = 1)

## ----ASCAE_PCA----------------------------------------------------------------
resASCAE <- lmpPcaEffects(
    resLmpEffectMatrices = resLmpEffectMatrices,
    method = "ASCA-E"
)

## ----ASCAE_ScoresXY-----------------------------------------------------------
lmpScorePlot(resASCAE,
    effectNames = "Hippurate",
    color = "Hippurate", shape = "Hippurate"
)
lmpScorePlot(resASCAE,
    effectNames = "Citrate",
    color = "Citrate", shape = "Citrate"
)
lmpScorePlot(resASCAE,
    effectNames = "Time",
    color = "Time", shape = "Time"
)
lmpScorePlot(resASCAE,
    effectNames = "Hippurate:Time",
    color = "Hippurate", shape = "Time"
)

## ----ASCAE_ScoresMatrix-------------------------------------------------------
lmpScoreScatterPlotM(resASCAE,
    effectNames = c(
        "Hippurate", "Citrate", "Time",
        "Hippurate:Time"
    ),
    modelAbbrev = TRUE,
    varname.colorup = "Citrate",
    varname.colordown = "Time",
    varname.pchup = "Hippurate",
    varname.pchdown = "Time",
    title = "ASCA-E scores scatterplot matrix"
)

## -----------------------------------------------------------------------------
sessionInfo()

