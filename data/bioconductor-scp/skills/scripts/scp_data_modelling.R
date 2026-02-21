# Code example from 'scp_data_modelling' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL
    ## cf https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## ----message = FALSE----------------------------------------------------------
library("scp")
library("SingleCellExperiment")
library("patchwork")
library("ggplot2")

## -----------------------------------------------------------------------------
data("leduc_minimal")
leduc_minimal

## ----technical_variables1-----------------------------------------------------
table(leduc_minimal$Set)

## ----technical_variables2-----------------------------------------------------
table(leduc_minimal$Channel)

## ----technical_variables3-----------------------------------------------------
hist(leduc_minimal$MedianIntensity, breaks = 10)

## ----biological_variable------------------------------------------------------
table(leduc_minimal$SampleType)

## ----formula------------------------------------------------------------------
f <- ~ 1 + ## intercept
    Channel + Set + ## batch variables
    MedianIntensity + ## normalization
    SampleType ## biological variable

## ----message=FALSE, results='hide'--------------------------------------------
leduc_minimal <- scpModelWorkflow(leduc_minimal, formula = f)

## ----scpModelFormula----------------------------------------------------------
scpModelFormula(leduc_minimal)

## ----scpModelEffects----------------------------------------------------------
scpModelEffects(leduc_minimal)

## ----scpModelResiduals--------------------------------------------------------
scpModelResiduals(leduc_minimal)[1:5, 1:5]

## ----scpModelInput------------------------------------------------------------
scpModelInput(leduc_minimal)[1:5, 1:5]

## ----dim_scpModelInput--------------------------------------------------------
dim(scpModelInput(leduc_minimal))

## -----------------------------------------------------------------------------
table(missing = is.na(assay(leduc_minimal)))

## ----scpModelFilterNPRatio----------------------------------------------------
head(scpModelFilterNPRatio(leduc_minimal))

## ----scpModelFilterPlot-------------------------------------------------------
scpModelFilterPlot(leduc_minimal)

## ----set_np_threshold---------------------------------------------------------
scpModelFilterThreshold(leduc_minimal) ## default is 1
scpModelFilterThreshold(leduc_minimal) <- 1.5
scpModelFilterThreshold(leduc_minimal) ## threshold is now 1.5

## ----scpModelFilterPlot2------------------------------------------------------
scpModelFilterPlot(leduc_minimal)

## ----scpVarianceAnalysis------------------------------------------------------
(vaRes <- scpVarianceAnalysis(leduc_minimal))

## ----vaRes_SampleType, out.width = "40%"--------------------------------------
vaRes$SampleType

## ----fig.width=2.5, fig.height=4----------------------------------------------
scpVariancePlot(vaRes)

## ----fig.width=10, fig.height=7-----------------------------------------------
scpVariancePlot(
    vaRes, top = 10, by = "percentExplainedVar", effect = "SampleType",
    decreasing = TRUE, combined = FALSE
) +
    scpVariancePlot(
    vaRes, top = 10, by = "percentExplainedVar", effect = "Set",
    decreasing = TRUE, combined = FALSE
) +
    plot_layout(ncol = 1, guides = "collect")

## -----------------------------------------------------------------------------
vaRes <- scpAnnotateResults(
    vaRes, rowData(leduc_minimal), by = "feature", by2 = "Sequence"
)
vaRes$SampleType

## ----scpVariancePlot_protein, fig.width=10, fig.height=7----------------------
scpVariancePlot(
    vaRes, top = 10, by = "percentExplainedVar", effect = "SampleType",
    decreasing = TRUE, combined = FALSE, fcol = "gene"
) +
    scpVariancePlot(
    vaRes, top = 10, by = "percentExplainedVar", effect = "Set",
    decreasing = TRUE, combined = FALSE, fcol = "gene"
) +
    plot_layout(ncol = 1, guides = "collect")

## ----scpVarianceAggregate-----------------------------------------------------
vaProtein <- scpVarianceAggregate(vaRes, fcol = "gene")
scpVariancePlot(
    vaProtein, effect = "SampleType", top = 10, combined = FALSE
)

