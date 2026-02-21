---
name: bioconductor-genegeneinter
description: The package also proposes tools for a graphic display of the results.
homepage: https://bioconductor.org/packages/3.8/bioc/html/GeneGeneInteR.html
---

# bioconductor-genegeneinter

name: bioconductor-genegeneinter
description: Statistical analysis of gene-gene interactions in case-control association studies using biallelic SNP data. Use this skill to perform gene-level interaction testing using 10 different methods (PCA, CCA, KCCA, PLSPM, CLD, GBIGM, minP, GATES, tTS, tProd), import/filter SNP data, and visualize interaction networks.

# bioconductor-genegeneinter

## Overview
The `GeneGeneInteR` package provides a comprehensive pipeline for testing interactions between pairs of genes in case-control studies. It transforms SNP-level genotype data into gene-level interaction statistics. The package supports data importation from standard formats (like .ped), data cleaning (MAF, HWE, call rate filtering), imputation, and multiple statistical testing frameworks.

## Core Workflow

### 1. Data Importation and Preparation
The package uses `SnpMatrix` objects from the `snpStats` package.

```R
library(GeneGeneInteR)

# Import from PED/INFO files
ped <- "path/to/data.ped"
info <- "path/to/data.info"
posi <- "path/to/data.txt"
data <- importFile(file=ped, snps=info, pos=posi, pos.sep="\t")

# Access components
Y <- data$status          # Phenotype (factor/numeric)
snpX <- data$snpX         # SnpMatrix
gInfo <- data$genes.info  # Gene/SNP mapping
```

### 2. Data Cleaning and Imputation
Statistical methods in this package generally do not handle missing values; imputation or filtering is required.

```R
# Filter SNPs based on quality metrics
data_clean <- snpMatrixScour(data$snpX, genes.info=data$genes.info, 
                             min.maf=0.05, min.eq=1e-3, call.rate=0.9)

# Impute missing values (Leave-One-Out approach)
data_imputed <- imputeSnpMatrix(data_clean$snpX, data_clean$genes.info)
```

### 3. Testing Interactions
You can test a single pair of genes or an entire network of genes.

#### Pairwise Testing (Single Pair)
Choose from 10 methods based on your research needs:
*   **Multidimensional:** `PCA.test`, `CCA.test`, `KCCA.test`, `PLSPM.test`, `CLD.test`, `GBIGM.test`.
*   **SNP-Aggregation:** `minP.test`, `gates.test`, `tTS.test`, `tProd.test`.

```R
# Example: PCA-based test
res_pair <- PCA.test(Y=Y, G1=gene1_SnpMatrix, G2=gene2_SnpMatrix, threshold=0.7)
```

#### Network Testing (All Pairs)
The `GGI` function automates all pairwise tests between genes in a dataset.

```R
# Perform all pairwise tests using PCA method
GGI.res <- GGI(Y=Y, snpX=data_imputed$snpX, genes.info=data_imputed$genes.info, method="PCA")

# Summarize significant interactions
summary(GGI.res)
```

### 4. Visualization
The package provides heatmap and network-based visualizations for `GGInetwork` objects.

```R
# Heatmap visualization
plot(GGI.res, method="heatmap", threshold=0.05, hclust.order=TRUE)

# Network visualization (genes as nodes, interactions as edges)
plot(GGI.res, method="network", threshold=0.05)
```

## Statistical Methods Summary

| Method | Function | Type | Key Parameters |
| :--- | :--- | :--- | :--- |
| Principal Components | `PCA.test` | Multidimensional | `threshold` (inertia) |
| Canonical Correlation | `CCA.test` | Multidimensional | `n.boot` |
| Kernel CCA | `KCCA.test` | Multidimensional | `kernel`, `sigma` |
| PLS Path Modeling | `PLSPM.test` | Multidimensional | `n.perm` |
| Composite LD | `CLD.test` | Multidimensional | `n.perm` |
| Information Gain | `GBIGM.test` | Multidimensional | `n.perm` |
| Minimum P-value | `minP.test` | Aggregation | - |
| GATES | `gates.test` | Aggregation | `me.est` (effective tests) |
| Truncated Tail Strength| `tTS.test` | Aggregation | `tau`, `n.sim` |
| Truncated Product | `tProd.test` | Aggregation | `tau`, `n.sim` |

## Reference documentation
- [Statistical analysis of the interaction between a pair of genes](./references/GenePair.md)
- [VignetteGeneGeneInteR Introduction](./references/VignetteGeneGeneInteR_Introduction.md)