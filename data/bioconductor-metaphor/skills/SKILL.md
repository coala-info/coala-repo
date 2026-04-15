---
name: bioconductor-metaphor
description: MetaPhOR analyzes metabolic dysregulation by transforming gene-level transcriptomic data into pathway-level scores. Use when user asks to calculate metabolic pathway scores from differentially expressed genes, generate bubble plots or heatmaps of metabolic profiles, or visualize gene-level changes within metabolic pathways using Cytoscape.
homepage: https://bioconductor.org/packages/release/bioc/html/MetaPhOR.html
---

# bioconductor-metaphor

name: bioconductor-metaphor
description: Analyze metabolic dysregulation using transcriptomic data (RNA-seq or Microarray). Use this skill to calculate metabolic pathway scores from differentially expressed genes (DEGs), generate publication-quality bubble plots and heatmaps, and visualize gene-level changes within metabolic pathways using Cytoscape.

## Overview

MetaPhOR (Metabolic Pathway Analysis of RNA-seq) enables the assessment of metabolic dysregulation by transforming gene-level differential expression data into KEGG pathway-level scores. It calculates both the magnitude (absolute score) and direction (score) of transcriptional changes. The package uses a bootstrapping approach to assign statistical significance to these pathway alterations.

## Data Preparation

MetaPhOR requires a data frame or file path to a DEG list (e.g., from DESeq2 or limma).
- **Required Columns**: HUGO gene names, log fold change, and adjusted p-values.
- **Default Headers**: Assumes "log2FoldChange" and "padj" (DESeq2 style). If using limma or other tools, specify headers in the function arguments.

```r
# Example loading data
exdegs <- read.csv("path/to/degs.csv")
```

## Pathway Analysis

The `pathwayAnalysis` function is the core engine. It calculates scores and performs bootstrapping (default 100,000 iterations) to generate p-values.

**Critical Requirement**: You must set a seed before running this function to ensure reproducible bootstrapping results.

```r
set.seed(1234)
results <- pathwayAnalysis(
  DEGpath = "path/to/degs.csv",
  genename = "gene_symbol_column",
  sampsize = 100, # Number of samples in original study
  iters = 50000,  # Can reduce iterations for speed
  headers = c("logFC", "adj.P.Val") # Custom headers if not DESeq2
)
```

## Visualization

### Bubble Plots
Used to visualize the metabolic profile of a single comparison.
- **X-axis**: Scores (Direction)
- **Y-axis**: Absolute Scores (Magnitude)
- **Size**: Significance (P-value)

```r
plot_pval <- bubblePlot(scorelist = results, labeltext = "Pval", labelsize = 0.85)
plot(plot_pval)
```

### Meta-Heatmaps
Used to compare metabolic profiles across multiple groups or experiments.
- Requires a list of data frames produced by `pathwayAnalysis`.
- Only includes pathways meeting the `pvalcut` threshold.

```r
all_scores <- list(group1_res, group2_res)
names <- c("Group1", "Group2")
metaHeatmap(scorelist = all_scores, samplenames = names, pvalcut = 0.05)
```

### Gene-Level Pathway Modeling
The `cytoPath` function visualizes individual gene changes within a specific metabolic pathway.
- **Requirement**: Requires a local instance of **Cytoscape** running and the R package `RCy3`.
- Use `pathwayList()` to see available WikiPathways.

```r
# List available pathways
pathwayList()

# Model a specific pathway
cytoPath(
  pathway = "Tryptophan Metabolism",
  DEGpath = "path/to/degs.csv",
  figpath = getwd(),
  genename = "gene_symbol_column",
  headers = c("logFC", "adj.P.Val")
)
```

## Tips and Best Practices
1. **Seed Consistency**: Keep the same seed throughout your entire analysis to ensure pathway scores remain comparable.
2. **Sample Size**: Ensure `sampsize` accurately reflects the number of samples used in the underlying DEG analysis, as this influences the scoring model.
3. **Iteration Count**: While 100,000 iterations is the gold standard for publication, 50,000 is often sufficient for exploratory analysis and significantly faster.
4. **Pathway Names**: When using `cytoPath`, ensure the pathway name matches the string returned by `pathwayList()` exactly.

## Reference documentation
- [MetaPhOR Vignette](./references/MetaPhOR-vignette.md)