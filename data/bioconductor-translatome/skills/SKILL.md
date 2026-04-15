---
name: bioconductor-translatome
description: This tool analyzes and compares gene expression data across two parallel omics levels, such as the transcriptome and the translatome. Use when user asks to detect differentially expressed genes, perform Gene Ontology enrichment analysis, or compare biological themes between different levels of gene expression profiling.
homepage: https://bioconductor.org/packages/release/bioc/html/tRanslatome.html
---

# bioconductor-translatome

name: bioconductor-translatome
description: Analysis and comparison of gene expression at different levels (e.g., transcriptome vs. translatome). Use this skill when analyzing parallel high-throughput profiling data (microarray or NGS) to detect differentially expressed genes (DEGs), perform GO enrichment, and compare biological themes across two omics levels.

## Overview

The `tRanslatome` package is designed to compare two parallel omics datasets, typically the transcriptome (total mRNA) and the translatome (polysome-bound mRNA). It provides a complete workflow for detecting differentially expressed genes (DEGs) at both levels, identifying enriched Gene Ontology (GO) terms, and performing regulatory enrichment analysis using the AURA database.

## Core Workflow

### 1. Data Initialization
Create a `TranslatomeDataset` object from a normalized expression matrix.

```R
library(tRanslatome)
# expr_matrix: rows=genes, cols=samples
# cond.a/b: columns for level 1 (control/treated)
# cond.c/d: columns for level 2 (control/treated)
limma.dataset <- newTranslatomeDataset(expr_matrix, 
                                       cond.a, cond.b, 
                                       cond.c, cond.d,
                                       label.level = c("Transcriptome", "Translatome"),
                                       label.condition = c("Control", "Treated"),
                                       data.type = "array") # or "ngs"
```

### 2. Detecting DEGs
Identify differentially expressed genes using various statistical methods.

```R
# Supported methods: limma, t-test, RP, TE, ANOTA, DESeq, edgeR
limma.DEGs <- computeDEGs(limma.dataset, 
                          method = "limma", 
                          significance.threshold = 0.05, 
                          FC.threshold = 0, 
                          mult.cor = TRUE)

# Retrieve the DEGs object
degs_table <- getDEGs(limma.DEGs)
```

### 3. Visualization and QC
Visualize the relationship between the two expression levels.

*   **Scatterplot**: Shows fold changes of level 1 vs level 2.
    `Scatterplot(limma.DEGs, track = c("GENE1", "GENE2"))`
*   **Histogram**: Distribution of DEGs (up/down/homodirectional/antidirectional).
    `Histogram(limma.DEGs, plottype = "detailed")`
*   **MA-plot**: Average intensity vs log fold change.
    `MAplot(limma.DEGs)`
*   **SD/CV plots**: Standard deviation or Coefficient of Variation vs log fold change.
    `SDplot(limma.DEGs)` or `CVplot(limma.DEGs)`

### 4. GO Enrichment and Comparison
Identify and compare enriched biological themes.

```R
# Enrichment (ontology: BP, CC, MF, or all)
CCEnrichment <- GOEnrichment(limma.DEGs, 
                             ontology = "CC", 
                             classOfDEGs = "both", 
                             test.method = "elim")

# Comparison between levels
CCComparison <- GOComparison(CCEnrichment)

# Visualization
Radar(CCEnrichment, ontology = "CC")
Heatmap(CCEnrichment, ontology = "CC")
IdentityPlot(CCComparison) # Barplot of shared vs unique GO terms
SimilarityPlot(CCComparison) # Semantic similarity (Wang method)
```

### 5. Regulatory Enrichment
Identify overrepresented post-transcriptional regulators (e.g., RBPs, miRNAs) using the AURA database.

```R
regEnrichment <- RegulatoryEnrichment(limma.DEGs, 
                                      classOfDEGs = "up")
Radar(regEnrichment)
```

## Tips for Success
*   **Normalization**: `tRanslatome` does not normalize data unless using `edgeR` or `DESeq` methods within `computeDEGs`. Ensure input matrices are pre-normalized (e.g., quantile normalization for arrays).
*   **Color Coding**: In scatterplots, Blue = Level 1 only, Yellow = Level 2 only, Green = Homodirectional (both), Red = Antidirectional (both).
*   **Data Types**: Set `data.type = "ngs"` when working with count data from sequencing experiments.

## Reference documentation
- [tRanslatome: an R/Bioconductor package to portray translational control](./references/tRanslatome_package.md)