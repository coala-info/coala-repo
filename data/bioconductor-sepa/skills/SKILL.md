---
name: bioconductor-sepa
description: This tool analyzes and visualizes gene expression patterns in single-cell RNA-seq data along experimental time points or pseudotime. Use when user asks to identify expression trends, perform pattern-specific GO enrichment analysis, or visualize temporal gene expression using heatmaps and scatter plots.
homepage: https://bioconductor.org/packages/3.5/bioc/html/SEPA.html
---


# bioconductor-sepa

name: bioconductor-sepa
description: Analyze and visualize gene expression patterns in single-cell RNA-seq data along true experimental time points or pseudo-temporal cell ordering. Use this skill to identify expression trends (e.g., monotonic, transition, or constant), perform pattern-specific GO enrichment analysis, and visualize results using heatmaps or scatter plots.

## Overview
SEPA (Single-cell Gene Expression Pattern Analysis) is an R package designed to characterize how gene expression changes over a time axis in single-cell datasets. It supports two main types of temporal data: discrete experimental time points and continuous pseudotime (often derived from tools like Monocle). SEPA categorizes genes into specific patterns (e.g., "up_constant", "constant_down", "down_up") and provides specialized Gene Ontology (GO) analysis, including moving-window GO analysis for transition patterns.

## Typical Workflow

### 1. Data Preparation
Ensure your gene expression matrix is appropriately transformed (e.g., log2 transformation) before analysis. You need a gene expression matrix and a vector representing either true time points or pseudotime.

```r
library(SEPA)
# Load example data
data(HSMMdata) 
# HSMMdata contains the expression matrix
# truetime and pseudotime are vectors associated with the cells
```

### 2. Pattern Identification for True Time Points
Use `truetimepattern` when cells are labeled with discrete experimental time points.

```r
# Identify patterns
true_patterns <- truetimepattern(HSMMdata, truetime)

# Summarize results
patternsummary(true_patterns)

# Visualize a specific gene
truetimevisualize(HSMMdata, truetime, "GENE_ID")
```

### 3. Pattern Identification for Pseudotime
Use `pseudotimepattern` for continuous cell ordering. This uses segmented linear regression to find transition points.

```r
# Identify patterns (returns a list including transition points)
pseudo_patterns <- pseudotimepattern(HSMMdata, pseudotime)

# Summarize results
patternsummary(pseudo_patterns)

# Check transition points for a specific pattern (e.g., constant_up)
head(pseudo_patterns$pattern$constant_up)

# Visualize a single gene (scatter plot with trend line)
pseudotimevisualize(pseudo_patterns, "GENE_ID")

# Visualize multiple genes (heatmap with transition points marked)
pseudotimevisualize(pseudo_patterns, c("GENE1", "GENE2", "GENE3"))
```

### 4. GO Enrichment Analysis
SEPA integrates with `topGO` to find biological functions associated with specific expression patterns.

```r
# Standard GO analysis for specific patterns
go_results <- patternGOanalysis(pseudo_patterns, 
                                type = c("constant_up", "down_constant"), 
                                termnum = 10)

# Window-based GO analysis (for transition patterns)
# This identifies how functions change as genes transition at different times
window_go <- windowGOanalysis(pseudo_patterns, 
                              type = "constant_up", 
                              windowsize = 20, 
                              termnum = 5)

# Visualize window GO results
windowGOvisualize(window_go)
```

## Tips and Best Practices
- **Input Transformation**: Always log-transform your expression data before running SEPA functions to ensure the statistical tests (t-tests and segmented regression) are valid.
- **Single Path Analysis**: If your pseudotime trajectory has multiple branches, analyze one path at a time.
- **Pattern Definitions**: 
    - `constant`: No significant change.
    - `up` / `down`: Monotonic increase or decrease.
    - `constant_up` / `up_constant`: Transitions between a stable state and a trend.
    - `up_down` / `down_up`: Transient peaks or valleys.
- **GUI**: For interactive exploration, use `SEPA()`. This launches a Shiny application that handles ID conversion and provides publication-quality plots.

## Reference documentation
- [SEPA: Single-Cell Gene Expression Pattern Analysis](./references/SEPA.md)