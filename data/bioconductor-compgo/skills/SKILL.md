---
name: bioconductor-compgo
description: bioconductor-compgo performs comparative gene ontology enrichment analysis and visualization for genomic regions or gene lists. Use when user asks to annotate BED files with genes, retrieve functional annotations from DAVID, compare GO enrichment between samples, or visualize GO term hierarchies and clustering.
homepage: https://bioconductor.org/packages/3.8/bioc/html/CompGO.html
---


# bioconductor-compgo

name: bioconductor-compgo
description: Perform gene ontology (GO) enrichment comparison and visualization for genomic regions (.bed files) or gene lists. Use this skill to annotate BED files with genes, interface with DAVID for functional annotation, and compare GO enrichment between samples using Z-scores, Jaccard metrics, and directed acyclic graphs (DAGs).

# bioconductor-compgo

## Overview

CompGO is an R package designed for the comparative analysis of Gene Ontology (GO) enrichment. It bridges the gap between genomic coordinates (BED files) and functional interpretation by automating gene annotation and interfacing with the DAVID web service. Its primary strength lies in comparing enrichment profiles across multiple samples using statistical standardization (Z-scores) and similarity metrics (Jaccard index).

## Core Workflow

### 1. Data Preparation and Annotation
If starting with genomic regions, use `CompGO` to map BED files to genes.

```r
library(CompGO)

# Annotate BED files to genes
# Requires rtracklayer and appropriate TxDb objects
annotated_list <- annotateBed(bedFiles = c("sample1.bed", "sample2.bed"), 
                              txdb = "TxDb.Hsapiens.UCSC.hg19.knownGene")
```

### 2. Functional Annotation with DAVID
CompGO interfaces with `RDAVIDWebService` to retrieve GO terms. You must have a registered DAVID account (email).

```r
# Generate functional annotation charts
# This requires an active internet connection and DAVID credentials
david_results <- getFullData(geneLists = annotated_list, 
                             email = "your_email@example.com", 
                             catalog = "GOTERM_BP_FAT")
```

### 3. Comparative Visualization and Statistics
Compare two or more samples to identify shared or unique biological processes.

*   **Z-score Standardization**: CompGO converts log odds-ratios to Z-scores to allow for normal distribution-based comparisons.
*   **Scatterplots**: Visualize the correlation of GO enrichment between two samples.
*   **Jaccard Metrics**: Quantify the similarity between sets of enriched GO terms.

```r
# Compare two samples via scatterplot
compareGO(david_results[[1]], david_results[[2]], 
          method = "scatterplot", 
          column = "ZScore")

# View GO term hierarchy using a Directed Acyclic Graph (DAG)
plotGOTermDAG(david_results[[1]], david_results[[2]])
```

### 4. Large-Scale Clustering
For experiments with many samples, use clustering functions to group samples with similar GO enrichment profiles.

```r
# Cluster multiple samples based on GO enrichment
cluster_results <- clusterGO(david_results)
plot(cluster_results)
```

## Key Functions

*   `annotateBed()`: Converts BED coordinates to gene lists using Bioconductor annotation packages.
*   `getFullData()`: Wrapper to fetch enrichment data from DAVID for multiple lists.
*   `compareGO()`: Main interface for pairwise comparisons (Scatterplots, Jaccard).
*   `plotGOTermDAG()`: Visualizes the relationship between enriched terms in the GO hierarchy.

## Tips for Success

*   **DAVID Credentials**: Ensure you have a valid registered email with DAVID before running `getFullData`.
*   **Gene ID Consistency**: Ensure the gene identifiers in your lists match the expected input for the DAVID API (e.g., Entrez IDs).
*   **Log-Odds Ratios**: When interpreting results, remember that CompGO uses log-odds ratios and standard errors to calculate Z-scores, providing a more robust comparison than raw p-values.

## Reference documentation

- [CompGO Introduction](./references/CompGO-Intro.md)