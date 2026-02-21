# Code example from 'Tutorial_AnalysisOfGenomicRegions' vignette. See references/ for full tutorial.

## ----libraries, echo=FALSE, message=FALSE, warning=FALSE----------------------
suppressPackageStartupMessages({
library(RcisTarget)
})

## -----------------------------------------------------------------------------
packageVersion("RcisTarget")

## -----------------------------------------------------------------------------
# download.file("https://gbiomed.kuleuven.be/apps/lcb/i-cisTarget/examples/input_files/human/peaks/Encode_GATA1_peaks.bed", "Encode_GATA1_peaks.bed")
txtFile <- paste(file.path(system.file('examples', package='RcisTarget')),"Encode_GATA1_peaks.bed", sep="/")
regionsList <- rtracklayer::import.bed(txtFile)
regionSets <- list(GATA1_peaks=regionsList)

## ----eval=FALSE---------------------------------------------------------------
# library(RcisTarget)
# # Motif rankings
# featherFilePath <- "~/databases/hg19-regions-9species.all_regions.mc9nr.feather"
# 
# ## Motif - TF annotation:
# data(motifAnnotations_hgnc_v9) # human TFs (for motif collection 9)
# motifAnnotation <- motifAnnotations_hgnc_v9
# 
# # Regions location *
# data(dbRegionsLoc_hg19)
# dbRegionsLoc <- dbRegionsLoc_hg19

## ----eval=FALSE---------------------------------------------------------------
# dbRegionsLoc <- getDbRegionsLoc(featherFilePath)

## ----eval=FALSE---------------------------------------------------------------
# # Convert regions
# regionSets_db <- lapply(regionSets, function(x) convertToTargetRegions(queryRegions=x, targetRegions=dbRegionsLoc))
# 
# # Import rankings
# allRegionsToImport <- unique(unlist(regionSets_db)); length(allRegionsToImport)
# motifRankings <- importRankings(featherFilePath, columns=allRegionsToImport)
# 
# # Run RcisTarget
# motifEnrichmentTable <- cisTarget(regionSets_db, motifRankings, aucMaxRank=0.005*getNumColsInDB(motifRankings))
# 
# # Show output:
# showLogo(motifEnrichmentTable)

