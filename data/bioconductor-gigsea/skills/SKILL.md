---
name: bioconductor-gigsea
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/GIGSEA.html
---

# bioconductor-gigsea

## Overview

GIGSEA (Genotype Imputed Gene Set Enrichment Analysis) is a method that uses GWAS summary statistics and eQTL data to perform gene set enrichment analysis. It addresses common challenges in SNP enrichment analysis—such as gene size and LD structure—by using imputed differential gene expression. The package utilizes weighted linear regression models where weights account for imputation accuracy and model completeness. It supports both discrete-valued (e.g., KEGG, GO) and continuous-valued (e.g., TargetScan miRNA binding affinity) gene sets.

## Core Workflow

### 1. Data Preparation
GIGSEA typically starts with output from MetaXcan (S-Predixcan). You need a data frame containing gene names, Z-scores (imputed differential expression), and weights.

```r
library(GIGSEA)
data(heart.metaXcan)

# Calculate weights: (fraction of SNPs used) * (prediction R^2)
usedFrac <- heart.metaXcan$n_snps_used / heart.metaXcan$n_snps_in_model
weights <- usedFrac * heart.metaXcan$pred_perf_r2

# Create the input data frame
input_data <- data.frame(
  gene = heart.metaXcan$gene_name,
  fc = heart.metaXcan$zscore,
  weights = weights
)
```

### 2. Loading Gene Sets
GIGSEA provides several built-in gene sets as sparse matrices.

*   **Discrete:** `data(MSigDB.KEGG.Pathway)`, `data(MSigDB.TF)`, `data(MSigDB.miRNA)`, `data(GO)`
*   **Continuous:** `data(Fantom5.TF)`, `data(TargetScan.miRNA)`, `data(LINCS.CMap.drug)`

### 3. Running Enrichment Analysis

#### Single Gene Set Enrichment Analysis (SGSEA)
Use the matrix-based function for high efficiency. It tests each gene set individually.

```r
# Align genes between expression data and gene set matrix
net <- MSigDB.KEGG.Pathway$net
data_aligned <- orderedIntersect(x = input_data, by.x = input_data$gene, by.y = rownames(net))
net_aligned <- orderedIntersect(x = net, by.x = rownames(net), by.y = input_data$gene)

# Run SGSEA with permutations
res_sgsea <- permutationSimpleLmMatrix(
  fc = data_aligned$fc, 
  net = net_aligned, 
  weights = data_aligned$weights, 
  num = 1000
)
```

#### Multiple Gene Set Enrichment Analysis (MGSEA)
Use this to adjust for redundancy/crosstalk between gene sets by considering all sets as covariates in one model.

```r
res_mgsea <- permutationMultipleLmMatrix(
  fc = data_aligned$fc, 
  net = net_aligned, 
  weights = data_aligned$weights, 
  num = 1000
)
```

### 4. One-Step Analysis
The `weightedGSEA` function wraps the entire process, checking multiple classes of gene sets and saving results to a directory.

```r
weightedGSEA(
  data = input_data, 
  geneCol = 'gene', 
  fcCol = 'fc', 
  weightCol = 'weights',
  geneSet = c("MSigDB.KEGG.Pathway", "TargetScan.miRNA"),
  permutationNum = 1000, 
  outputDir = "./GIGSEA_results"
)
```

## User-Defined Gene Sets
You can convert custom GMT files or data frames into the required sparse matrix format using `gmt2geneSet` and `geneSet2sparseMatrix`.

```r
# Example: Creating a net from custom terms
# net <- geneSet2sparseMatrix(term = terms, geneset = gene_lists, value = values)
```

## Tips for Performance
*   **Matrix Functions:** Always prefer functions ending in `Matrix` (e.g., `permutationSimpleLmMatrix`) as they use large matrix operations and are significantly faster than their standard counterparts.
*   **Sparse Matrices:** Use the `Matrix` package to handle gene sets to minimize memory footprint.
*   **Permutations:** For publication-quality results, use at least 10,000 permutations.

## Reference documentation
- [GIGSEA Tutorial](./references/GIGSEA_tutorial.md)