---
name: bioconductor-cola
description: This tool performs consensus partitioning to identify stable subgroups and signature features in high-throughput genomic data. Use when user asks to identify stable subgroups, perform consensus partitioning, extract signature features, or conduct hierarchical clustering for complex datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/cola.html
---

# bioconductor-cola

name: bioconductor-cola
description: Performs consensus partitioning for subgroup classification in high-throughput genomic data (e.g., gene expression, DNA methylation). Use when you need to identify stable subgroups, extract signature features, or perform hierarchical clustering with robust statistical validation.

# bioconductor-cola

## Overview
The `cola` package provides a comprehensive framework for consensus partitioning. It is designed to identify stable subgroups in high-throughput data by modularizing the process into feature selection (top-value methods) and partitioning methods. It supports various visualization tools, functional enrichment for signature genes, and hierarchical partitioning for complex datasets.

## Core Workflow

### 1. Data Preparation
Clean the input matrix to remove outliers and handle missing values.
```r
library(cola)
# mat is a matrix with features in rows and samples in columns
mat = adjust_matrix(mat)
```

### 2. Running Consensus Partitioning
You can run a single combination of methods or test all available combinations.

**Single Method:**
```r
res = consensus_partition(mat, 
                          top_value_method = "ATC", 
                          partition_method = "skmeans", 
                          top_n = c(1000, 2000, 3000),
                          max_k = 6)
```

**All Methods (Recommended for discovery):**
```r
rl = run_all_consensus_partition_methods(mat, cores = 4)
```

### 3. Determining the Best Number of Groups (k)
Use statistical metrics (1-PAC, silhouette, concordance) to select the optimal $k$.
```r
# For a single result
select_partition_number(res)
# For a list of results
collect_stats(rl, k = 3)
```

### 4. Extracting Signatures and Functional Enrichment
Identify features that distinguish the subgroups and perform GO/KEGG enrichment.
```r
# Get signature features
tb = get_signatures(res, k = 4)

# Functional enrichment (requires gene IDs)
# id_mapping is a named vector mapping rownames to Entrez IDs
lt = functional_enrichment(res, k = 4, id_mapping = id_mapping)
```

## Advanced Features

### Hierarchical Partitioning
For datasets with nested subgroup structures, use hierarchical partitioning to recursively find clusters.
```r
rh = hierarchical_partition(mat, cores = 4)
collect_classes(rh)
```

### The ATC Method
The "Ability to Correlate to other rows" (ATC) is a unique feature selection method in `cola` that identifies features based on their global correlation structure rather than just variance. It is highly effective for noisy data like single-cell RNA-seq.

### Big Datasets
For very large matrices, use down-sampling to perform partitioning on a subset and then predict the remaining samples.
```r
res = consensus_partition_by_down_sampling(mat, subset = 500, 
                                           top_value_method = "ATC", 
                                           partition_method = "skmeans")
```

## Visualization Tips
- `collect_plots(res)`: Generates a comprehensive overview of consensus, membership, and signature heatmaps.
- `dimension_reduction(res, k = 3)`: Visualizes samples using PCA, UMAP, or t-SNE.
- `cola_report(rl, output_dir = "./report")`: Generates a complete, interactive HTML report of the entire analysis.

## Reference documentation
- [Re-analyze an AML proteomics dataset](./references/AML.Rmd)
- [ATC - More Forms](./references/ATC_methods.Rmd)
- [The cola package](./references/cola.Rmd)
- [The cola package (Markdown)](./references/cola.md)
- [cola: A Framework for Consensus Partitioning](./references/cola_general.Rmd)
- [A Quick Start of cola Package](./references/cola_quick.Rmd)
- [Compare Two Partitioning Results](./references/compare_partitions.Rmd)
- [Applications on public datasets](./references/examples.Rmd)
- [Automatic Functional Enrichment on Signature Genes](./references/functional_enrichment.Rmd)
- [Hierarchical Consensus Partitioning](./references/hierarchical.Rmd)
- [Predict classes for new samples](./references/predict.Rmd)
- [Work with Big Datasets](./references/work_with_big_datasets.Rmd)