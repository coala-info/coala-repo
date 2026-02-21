# Code example from 'gettingStarted' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
# These settings make the vignette prettier
knitr::opts_chunk$set(results="hold", message=FALSE)

## ----Load a regionDB----------------------------------------------------------
library("LOLA")
dbPath = system.file("extdata", "hg19", package="LOLA")
regionDB = loadRegionDB(dbPath)

## ----Look at the elements of a regionDB---------------------------------------
names(regionDB)

## ----Load sample user sets and universe---------------------------------------
data("sample_input", package="LOLA") # load userSets
data("sample_universe", package="LOLA") # load userUniverse

## ----Run the calculation------------------------------------------------------
locResults = runLOLA(userSets, userUniverse, regionDB, cores=1)

## -----------------------------------------------------------------------------
colnames(locResults)
head(locResults)

## -----------------------------------------------------------------------------
locResults[order(support, decreasing=TRUE),]

## -----------------------------------------------------------------------------
locResults[order(maxRnk, decreasing=TRUE),]

## ----Write results------------------------------------------------------------
writeCombinedEnrichment(locResults, outFolder= "lolaResults")

## ----Write split results------------------------------------------------------
writeCombinedEnrichment(locResults, outFolder= "lolaResults", includeSplits=TRUE)

## ----Extracting overlaps------------------------------------------------------
oneResult = locResults[2,]
extractEnrichmentOverlaps(oneResult, userSets, regionDB)

## ----Grabbing individual region sets------------------------------------------
getRegionSet(regionDB, collections="ucsc_example", filenames="vistaEnhancers.bed")

## ----Grabbing individual region sets from disk--------------------------------
getRegionSet(dbPath, collections="ucsc_example", filenames="vistaEnhancers.bed")

