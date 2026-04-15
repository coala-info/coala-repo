---
name: bioconductor-msd16s
description: This tool provides access to the Moderate-to-Severe Diarrhea 16S rRNA marker gene survey dataset as an MRexperiment object for microbiome analysis. Use when user asks to load the msd16s dataset, subset samples by clinical metadata, or extract taxonomic and count information for metagenomic research.
homepage: https://bioconductor.org/packages/release/data/experiment/html/msd16s.html
---

# bioconductor-msd16s

name: bioconductor-msd16s
description: Access and analyze the Moderate-to-Severe Diarrhea (MSD) 16S rRNA marker gene survey dataset. Use this skill to load the msd16s MRexperiment object, subset data by phenotype (e.g., Case/Control, Country, Age), and extract taxonomic or count information for microbiome research.

## Overview

The `msd16s` package provides a large-scale 16S metagenomic dataset from a study on diarrhea in young children from low-income countries. The data is stored as an `MRexperiment` object, making it compatible with the `metagenomeSeq` analysis framework. It includes 26,044 features (OTUs) across 992 samples, complete with taxonomic classifications and clinical metadata.

## Data Loading and Inspection

To begin using the dataset, load the package and the data object:

```r
library(metagenomeSeq)
library(msd16s)

# Load the dataset
data(msd16s)

# View summary information
msd16s
```

## Accessing Components

The `msd16s` object contains three primary types of data:

### 1. Phenotype Data (Sample Metadata)
Access clinical information such as `Type` (Case/Control), `Country`, `Age`, `AgeFactor`, and `Dysentery` status.

```r
# View metadata structure
phenoData(msd16s)

# Access the data frame of sample information
sample_info <- pData(msd16s)
head(sample_info)
```

### 2. Feature Data (Taxonomy)
Access taxonomic information for the OTUs, including phylum, class, order, family, genus, and species, as well as the cluster representative sequences.

```r
# View feature metadata structure
featureData(msd16s)

# Access the data frame of taxonomic information
taxa_info <- fData(msd16s)
head(taxa_info)
```

### 3. Count Matrix
Extract the raw or normalized abundance counts.

```r
# Extract counts for the first 10 samples
counts_matrix <- MRcounts(msd16s[, 1:10])
head(counts_matrix)
```

## Common Workflows

### Subsetting the Dataset
You can subset the `MRexperiment` object using standard R indexing based on phenotype criteria.

```r
# Subset for samples from a specific country (e.g., Bangladesh)
msd16s_bangladesh <- msd16s[, pData(msd16s)$Country == "Bangladesh"]

# Subset for Cases only
msd16s_cases <- msd16s[, pData(msd16s)$Type == "Case"]
```

### Integration with metagenomeSeq
Since the data is an `MRexperiment` object, you can proceed directly to `metagenomeSeq` workflows such as normalization and differential abundance testing:

```r
# Example: Cumulative Sum Scaling (CSS) normalization
cumNorm(msd16s)
```

## Reference documentation

- [Moderate-to-Severe diarrhea 16S dataset](./references/msd16s.md)