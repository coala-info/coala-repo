---
name: bioconductor-aracne.networks
description: This package provides access to pre-computed transcriptional regulatory networks for 25 cancer types generated from TCGA data using the ARACNe-AP algorithm. Use when user asks to load cancer-specific regulon objects, identify gene-regulator interactions, or export network data including mode of action and likelihood scores.
homepage: https://bioconductor.org/packages/release/data/experiment/html/aracne.networks.html
---


# bioconductor-aracne.networks

name: bioconductor-aracne.networks
description: Access and export context-specific transcriptional regulatory networks (interactomes) for 25 cancer types from TCGA, reverse-engineered using the ARACNe-AP algorithm. Use this skill to load pre-computed regulon objects, identify gene-regulator interactions, and export network data including Mode of Action (MoA) and likelihood scores.

## Overview

The `aracne.networks` package is a Bioconductor data package containing gene regulatory networks assembled from The Cancer Genome Atlas (TCGA) RNA-seq data. These networks were generated using the ARACNe-AP (Algorithm for the Reconstruction of Accurate Cellular Networks with Adaptive Partitioning) algorithm. Each network (regulon) consists of centroid genes (Transcription Factors and Signaling Proteins) and their significantly associated target genes.

## Core Workflows

### 1. List Available Networks
The package contains 25 context-specific networks named according to TCGA abbreviations (e.g., `regulonbrca` for Breast Carcinoma).

```r
library(aracne.networks)
# List all available regulon objects in the package
data(package="aracne.networks")$results[, "Item"]
```

### 2. Load a Specific Network
Load the desired network into the R environment using the `data()` function.

```r
# Example: Load the Bladder Carcinoma (BLCA) network
data(regulonblca)

# The object is now available as 'regulonblca'
class(regulonblca)
```

### 3. Export and Inspect Network Data
Use the `write.regulon()` function to extract network details. This function returns a data frame (or prints to console) with four columns:
- **Regulator**: Entrez ID of the regulator gene.
- **Target**: Entrez ID of the target gene.
- **MoA**: Mode of Action (Spearman correlation between -1 and 1). Positive values indicate activation; negative values indicate repression.
- **Likelihood**: Edge weight (0 to 1) indicating the strength of mutual information relative to the maximum observed in the network.

```r
# View the first 10 interactions of a network
write.regulon(regulonblca, n = 10)

# Extract all targets for a specific regulator (using Entrez ID)
# Example: RHOH gene (Entrez ID "399")
rhoh_targets <- write.regulon(regulonblca, regulator = "399")
```

## Available Cancer Contexts
Commonly used regulons include:
- `regulonblca`: Bladder Carcinoma
- `regulonbrca`: Breast Carcinoma
- `regulongbm`: Glioblastoma Multiforme
- `regulonlaml`: Acute Myeloid Leukemia
- `regulonluad`: Lung Adenocarcinoma
- `regulonprad`: Prostate Adenocarcinoma
- `regulonsarc`: Sarcoma

## Tips for Analysis
- **Gene IDs**: All genes in these networks are identified by **Entrez Gene IDs**. If you have Gene Symbols, use `org.Hs.eg.db` to map them before querying the networks.
- **Integration**: These regulon objects are compatible with the `VIPER` package for estimating protein activity from gene expression data.
- **Filtering**: Use the `likelihood` column to filter for the most confident interactions or the `MoA` column to distinguish between positive and negative regulation.

## Reference documentation

- [aracne.networks](./references/aracne.networks.md)