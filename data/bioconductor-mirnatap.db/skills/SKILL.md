---
name: bioconductor-mirnatap.db
description: This package provides aggregated microRNA target prediction data from multiple algorithms including DIANA, Miranda, PicTar, TargetScan, and miRDB. Use when user asks to access annotation data for miRNAtap, retrieve consensus miRNA-gene interactions, or query aggregated microRNA target predictions.
homepage: https://bioconductor.org/packages/release/data/annotation/html/miRNAtap.db.html
---


# bioconductor-mirnatap.db

name: bioconductor-mirnatap.db
description: Provides annotation data and aggregated microRNA target predictions from multiple algorithms (DIANA, Miranda, PicTar, TargetScan, and miRDB). Use this skill when an AI agent needs to access the underlying database for the miRNAtap package to perform miRNA target aggregation or to understand the source data for predicted miRNA-gene interactions.

# bioconductor-mirnatap.db

## Overview

The `miRNAtap.db` package is a dedicated annotation data package for the `miRNAtap` system. It contains aggregated target prediction data from five major algorithms: DIANA, Miranda, PicTar, TargetScan, and miRDB. While the package primarily serves as a backend database for the `miRNAtap` functional package, it is essential for any workflow involving the identification of miRNA targets based on consensus across multiple prediction methods.

## Installation

To use this data package, it must be installed via BiocManager:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("miRNAtap.db")
```

## Workflow and Usage

The `miRNAtap.db` package is rarely used in isolation. It is designed to be called by the functions within the `miRNAtap` package.

### Loading the Database

To ensure the data is available for the `miRNAtap` functions:

```r
library(miRNAtap.db)
# This loads the SQLite database containing the aggregated predictions
```

### Integration with miRNAtap

The primary workflow involves using the `getTargetsFromSource` or `getPredictedTargets` functions from the main `miRNAtap` package, which query this database.

1. **Identify miRNA of interest**: Use standard nomenclature (e.g., "mmu-miR-10b").
2. **Specify Sources**: Choose from the five available sources: 'DIANA', 'Miranda', 'PicTar', 'TargetScan', and 'miRDB'.
3. **Aggregate**: Use `miRNAtap` functions to pull data from the `.db` backend and rank targets.

### Data Sources Included

The database aggregates predictions from:
- **DIANA**: Focuses on microT-CDS.
- **Miranda**: Uses sequence complementarity and thermodynamic stability.
- **PicTar**: Focuses on conserved 3' UTR targets.
- **TargetScan**: Searches for conserved 8mer, 7mer, and 6mer sites.
- **miRDB**: Uses a machine learning model (MirTarget) for prediction.

## Tips for Success

- **Version Consistency**: Ensure that `miRNAtap.db` and the `miRNAtap` software package are from the same Bioconductor release to avoid schema mismatches.
- **Memory**: As a database package, it uses an SQLite backend; ensure you have sufficient disk space for the annotation data.
- **Species Support**: The database contains predictions for multiple model organisms; ensure your miRNA nomenclature matches the supported species in the database.

## Reference documentation

- [miRNAtap.db: microRNA Targets - Aggregated Predictions database use](./references/miRNAtap.db.md)