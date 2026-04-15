---
name: bioconductor-pubscore
description: This tool performs quantitative literature enrichment analysis to calculate relevance scores between gene lists and specific PubMed search terms. Use when user asks to calculate gene-term association scores, perform permutation tests for statistical significance, or generate heatmaps and network visualizations of literature enrichment.
homepage: https://bioconductor.org/packages/3.11/bioc/html/PubScore.html
---

# bioconductor-pubscore

name: bioconductor-pubscore
description: Quantitative literature enrichment analysis for gene lists using PubMed. Use this skill to calculate relevance scores for genes against specific topics, perform permutation tests to estimate statistical significance (p-values), and generate interactive visualizations (heatmaps and networks) of gene-term associations.

# bioconductor-pubscore

## Overview

The `PubScore` package provides a framework for quantifying the relationship between a list of genes and specific terms of interest (e.g., diseases, cell types, or biological processes) based on PubMed article counts. It is particularly useful for validating gene sets derived from high-throughput experiments (like scRNA-seq or feature selection) by checking if they are significantly enriched in existing literature compared to a background gene set.

## Core Workflow

### 1. Initialization
Create a `PubScore` object by providing a vector of gene symbols and a vector of terms to search in PubMed.

```r
library(PubScore)

selected_genes <- c('CD79A', 'CD14', 'NKG7', 'CST3', 'AIF1')
terms <- c("B cells", "macrophages", "NK cells")

# Initialize object and calculate initial score
pub <- pubscore(terms_of_interest = terms, genes = selected_genes)

# Retrieve the average number of articles per gene/term combination
score <- getScore(pub)
```

### 2. Statistical Significance (Permutation Testing)
To determine if the score is higher than expected by chance, run a permutation test. This requires a "universe" or background list of genes from which the selected genes were drawn.

```r
# total_genes should be the background set (e.g., all genes in the assay)
pub <- test_score(pub, total_genes = total_genes, nsim = 10000)
```

### 3. Handling Ambiguous Gene Names
Common gene symbols (e.g., "PC", "JUN", "MET") often lead to false positives because they are also common English words or acronyms. `PubScore` allows for blacklisting these.

```r
# Use the built-in blacklist or provide a custom one
pub <- test_score(pub, 
                  total_genes = total_genes, 
                  remove_ambiguous = TRUE, 
                  ambiguous_terms = c("PC", "JUN", "IMPACT"))
```

### 4. Visualization
`PubScore` integrates with `plotly` and `igraph` for interactive and static visualizations.

```r
# Interactive Heatmap
library(plotly)
p_heat <- heatmapViz(pub)
ggplotly(p_heat)

# Network Visualization
p_net <- networkViz(pub)
plot(p_net)
```

## Key Functions

- `pubscore()`: Main constructor. Queries PubMed and initializes the score.
- `getScore()`: Extracts the literature enrichment score.
- `test_score()`: Performs simulations to calculate a p-value.
- `heatmapViz()`: Generates a ggplot2 object for gene-term associations.
- `networkViz()`: Generates an igraph object showing connections between genes and terms.
- `get_all_counts()` / `set_all_counts()`: Accessors for the underlying count data, useful for avoiding redundant PubMed queries during re-testing.

## Usage Tips

- **Gene Symbols**: Ensure genes are in HGNC symbol format. If using Ensembl IDs, convert them using `biomaRt` before running `PubScore`.
- **Empty Names**: Remove empty strings (`""`) from your gene vectors, as they cause errors in PubMed queries.
- **Performance**: PubMed queries take ~0.7s per gene/term combination. For large gene lists, the initial `pubscore()` call or `test_score()` (if counts aren't cached) can take significant time.
- **Caching**: If you have already run a large simulation, save the counts using `get_all_counts(pub)` and reload them in future sessions to save hours of API calls.

## Reference documentation

- [PubScore Vignette](./references/PubScore_vignette.md)