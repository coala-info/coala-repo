---
name: bioconductor-macarron
description: Macarron prioritizes bioactive metabolites from untargeted metabolomics data by integrating metabolic covariation with phenotypic associations. Use when user asks to prioritize metabolites, identify metabolic modules, or find functional drivers in metabolomics datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/Macarron.html
---


# bioconductor-macarron

name: bioconductor-macarron
description: Metabolic Covariation for Antigenic Response and Risk Optimization (Macarron). Use this skill when performing prioritization of bioactive metabolites from untargeted metabolomics data. It is specifically designed to identify metabolites that are likely to be functionally relevant by integrating metabolic covariation (co-abundance) with phenotypic associations.

# bioconductor-macarron

## Overview
Macarron is a Bioconductor package used to prioritize metabolites in untargeted metabolomics datasets. It moves beyond simple differential abundance by identifying "bioactive" metabolites—those that are both associated with a phenotype and part of a co-abundant metabolic module. This approach helps distinguish primary drivers of biological processes from secondary or redundant signals.

## Core Workflow

### 1. Data Preparation
Macarron requires two primary inputs: an abundance table (features vs. samples) and metadata (samples vs. phenotypes).

```r
library(Macarron)

# Load your metabolomics abundance data
# Rows are metabolites, columns are samples
metabolite_abundance <- read.table("metabolites.txt", header = TRUE, row.names = 1)

# Load metadata
# Rows are samples, columns include the phenotype of interest
metadata <- read.table("metadata.txt", header = TRUE, row.names = 1)
```

### 2. Identifying Metabolic Modules
Macarron groups metabolites into modules based on covariation. This reduces dimensionality and identifies tightly regulated metabolic clusters.

```r
# Calculate covariation and define modules
macarron_res <- Macarron(
    abundance = metabolite_abundance,
    metadata = metadata,
    phenotype = "TargetPhenotype"
)
```

### 3. Prioritization Logic
The package evaluates metabolites based on three main criteria:
- **Module Membership:** Is the metabolite part of a robust co-abundance cluster?
- **Phenotype Association:** Does the metabolite (or its module) correlate significantly with the study variable?
- **Bioactivity Score:** A composite score ranking the likelihood of the metabolite being a functional driver.

### 4. Visualizing and Exporting Results
Macarron provides functions to visualize the prioritized metabolites and their relationships within modules.

```r
# Plot the top prioritized metabolites
plot_macarron(macarron_res)

# Access the prioritization table
priority_table <- macarron_res$priority_scores
head(priority_table)
```

## Key Functions
- `Macarron()`: The main wrapper function that performs module identification and prioritization.
- `find_modules()`: Specifically handles the clustering of metabolites based on abundance patterns.
- `calculate_proximity()`: Measures the relationship between metabolites within the metabolic network.

## Usage Tips
- **Data Normalization:** Ensure metabolomics data is appropriately normalized (e.g., log-transformation or scaling) before running Macarron to ensure covariation is not driven by outliers.
- **Missing Values:** Macarron performs best when missing values are imputed or filtered out, as high sparsity can interfere with correlation-based module detection.
- **Phenotype Selection:** The phenotype variable should be clearly defined in the metadata (categorical or continuous).

## Reference documentation
- [Macarron Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/Macarron.html)