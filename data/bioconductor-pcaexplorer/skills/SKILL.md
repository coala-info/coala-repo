---
name: bioconductor-pcaexplorer
description: pcaExplorer provides an interactive Shiny application and R functions for exploring RNA-seq data through Principal Components Analysis. Use when user asks to visualize sample relationships, identify gene loadings, perform functional enrichment on principal components, or generate reproducible PCA reports.
homepage: https://bioconductor.org/packages/release/bioc/html/pcaExplorer.html
---


# bioconductor-pcaexplorer

## Overview
The `pcaExplorer` package provides an interactive Shiny application and a suite of standalone R functions for exploring RNA-seq data through Principal Components Analysis. It bridges the gap between raw count matrices and biological insight by allowing users to visualize sample relationships, gene loadings, and functional enrichment of specific PCs. It integrates seamlessly with `DESeq2` objects and supports reproducible research through automated report generation.

## Core Workflow

### 1. Data Preparation
`pcaExplorer` works best with `DESeqDataSet` and `DESeqTransform` objects.

```R
library(pcaExplorer)
library(DESeq2)

# Create dds object
dds <- DESeqDataSetFromMatrix(countData = count_matrix, 
                              colData = col_data, 
                              design = ~ condition)

# Normalize and transform (required for PCA)
dds <- estimateSizeFactors(dds)
dst <- rlog(dds) # or vst(dds)
```

### 2. Launching the Interactive App
The app can be launched with varying levels of pre-computed data:

```R
# Basic launch
pcaExplorer(dds = dds, dst = dst)

# Launch with annotation for better readability
anno <- get_annotation_orgdb(dds, "org.Hs.eg.db", "ENSEMBL")
pcaExplorer(dds = dds, dst = dst, annotation = anno)
```

### 3. Standalone Analysis Functions
You can use the package's internal functions for custom plotting and analysis without the Shiny interface.

*   **Sample PCA Plot**: `pcaplot(dst, intgroup = "condition", ntop = 1000)`
*   **Scree Plot**: 
    ```R
    pcaobj <- prcomp(t(assay(dst)))
    pcascree(pcaobj)
    ```
*   **Identify High Loadings**: `hi_loadings(pcaobj, topN = 10)`
*   **Gene PCA (Biplot)**: `genespca(dst, ntop = 500)`
*   **Gene Expression Profiles**: `geneprofiler(dst, genelist = c("GENE1", "GENE2"))`

## Functional Interpretation (PCA2GO)
To understand the biological meaning of the principal components, use `pca2go` to find enriched GO terms for genes with high positive and negative loadings.

```R
# Pre-compute for the app or standalone use
bg_ids <- rownames(dds)[rowSums(counts(dds)) > 0]
pca2go_res <- pca2go(dst, 
                     annotation = anno, 
                     organism = "Hs", 
                     background_genes = bg_ids)

# Use in app
pcaExplorer(dds, dst, pca2go = pca2go_res)
```

## Tips for Effective Exploration
*   **Top Genes**: By default, PCA is often calculated on the top 500-1000 most variable genes. Adjust `ntop` in functions to see if patterns are robust.
*   **Annotation**: Always provide an `annotation` data frame with a `gene_name` column to avoid looking at cryptic Ensembl IDs.
*   **Multifactor**: Use `makeExampleDESeqDataSet_multifac()` to generate synthetic data for testing complex experimental designs (e.g., condition + tissue).
*   **State Saving**: In the Shiny app, use the "cog" icon to save the state to your R global environment for later use.

## Reference documentation
- [pcaExplorer User Guide](./references/pcaExplorer.md)
- [Up and running with pcaExplorer](./references/upandrunning.md)