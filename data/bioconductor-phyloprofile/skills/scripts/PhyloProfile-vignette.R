# Code example from 'PhyloProfile-vignette' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    library(PhyloProfile),
    collapse = TRUE,
    comment = "#>",
    dev = 'png',
    crop = NULL
)

## ----example_input, echo = FALSE, results = 'asis'----------------------------
data("mainLongRaw", package="PhyloProfile")
knitr::kable(head(mainLongRaw, 10), row.names = FALSE)

## ----poster, echo=FALSE, fig.cap="PhyloProfile's GUI", out.width = '100%'-----
knitr::include_graphics("./posterSub.png")

## ----profile-clustering, fig.show='hold', dev='png'---------------------------
### An example for plotting the clustered profiles tree.
### See ?getDendrogram for more details.

#' Load built-in data
data("finalProcessedProfile", package="PhyloProfile")
data <- finalProcessedProfile

#' Calculate distance matrix
#' Check ?getDistanceMatrix
profileType <- "binary"
profiles <- getDataClustering(
    data, profileType, var1AggregateBy, var2AggregateBy)
method <- "mutualInformation"
distanceMatrix <- getDistanceMatrix(profiles, method)

#' Create clustered profile tree
clusterMethod <- "complete"
dd <- clusterDataDend(as.dist(distanceMatrix), clusterMethod)
getDendrogram(dd)

## ----gene-age-----------------------------------------------------------------
### An example for calculating gene age for the built-in data set.
### See ?estimateGeneAge for more details.
#' Load built-in data
data("fullProcessedProfile", package="PhyloProfile")

#' Choose the working rank and the reference taxon
rankName <- "class"
refTaxon <- "Mammalia"

#' Count taxa within each supertaxon
taxonIDs <- levels(as.factor(fullProcessedProfile$ncbiID))
sortedInputTaxa <- sortInputTaxa(
    taxonIDs, rankName, refTaxon, NULL, NULL, NULL
)
library(dplyr)
taxaCount <- sortedInputTaxa %>% dplyr::count(supertaxon)

#' Set cutoff for 2 additional variables and the percentage of present species
#' in each supertaxon
var1Cutoff <- c(0,1)
var2Cutoff <- c(0,1)
percentCutoff <- c(0,1)

#' Estimate gene age
estimateGeneAge(
    fullProcessedProfile, taxaCount, rankName, refTaxon,
    var1Cutoff, var2Cutoff, percentCutoff
)

## ----core-gene----------------------------------------------------------------
### An example for calculating core gene set for the built-in data set.
### See ?getCoreGene for more details.

#' Load built-in data
data("fullProcessedProfile", package="PhyloProfile")

#' Choose the working rank and a set of taxa of interest
rankName <- "class"
refTaxon <- "Mammalia"
taxaCore <- c("Mammalia", "Saccharomycetes", "Insecta")

#' Set cutoff for 2 additional variables and the percentage of present species
#' in each supertaxon
var1Cutoff <- c(0.75, 1.0)
var2Cutoff <- c(0.75, 1.0)
percentCutoff <- c(0.0, 1.0)

#' Set core coverage, the % of taxa that must be present in the selected set
coreCoverage <- 1

#' Count taxa within each supertaxon
taxonIDs <- levels(as.factor(fullProcessedProfile$ncbiID))
sortedInputTaxa <- sortInputTaxa(
    taxonIDs, rankName, refTaxon, NULL, NULL, NULL
)
taxaCount <- sortedInputTaxa %>% dplyr::count(supertaxon)

#' Identify core genes
getCoreGene(
    rankName,
    taxaCore,
    fullProcessedProfile,
    taxaCount,
    var1Cutoff, var2Cutoff,
    percentCutoff, coreCoverage
)

## ----group-comparison---------------------------------------------------------
#' Load built-in data
data("mainLongRaw", package="PhyloProfile")
data <- mainLongRaw
#' choose the in-group taxa
inGroup <- c("ncbi9606", "ncbi10116")
#' choose variable to be compared
variable <- colnames(data)[4]
#' compare the selected variable between the in-group and out-group taxa
compareTaxonGroups(data, inGroup, TRUE, variable, 0.05)

## ----distribution-analysis, fig.show='hold', dev='png'------------------------
### An example for plotting the distribution of the 1st additional variable.
### See ?createVarDistPlot for more details.

#' Load built-in data
data("mainLongRaw", package="PhyloProfile")

#' Process data for distribution analysis
#' See ?createVariableDistributionData
data <- createVariableDistributionData(
    mainLongRaw, c(0, 1), c(0.5, 1)
)
head(data, 6)

#' Choose a variable for plotting and set the variable name
varType <- "var1"
varName <- "Variable 1"

#' Set cutoff for the percentage of present species in each supertaxon
percentCutoff <- c(0,1)

#' Set text size
distTextSize <- 12

#' Create distribution plot
createVarDistPlot(
    data,
    varName,
    varType,
    percentCutoff,
    distTextSize
)

## ----process-input------------------------------------------------------------
#' Load built-in data
#' If input data is in other format (e.g. fasta, OrthoXML, or wide matrix),
#' see ?createLongMatrix
rawInput <- system.file(
    "extdata", "test.main.long", package = "PhyloProfile", mustWork = TRUE
)

#' Set working rank and the reference taxon
rankName <- "class"
refTaxon <- "Mammalia"

#' Input a user-defined taxonomy tree to replace NCBI taxonomy tree (optional)
taxaTree <- NULL
#' Or a sorted taxon list (optional)
sortedTaxonList <- NULL

#' Choose how to aggregate the additional variables when pocessing the data
#' into supertaxon
var1AggregateBy <- "max"
var2AggregateBy <- "mean"

