# Code example from 'bettr' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("bettr")

## -----------------------------------------------------------------------------
suppressPackageStartupMessages({
    library("bettr")
    library("SummarizedExperiment")
    library("tibble")
    library("dplyr")
})

## -----------------------------------------------------------------------------
## Data for two metrics (metric1, metric2) for three methods (M1, M2, M3)
df <- data.frame(Method = c("M1", "M2", "M3"),
                 metric1 = c(1.0, 2.0, 3.0),
                 metric2 = c(3.0, 1.0, 2.0))

## More information for metrics
metricInfo <- data.frame(Metric = c("metric1", "metric2", "metric3"),
                         Group = c("G1", "G2", "G2"))

## More information for methods ('IDs')
idInfo <- data.frame(Method = c("M1", "M2", "M3"),
                     Type = c("T1", "T1", "T2"))

## -----------------------------------------------------------------------------
se <- assembleSE(df = df, idCol = "Method", metricInfo = metricInfo,
                 idInfo = idInfo)
se

## -----------------------------------------------------------------------------
# ## Alternative 1
# bettr(bettrSE = se)
# 
# ## Alternative 2
# bettr(df = df, idCol = "Method", metricInfo = metricInfo, idInfo = idInfo)

## -----------------------------------------------------------------------------
res <- read.csv(system.file("extdata", "duo2018_results.csv",
                            package = "bettr"))
dim(res)
tibble(res)

## -----------------------------------------------------------------------------
metricInfo <- tibble(Metric = colnames(res)[-1L]) |>
    mutate(Class = sub("_.*", "", Metric))
head(metricInfo)
table(metricInfo$Class)

## -----------------------------------------------------------------------------
## Initialize list
initialTransforms <- lapply(res[, grep("elapsed|nclust.vs.true|s.norm.vs.true",
                                       colnames(res), value = TRUE)],
                            function(i) {
                                list(flip = TRUE, transform = "[0,1]")
                            })

length(initialTransforms)
names(initialTransforms)
head(initialTransforms)

## -----------------------------------------------------------------------------
metricColors <- list(
    Class = c(ARI = "purple", elapsed = "forestgreen",
              nclust.vs.true = "blue",
              s.norm.vs.true = "orange")
)
idColors <- list(
    method = c(
        CIDR = "#332288", FlowSOM = "#6699CC", PCAHC = "#88CCEE",
        PCAKmeans = "#44AA99", pcaReduce = "#117733",
        RtsneKmeans = "#999933", Seurat = "#DDCC77", SC3svm = "#661100",
        SC3 = "#CC6677", TSCAN = "grey34", ascend = "orange", SAFE = "black",
        monocle = "red", RaceID2 = "blue"
    )
)

## -----------------------------------------------------------------------------
duo2018 <- assembleSE(df = res, idCol = "method", metricInfo = metricInfo,
                      initialTransforms = initialTransforms,
                      metricColors = metricColors, idColors = idColors)
duo2018

## -----------------------------------------------------------------------------
## Display the whole performance table
tibble(assay(duo2018, "values"))

## Showing the first metric, evaluated on all datasets
head(colData(duo2018), 12L)

## These are the color definitions (can mix character and hex values)
metadata(duo2018)$bettrInfo$idColors
metadata(duo2018)$bettrInfo$metricColors

names(metadata(duo2018)$bettrInfo$initialTransforms)

## An example of a transformation - elapsed time for the Koh dataset
metadata(duo2018)$bettrInfo$initialTransforms$elapsed_Koh

## -----------------------------------------------------------------------------
# bettr(bettrSE = duo2018, bstheme = "sandstone")

## -----------------------------------------------------------------------------
## Assign a higher weight to one of the collapsed metric classes
metadata(duo2018)$bettrInfo$initialWeights["Class_ARI"] <- 0.55

prepData <- bettrGetReady(
    bettrSE = duo2018, idCol = "method",
    scoreMethod = "weighted mean", metricGrouping = "Class",
    metricCollapseGroup = TRUE
)

## This object is fairly verbose and detailed,
## but has the whole set of info needed
prepData

## Call the plotting routines specifying one single parameter
makeHeatmap(bettrList = prepData)
makePolarPlot(bettrList = prepData)

## -----------------------------------------------------------------------------
if (interactive()) {
    app <- bettr(bettrSE = duo2018, bstheme = "sandstone")
    out <- shiny::runApp(app)
}

## -----------------------------------------------------------------------------
sessionInfo()

