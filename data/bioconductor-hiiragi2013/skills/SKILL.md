---
name: bioconductor-hiiragi2013
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/Hiiragi2013.html
---

# bioconductor-hiiragi2013

name: bioconductor-hiiragi2013
description: Analysis of early mouse embryonic development (E3.25 to E4.5) using single-cell gene expression data. Use this skill to perform transcriptomic analysis of lineage segregation (EPI, PE, and ICM), cluster stability analysis, and differential expression workflows based on the Ohnishi et al. (2014) study.

# bioconductor-hiiragi2013

## Overview
The `Hiiragi2013` package provides the experimental data and executable analysis for the study of cell-to-cell expression variability in early mouse lineages. It contains normalized microarray data (Affymetrix) and qPCR data for wild-type and FGF4-KO embryos. The package is primarily used to study the progressive segregation of Epiblast (EPI) and Primitive Endoderm (PE) from the Inner Cell Mass (ICM).

## Data Loading and Preparation
The package provides two main datasets as `ExpressionSet` objects.

```R
library(Hiiragi2013)

# Load normalized microarray data (101 samples, 45101 features)
data("x")

# Load qPCR data
data("xq")

# Access phenotypic data (metadata)
pData(x)
# Key columns: Embryonic.day (E3.25, E3.5, E4.5), genotype (WT, FGF4-KO), sampleGroup, lineage
```

## Core Workflows

### 1. Cluster Stability Analysis
To determine if samples fall naturally into clusters (e.g., EPI vs. PE), use the `clue` package framework to perform resampling and consensus clustering.

*   **Workflow**: Draw random subsets (67%), select top variable features, apply k-means/PAM, and measure agreement with the consensus.
*   **Interpretation**: High agreement (near 1.0) indicates stable, reproducible clusters.

### 2. Differential Expression
Identify lineage markers or genes responding to FGF4 knockout.

```R
# Example: T-test between clusters in E3.5 WT samples
library(genefilter)
x35wt <- x[, x$Embryonic.day == "E3.5" & x$genotype == "WT"]
# Assuming 'clusters' is a factor derived from k-means
de_results <- rowttests(x35wt, fac = clusters)

# Independent filtering: Use variance to filter out noise before FDR adjustment
variance_rank <- rank(-rowVars(exprs(x35wt)))
adjp <- p.adjust(de_results$p.value[variance_rank <= 20000], method = "BH")
```

### 3. Principal Component Analysis (PCA)
Visualize sample relationships across developmental time and genotypes.

```R
# Select top 100 variable features (excluding FGF4 probes to avoid bias)
nfeatures <- 100
v_order <- order(rowVars(exprs(x)), decreasing = TRUE)
sel_features <- v_order[1:nfeatures]

# Compute PCA
the_pca <- prcomp(t(exprs(x[sel_features, ])), center = TRUE)
plot(the_pca$x[, 1:2], col = x$sampleColour, pch = 16)
```

### 4. Jensen-Shannon Divergence (JSD)
Measure transcriptomic heterogeneity within groups.

*   **Function**: `JSD(matrix)` where the matrix contains probability-transformed expression values (sum to 1 per cell).
*   **Usage**: Compare JSD across embryonic days to see if cell-to-cell variability increases or decreases during lineage commitment.

### 5. Rule-Based Temporal Classification
Classify genes into temporal profiles (Class 1-4) based on their expression peaks:
*   **Class 1**: Highest in E3.25.
*   **Class 2**: Highest in E3.5 (lineage-specific).
*   **Class 3**: Gradual increase (E3.25 < E3.5 < E4.5).
*   **Class 4**: Activated only at E4.5.

## Tips and Best Practices
*   **FGF4 Probes**: When analyzing FGF4-KO samples, be aware that some FGF4 probe sets (e.g., 1420085_at) are better reporters of the knockout effect than others.
*   **Scaling**: For heatmaps comparing different lineages, scale data to [0, 1] (min-max scaling) to highlight relative temporal changes rather than absolute intensity.
*   **Batch Effects**: When calculating variability (MAD), consider grouping samples by `Total.number.of.cells` or `ScanDate` to account for potential technical variation.

## Reference documentation
- [Hiiragi2013](./references/Hiiragi2013.md)