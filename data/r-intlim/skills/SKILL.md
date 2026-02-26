---
name: r-intlim
description: This tool integrates metabolomics with other omics data using linear modeling to identify phenotype-specific associations between analytes. Use when user asks to integrate multi-omics data, run interaction models to find phenotype-dependent correlations, filter high-throughput datasets, or visualize gene-metabolite relationships.
homepage: https://cran.r-project.org/web/packages/intlim/index.html
---


# r-intlim

name: r-intlim
description: Integration of metabolomics and other omics data (e.g., transcriptomics) using linear modeling. Use this skill to identify phenotype-specific associations between different types of high-throughput data, perform data filtering, run interaction models, and visualize gene-metabolite relationships.

## Overview

IntLIM (Integration through LInear Modeling) is an R package designed to integrate metabolomics data with other omics data, particularly transcriptomics. It focuses on understanding how specific gene-metabolite associations are affected by phenotypic features (e.g., drug resistance vs. sensitivity, tumor vs. normal). The workflow identifies pairs where the correlation between two analytes differs significantly between phenotype groups.

## Installation

```R
install.packages("IntLIM")
# Note: Requires Bioconductor package 'MultiDataSet'
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("MultiDataSet")
```

## Core Workflow

### 1. Data Input
IntLIM requires a CSV configuration file (input manifest) that points to:
- Metabolite expression data
- Gene expression data (or other omics)
- Sample metadata (phenotypes)
- Analyte metadata (optional)

```R
library(IntLIM)
inputData <- ReadData(inputFile = "path/to/config.csv", 
                      metabid = "metabolite_id_column", 
                      geneid = "gene_id_column")
```

### 2. Data Filtering
Filter analytes based on abundance, percentage of missing values, or variance to reduce the computational burden.

```R
# Filter by percent missing and percentile
inputDataFiltered <- FilterData(inputData, 
                                geneperc = 0.1, 
                                metabperc = 0.1, 
                                genethresh = 0, 
                                metabthresh = 0)
```

### 3. Linear Modeling (Interaction Analysis)
The core function runs a linear model: `Analyte1 ~ Analyte2 + Phenotype + Analyte2:Phenotype`. The interaction term determines if the relationship between analytes changes based on the phenotype.

```R
# Run the linear model
results <- RunIntLIM(inputDataFiltered, 
                     stype = "PhenotypeColumnName", 
                     outcome = "metabolite")
```

### 4. Results Filtering and Visualization
Filter results by FDR-adjusted p-values and the difference in Spearman correlation coefficients between groups.

```R
# Filter results
finalResults <- ProcessResults(results, 
                               inputDataFiltered, 
                               pvalcutoff = 0.05, 
                               diffcorr = 0.5)

# Visualize a specific pair
PlotPair(inputDataFiltered, 
         stype = "PhenotypeColumnName", 
         geneName = "GeneID", 
         metabName = "MetaboliteID")

# Heatmap of significant interactions
InteractionHeatmap(finalResults, inputDataFiltered)
```

## Tips for Success
- **Outcome Selection**: While typically metabolomics is the outcome, you can set `outcome = "gene"` depending on your biological hypothesis.
- **Data Scaling**: Ensure your data is log-transformed or appropriately normalized before running `RunIntLIM`.
- **Shiny App**: For an interactive experience, use `runIntLIMApp()` to launch the built-in web interface.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)