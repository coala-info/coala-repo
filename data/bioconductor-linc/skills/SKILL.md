---
name: bioconductor-linc
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.6/bioc/html/LINC.html
---

# bioconductor-linc

name: bioconductor-linc
description: Co-expression analysis of lincRNAs and protein-coding genes using the LINC R package. Use this skill to compute co-expression networks, identify biological contexts for lincRNAs via 'Guilty by Association', and perform functional enrichment analysis (GO, Reactome, DO) for non-coding RNAs.

# bioconductor-linc

## Overview
The `LINC` package provides a specialized workflow for analyzing the co-expression of long intergenic non-coding RNAs (lincRNAs) and protein-coding genes. It implements the "Guilty by Association" approach to predict the biological functions of lincRNAs based on the known functions of their co-expressed protein-coding partners. The package supports statistical corrections (SVA, PCA), outlier removal, and integration with `clusterProfiler` for functional enrichment.

## Core Workflow

### 1. Data Preparation and Matrix Creation
The starting point is a gene expression matrix where rows are genes and columns are samples. You must provide a logical vector identifying which genes are protein-coding.

```r
library(LINC)
data(BRAIN_EXPR)

# Create a LINCmatrix object
# codingGenes is a logical vector (TRUE for protein-coding)
crbl_matrix <- linc(cerebellum, codingGenes = pcgenes_crbl, corMethod = "spearman")

# Optional: Remove batch effects or principal components
crbl_matrix_clean <- linc(cerebellum, codingGenes = pcgenes_crbl, rmPC = c(1:5))
```

### 2. Co-expression Clustering
Cluster lincRNAs based on their interaction partners. This converts a `LINCmatrix` to a `LINCcluster`.

```r
# distMethod can be "dicedist", "correlation", or "pvalue"
crbl_cluster <- clusterlinc(crbl_matrix, distMethod = "dicedist", pvalCutOff = 0.05)

# Plot the cluster dendrogram and co-expression stats
plotlinc(crbl_cluster)
```

### 3. Functional Enrichment (Guilty by Association)
Identify biological terms associated with the protein-coding genes co-expressed with your lincRNAs.

```r
# Find enriched Gene Ontology (BP, MF, or CC)
crbl_bio <- getbio(crbl_cluster, enrichFun = 'enrichGO', ont = "BP")

# Plot enrichment results
plotlinc(crbl_bio)
```

### 4. Single Gene Analysis
To focus on a specific lincRNA query:

```r
# Analyze a single gene (e.g., Entrez ID "55384")
meg3_analysis <- singlelinc(crbl_matrix, query = "55384", threshold = 0.05)
plotlinc(meg3_analysis)

# Extract specific co-expressed gene IDs
coexpressed_genes <- getcoexpr(meg3_analysis)
```

## Advanced Features

### Multi-Dataset Comparison
Use `querycluster` to see how a specific lincRNA's co-expression pattern behaves across different tissues or conditions.

```r
# Compare 'NORAD' (ID 647979) across multiple LINCcluster objects
querycluster(query = '647979', queryTitle = 'NORAD', 
             ctx_cluster, hpc_cluster, crbl_cluster)
```

### Customizing Objects
Use the `feature` function and the `+` operator to add metadata for plotting.

```r
# Add custom ID and color for plots
crbl_cluster_feat <- crbl_cluster + feature(customID = "CEREBELLUM", customCol = "blue")
```

### Handling Different Organisms
If your data is not Human (default), change the annotation database:

```r
# Change to Mouse annotation
murine_matrix <- changeOrgDb(crbl_matrix, OrgDb = 'org.Mm.eg.db')
```

## Tips for Success
- **Gene IDs**: The package works best with Entrez IDs. If using Ensembl, ensure the `OrgDb` is set correctly.
- **Distance Methods**: "dicedist" (Czekanovski dice distance) is effective for clustering lincRNAs that share the same protein-coding partners.
- **Memory**: For very large matrices (>5000 genes), computation of the correlation matrix may be slow; consider filtering for high-variance genes first.

## Reference documentation
- [LINC Reference Manual](./references/reference_manual.md)