---
name: bioconductor-netactivity
description: NetActivity computes gene set activity scores from gene expression data using pre-trained sparsely-connected autoencoder models. Use when user asks to compute pathway activity levels, project gene expression into a lower-dimensional biological space, or identify differentially active gene sets using GTEx or TCGA weights.
homepage: https://bioconductor.org/packages/release/bioc/html/NetActivity.html
---

# bioconductor-netactivity

## Overview

NetActivity is a Bioconductor package designed to compute gene set scores (activity levels) by applying pre-trained sparsely-connected autoencoder models to gene expression data. Unlike traditional enrichment methods, it uses weights derived from large-scale datasets (GTEx or TCGA) to project gene expression into a lower-dimensional space where each "neuron" represents a specific biological pathway or Gene Ontology (GO) term.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install(c("NetActivity", "NetActivityData"))
```

## Core Workflow

### 1. Data Preparation
The package requires a `SummarizedExperiment` object. Input data must be normalized (e.g., VST for RNA-seq or log-transformation for microarrays).

```r
library(NetActivity)
library(SummarizedExperiment)

# For RNA-seq (using DESeq2 VST as an example)
# vst_data is a SummarizedExperiment
# "gtex_gokegg" is a standard pre-trained model from NetActivityData
prepared_se <- prepareSummarizedExperiment(vst_data, "gtex_gokegg")
```

**Key Note on Annotation:** Models in `NetActivityData` typically use **ENSEMBL IDs**. If your data uses Gene Symbols or other IDs, you must convert them to ENSEMBL before running `prepareSummarizedExperiment`.

### 2. Computing Scores
The `computeGeneSetScores` function applies the model weights to the standardized data.

```r
scores_se <- computeGeneSetScores(prepared_se, "gtex_gokegg")
```

The resulting `scores_se` is a `SummarizedExperiment` where:
- **Rows:** Gene sets (GO terms or KEGG pathways).
- **Columns:** Samples.
- **Assay:** Activity scores.
- **rowData:** Contains the "Weights" and "Term" descriptions.

### 3. Downstream Analysis
Since the output is a standard `SummarizedExperiment`, you can use `limma` or other linear modeling tools to find differentially active pathways.

```r
library(limma)
design <- model.matrix(~ condition, data = colData(scores_se))
fit <- lmFit(assay(scores_se), design)
fit <- eBayes(fit)
results <- topTable(fit, coef = 2)
```

## Interpreting Results

The sign of a gene set score is arbitrary relative to the biological direction unless you inspect the weights. To understand what a "high" score means for a specific pathway:

1.  **Check Weights:** Look at `rowData(scores_se)$Weights_SYMBOL`.
2.  **Identify Drivers:** Genes with the largest absolute weights contribute most to the score.
3.  **Directionality:** If the top driver genes have positive weights, a higher activity score indicates higher expression of those specific genes.

## Tips and Best Practices

- **Missing Genes:** If genes required by the model are missing from your dataset, `prepareSummarizedExperiment` will set their expression to 0 and issue a warning. High numbers of missing genes may reduce the reliability of specific pathway scores.
- **Model Selection:** Common models include `"gtex_gokegg"` (General tissues) and `"tcga_gokegg"` (Cancer-specific).
- **Standardization:** Always use `prepareSummarizedExperiment` rather than manual scaling, as it ensures the data matches the expected input distribution of the autoencoder.

## Reference documentation

- [Gene set scores computation with NetActivity](./references/NetActivity.md)