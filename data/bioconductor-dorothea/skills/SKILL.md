---
name: bioconductor-dorothea
description: This tool provides access to curated transcription factor-target gene interactions and regulons for human and mouse. Use when user asks to retrieve gene regulatory networks, filter transcription factor interactions by confidence levels, or prepare data for transcription factor activity inference.
homepage: https://bioconductor.org/packages/release/data/experiment/html/dorothea.html
---


# bioconductor-dorothea

name: bioconductor-dorothea
description: Access and utilize DoRothEA (Discriminant Regulon Expression Analysis), a comprehensive resource of curated transcription factor (TF) - target gene interactions. Use this skill to retrieve TF regulons for human or mouse, filter interactions by confidence levels (A-E), and prepare gene regulatory networks for TF activity inference.

# bioconductor-dorothea

## Overview
DoRothEA is a gene regulatory network (GRN) containing signed transcription factor (TF) - target gene interactions. It provides "regulons"—collections of TFs and their transcriptional targets—curated from various evidence sources including literature, ChIP-seq data, and computational predictions. Each interaction is assigned a confidence level from A (highest) to E (lowest). This package is primarily used as a resource for downstream TF activity inference from bulk or single-cell transcriptomics data.

## Typical Workflow

### 1. Load the Package
```r
library(dorothea)
library(decoupleR) # Often used in conjunction for data retrieval and activity inference
```

### 2. Retrieve Regulons
The primary way to access DoRothEA regulons is through the `decoupleR` interface, which provides the most up-to-date access to the data.

```r
# Retrieve human regulons with high confidence levels (A, B, and C)
net <- decoupleR::get_dorothea(levels = c('A', 'B', 'C'))

# View the structure
head(net)
# Columns: source (TF), confidence, target (Gene), mor (Mode of Regulation)
```

### 3. Filtering by Confidence
DoRothEA interactions are ranked:
*   **Level A**: Highly reliable; supported by all evidence types or manually curated.
*   **Levels B-D**: Supported by curated and/or ChIP-seq data with varying additional evidence.
*   **Level E**: Supported only by computational predictions.

**Tip**: For the most robust TF activity estimations, it is recommended to use only levels A, B, and C.

### 4. Understanding Mode of Regulation (mor)
The `mor` column indicates the direction of the interaction:
*   **1**: Activation (positive regulation)
*   **-1**: Repression (negative regulation)
*   Values between -1 and 1 may exist depending on the specific evidence weighting.

### 5. Transitioning to CollecTRI
The authors of DoRothEA now recommend **CollecTRI** for most use cases, as it is a newer literature-based GRN with better coverage.

```r
# Access CollecTRI via decoupleR
collectri_net <- decoupleR::get_collectri(split_complexes = FALSE)
```

## Activity Inference
DoRothEA itself provides the network, but the actual activity estimation (inferring TF activity from a gene expression matrix) is typically performed using the `decoupleR` package.

```r
# Example conceptual workflow:
# 1. Get DoRothEA network
# 2. Provide expression matrix (mat)
# 3. Run an algorithm like Weighted Mean (wmean)
# activities <- decoupleR::run_wmean(mat, net)
```

## Tips for Success
*   **Organism Support**: Ensure you specify the correct organism if not using the default (human).
*   **Regulon Size**: Most TFs in DoRothEA have around 20 targets, but some have over 1000. Activity inference is generally more stable for TFs with at least 10 targets.
*   **Data Format**: The networks are returned as tidy data frames (tibbles), making them easy to manipulate with `dplyr`.

## Reference documentation
- [DoRothEA regulons.](./references/dorothea.Rmd)
- [DoRothEA regulons.](./references/dorothea.md)