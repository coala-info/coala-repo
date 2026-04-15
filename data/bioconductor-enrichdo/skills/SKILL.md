---
name: bioconductor-enrichdo
description: This tool performs Disease Ontology enrichment analysis using a global weighted model to identify associations between gene sets and diseases. Use when user asks to perform disease ontology enrichment, identify disease associations for Entrez IDs, or visualize enriched disease terms using bar plots and DAG trees.
homepage: https://bioconductor.org/packages/release/bioc/html/EnrichDO.html
---

# bioconductor-enrichdo

name: bioconductor-enrichdo
description: Perform Disease Ontology (DO) enrichment analysis using the EnrichDO package. Use this skill to identify associations between gene sets (Entrez IDs) and diseases using a global weighted model that accounts for DO graph topology to reduce over-enrichment.

# bioconductor-enrichdo

## Overview

EnrichDO provides a double-weighted iterative model for Disease Ontology (DO) enrichment analysis. Unlike traditional methods, it integrates DO graph topology on a global scale to address the "true-path" rule problem. It assigns different weights to directly vs. indirectly annotated genes and dynamically down-weights less significant nodes to identify more specific disease terms.

## Installation

Install the package via Bioconductor:

```r
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("EnrichDO")
library(EnrichDO)
```

## Data Preparation

The input must be a vector of protein-coding genes in **ENTREZID** format (NCBI).

```r
# Example: Loading Entrez IDs
demo_genes <- c(1636, 351, 102, 2932, 3077, 348, 4137, 54209, 5663, 5328)
```

## Enrichment Analysis

Use the `doEnrich` function to perform the analysis.

### Weighted Enrichment (Default)
This is the recommended approach to leverage the global weighted model.

```r
result <- doEnrich(interestGenes = demo_genes)

# Advanced parameters
result_adv <- doEnrich(
  interestGenes = demo_genes,
  test = "fisherTest",   # Statistical model
  method = "holm",       # Multiple testing correction
  minGsize = 10,         # Minimum gene set size
  maxGsize = 2000,       # Maximum gene set size
  delta = 0.05           # Significance threshold
)
```

### Classic Enrichment (ORA)
Set `traditional = TRUE` to perform standard over-representation analysis without topological weighting.

```r
trad_result <- doEnrich(demo_genes, traditional = TRUE)
```

## Handling Results

### Inspection and Export
Use `show` for a summary and `writeResult` to save the data to a file.

```r
# Summarize object
show(result)

# Access the enrichment data frame
head(result$enrich)

# Write to text file
writeResult(EnrichResult = result, file = "enrichment_results.txt")
```

### Result Columns
The `enrich` data frame contains:
- `DOID` / `DOTerm`: Disease identifiers and names.
- `p` / `p.adjust`: Raw and corrected p-values.
- `level`: The depth in the DO Directed Acyclic Graph (DAG).
- `cg.len`: Number of interest genes annotated to the term.

## Visualization

EnrichDO provides four primary visualization methods:

### 1. Bar and Bubble Plots
Visualize the top significant terms.

```r
# Bar plot
drawBarGraph(result, n = 10, delta = 0.05)

# Bubble/Point plot
drawPointGraph(result, n = 10, delta = 0.05)
```

### 2. DAG Tree Plot
Visualize the hierarchical relationship of enriched terms.

```r
drawGraphViz(result, n = 10, pview = TRUE, numview = TRUE)
```

### 3. Heatmap
Show the relationship between specific genes and top DO terms.

```r
drawHeatmap(interestGenes = demo_genes, EnrichResult = result, gene_n = 10)
```

### 4. Plotting from Saved Files
If you have a saved result file, use `convDraw` to recreate the object for plotting without re-running the enrichment algorithm.

```r
data <- read.delim("enrichment_results.txt")
enrich_obj <- convDraw(resultDO = data)
drawBarGraph(enrich = enrich_obj)
```

## Reference documentation

- [EnrichDO](./references/EnrichDO.md)