## ----scpDifferentialAnalysis--------------------------------------------------
(daRes <- scpDifferentialAnalysis(
    leduc_minimal,
    contrasts = list(c("SampleType", "Melanoma", "Monocyte"))
))

## ----daRes$SampleType_Melanoma_vs_Monocyte------------------------------------
daRes$SampleType_Melanoma_vs_Monocyte

## -----------------------------------------------------------------------------
scpVolcanoPlot(daRes)

## -----------------------------------------------------------------------------
daRes <- scpAnnotateResults(
    daRes, rowData(leduc_minimal),
    by = "feature", by2 = "Sequence"
)
np <- scpModelFilterNPRatio(leduc_minimal)
daRes <- scpAnnotateResults(
    daRes, data.frame(feature = names(np), npRatio = np),
    by = "feature"
)

## -----------------------------------------------------------------------------
scpVolcanoPlot(
    daRes, top = 30, textBy = "gene",
    pointParams = list(aes(colour = npRatio), size = 1.5, shape = 3)
)

## ----scpDifferentialAggregate-------------------------------------------------
byProteinDA <- scpDifferentialAggregate(
    daRes, fcol = "gene", method = "simes"
)
byProteinDA$SampleType_Melanoma_vs_Monocyte

## ----component_analysis-------------------------------------------------------
(caRes <- scpComponentAnalysis(
    leduc_minimal, ncomp = 20, method = "APCA", effect = "SampleType"
))

## ----component_bySample-------------------------------------------------------
(caResCells <- caRes$bySample)
caResCells[[1]]

## ----annotate_components------------------------------------------------------
leduc_minimal$cell <- colnames(leduc_minimal)
caResCells <- scpAnnotateResults(
    caResCells, colData(leduc_minimal), by = "cell"
)

## ----scpComponentPlot_cell, fig.height=9, fig.width=5-------------------------
scpComponentPlot(
    caResCells,
    pointParams = list(aes(shape = SampleType, colour = Set))
) |>
    wrap_plots(ncol = 1, guides = "collect")

## ----addReducedDims-----------------------------------------------------------
leduc_minimal <- addReducedDims(leduc_minimal, caResCells)
reducedDims(leduc_minimal)

## ----t-SNE, fig.height=3, fig.width=4-----------------------------------------
library("scater")
leduc_minimal <- runTSNE(leduc_minimal, dimred = "APCA_SampleType")
plotTSNE(leduc_minimal, colour_by = "Set", shape_by = "SampleType") +
    ggtitle("t-SNE on 20 APCA components")

## ----scpComponentPlot_peptide, fig.height=9, fig.width=5----------------------
caResPeps <- caRes$byFeature
caResPeps <- scpAnnotateResults(
    caResPeps, rowData(leduc_minimal), by = "feature", by2 = "Sequence"
)
scpComponentPlot(
    caResPeps, pointParams = list(size = 0.8, alpha = 0.4)
) |>
    wrap_plots(ncol = 1)

## ----biplot, warning=FALSE, fig.height=9, fig.width=5-------------------------
scpComponentBiplot(
    caResCells, caResPeps,
    pointParams = list(aes(colour = SampleType)),
    labelParams = list(size = 1.5, max.overlaps = 15),
    textBy = "gene", top = 10
) |>
    wrap_plots(ncol = 1, guides = "collect")

## ----scpComponentAggregate, fig.width=9, fig.height=3-------------------------
caResProts <- scpComponentAggregate(caResPeps, fcol = "gene")
caResProts$APCA_SampleType

## ----batch_correction---------------------------------------------------------
(leduc_batchCorrect <- scpRemoveBatchEffect(
    leduc_minimal, effects = c("Set", "Channel", "MedianIntensity"),
    intercept = TRUE
))

## ----setup2, include = FALSE--------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "",
    crop = NULL
)

## ----sessioninfo, echo=FALSE--------------------------------------------------
sessionInfo()

