---
name: bioconductor-celaref
description: The celaref package annotates single-cell RNA-seq clusters by comparing their gene expression rankings to characterized reference datasets. Use when user asks to annotate scRNA-seq clusters, compare query clusters to reference datasets, or identify cell types based on transcriptomic similarity.
homepage: https://bioconductor.org/packages/release/bioc/html/celaref.html
---


# bioconductor-celaref

## Overview

The `celaref` package streamlines the annotation of scRNAseq clusters by suggesting labels based on transcriptomic similarity to characterized reference datasets. Unlike tools that operate at the individual cell level, `celaref` works at the cluster level. It ranks genes by their enrichment within a cluster (using the lower 95% CI of fold-change) and compares the distribution of "top" genes from a query cluster against the full rankings of a reference dataset.

## Typical Workflow

### 1. Data Loading and Preparation
`celaref` uses `SummarizedExperiment` objects. You can load data from flat files, 10X Genomics output, or R data frames.

```r
library(celaref)

# From flat files
dataset_se <- load_se_from_files(
    counts_matrix = "counts.tab",
    cell_info_file = "cell_metadata.tab",
    group_col_name = "Cluster" # Column containing cluster assignments
)

# From 10X CellRanger output
dataset_se <- load_dataset_10Xdata(
    dataset_path = "path/to/10X_output",
    dataset_genome = "GRCh38",
    clustering_set = "kmeans_7_clusters"
)
```

### 2. Pre-processing and Filtering
It is essential to filter low-expression genes and small clusters that lack statistical power.

```r
# Filter genes and small groups
dataset_se <- trim_small_groups_and_low_expression_genes(
    dataset_se,
    min_lib_size = 1000,
    min_group_membership = 5
)

# Optional: Convert IDs (e.g., Ensembl to Symbol)
# Requires a 'GeneSymbol' column in rowData
dataset_se <- convert_se_gene_ids(dataset_se, new_id='GeneSymbol', eval_col='total_count')
```

### 3. Within-Dataset Differential Expression
This step calculates the "distinctiveness" of genes for each cluster. It is the most time-consuming step and should be done for both query and reference datasets.

```r
# Parallelization is highly recommended via num_cores
de_table.query <- contrast_each_group_to_the_rest(
    dataset_se, 
    dataset_name = "my_query", 
    num_cores = 4
)
```

### 4. Comparison and Annotation
Compare the query rankings to the reference rankings to visualize similarity and generate labels.

```r
# 1. Visualize similarity with violin plots
# A biased distribution near 0 (top of plot) indicates high similarity
make_ranking_violin_plot(de_table.test = de_table.query, de_table.ref = de_table.ref)

# 2. Generate suggested cluster labels
label_table <- make_ref_similarity_names(de_table.query, de_table.ref)
# The 'shortlab' column contains the suggested names
```

## Working with Microarray References
If using a microarray dataset as a reference, use the `limma`-based function:

```r
de_table.microarray <- contrast_each_group_to_the_rest_for_norm_ma_with_limma(
    norm_expression_table = microarray_expr_matrix,
    sample_sheet_table = sample_metadata,
    dataset_name = "MicroarrayRef",
    sample_name = "sampleId", 
    group_name = "celltype"
)
```

## Interpreting Results

*   **Median Gene Rank**: A value near 0 indicates the query cluster's top genes are also highly ranked in the reference group. A value of 0.5 indicates a random distribution.
*   **shortlab**: The suggested label. If multiple reference groups are similar (e.g., subtypes), they are separated by "|".
*   **No similarity**: Reported if the distribution is not significantly different from random or if no clear frontrunner exists.
*   **Reciprocal Matches**: Indicated in brackets `()`. These occur when the reference-to-query comparison also supports the match, providing higher confidence.

## Reference documentation
- [celaref Manual](./references/celaref_doco.md)