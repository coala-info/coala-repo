# Code example from 'proteinWorkflow' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    fig.width=7, fig.height=4.5,
    collapse = TRUE,
    eval = TRUE,
    comment = "#>"
)

## -----------------------------------------------------------------------------
library(ComPrAn)
inputFile <- system.file("extData", "dataNormProts.txt", package = "ComPrAn")

forAnalysis <- protImportForAnalysis(inputFile)

## -----------------------------------------------------------------------------
protein <- "P52815"
max_frac <- 23
# example protein plot, quantitative comparison between labeled and unlabeled
# samples (default settings)
proteinPlot(forAnalysis[forAnalysis$scenario == "B",], protein, max_frac)

## ----groupHeatMap, fig.width=7, fig.height=6.7--------------------------------
groupDataFileName <- system.file("extData","exampleGroup.txt",package="ComPrAn")
groupName <- 'group1'
groupData <- data.table::fread(groupDataFileName)
# example heatmap, quantitative comparison between labeled and unlabeled samples
# (default settings)
groupHeatMap(dataFrame = forAnalysis[forAnalysis$scenario == "B",],
                groupData, groupName)

## -----------------------------------------------------------------------------
groupDataVector <- c("Q16540","P52815","P09001","Q13405","Q9H2W6")
groupName <- 'group1' 
max_frac <- 23 
# example co-migration plot, non-quantitative comparison of migration profile 
# of a sigle protein goup between labeled and unlabeled samples 
# (default settings)
oneGroupTwoLabelsCoMigration(forAnalysis, max_frac = max_frac, 
                                groupDataVector,groupName)


## -----------------------------------------------------------------------------
group1DataVector <- c("Q16540","P52815","P09001","Q13405","Q9H2W6")
group1Name <- 'group1' 
group2DataVector <- c("Q9NVS2","Q9NWU5","Q9NX20","Q9NYK5","Q9NZE8")
group2Name <- 'group2'
max_frac <- 23 
# example co-migration plot, non-quantitative comparison of migration profile 
# of two protein goups within label states (default settings)
twoGroupsWithinLabelCoMigration(dataFrame = forAnalysis, max_frac = max_frac, 
                                group1Data = group1DataVector, 
                                group1Name = group1Name,
                                group2Data = group2DataVector, 
                                group2Name = group2Name)

## -----------------------------------------------------------------------------
clusteringDF <- clusterComp(forAnalysis,scenar = "A", PearsCor = "centered")

## -----------------------------------------------------------------------------
labTab_clust <- assignClusters(.listDf = clusteringDF,sample = "labeled",
                                    method = 'average', cutoff = 0.85)
unlabTab_clust <- assignClusters(.listDf = clusteringDF,sample = "unlabeled",
                                    method = 'average', cutoff = 0.85)

## ----clusterBar, fig.width=4, fig.height=2.5----------------------------------
makeBarPlotClusterSummary(labTab_clust, name = 'labeled')
makeBarPlotClusterSummary(unlabTab_clust, name = 'unlabeled')

## -----------------------------------------------------------------------------
tableForClusterExport <- exportClusterAssignments(labTab_clust,unlabTab_clust)

