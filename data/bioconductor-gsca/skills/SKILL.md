---
name: bioconductor-gsca
description: Bioconductor-gsca identifies biological contexts where specific gene sets or transcription factors exhibit distinct activity patterns. Use when user asks to predict biological contexts for gene sets, integrate ChIP-seq data with expression compendia, or perform exploratory data analysis on gene expression samples.
homepage: https://bioconductor.org/packages/release/bioc/html/GSCA.html
---


# bioconductor-gsca

name: bioconductor-gsca
description: Gene Set Context Analysis (GSCA) for predicting biological contexts (cell types, diseases, conditions) associated with specific gene set activity patterns. Use this skill to integrate ChIP-seq/ChIP-chip data with large-scale gene expression compendia (human/mouse) to identify where specific transcription factors or gene sets are active.

# bioconductor-gsca

## Overview

GSCA (Gene Set Context Analysis) is a tool for "Gene Set Context Analysis." It allows users to take gene sets (often derived from ChIP-seq or differential expression experiments) and search for biological contexts in a large compendium of publicly available gene expression data where those genes exhibit specific activity patterns. It is particularly useful for identifying cell types or disease states where a transcription factor is likely functional.

## Core Workflow

### 1. Prepare Input Data
GSCA requires two main data frames: `genedata` (the genes) and `pattern` (the desired activity).

**Genedata Structure:**
A data frame with three columns:
- `gsname`: Name of the gene set (e.g., "TF", "TargetGenes").
- `gene`: Entrez GeneID (numeric).
- `weight`: `1` for activated genes, `-1` for repressed genes.

**Pattern Structure:**
A data frame with four columns defining the search criteria:
- `gsname`: Must match names in `genedata`.
- `acttype`: "High" or "Low" activity.
- `cotype`: Cutoff type ("Norm", "Quantile", or "Exprs").
- `cutoff`: Numeric value (p-value for "Norm", quantile 0-1 for "Quantile", or raw value for "Exprs").

### 2. Run the Analysis
The primary function is `GSCA()`. It compares your patterns against compendia for human (`hgu133a`) or mouse (`moe4302`).

```r
library(GSCA)

# Example: Search for contexts where TF and TG are both High
results <- GSCA(genedata = my_genedata, 
                pattern = my_pattern, 
                chipdata = "moe4302", 
                Pval.co = 0.05)

# View the ranking table
head(results[[1]])
```

### 3. Visualization
Use `GSCAplot` to visualize the distribution of samples and the defined activity region.

```r
GSCAplot(results, N = 5, Title = "Top 5 Biological Contexts")
```

## Exploratory Data Analysis (EDA)

If a specific experiment (e.g., a GSE ID) appears significant, you can perform follow-up analysis to compare related samples within that experiment.

1. **Search for samples:** Use `tabSearch(keyword, chipdata)` to find relevant contexts.
2. **Run EDA:** Use `GSCAeda()` to calculate statistics and generate boxplots/heatmaps comparing these contexts.

```r
# Find all samples in a specific GSE
search_res <- tabSearch("GSE7123", "hgu133a")

# Perform detailed comparison
eda_res <- GSCAeda(genedata = my_genedata, 
                   pattern = my_pattern, 
                   chipdata = "hgu133a", 
                   Searchoutput = search_res)
```

## Interactive UI
For users preferring a graphical interface, the package provides a Shiny app:
```r
GSCAui()
```

## Tips for Success
- **Gene IDs:** Ensure all gene identifiers are Entrez GeneIDs.
- **Cutoffs:** There is no universal "optimal" cutoff. "Norm" with a cutoff of 0.1 is a common starting point, but stringency should be adjusted based on the number of hits.
- **Weights:** If a gene set only contains activated genes, set all weights to 1.
- **Compendia:** `hgu133a` is for Human (GPL96); `moe4302` is for Mouse (GPL1261).

## Reference documentation
- [GSCA](./references/GSCA.md)