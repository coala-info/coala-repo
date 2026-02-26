---
name: bioconductor-curatedmetagenomicdata
description: This tool provides access to standardized human microbiome data including taxonomic and functional profiles from thousands of curated shotgun metagenomic samples. Use when user asks to retrieve species-level taxonomic profiles, access gene family or metabolic pathway abundances, or perform mega-analyses across multiple microbiome studies.
homepage: https://bioconductor.org/packages/release/data/experiment/html/curatedMetagenomicData.html
---


# bioconductor-curatedmetagenomicdata

name: bioconductor-curatedmetagenomicdata
description: Access and analyze standardized human microbiome data from the curatedMetagenomicData Bioconductor package. Use this skill when you need to retrieve species-level taxonomic profiles, gene families, or metabolic pathways from thousands of human shotgun metagenomic samples with curated metadata.

# bioconductor-curatedmetagenomicdata

## Overview

The `curatedMetagenomicData` package provides access to a massive collection of processed human microbiome data. It standardizes data from MetaPhlAn3 (taxonomy) and HUMAnN3 (functional potential) across nearly 100 studies. Data is delivered as `TreeSummarizedExperiment` or `SummarizedExperiment` objects, which integrate abundance matrices with rich, manually curated sample metadata.

## Core Workflows

### 1. Exploring Metadata
Before downloading large datasets, use the `sampleMetadata` data frame to identify studies or samples of interest.

```r
library(curatedMetagenomicData)
library(dplyr)

# View available studies and sample counts
sampleMetadata %>%
  count(study_name, body_site)

# Filter for specific conditions (e.g., stool samples from healthy adults)
target_samples <- sampleMetadata %>%
  filter(body_site == "stool", disease == "Healthy", age_group == "Adult")
```

### 2. Accessing Data by Study
Use `curatedMetagenomicData()` to query and download specific resources using a regex pattern.

*   **Data Types:** `relative_abundance`, `gene_families`, `pathway_abundance`, `pathway_coverage`, `marker_abundance`, `marker_presence`.
*   **Dry Run:** By default, it returns only the names of available resources. Set `dryrun = FALSE` to download.

```r
# Search for available resources for a specific study
curatedMetagenomicData("AsnicarF_2017.+", dryrun = TRUE)

# Download relative abundance for a study
data_list <- curatedMetagenomicData("AsnicarF_2017.relative_abundance", dryrun = FALSE, rownames = "short")

# Merge multiple studies of the same data type
merged_data <- mergeData(data_list)
```

### 3. Accessing Data by Samples (Mega-analysis)
The `returnSamples()` function is the most efficient way to build a custom dataset across multiple studies based on filtered metadata.

```r
# Get relative abundance for the filtered metadata created in step 1
tse <- target_samples %>%
  returnSamples("relative_abundance", rownames = "short")
```

## Data Manipulation and Analysis

### Taxonomic Agglomeration
Since data is returned as a `TreeSummarizedExperiment`, use the `mia` package to aggregate data to specific taxonomic ranks.

```r
library(mia)
# Aggregate to Genus level
tse_genus <- agglomerateByRank(tse, rank = "genus")
```

### Diversity and Differential Abundance
The package output is compatible with the `mia`, `scater`, and `lefser` ecosystems.

```r
# Alpha Diversity (Shannon Index)
tse_genus <- addAlpha(tse_genus, assay.type = "relative_abundance", index = "shannon_diversity")

# Beta Diversity (PCoA with Bray-Curtis)
library(scater)
library(vegan)
tse_genus <- runMDS(tse_genus, FUN = vegdist, method = "bray", 
                    exprs_values = "relative_abundance", name = "PCoA")
plotReducedDim(tse_genus, "PCoA", colour_by = "disease")

# Differential Abundance (LEfSe)
library(lefser)
res <- lefser(tse_genus, groupCol = "disease")
```

## Tips and Best Practices
*   **Rownames:** Use `rownames = "short"` in data retrieval functions to get readable species names instead of long clade strings.
*   **Counts:** Set `counts = TRUE` in `curatedMetagenomicData()` or `returnSamples()` to convert relative abundances back to estimated reads (relative abundance * read depth).
*   **Phyloseq Conversion:** If you prefer `phyloseq`, use `mia::makePhyloseqFromTreeSummarizedExperiment(tse)`.
*   **Memory Management:** These datasets can be large. Filter your `sampleMetadata` as much as possible before calling `returnSamples()`.

## Reference documentation
- [curatedMetagenomicData](./references/curatedMetagenomicData.md)