#' Set cutoffs for for percentage of species present in a supertaxon,
#' allowed number of co orthologs, and cutoffs for the additional variables
percentCutoff <- c(0.0, 1.0)
coorthologCutoffMax <- 10
var1Cutoff <- c(0.75, 1.0)
var2Cutoff <- c(0.5, 1.0)

#' Choose the relationship of the additional variables, if they are related to
#' the orthologous proteins or to the species
var1Relation <- "protein"
var2Relation <- "species"

#' Identify categories for input genes (by a mapping tab-delimited file)
groupByCat <- FALSE
catDt <- NULL

#' Process the input file into a phylogenetic profile data that contains
#' taxonomy information and the aggregated values for the 2 additional variables
profileData <- fromInputToProfile(
    rawInput,
    rankName,
    refTaxon,
    taxaTree,
    sortedTaxonList,
    var1AggregateBy,
    var2AggregateBy,
    percentCutoff,
    coorthologCutoffMax,
    var1Cutoff,
    var2Cutoff,
    var1Relation,
    var2Relation,
    groupByCat,
    catDt
)

head(profileData)

## ----profile-plot, fig.show='hold', dev='png'---------------------------------
#' Load built-in processed data
data("finalProcessedProfile", package="PhyloProfile")

#' Create data for plotting
plotDf <- dataMainPlot(finalProcessedProfile)

#' You can also choose a subset of genes and/or taxa for plotting with:
#' selectedTaxa <- c("Mammalia", "Echinoidea", "Gunneridae")
#' selectedSeq <- "all"
#' plotDf <- dataCustomizedPlot(
#'     finalProcessedProfile, selectedTaxa, selectedSeq
#' )

#' Identify plot's parameters
plotParameter <- list(
    "xAxis" = "taxa",
    "var1ID" = "FAS_FW",
    "var2ID"  = "FAS_BW",
    "midVar1" = 0.5,
    "midColorVar1" =  "#FFFFFF",
    "lowColorVar1" =  "#FF8C00",
    "highColorVar1" = "#4682B4",
    "midVar2" = 1,
    "midColorVar2" =  "#FFFFFF",
    "lowColorVar2" = "#CB4C4E",
    "highColorVar2" = "#3E436F",
    "paraColor" = "#07D000",
    "xSize" = 8,
    "ySize" = 8,
    "legendSize" = 8,
    "mainLegend" = "top",
    "dotZoom" = 0,
    "xAngle" = 60,
    "guideline" = 0,
    "colorByGroup" = FALSE,
    "colorByOrthoID" = FALSE
)

#' Generate profile plot
p <- heatmapPlotting(plotDf, plotParameter)
p
#' To highlight a gene and/or taxon of interest
taxonHighlight <- "Mammalia"
workingRank <- "class"
geneHighlight <- "none"
#' Then use ?highlightProfilePlot function
# highlightProfilePlot(
#    p, plotDf, taxonHighlight, workingRank, geneHighlight, plotParameter$xAxis
# )

## ----domain-plot, fig.show='hold', dev='png'----------------------------------
#' Load protein domain architecture file
domainFile <- system.file(
    "extdata", "domainFiles/101621at6656.domains",
    package = "PhyloProfile", mustWork = TRUE
)

#' Identify IDs of gene of interest and its ortholog partner
seedID <- "101621at6656"
orthoID <- "101621at6656|AGRPL@224129@0|224129_0:001955|1"
info <- c(seedID, orthoID)

#' Get data for 2 selected genes from input file
domainDf <- parseDomainInput(seedID, domainFile, "file")

#' Modify feature IDs
domainDf$feature_id_mod <- domainDf$feature_id
domainDf$feature_id_mod <- gsub("SINGLE", "LCR", domainDf$feature_id_mod)
domainDf$feature_id_mod[domainDf$feature_type == "coils"] <- "Coils"
domainDf$feature_id_mod[domainDf$feature_type == "seg"] <- "LCR"
domainDf$feature_id_mod[domainDf$feature_type == "tmhmm"] <- "TM"

#' Generate plot
plot <- createArchiPlot(info, domainDf, 9, 9)
grid::grid.draw(plot)

## ----get-tax-id-name----------------------------------------------------------
#' Load raw input
data("mainLongRaw", package="PhyloProfile")
inputDf <- mainLongRaw

#' Set working rank and the reference taxon
rankName <- "phylum"

#' Get taxonomy IDs and names for the input data
inputTaxonID <- getInputTaxaID(inputDf)
inputTaxonName <- getInputTaxaName(rankName, inputTaxonID)

head(inputTaxonName)

## ----sort-taxa----------------------------------------------------------------
#' Get list of taxon IDs and names for input profile
data("mainLongRaw", package="PhyloProfile")
inputDf <- mainLongRaw
rankName <- "phylum"
inputTaxonID <- getInputTaxaID(inputDf)

#' Input a user-defined taxonomy tree to replace NCBI taxonomy tree (optional)
inputTaxaTree <- NULL

#' Sort taxonomy list based on a selected refTaxon
refTaxon <- "Chordata"
sortedTaxonomy <- sortInputTaxa(
    taxonIDs = inputTaxonID,
    rankName = rankName,
    refTaxon = refTaxon,
    taxaTree = inputTaxaTree,
    NULL,
    NULL
)

head(
    sortedTaxonomy[
        , c("ncbiID", "fullName", "supertaxon", "supertaxonID", "rank")
    ]
)

## ----citation-----------------------------------------------------------------
citation("PhyloProfile")

## ----sessionInfo, echo = FALSE------------------------------------------------
sessionInfo(package = "PhyloProfile")

