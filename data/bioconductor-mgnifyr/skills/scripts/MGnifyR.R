# Code example from 'MGnifyR' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
library(knitr)
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    cache = TRUE
)

# Get already loaded results
path <- system.file("extdata", "vignette_MGnifyR.rds", package = "MGnifyR")
vignette_MGnifyR <- readRDS(path)

## ----install, eval=FALSE------------------------------------------------------
# BiocManager::install("MGnifyR")

## ----load_package-------------------------------------------------------------
library(MGnifyR)

## ----create_client, message = FALSE-------------------------------------------
mg <- MgnifyClient(useCache = TRUE)
mg

## ----search_studies1, eval=FALSE----------------------------------------------
# # Fetch studies
# samples <- doQuery(
#     mg,
#     type = "samples",
#     biome_name = "root:Environmental:Aquatic:Freshwater:Drinking water",
#     max.hits = 10)

## ----search_studies2, eval=TRUE, include=FALSE--------------------------------
samples <- vignette_MGnifyR[["samples"]]

## ----search_studies3----------------------------------------------------------
colnames(samples) |> head()

## ----convert_to_analyses1, eval=FALSE-----------------------------------------
# analyses_accessions <- searchAnalysis(mg, "samples", samples$accession)

## ----convert_to_analyses2, eval=TRUE, include=FALSE---------------------------
analyses_accessions <- vignette_MGnifyR[["analyses_accessions"]]

## ----convert_to_analyses3-----------------------------------------------------
analyses_accessions |> head()

## ----get_metadata1, eval=FALSE------------------------------------------------
# analyses_metadata <- getMetadata(mg, analyses_accessions)

## ----get_metadata2, eval=TRUE, include=FALSE----------------------------------
analyses_metadata <- vignette_MGnifyR[["analyses_metadata"]]

## ----get_metadata3------------------------------------------------------------
colnames(analyses_metadata) |> head()

## ----get_mae1, eval=FALSE-----------------------------------------------------
# mae <- getResult(mg, accession = analyses_accessions)

## ----get_mae2, eval=TRUE, include=FALSE---------------------------------------
mae <- vignette_MGnifyR[["mae"]]

## ----get_mae3-----------------------------------------------------------------
mae

## ----mae_access---------------------------------------------------------------
mae[[1]]

## ----calculate_diversity, fig.width=9-----------------------------------------
library(mia)

mae[[1]] <- estimateDiversity(mae[[1]], index = "shannon")

library(scater)

plotColData(mae[[1]], "shannon", x = "sample_environment..biome.")

## ----plot_abundance-----------------------------------------------------------
# Agglomerate data
altExps(mae[[1]]) <- splitByRanks(mae[[1]])

library(miaViz)

# Plot top taxa
top_taxa <- getTopFeatures(altExp(mae[[1]], "Phylum"), 10)
plotAbundance(
    altExp(mae[[1]], "Phylum")[top_taxa, ],
    rank = "Phylum",
    as.relative = TRUE
    )

## ----pcoa---------------------------------------------------------------------
# Apply relative transformation
mae[[1]] <- transformAssay(mae[[1]], method = "relabundance")
# Perform PCoA
mae[[1]] <- runMDS(
    mae[[1]], assay.type = "relabundance",
    FUN = vegan::vegdist, method = "bray")
# Plot
plotReducedDim(
    mae[[1]], "MDS", colour_by = "sample_environment..biome.")

## ----fetch_data1, eval=FALSE--------------------------------------------------
# publications <- getData(mg, type = "publications")

## ----fetch_data2, eval=TRUE, include=FALSE------------------------------------
publications <- vignette_MGnifyR[["publications"]]

## ----fetch_data3--------------------------------------------------------------
colnames(publications) |> head()

## ----get_download_urls1, eval=FALSE-------------------------------------------
# dl_urls <- searchFile(mg, analyses_accessions, type = "analyses")

## ----get_download_urls2, eval=TRUE, include=FALSE-----------------------------
dl_urls <- vignette_MGnifyR[["dl_urls"]]

## ----get_download_urls3-------------------------------------------------------
target_urls <- dl_urls[
    dl_urls$attributes.description.label == "Predicted alpha tmRNA", ]

colnames(target_urls) |> head()

## ----download_file1, eval=FALSE-----------------------------------------------
# # Just select a single file from the target_urls list for demonstration.
# file_url <- target_urls$download_url[[1]]
# cached_location <- getFile(mg, file_url)

## ----download_file2, eval=TRUE, include=FALSE---------------------------------
cached_location <- vignette_MGnifyR[["cached_location"]]

## ----download_file3-----------------------------------------------------------
# Where are the files?
cached_location

## ----session_info-------------------------------------------------------------
sessionInfo()

