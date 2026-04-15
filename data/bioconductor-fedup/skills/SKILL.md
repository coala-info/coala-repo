---
name: bioconductor-fedup
description: This tool performs pathway enrichment and depletion analysis using Fisher's Exact Test on gene sets against a genomic background. Use when user asks to identify enriched pathways, perform enrichment analysis on CRISPR or genetic interaction data, or visualize results via dot plots and Cytoscape enrichment maps.
homepage: https://bioconductor.org/packages/release/bioc/html/fedup.html
---

# bioconductor-fedup

name: bioconductor-fedup
description: Fisher's Exact Test for Enrichment Analysis (fedup). Use this skill to perform pathway enrichment and depletion analysis on gene sets (single or multiple) against a background. It supports custom pathway annotations (GMT, TXT, XLSX) and provides integrated visualization via ggplot2 dot plots and Cytoscape enrichment maps.

# bioconductor-fedup

## Overview
The `fedup` package implements a Fisher's Exact Test to identify enriched or depleted pathways in user-defined gene sets. It is particularly useful for analyzing genetic interaction data or CRISPR screen results where both positive and negative hits need to be tested against a common genomic background.

## Core Workflow

### 1. Data Preparation
Input data must be a named list where one element is named `background` and other elements are your test sets (e.g., "positive_hits", "negative_hits").

```r
library(fedup)

# Example structure
genes <- list(
  background = c("GENE1", "GENE2", "GENE3", ...),
  test_set1 = c("GENE1", "GENE5"),
  test_set2 = c("GENE2", "GENE8")
)

# Pathways should be a named list of gene vectors (e.g., from a GMT file)
# Use readPathways() for GMT files
pathways <- readPathways("pathways.gmt")
```

### 2. Running Enrichment
The `runFedup` function handles the statistical testing for all sets in the list.

```r
fedupRes <- runFedup(genes, pathways)
```

### 3. Processing Results
Results are returned as a list of data tables, one per test set. Common columns include `pvalue`, `qvalue` (FDR), `fold_enrichment`, and `status` (enriched/depleted).

```r
# View top enriched pathways for a specific set
set1_results <- fedupRes[["test_set1"]]
enriched <- set1_results[set1_results$status == "enriched", ]
head(enriched[order(enriched$pvalue), ])
```

## Visualization

### Dot Plots
Use `plotDotPlot` to visualize significant results. It is often helpful to combine results into a single dataframe for faceting.

```r
library(dplyr)
library(tidyr)

# Prepare data
plot_df <- fedupRes %>%
  bind_rows(.id = "set") %>%
  filter(qvalue < 0.05) %>%
  mutate(log10q = -log10(qvalue))

# Plot
plotDotPlot(
  df = plot_df,
  xVar = "log10q",
  yVar = "pathway",
  fillVar = "status",
  sizeVar = "fold_enrichment"
) + facet_grid(~set)
```

### Enrichment Maps (Cytoscape)
`fedup` integrates with Cytoscape to group redundant pathways into biological themes.

1.  **Format for EM**: Use `writeFemap(fedupRes, "output_folder")`.
2.  **Prepare GMT**: Use `writePathways(pathways, "pathways.gmt")`.
3.  **Visualize**: Ensure Cytoscape is open with EnrichmentMap installed, then run `plotFemap()`.

## Tips
- **Background Selection**: Ensure the `background` list contains all genes that *could* have been picked in your experiment (e.g., all genes on the CRISPR library or all genes expressed in the tissue).
- **Pathway Names**: Pathway names in results often contain metadata (e.g., "PATHWAY_NAME%SOURCE%ID"). Use `gsub("\\%.*", "", pathway)` to clean them for plotting.
- **Multiple Sets**: When testing multiple sets, `runFedup` will warn you if there is high overlap between test sets, which may lead to similar enrichment results.

## Reference documentation
- [Running fedup with two test sets](./references/fedup_doubleTest.md)
- [Running fedup with multiple test sets](./references/fedup_mutliTest.md)
- [Running fedup with a single test set](./references/fedup_singleTest.md)