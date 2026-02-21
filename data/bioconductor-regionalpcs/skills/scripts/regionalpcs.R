# Code example from 'regionalpcs' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    echo = TRUE
)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("regionalpcs")

## ----eval=FALSE---------------------------------------------------------------
# # install devtools package if not already installed
# if (!requireNamespace("devtools", quietly=TRUE))
#     install.packages("devtools")
# 
# # download and install the regionalpcs package
# devtools::install_github("tyeulalio/regionalpcs")

## ----load-packages, message=FALSE, warning=FALSE------------------------------
library(regionalpcs)
library(GenomicRanges)
library(tidyr)
library(tibble)
library(dplyr)
library(minfiData)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)

## -----------------------------------------------------------------------------
# Load the MethylSet data
data(MsetEx.sub)

# Display the first few rows of the dataset for a preliminary view
head(MsetEx.sub)

# Extract methylation M-values from the MethylSet
# M-values are logit-transformed beta-values and are often used in differential
# methylation analysis for improved statistical performance.
mvals <- getM(MsetEx.sub)

# Display the extracted methylation beta values
head(mvals)

## ----genomic-positions--------------------------------------------------------
# Map the methylation data to genomic coordinates using the mapToGenome
# function. This creates a GenomicMethylSet (gset) which includes genomic 
# position information for each probe.
gset <- mapToGenome(MsetEx.sub)

# Display the GenomicMethylSet object to observe the structure and initial 
# entries.
gset

# Convert the genomic position data into a GRanges object, enabling genomic 
# range operations in subsequent analyses.
# The GRanges object (cpg_gr) provides a versatile structure for handling 
# genomic coordinates in R/Bioconductor.
cpg_gr <- granges(gset)

# Display the GRanges object for a preliminary view of the genomic coordinates.
cpg_gr

## -----------------------------------------------------------------------------
# Obtain promoter regions
# The TxDb object 'txdb' facilitates the retrieval of transcript-based 
# genomic annotations.
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

# Extracting promoter regions with a defined upstream and downstream window. 
# This GRanges object 'promoters_gr' will be utilized to map and summarize 
# methylation data in promoter regions.
promoters_gr <- suppressMessages(promoters(genes(txdb), 
                                    upstream=1000, 
                                    downstream=0))

# Display the GRanges object containing the genomic coordinates of promoter 
# regions.
promoters_gr


## -----------------------------------------------------------------------------
# get the region map using the regionalpcs function
region_map <- regionalpcs::create_region_map(cpg_gr=cpg_gr, 
                                                genes_gr=promoters_gr)

# Display the initial few rows of the region map.
head(region_map)

## ----compute-regional-pcs-----------------------------------------------------
# Display head of region map
head(region_map)
dim(region_map)

# Compute regional PCs
res <- compute_regional_pcs(meth=mvals, region_map=region_map, pc_method="gd")

## ----inspect-output-----------------------------------------------------------
# Inspect the output list elements
names(res)

## ----extract-regional-pcs-----------------------------------------------------
# Extract regional PCs
regional_pcs <- res$regional_pcs
head(regional_pcs)[1:4]

## ----count-pcs-regions--------------------------------------------------------
# Count the number of unique gene regions and PCs
regions <- data.frame(gene_pc = rownames(regional_pcs)) |>
    separate(gene_pc, into = c("gene", "pc"), sep = "-")
head(regions)

# number of genes that have been summarized
length(unique(regions$gene))

# how many of each PC did we get
table(regions$pc)

## ----marcenko-pasteur-method--------------------------------------------------
# Using Marcenko-Pasteur method
mp_res <- compute_regional_pcs(mvals, region_map, pc_method = "mp")

# select the regional pcs
mp_regional_pcs <- mp_res$regional_pcs

# separate the genes from the pc numbers
mp_regions <- data.frame(gene_pc = rownames(mp_regional_pcs)) |>
    separate(gene_pc, into = c("gene", "pc"), sep = "-")
head(mp_regions)

# number of genes that have been summarized
length(unique(mp_regions$gene))

# how many of each PC did we get
table(mp_regions$pc)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

