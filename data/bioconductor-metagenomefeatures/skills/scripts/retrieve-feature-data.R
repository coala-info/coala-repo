# Code example from 'retrieve-feature-data' vignette. See references/ for full tutorial.

## ----setup, include = FALSE------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  warning = FALSE
)
suppressPackageStartupMessages(library(metagenomeFeatures)) 
suppressPackageStartupMessages(library(phyloseq)) 

## ----message = FALSE-------------------------------------------------------
library(metagenomeFeatures)
gg85 <- get_gg13.8_85MgDb()

## --------------------------------------------------------------------------
data(qiita_study_94_gg_ids)

## --------------------------------------------------------------------------
soil_mgF <- annotateFeatures(gg85, qiita_study_94_gg_ids)

## Taxonomic heirarchy
soil_mgF

# Sequence data
mgF_seq(soil_mgF)

# Tree data 
mgF_tree(soil_mgF)

## --------------------------------------------------------------------------
data_dir <- system.file("extdata", package = "metagenomeFeatures")

## Load Biom
biom_file <-  file.path(data_dir, "229_otu_table.biom")
soil_ps <- phyloseq::import_biom(BIOMfilename = biom_file)

## Define sample data
sample_file <- file.path(data_dir, "229_sample_data.tsv")
sample_dat <- read.delim(sample_file)

## Rownames matching sample_names(), required for phyloseq sample_data slot
rownames(sample_dat) <- sample_dat$SampleID
sample_data(soil_ps) <- sample_dat

## Resulting phyloseq object
soil_ps

## --------------------------------------------------------------------------
# Removing OTUs not in `gg85`
soil_tree <- mgF_tree(soil_mgF)
soil_ps_gg85 <- prune_taxa(taxa = soil_tree$tip.label, x = soil_ps)

# Removing samples with no OTUs in `gg85`
samples_to_keep <- sample_sums(soil_ps_gg85) != 0
soil_ps_gg85 <- prune_samples(samples = samples_to_keep, x = soil_ps_gg85)

## --------------------------------------------------------------------------
## Defining tree slot
phy_tree(physeq = soil_ps_gg85) <- soil_tree

## Defining seq slot
soil_ps_gg85@refseq <- mgF_seq(soil_mgF)

## ----betaFig, fig.cap="Beta diversity and ordination for a subset of features from Rousk et al. [-@rousk2010soil]. Beta diversity was estimated using Weighted Unifrac and Principal Component Analysis was used for ordination. Sampels are represented as individual point and color indicates soil sample pH."----
soil_ord <- ordinate(physeq = soil_ps_gg85, 
                     distance = "wunifrac", 
                     method = "PCoA")
plot_ordination(soil_ps_gg85, soil_ord, 
                color = "ph", 
                type="sample",
                label = "SampleID")

## ----sessionInfo, echo=FALSE-----------------------------------------------
sessionInfo()

