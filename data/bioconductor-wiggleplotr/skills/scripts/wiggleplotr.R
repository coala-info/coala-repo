# Code example from 'wiggleplotr' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
#This block gets rid of the import messages
library("wiggleplotr")
library("GenomicRanges")
library("dplyr")
library("biomaRt")
library("GenomicFeatures")
library("ensembldb")
library("EnsDb.Hsapiens.v86")
library("org.Hs.eg.db")
library("TxDb.Hsapiens.UCSC.hg38.knownGene")

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("wiggleplotr")

## -----------------------------------------------------------------------------
library("wiggleplotr")
library("dplyr")
library("GenomicRanges")
library("GenomicFeatures")
library("biomaRt")

## -----------------------------------------------------------------------------
ncoa7_metadata
names(ncoa7_exons)
names(ncoa7_cdss)

## -----------------------------------------------------------------------------
plotTranscripts(ncoa7_exons, ncoa7_cdss, ncoa7_metadata, rescale_introns = FALSE)

## -----------------------------------------------------------------------------
plotTranscripts(ncoa7_exons, ncoa7_cdss, ncoa7_metadata, rescale_introns = TRUE)

## -----------------------------------------------------------------------------
plotTranscripts(ncoa7_exons, rescale_introns = TRUE)

## -----------------------------------------------------------------------------
sample_data = dplyr::data_frame(
  sample_id = c("aipt_A", "aipt_C", "bima_A", "bima_C"), 
  condition = factor(c("Naive", "LPS", "Naive", "LPS"), levels = c("Naive", "LPS")), 
  scaling_factor = 1)
sample_data = sample_data %>%
  dplyr::mutate(bigWig = system.file("extdata", paste0(sample_id, ".str2.bw"), 
                                     package = "wiggleplotr"))
as.data.frame(sample_data)

## -----------------------------------------------------------------------------
track_data = dplyr::mutate(sample_data, track_id = condition, colour_group = condition)

## -----------------------------------------------------------------------------
selected_transcripts = c("ENST00000438495", "ENST00000392477") #Plot only two transcripts of the gens
plotCoverage(ncoa7_exons[selected_transcripts], ncoa7_cdss[selected_transcripts], 
             ncoa7_metadata, track_data,
             heights = c(2,1), fill_palette = getGenotypePalette())

## -----------------------------------------------------------------------------
plotCoverage(ncoa7_exons[selected_transcripts], ncoa7_cdss[selected_transcripts], 
             ncoa7_metadata, track_data,
             heights = c(2,1), fill_palette = getGenotypePalette(), mean_only = FALSE, alpha = 0.5)

## -----------------------------------------------------------------------------
track_data = dplyr::mutate(sample_data, track_id = "RNA-seq", colour_group = condition)
plotCoverage(ncoa7_exons[selected_transcripts], ncoa7_cdss[selected_transcripts], 
            ncoa7_metadata, track_data,
             heights = c(2,1), fill_palette = getGenotypePalette(), coverage_type = "line")

## ----eval = FALSE-------------------------------------------------------------
# track_data = dplyr::mutate(sample_data, track_id = "RNA-seq", colour_group = condition)
# plotCoverage(ncoa7_exons[selected_transcripts], ncoa7_cdss[selected_transcripts],
#             ncoa7_metadata, track_data,
#              heights = c(2,1), fill_palette = getGenotypePalette(), coverage_type = "line",
#              connect_exons = FALSE, transcript_label = FALSE, rescale_introns = FALSE)

## -----------------------------------------------------------------------------
library("ensembldb")
library("EnsDb.Hsapiens.v86")
plotTranscriptsFromEnsembldb(EnsDb.Hsapiens.v86, gene_names = "NCOA7", 
                             transcript_ids = c("ENST00000438495", "ENST00000392477"))

## -----------------------------------------------------------------------------
#Load OrgDb and TxDb objects with UCSC gene annotations
require("org.Hs.eg.db")
require("TxDb.Hsapiens.UCSC.hg38.knownGene")
plotTranscriptsFromUCSC(orgdb = org.Hs.eg.db, txdb = TxDb.Hsapiens.UCSC.hg38.knownGene, 
                        gene_names = "NCOA7", transcript_ids = c("ENST00000438495.6", "ENST00000368357.7"))

