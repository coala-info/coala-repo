# Code example from 'CTCF' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL, ## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
    warning = FALSE
)

## ----'install1', eval = TRUE, message=FALSE, warning=FALSE--------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install(version = "3.16")

## ----'install2', eval = TRUE, message=FALSE, warning=FALSE--------------------
# BiocManager::install("AnnotationHub", update = FALSE) 
# BiocManager::install("GenomicRanges", update = FALSE)
# BiocManager::install("plyranges", update = FALSE)

## ----get-data-----------------------------------------------------------------
suppressMessages(library(AnnotationHub))
ah <- AnnotationHub()
query_data <- subset(ah, preparerclass == "CTCF")
# Explore the AnnotationHub object
query_data
# Get the list of data providers
query_data$dataprovider %>% table()

## -----------------------------------------------------------------------------
subset(query_data, species == "Homo sapiens" & 
                   genome == "hg38" & 
                   dataprovider == "JASPAR 2022")
# Same for mm10 mouse genome
# subset(query_data, species == "Mus musculus" & genome == "mm10" & dataprovider == "JASPAR 2022")

## -----------------------------------------------------------------------------
# hg38.JASPAR2022_CORE_vertebrates_non_redundant_v2
CTCF_hg38_all <- query_data[["AH104727"]]
CTCF_hg38_all

## -----------------------------------------------------------------------------
# hg38.MA0139.1
CTCF_hg38 <- query_data[["AH104729"]]
CTCF_hg38

## -----------------------------------------------------------------------------
suppressMessages(library(GenomeInfoDb))  # for keepStandardChromosomes()
CTCF_hg38_all <- CTCF_hg38_all %>% keepStandardChromosomes() %>% sort()
CTCF_hg38 <- CTCF_hg38 %>% keepStandardChromosomes() %>% sort()

## ----eval=FALSE---------------------------------------------------------------
# # Note that rtracklayer::import and rtracklayer::export perform unexplained
# # start coordinate conversion, likely related to 0- and 1-based coordinate
# # system. We recommend converting GRanges to a data frame and save tab-separated
# write.table(CTCF_hg38_all %>% sort() %>% as.data.frame(),
#             file = "CTCF_hg38_all.bed",
#             sep = "\t", row.names = FALSE, col.names = FALSE, quote = FALSE)
# write.table(CTCF_hg38 %>% sort() %>% as.data.frame(),
#             file = "CTCF_hg38.bed",
#             sep = "\t", row.names = FALSE, col.names = FALSE, quote = FALSE)

## ----eval=FALSE---------------------------------------------------------------
# library(tracktables) # BiocManager::install("tracktables")
# # Sample sheet metadata
# SampleSheet <- data.frame(SampleName = c("CTCF all", "CTCF MA0139.1"),
#                           Description = c("All CTCF matrices from JASPAR2022",
#                                           "MA0139.1 CTCF matrix from JASPAR2022"))
# # File sheet linking files with sample names
# FileSheet <- data.frame(SampleName = c("CTCF all", "CTCF MA0139.1"),
#                         bigwig = c(NA, NA),
#                         interval = c("CTCF_hg38_all.bed", "CTCF_hg38.bed"),
#                         bam = c(NA, NA))
# # Creating an IGV session XML file
# MakeIGVSession(SampleSheet, FileSheet,
#                igvdirectory = getwd(), "CTCF_from_JASPAR2022", "hg38")
# 

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("../man/figures/Figure_human_pvalues_threshold.png")

## -----------------------------------------------------------------------------
# Check length before filtering
print(paste("Number of CTCF motifs at the default 1e-4 threshold:", length(CTCF_hg38)))
# Filter and check length after filtering
suppressMessages(library(plyranges))
# CTCF_hg38_filtered <- CTCF_hg38 %>% plyranges::filter(pvalue < 1e-6)
CTCF_hg38_filtered <- CTCF_hg38[mcols(CTCF_hg38)$pvalue < 1e-6]
print(paste("Number of CTCF motifs at the 1e-6 threshold:", length(CTCF_hg38_filtered)))
# Similarly, filter
# CTCF_hg38_all_filtered <- CTCF_hg38_all %>% plyranges::filter(pvalue < 1e-6)
CTCF_hg38_all_filtered <- CTCF_hg38_all[mcols(CTCF_hg38_all)$pvalue < 1e-6]


## -----------------------------------------------------------------------------
# Proportion of overlapping enrtries
tmp <- findOverlaps(CTCF_hg38_all, CTCF_hg38_all)
prop_overlap <- sort(table(queryHits(tmp)) %>% table(), decreasing = TRUE)
sum(prop_overlap[which(names(prop_overlap) != "1")]) / length(CTCF_hg38_all)

## -----------------------------------------------------------------------------
tmp <- findOverlaps(CTCF_hg38, CTCF_hg38)
prop_overlap <- sort(table(queryHits(tmp)) %>% table(), decreasing = TRUE)
sum(prop_overlap[which(names(prop_overlap) != "1")]) / length(CTCF_hg38)

## -----------------------------------------------------------------------------
print(paste("Number of CTCF_hg38 motifs at the 1e-6 threshold AND reduced:", length(CTCF_hg38_filtered %>% reduce())))
print(paste("Number of CTCF_hg38_all motifs at the 1e-6 threshold AND reduced:", length(CTCF_hg38_all_filtered %>% reduce())))

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("../man/figures/Figure_liftOverJaccard.png")

## ----echo=FALSE---------------------------------------------------------------
mtx <- read.csv("../man/tables/Table_PWMs.csv")
knitr::kable(mtx)

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("../man/figures/Supplementary_Figure_1.png")

## ----echo=FALSE---------------------------------------------------------------
mtx <- read.csv("../man/tables/Table_Predefined.csv")
knitr::kable(mtx)

## ----echo=FALSE---------------------------------------------------------------
mtx <- read.csv("../man/tables/Table_log.csv")
knitr::kable(mtx)

## ----'citation', eval = requireNamespace('CTCF')------------------------------
print(citation("CTCF"), bibtex = TRUE)

## -----------------------------------------------------------------------------
sessionInfo()

