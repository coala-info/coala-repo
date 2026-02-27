---
name: bioconductor-targetscoredata
description: This package provides processed miRNA-overexpression data, TargetScan scores, and precomputed TargetScore results for human miRNA target prediction. Use when user asks to retrieve miRNA transfection log fold-change data, access TargetScan context scores or PCT, or obtain precomputed target probability scores for human miRNAs.
homepage: https://bioconductor.org/packages/release/data/experiment/html/TargetScoreData.html
---


# bioconductor-targetscoredata

name: bioconductor-targetscoredata
description: Access and use processed miRNA-overexpression data, TargetScan context scores, and precomputed TargetScore results for human miRNA target prediction. Use this skill when you need to retrieve log fold-change (logFC) data from GEO miRNA perturbation studies, TargetScan PCT/context scores, or precomputed target probability scores for downstream analysis in R.

# bioconductor-targetscoredata

## Overview

The `TargetScoreData` package provides a comprehensive collection of processed data for miRNA target prediction. It includes the largest compendium of miRNA-overexpression data (84 GEO series, 112 miRNAs), TargetScan context scores and PCT (Probability of Conserved Targeting), and precomputed TargetScore results. This data is primarily used as input for the `TargetScore` package to identify high-confidence miRNA targets by integrating sequence-based scores with expression data.

## Core Workflows

### Loading miRNA Transfection Data
To access the raw log fold-change (logFC) data from various GEO studies:

```r
library(TargetScoreData)

# Retrieve the list of transfection dataframes
transfection_list <- get_miRNA_transfection_data()$transfection_data

# The result is a list where each element contains:
# - logFC: The expression change
# - Series: GEO accession
# - platform: Microarray platform
# - cell: Cell type or tissue
```

### Accessing TargetScan Scores
Retrieve sequence-based features used in target prediction:

```r
# Get TargetScan Context Scores (CS)
targetScanCS <- get_TargetScanHuman_contextScore()

# Get TargetScan Probability of Conserved Targeting (PCT)
targetScanPCT <- get_TargetScanHuman_PCT()
```

### Retrieving Precomputed TargetScores
The package provides precomputed scores for 112 miRNAs, integrating expression and sequence data:

```r
# Get the matrix of precomputed scores
targetScoreMatrix <- get_precomputed_targetScores()

# Access scores for a specific miRNA (e.g., hsa-miR-1)
# Returns a dataframe with logFC, targetScanCS, targetScanPCT, and the final targetScore
mir1_scores <- targetScoreMatrix[["hsa-miR-1"]]

# Filter for high-confidence targets (e.g., score > 0.1)
high_conf_targets <- mir1_scores[mir1_scores$targetScore > 0.1, ]
```

### Accessing Imputed logFC Matrix
For large-scale analysis across all 112 miRNAs:

```r
# Get the N x M matrix (Genes x Datasets) of imputed log fold-changes
logFC_imputed <- get_precomputed_logFC()
```

## Integration with TargetScore Package
While `TargetScoreData` provides the data, the `TargetScore` package is used to compute new scores. You can use the data from this package to reproduce or extend the analysis:

```r
library(TargetScore)

# Example: Compute scores for hsa-miR-1 using the data provided in this package
# This function internally handles the data retrieval from TargetScoreData
myTargetScores <- getTargetScores("hsa-miR-1", tol=1e-3, maxiter=200)
```

## Tips and Troubleshooting
- **Memory Usage**: The TargetScan context score object is large (~9.5 million rows). Ensure your R session has sufficient memory before calling `get_TargetScanHuman_contextScore()`.
- **ID Mapping**: The data uses RefSeq mRNA IDs (NM_*) and Gene Symbols. Ensure your gene identifiers match this format when joining with external datasets.
- **Data Version**: The TargetScan data is based on version 6.1.

## Reference documentation
- [TargetScoreData](./references/TargetScoreData.md)