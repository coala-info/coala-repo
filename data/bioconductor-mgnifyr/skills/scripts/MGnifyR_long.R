# Code example from 'MGnifyR_long' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
library(knitr)
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    eval = FALSE,
    cache = TRUE
)

## ----install, eval=FALSE------------------------------------------------------
# BiocManager::install("MGnifyR")

## ----load_package-------------------------------------------------------------
# library(MGnifyR)

## ----create_client------------------------------------------------------------
# mg <- MgnifyClient()
# mg

## ----create_client_passwd, eval=FALSE-----------------------------------------
# mg <- MgnifyClient(
#     username = "Webin-username", password = "your-password", useCache = TRUE)

## ----search_studies-----------------------------------------------------------
# northpolar <- doQuery(
#     mg, "samples", latitude_gte=60.0, experiment_type="amplicon",
#     biome_name="Soil", instrument_platform = "Illumina", max.hits = 10)
# 
# head(northpolar)

## ----search_studies_accession-------------------------------------------------
# study_samples <- doQuery(mg, "studies", accession="MGYS00002891")
# 
# head(study_samples)

## ----convert_to_analyses------------------------------------------------------
# analyses_accessions <- searchAnalysis(
#     mg, type="studies", accession = study_samples$accession)
# 
# head(analyses_accessions)

## ----get_metadata-------------------------------------------------------------
# analyses_metadata <- getMetadata(mg, analyses_accessions)
# 
# head(analyses_metadata)

## ----filter_metadata----------------------------------------------------------
# known_depths <- analyses_metadata[
#     !is.na(as.numeric(analyses_metadata$sample_depth)), ]
# # How many are left?
# dim(known_depths)

## ----get_treese---------------------------------------------------------------
# tse <- getResult(mg, accession = analyses_accessions, get.func = FALSE)
# 
# tse

## ----calculate_diversity------------------------------------------------------
# library(mia)
# 
# tse <- estimateDiversity(tse, index = "shannon")
# 
# library(scater)
# 
# plotColData(tse, "shannon", x = "sample_geo.loc.name")

## ----plot_abundance-----------------------------------------------------------
# library(miaViz)
# 
# plotAbundance(
#     tse[!is.na( rowData(tse)[["Kingdom"]] ), ],
#     rank = "Kingdom",
#     as.relative = TRUE
#     )

## ----to_phyloseq--------------------------------------------------------------
# pseq <- makePhyloseqFromTreeSE(tse)
# pseq

## ----get_analyses-------------------------------------------------------------
# soil <- searchAnalysis(mg, "studies", "MGYS00001447")
# human <- searchAnalysis(mg, "studies", "MGYS00001442")
# marine <- searchAnalysis(mg, "studies", "MGYS00001282")
# 
# # Combine analyses
# all_accessions <- c(soil, human, marine)
# 
# head(all_accessions)

## ----get_new_metadata---------------------------------------------------------
# full_metadata <- getMetadata(mg, all_accessions)
# 
# colnames(full_metadata)
# head(full_metadata)

## ----full_metatdata_explore---------------------------------------------------
# # Load ggplot2
# library(ggplot2)
# 
# #Distribution of sample source material:
# table(full_metadata$`sample_environment-material`)
# 
# #What sequencing machine(s) were used?
# table(full_metadata$`sample_instrument model`)
# 
# # Boxplot of raw read counts:
# ggplot(
#     full_metadata, aes(x=study_accession, y=log(
#         as.numeric(`analysis_Submitted nucleotide sequences`)))) +
#     geom_boxplot(aes(group=study_accession)) +
#     theme_bw() +
#     ylab("log(submitted reads)")

## ----get_mae------------------------------------------------------------------
# mae <- getResult(mg, all_accessions, bulk.dl = TRUE)
# 
# mae

## ----mae_access---------------------------------------------------------------
# mae[[2]]

## ----pcoa---------------------------------------------------------------------
# # Apply relative transformation
# mae[[1]] <- transformAssay(mae[[1]], method = "relabundance")
# # Perform PCoA
# mae[[1]] <- runMDS(
#     mae[[1]], assay.type = "relabundance",
#     FUN = vegan::vegdist, method = "bray")
# # Plot
# plotReducedDim(mae[[1]], "MDS", colour_by = "sample_environment.feature")

## ----fetch_data---------------------------------------------------------------
# kegg <- getData(
#     mg, type = "kegg-modules", accession = "MGYA00642773",
#     accession.type = "analyses")
# 
# head(kegg)

## ----get_download_urls--------------------------------------------------------
# # Find list of available downloads
# dl_urls <- searchFile(
#     mg, full_metadata$analysis_accession, type = "analyses")
# 
# # Filter table
# target_urls <- dl_urls[
#     dl_urls$attributes.description.label == "Predicted CDS with annotation", ]
# 
# head(target_urls)

## ----list_descriptions--------------------------------------------------------
# table(dl_urls$attributes.description.label)

## ----get_genome_urls----------------------------------------------------------
# genome_urls <- searchFile(mg, "MGYG000433953", type = "genomes")
# 
# genome_urls[ , c("id", "attributes.file.format.name", "download_url")]

## ----get_files----------------------------------------------------------------
# # Just select a single file from the target_urls list for demonstration.
# 
# # Default behavior - use local cache.
# cached_location1 = getFile(mg, target_urls$download_url[[1]])
# 
# # Specifying a file
# cached_location2 <- getFile(
#     mg, target_urls$download_url[[1]])
# 
# cached_location <- c(cached_location1, cached_location2)
# 
# # Where are the files?
# cached_location

## ----simple_parse_function----------------------------------------------------
# library(Biostrings)
# 
# # Simple function to a count of unique sequences matching PFAM amoC/mmoC motif
# getAmoCseqs <- function(fname){
#     sequences <- readAAStringSet(fname)
#     tgtvec <- grepl("PF04896", names(sequences))
#     as.data.frame(as.list(table(as.character(sequences[tgtvec]))))
# }

## ----download_with_read-------------------------------------------------------
# # Just download a single accession for demonstration, specifying a read_function
# amoC_seq_counts <- getFile(
#     mg, target_urls$download_url[[1]], read_func = getAmoCseqs)
# 
# amoC_seq_counts

## ----session_info-------------------------------------------------------------
# sessionInfo()

