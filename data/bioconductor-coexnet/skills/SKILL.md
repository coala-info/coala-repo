---
name: bioconductor-coexnet
description: "bioconductor-coexnet constructs and analyzes co-expression networks from raw microarray data. Use when user asks to download GEO datasets, normalize AffyBatch data, identify differentially expressed genes, determine network thresholds, or build and compare co-expression and protein-protein interaction networks."
homepage: https://bioconductor.org/packages/3.8/bioc/html/coexnet.html
---


# bioconductor-coexnet

name: bioconductor-coexnet
description: Analysis and construction of co-expression networks from microarray data. Use this skill to download GEO datasets, normalize raw AffyBatch data, identify differentially expressed genes (SAM/ACDE), determine optimal network thresholds, and build/compare co-expression or PPI networks.

## Overview

The `coexnet` package provides a complete workflow for transforming raw microarray data into biological networks. It handles the entire pipeline from data acquisition (GEO) and normalization to advanced network analysis, including the identification of Common Connection Patterns (CCP) across different phenotypes.

## Core Workflow

### 1. Data Acquisition and Preparation
Download raw data and chip information from GEO using GSE and GPL identifiers.

```R
library(coexnet)

# Download raw .CEL files and .soft chip info
getInfo(GSE = "GSE8216", GPL = "GPL2025", directory = ".")

# Load raw data into an AffyBatch object
# Note: Ensure the directory contains the GSE folder created by getInfo
affy <- getAffy(GSE = "GSE8216", directory = ".")

# Map probesets to Gene Symbols/IDs
gene_table <- geneSymbol(GPL = "GPL2025", directory = ".")
# Clean table: remove NAs and empty IDs
gene_table <- na.omit(gene_table)
gene_table <- gene_table[gene_table$ID != "", ]
```

### 2. Normalization and Expression Matrix
Convert raw probe data into a summarized expression matrix.

```R
# Normalize using 'rma' or 'vsn'
# SummaryMethod can be 'median' or 'max' (representative probeset)
exp_matrix <- exprMat(affy = affy, 
                      genes = gene_table, 
                      NormalizeMethod = "rma", 
                      SummaryMethod = "median", 
                      BatchCorrect = FALSE)
```

### 3. Differential Expression Analysis
Identify significant genes to reduce network complexity.

```R
# Define treatment vector (0 for control, 1 for case)
group_vec <- c(rep(0, 10), rep(1, 10))

# Methods: "sam" (Significance Analysis of Microarrays) or "acde"
diff_genes <- difExprs(expData = exp_matrix, 
                       treatment = group_vec, 
                       fdr = 0.05, 
                       DifferentialMethod = "sam")
```

### 4. Network Construction
Determine the statistical threshold and build the adjacency network.

```R
# Find optimal threshold based on Clustering Coefficient and Degree Distribution
threshold_val <- findThreshold(expData = diff_genes, method = "correlation")

# Create igraph object
net <- createNet(expData = diff_genes, 
                 threshold = threshold_val, 
                 method = "correlation")

# Visualize
plot(net)
```

### 5. Network Comparison and PPI
Compare multiple networks or integrate Protein-Protein Interaction data from STRING.

```R
# Find Common Connection Patterns (CCP) - shared connected subgraphs
common_net <- CCP(net1, net2)

# Find shared solitary nodes (components present in both but not connected)
shared_nodes <- sharedComponents(net1, net2)

# Build a PPI network from a list of Gene Symbols
ppi <- ppiNet(molecularIDs = c("FN1", "HAMP", "ILK"), 
              evidence = c("neighborhood", "experiments"))
```

## Tips and Best Practices
- **Memory Management**: `vsn` normalization can be computationally intensive for large datasets; `rma` is generally faster.
- **ID Mapping**: If a probeset matches multiple genes, `coexnet` joins them with a hyphen (e.g., "GENEA-GENEB").
- **Thresholding**: Use `findThreshold` rather than arbitrary values to ensure the resulting network follows biological network assumptions (non-normal degree distribution).
- **Batch Effects**: If samples were processed at different times, set `BatchCorrect = TRUE` in `exprMat` to utilize scan dates for correction.

## Reference documentation
- [coexnet](./references/coexnet.md)