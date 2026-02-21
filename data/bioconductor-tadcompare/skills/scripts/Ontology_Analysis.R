# Code example from 'Ontology_Analysis' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----eval = FALSE-------------------------------------------------------------
# BiocManager::install("TADCompare")

## ----echo = FALSE, warning = FALSE, message=FALSE-----------------------------
library(dplyr)
library(TADCompare)

## ----warning=FALSE, message = FALSE, eval=FALSE-------------------------------
# library(rGREAT)
# # Reading in data
# data("rao_chr22_prim")
# data("rao_chr22_rep")
# 
# # Performing differential analysis
# results <- TADCompare(rao_chr22_prim, rao_chr22_rep, resolution = 50000)
# 
# # Saving the results into its own data frame
# TAD_Frame <- results$TAD_Frame
# 
# # Filter data to only include complex boundaries enriched in the second
# # contact matrix
# TAD_Frame <- TAD_Frame %>% dplyr::filter((Type == "Shifted") &
#                                          (Enriched_In == "Matrix 2"))
# 
# # Assign a chromosome and convert to a bed format
# TAD_Frame <- TAD_Frame %>% dplyr::select(Boundary) %>% mutate(chr = "chr22",
#     start = Boundary, end = Boundary) %>% dplyr::select(chr, start, end)
# 
# # Set up rGREAT job with default parameters
# great_shift <- submitGreatJob(TAD_Frame, request_interval = 1, version = "2.0")
# 
# # Submit the job
# enrichment_table <- getEnrichmentTables(great_shift)
# 
# # Subset to only include vital information
# enrichment_table <- bind_rows(enrichment_table, .id = "source") %>%
#   dplyr::select(Ontology = source, Description = name,
#                 `P-value` = Hyper_Raw_PValue)
# 
# # Print head organizaed by p-values
# head(enrichment_table %>% dplyr::arrange(`P-value`))

## ----warning=FALSE, message = FALSE, eval=FALSE-------------------------------
# # Read in time course data
# data("time_mats")
# # Identifying boundaries
# results <- TimeCompare(time_mats, resolution = 50000)
# 
# # Pulling out the frame of TADs
# TAD_Frame <- results$TAD_Bounds
# 
# # Getting coordinates for TAD boundaries and converting into bed format
# Bound_List <- lapply(unique(TAD_Frame$Category), function(x) {
#     TAD_Frame %>% filter((Category == x)) %>% mutate(chr = "chr22") %>%
#         dplyr::select(chr, Coordinate) %>%
#         mutate(start = Coordinate, end = Coordinate) %>%
#         dplyr::select(chr, start, end)
# })
# 
# # Performing rGREAT analysis for each boundary Category
# TAD_Enrich <- lapply(Bound_List, function(x) {
#   getEnrichmentTables(submitGreatJob(x, request_interval = 1, version = "2.0"))
# })
# 
# # Name list of data frames to keep track of which enrichment belongs to which
# names(TAD_Enrich) <- unique(TAD_Frame$Category)
# 
# # Bind each category of pathway and create new column for each pathway
# TAD_Enrich <- lapply(names(TAD_Enrich), function(x) {
#   bind_rows(lapply(TAD_Enrich[[x]], function(y) {
#     y %>% mutate(Category = x)
#   }), .id = "source")
# })
# 
# # Bind each boundary category together and pull out important variables
# enrichment_table <- bind_rows(TAD_Enrich) %>%
#   dplyr::select(Ontology = source, Description = name,
#                 `P-value` = Hyper_Raw_PValue, Category)
# 
# # Get the top enriched pathways
# head(enrichment_table %>% dplyr::arrange(`P-value`))

## -----------------------------------------------------------------------------
sessionInfo()

