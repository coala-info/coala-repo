---
name: bioconductor-props
description: PROPS calculates pathway-based features from gene expression data by utilizing pathway topology to generate probabilistic scores. Use when user asks to calculate pathway scores, generate robust features for classification, or incorporate pathway edge information into gene expression analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/PROPS.html
---

# bioconductor-props

## Overview
PROPS is a method for calculating pathway-based features from gene expression data. Unlike methods that only consider gene sets, PROPS utilizes pathway topology (edges) to calculate probabilistic scores. It is designed to produce robust features for classification, especially in the context of heterogeneous diseases like Inflammatory Bowel Disease (IBD).

## Core Workflow

### 1. Data Preparation
PROPS requires two primary inputs:
- **Healthy Reference Data**: A matrix or data frame of "normal" samples (rows = samples, columns = genes).
- **Target Data**: A matrix or data frame of the samples you wish to score (rows = samples, columns = genes).
- **Gene Identifiers**: Column names must be Entrez IDs to match the default KEGG pathways.

### 2. Basic Score Calculation
By default, PROPS uses internal KEGG pathway edge definitions.
```r
library(PROPS)

# Load your data (example_healthy and example_data are provided in the package)
data(example_healthy)
data(example_data)

# Calculate scores
props_features <- props(example_healthy, example_data)
```

### 3. Handling Batch Effects
If the healthy reference and target data come from different batches, use the built-in ComBat integration:
```r
# Define batch vectors
h_batches <- c(rep(1, 25), rep(2, 25))
d_batches <- c(rep(1, 20), rep(2, 30))

# Run with batch correction
props_features <- props(example_healthy, 
                        example_data, 
                        batch_correct = TRUE, 
                        healthy_batches = h_batches, 
                        dat_batches = d_batches)
```

### 4. Using Custom Pathways
To use pathways from other databases (e.g., Reactome, WikiPathways) or custom literature-curated networks, provide a custom edge data frame.
- **Format**: A data frame with three columns: `from`, `to`, and `pathway_ID`.
```r
data(example_edges) # View expected format

props_features_custom <- props(example_healthy, 
                               example_data, 
                               pathway_edges = example_edges)
```

## Implementation Tips
- **Output Structure**: The `props()` function returns a data frame where rows are pathways and columns are samples. The first column is always `pathway_ID`.
- **Entrez ID Mapping**: Ensure your gene expression data is mapped to Entrez IDs before running `props()`. If using custom edges, the IDs in the expression data must match the IDs in the `from` and `to` columns of the edge data frame.
- **Probabilistic Interpretation**: The scores represent log-likelihoods; lower (more negative) scores generally indicate higher deviation from the reference "healthy" distribution for that specific pathway topology.

## Reference documentation
- [PRObabilistic Pathway Scores (PROPS)](./references/props.md)