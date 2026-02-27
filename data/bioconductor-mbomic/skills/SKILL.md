---
name: bioconductor-mbomic
description: The bioconductor-mbomic package provides a framework for the integrative analysis of metabolomics and microbiomics data through co-expression network construction and inter-omic correlation. Use when user asks to identify metabolite modules, correlate microbial abundance with metabolites, visualize multi-omic networks, or perform gut enterotyping.
homepage: https://bioconductor.org/packages/3.16/bioc/html/mbOmic.html
---


# bioconductor-mbomic

## Overview

The `mbOmic` package provides a specialized framework for the integrative analysis of metabolomics and microbiomics data. It facilitates the identification of inter-omic relationships by grouping metabolites into co-expression modules and correlating these modules (or individual analytes) with microbial abundance (OTUs/genera). Additionally, it includes a workflow for identifying human gut enterotypes using Jensen-Shannon divergence and clustering optimization.

## Core Workflows

### 1. Data Preparation and mbSet Objects
The package uses S4 classes to manage omics data. Use `mSet` for metabolites and `bSet` for microbiome data (e.g., OTU/genera tables).

```r
library(mbOmic)

# Prepare data (ensure first column is 'rn' for row names/features)
names(metabolites)[1] <- 'rn'
m <- mSet(m = metabolites)

# Basic exploration
samples(m)
features(m)

# Data cleaning: remove analytes present in fewer than 'fea_num' samples
m <- clean_analytes(m, fea_num = 2)
```

### 2. Metabolite Module Generation
`mbOmic` encapsulates `WGCNA` for one-step network construction.

```r
# Automatic power detection
net <- coExpress(m, threshold.d = 0.02, threshold = 0.8, plot = TRUE)

# If automatic detection fails, set power based on sample size:
# <20 samples: power = 9 (unsigned) or 18 (signed)
# 20-30 samples: power = 8 (unsigned) or 16 (signed)
net <- coExpress(m, power = 9)
```

### 3. Correlation Analysis
Calculate Spearman correlations between the two omic layers.

```r
names(genera)[1] <- 'rn'
b <- bSet(b = genera)

# Calculate correlations (supports parallel mode)
spearm <- corr(m = m, b = b, method = 'spearman')

# Filter significant results
significant_corrs <- spearm[abs(rho) >= 0.8 & p <= 0.001]
```

### 4. Network Visualization
Visualize the relationships between metabolite modules and microbial taxa.

```r
# Static plot
plot_network(net, significant_corrs, interaction = FALSE)

# Interactive plot (returns a visNetwork object)
plot_network(net, significant_corrs, interaction = TRUE, return = TRUE)
```

### 5. Enterotyping Workflow
Identify gut microbiota clusters (enterotypes) based on relative abundance.

```r
# 1. Estimate optimal number of clusters (k) using Jensen-Shannon divergence
# Returns a verCHI object with CHI and Silhouette indices
res <- estimate_k(b_data)

# 2. Identify enterotypes for the clusters
# Returns a list with enterotype assignments and unidentified samples
ret <- enterotyping(b_data, res$verOptCluster)
```

## Tips for Success
- **Data Formatting**: Ensure input data frames have the feature names in the first column and rename that column to `'rn'` before creating `mSet` or `bSet` objects.
- **WGCNA Power**: If `coExpress` throws a "No power detected" error, manually provide the `power` argument based on the sample size table provided in the documentation.
- **Parallel Processing**: The `corr` function can be computationally intensive; utilize parallel execution if the environment supports it to speed up large-scale inter-omic comparisons.

## Reference documentation

- [Integrative analysis of metabolome and microbiome](./references/Integrative_analysis_of_metabolome_and_microbiome.md)
- [Enterotyping](./references/enterotyping.md)