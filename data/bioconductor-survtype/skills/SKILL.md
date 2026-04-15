---
name: bioconductor-survtype
description: This tool identifies patient subtypes by integrating survival data with clinical, gene expression, or mutation profiles. Use when user asks to perform semi-supervised clustering for survival-based subgroups, select genes using Cox proportional-hazards scores, or analyze the impact of specific mutations on patient outcomes.
homepage: https://bioconductor.org/packages/release/bioc/html/survtype.html
---

# bioconductor-survtype

name: bioconductor-survtype
description: Identification of patient subtypes using survival data combined with clinical, gene expression, or mutation data. Use this skill when you need to perform semi-supervised clustering to find clinically relevant subgroups, calculate Cox proportional-hazards scores for gene selection, or analyze the impact of specific mutations on survival outcomes.

# bioconductor-survtype

## Overview

The `survtype` package is designed to identify patient subtypes that are both biologically meaningful and clinically relevant. Unlike standard unsupervised clustering which ignores clinical outcomes, or purely clinical grouping which may lack biological basis, `survtype` integrates survival information (time-to-event and status) with molecular profiles. It supports three main workflows:
1. **Clinical-only**: Grouping based on median survival or estimated probabilities for censored data.
2. **Gene Expression**: Selecting genes via Cox scores followed by clustering to find expression-based subtypes.
3. **Mutation Data**: Identifying specific gene mutations that significantly differentiate survival curves.

## Workflow and Main Functions

### 1. Subtyping by Clinical Data Alone
Use `Surv.survtype` to create high-risk and low-risk groups based on survival time.
```r
library(survtype)
# data: dataframe containing survival columns
# time: column name for time
# status: column name for event status
result <- Surv.survtype(data, time = "time", status = "status")
plot(result, pval = TRUE)
```

### 2. Subtyping by Gene Expression
Use `Exprs.survtype` to identify clusters based on a subset of genes that correlate with survival.
```r
# clinic.data: dataframe with survival info
# exprs.data: matrix or SummarizedExperiment assay (genes as rows)
# num.genes: number of top Cox-ranked genes to use
# gene.sel: if TRUE, applies variable selection for clustering
res <- Exprs.survtype(clinic.data, time = "time", status = "status", 
                      exprs.data, num.genes = 50, clustering_method = "ward.D2")

# Visualize the Kaplan-Meier curves for the identified clusters
plot(res, pval = TRUE)

# Visualize the heatmap of genes defining the clusters
gene.clust(res, num.clusters = 2, scale = "row")
```

### 3. Single Gene Analysis
To test if a specific gene's expression level (using an optimal cutpoint) defines survival groups:
```r
# gene.vec: numeric vector of expression for one gene
sg <- Single.survgroup(clinic.data, time = "time", status = "status", 
                       gene.vec, group.names = c("High", "Low"))
plot(sg, pval = TRUE)
```

### 4. Mutation-based Subtyping
Use `MAF.survgroup` to find mutations (from MAF files) that most significantly impact survival.
```r
# maf.data: mutation data (e.g., from read.maf in maftools)
# variants: type of mutation to filter (e.g., "Missense_Mutation")
# top.genes: number of top significant genes to return
mut_res <- MAF.survgroup(clinic.data, time = "time", status = "status", 
                         maf.data, variants = "Missense_Mutation", top.genes = 1)

# View the statistical summary of genes
head(mut_res$summary)
```

## Tips and Best Practices
- **Data Matching**: Ensure that the row names of your clinical data match the column names (sample IDs) of your expression or mutation data.
- **Normalization**: For RNA-Seq data, perform log2 transformation and normalization (e.g., quantile normalization) before passing the matrix to `Exprs.survtype`.
- **Gene Selection**: Setting `gene.sel = TRUE` in `Exprs.survtype` helps refine the gene list to those most useful for clustering, which can lead to cleaner subtype definitions.
- **Visualization**: The `plot()` function for `survtype` objects is a wrapper that typically produces Kaplan-Meier plots with p-values.

## Reference documentation
- [Subtype Identification with Survival Data](./references/survtype.md)