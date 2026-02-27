---
name: bioconductor-metcirc
description: Bioconductor-metcirc provides tools for MS/MS spectral similarity analysis and circular visualization of metabolomics data. Use when user asks to calculate spectral similarity using normalized dot product or neutral losses, create circular layouts to visualize metabolite relationships across biological groups, or cluster spectra to identify metabolite families.
homepage: https://bioconductor.org/packages/release/bioc/html/MetCirc.html
---


# bioconductor-metcirc

name: bioconductor-metcirc
description: Comprehensive MS/MS spectral similarity analysis and circular visualization using the MetCirc package. Use when Claude needs to: (1) Calculate similarity between MS/MS spectra using normalized dot product (NDP) or neutral losses, (2) Create circular layouts (Circos-style) to visualize metabolomics data across different biological groups/tissues, (3) Interactively explore and annotate MS/MS features, or (4) Cluster spectra based on structural similarity.

## Overview

MetCirc is designed for the interactive exploration and visualization of MS/MS metabolomics data, particularly from comparative experiments (e.g., cross-species or cross-tissue). It utilizes the `Spectra` infrastructure to handle MS/MS data and provides tools to calculate similarity scores based on shared fragments or neutral losses. These similarities are visualized in a circular layout (inspired by Circos), allowing users to identify clusters of related metabolites and annotate unknown features.

## Data Preparation

### Load the Package
```r
library(MetCirc)
library(MsCoreUtils)
library(Spectra)
```

### Create Spectra Objects
MetCirc relies on `Spectra` objects. You can create them from data frames or .MSP files.

**From a Data Frame:**
Ensure the data frame has columns for `id` (unique identifier), `mz`, and `intensity`.
```r
# Example: Create a Spectra object from a data frame 'df'
spd <- S4Vectors::DataFrame(
    name = as.character(unique_ids),
    rtime = retention_times,
    msLevel = 2L,
    precursorMz = precursor_mzs
)
spd$mz <- list_of_mz_vectors
spd$intensity <- list_of_intensity_vectors
sps <- Spectra::Spectra(spd)

# Add metadata for biological groups (e.g., tissues)
sps@metadata <- data.frame(Tissue1 = c(TRUE, FALSE, ...), Tissue2 = ...)
```

**From .MSP Files:**
```r
# Use the built-in converter for MSP-formatted data frames
sps_msp <- convertMsp2Spectra(msp_dataframe)
```

## Similarity Calculation

Use `Spectra::compareSpectra` to generate a similarity matrix.

### Normalized Dot Product (NDP)
Calculates similarity based on shared fragment ions.
```r
similarityMat <- Spectra::compareSpectra(sps, 
    FUN = MsCoreUtils::ndotproduct, 
    ppm = 10, m = 0.5, n = 2)
colnames(similarityMat) <- rownames(similarityMat) <- sps$name
```

### Neutral Loss
Calculates similarity based on shared neutral losses (precursor m/z - fragment m/z).
```r
# Use neutralloss function within compareSpectra
similarityMat_nl <- Spectra::compareSpectra(sps, 
    FUN = neutralloss, 
    ppm = 10)
```

## Clustering and Module Extraction

Cluster features to identify metabolite families.
```r
library(amap)
# Cluster using Spearman correlation
hClust <- hcluster(similarityMat, method = "spearman")

# Cut tree to extract specific modules
cutTree <- cutree(hClust, k = 5)
module1_ids <- names(cutTree)[cutTree == 1]
similarityMat_mod1 <- similarityMat[module1_ids, module1_ids]
```

## Visualization

### Interactive Exploration (shinyCircos)
The primary tool for interactive annotation and exploration.
```r
# Start the Shiny app
# Returns updated Spectra object and selected features upon exit
result <- shinyCircos(similarityMat, sps = sps, 
                      condition = c("Group1", "Group2", "Group3"))

# Access updated annotations
updated_sps <- result$sps
```

### Static Circular Plots (plotCircos)
For reproducible figure generation.

1. **Prepare Link Data Frame:**
```r
linkDf <- createLinkDf(similarityMatrix = similarityMat, 
                       sps = sps, 
                       condition = c("Group1", "Group2"), 
                       lower = 0.8, upper = 1)

# Filter for inter-group or intra-group links
linkDf_inter <- cutLinkDf(linkDf, type = "inter")
```

2. **Generate Plot:**
```r
# Set circlize parameters
circos.par(gap.degree = 0, cell.padding = c(0, 0, 0, 0), track.margin = c(0, 0))

# Plot
plotCircos(group_vector, linkDf_inter, initialize = TRUE, 
           featureNames = TRUE, groupSector = TRUE, links = TRUE)
```

3. **Highlight Specific Features:**
```r
highlight(groupname = group_vector, ind = feature_index, linkDf = linkDf_inter)
```

## Workflow Tips
- **Filtering:** Before calculating similarity, filter `Spectra` objects to remove low-intensity noise or irrelevant precursors to save computation time.
- **Ordering:** Use `orderSimilarityMatrix` to sort the matrix by m/z or retention time before plotting to make patterns more visible.
- **Annotation:** In `shinyCircos`, you can manually update metabolite names and classes. These changes are preserved in the returned `Spectra` object.

## Reference documentation
- [MetCirc](./references/MetCirc.md)