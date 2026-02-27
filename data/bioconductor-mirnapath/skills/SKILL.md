---
name: bioconductor-mirnapath
description: This tool performs pathway enrichment analysis for miRNA expression data while accounting for many-to-many relationships between miRNAs and target genes. Use when user asks to perform miRNA-mediated gene set enrichment analysis, run hypergeometric tests for miRNA pathways, or handle complex miRNA-to-gene mapping for functional validation.
homepage: https://bioconductor.org/packages/release/bioc/html/miRNApath.html
---


# bioconductor-mirnapath

name: bioconductor-mirnapath
description: Pathway enrichment analysis for miRNA expression data using the miRNApath R package. Use this skill when performing miRNA-mediated gene set enrichment analysis, specifically when you need to handle the many-to-many relationships between miRNAs and target genes using hypergeometric tests and permutation-based validation.

# bioconductor-mirnapath

## Overview

The `miRNApath` package implements a specialized enrichment analysis for microRNA (miRNA) data. Unlike standard gene set enrichment, it accounts for the complex many-to-many mapping where one miRNA targets multiple genes and one gene is targeted by multiple miRNAs. It uses a hypergeometric enrichment paradigm with an option for "Composite" enrichment to represent individual miRNA-gene prediction events.

## Core Workflow

### 1. Data Initialization
Load the library and create the base `mirnapath` object from a tab-delimited file.

```r
library(miRNApath)

# Load miRNA expression data
# mirnafile: tab-delimited file with miRNA names and P-values
mirnaobj <- loadmirnapath(
    mirnafile="mirnaTable.txt",
    pvaluecol="P-value",
    groupcol="GROUP",
    mirnacol="miRNA Name",
    assayidcol="ASSAYID"
)
```

### 2. Filtering for Hits
Define which miRNAs are considered "hits" based on statistical thresholds (P-value, fold change, or expression).

```r
# Filter for significance (e.g., P < 0.05)
mirnaobj <- filtermirnapath(mirnaobj, pvalue=0.05, expression=NA, foldchange=NA)
```

### 3. Loading Associations
You must provide two mapping files: miRNA-to-gene and gene-to-pathway.

```r
# Load miRNA-gene associations (e.g., from miRBase or TargetScan)
mirnaobj <- loadmirnatogene(
    mirnaobj=mirnaobj,
    mirnafile="mirnaGene.txt",
    mirnacol="miRNA Name",
    genecol="Entrez Gene ID",
    columns=c(assayidcol="ASSAYID")
)

# Load gene-pathway associations (e.g., KEGG or GO)
mirnaobj <- loadmirnapathways(
    mirnaobj=mirnaobj,
    pathwayfile="mirnaPathways.txt",
    pathwaycol="Pathway Name",
    genecol="Entrez Gene ID"
)
```

### 4. Running Enrichment
The `runEnrichment` function performs the statistical test.

```r
# Composite=TRUE treats each miRNA-gene combination as a separate event
# permutations > 0 provides empirical P-values for added confidence
mirnaobj <- runEnrichment(
    mirnaobj=mirnaobj, 
    Composite=TRUE, 
    groups=unique(mirnaobj@mirnaTable$GROUP), 
    permutations=1000
)
```

### 5. Exporting and Visualizing Results
Results can be exported in "Tall" (long) or "Wide" formats.

```r
# Export results table
finaltable <- mirnaTable(
    mirnaobj, 
    Significance=0.1, 
    format="Tall", 
    pvalueTypes=c("pvalues", "permpvalues")
)

# Create a heatmap for cross-group comparisons
widetable <- mirnaTable(mirnaobj, format="Wide", Significance=0.3)
widetable[is.na(widetable)] <- 1
wt_matrix <- as.matrix(widetable[, 3:ncol(widetable)])
heatmap(log2(wt_matrix), scale="row")
```

## Key Parameters

- **Composite**: If `TRUE`, the algorithm counts every miRNA-gene pair. If `FALSE`, it reverts to standard hypergeometric enrichment where multiple miRNAs hitting the same gene are counted once.
- **permutations**: Setting this to a value (e.g., 1000) randomizes the miRNA "hits" to determine if the observed pathway enrichment is better than random chance.
- **pvalueTypes**: Can include "pvalues" (standard hypergeometric) and "permpvalues" (permutation-based).

## Reference documentation

- [miRNApath](./references/miRNApath.md)