---
name: bioconductor-cocitestats
description: This tool performs statistical analysis of gene co-citation data from PubMed to quantify functional associations between genes. Use when user asks to calculate association measures between genes, adjust for gene and paper citation frequency, or evaluate the significance of co-citation between a gene and a list.
homepage: https://bioconductor.org/packages/release/bioc/html/CoCiteStats.html
---


# bioconductor-cocitestats

name: bioconductor-cocitestats
description: Statistical analysis of gene co-citation data using PubMed. Use this skill to calculate association measures (Concordance, Jaccard index, Hubert's Gamma, Odds Ratio) between genes based on shared citations, including adjustments for gene and paper size.

## Overview

The `CoCiteStats` package provides tools to quantify the relationship between genes based on their co-occurrence in PubMed abstracts. It moves beyond simple counts by providing adjustments for "actor size" (how often a gene is cited) and "event size" (how many genes a single paper cites). This is particularly useful for identifying functional associations between genes that are not merely artifacts of high citation frequency.

## Core Workflow

### 1. Data Preparation
Most functions require Entrez Gene identifiers (as strings) and a `paperLens` object which maps papers to the number of genes they cite.

```r
library(CoCiteStats)
library(org.Hs.eg.db)

# Generate paper length statistics for all genes (or a subset)
pL <- paperLen() 
# pL$counts contains citation counts per paper
# pL$papers contains papers per gene
```

### 2. Gene-to-Gene Analysis
To compare two specific genes, use `gene.gene.statistic`. This returns the original statistics plus three adjusted versions (gene size, paper size, and both).

```r
g1 <- "10"  # Entrez ID
g2 <- "101" # Entrez ID
stats <- gene.gene.statistic(g1, g2, paperLens = pL)

# Access adjusted results
stats$both  # Statistics adjusted for both gene and paper size
```

### 3. Gene-to-List Analysis
To evaluate the significance of co-citation between a single gene and a list of genes:

```r
gene_id <- "705"
list_ids <- c("7216", "1017", "558")

# Calculate statistics and empirical p-values via resampling
sig_results <- gene.geneslist.sig(gene_id, list_ids, n.resamp = 100)
```

### 4. Manual Table Construction and Testing
For custom workflows, you can generate the 2x2 contingency table manually and then apply statistics.

```r
# Create a two-way table (weighted by inverse paper size by default)
twT <- twowayTable("10", "100", weights = TRUE, paperLens = pL)

# Apply actor size adjustment (social network adjustment)
adj_twT <- actorAdjTable(twT)

# Compute test statistics (Concordance, Jaccard, Hubert, OddsRatio)
results <- twTStats(adj_twT)
```

## Key Statistics Explained

- **Concordance**: The raw (or weighted) count of papers citing both genes (n11).
- **Jaccard Index**: The intersection over union of citations; measures similarity normalized by the total number of papers citing either gene.
- **Hubert's Gamma**: A correlation-like measure for the association in the 2x2 table.
- **Odds Ratio**: The ratio of the odds of gene A being cited given gene B is cited, versus gene A being cited when gene B is not.

## Tips for Usage

- **Organism Support**: By default, the package uses `org.Hs.eg.db` (Human). For other organisms, you must explicitly provide the `paperLens` vector derived from the appropriate Bioconductor annotation package.
- **Weighting**: In `twowayTable`, setting `weights = TRUE` (default) discounts papers that cite a very large number of genes, as they are considered less specific/informative.
- **Entrez IDs**: Ensure all gene identifiers are passed as character strings, not integers.

## Reference documentation

- [CoCiteStats Reference Manual](./references/reference_manual.md)