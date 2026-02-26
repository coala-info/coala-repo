---
name: bioconductor-agdex
description: This tool evaluates the agreement of differential expression results across two distinct experiments, such as cross-species or cross-platform studies. Use when user asks to integrate transcriptome data, identify shared differentially expressed genes, or calculate the statistical significance of similarity between two biological comparisons.
homepage: https://bioconductor.org/packages/release/bioc/html/AGDEX.html
---


# bioconductor-agdex

name: bioconductor-agdex
description: Statistical evaluation of the agreement of differential expression (AGDEX) across two experiments (e.g., cross-species or cross-platform studies). Use this skill to integrate transcriptome data, identify shared differentially expressed genes/gene-sets, and calculate the statistical significance of similarity between two biological comparisons.

# bioconductor-agdex

## Overview

The `AGDEX` package provides a robust framework for comparing differential expression results between two distinct experiments. It is particularly useful for cross-species studies (e.g., comparing a mouse model to human disease) or cross-platform comparisons. It evaluates agreement across the entire transcriptome and within specific gene-sets using permutation-based testing.

## Core Workflow

### 1. Data Preparation
AGDEX requires data from each experiment to be encapsulated in a `dex.set` object.

```R
library(AGDEX)
library(Biobase)

# Create a dex.set for Experiment A
# Eset.data: An ExpressionSet object
# comp.var: Column index/name in pData for group labels
# comp.def: Contrast string (e.g., "case-control")
# gset.collection: (Optional) GeneSetCollection object
dex.set.A <- make.dex.set.object(Eset.data = human.eset, 
                                 comp.var = "group", 
                                 comp.def = "tumor-normal", 
                                 gset.collection = human.gs)

# Repeat for Experiment B
dex.set.B <- make.dex.set.object(Eset.data = mouse.eset, 
                                 comp.var = "condition", 
                                 comp.def = "model-wildtype")
```

### 2. Mapping Probe IDs
You must provide a mapping between the identifiers (probes/genes) of the two experiments.

```R
# map.data is a list containing:
# probe.map: data.frame with columns for both experiments
# map.Aprobe.col: index/name of Experiment A column
# map.Bprobe.col: index/name of Experiment B column
map.data <- list(probe.map = my_map_df, 
                 map.Aprobe.col = 1, 
                 map.Bprobe.col = 2)
```

### 3. Running AGDEX
The main analysis is performed using the `agdex` function.

```R
# min.nperms/max.nperms: Controls adaptive permutation testing
agdex.res <- agdex(dex.setA = dex.set.A, 
                   dex.setB = dex.set.B, 
                   map.data = map.data, 
                   min.nperms = 100, 
                   max.nperms = 1000)
```

## Interpreting Results

The result object is a list containing several key components:

*   `gwide.agdex.result`: Genome-wide agreement statistics (Cosine and Difference-of-Proportions) and their permutation p-values.
*   `dex.resA` / `dex.resB`: Differential expression results (difference of means and p-values) for each experiment individually.
*   `meta.dex.res`: Meta-analysis results for matched probe pairs, including Z-statistics and p-values.
*   `gset.res`: Results for gene-set differential expression and cross-experiment agreement.

## Visualization and Export

### Scatterplot
Visualize the agreement of differential expression statistics:
```R
# gset.id=NULL for genome-wide, or specify a gene-set ID
agdex.scatterplot(agdex.res, gset.id = NULL)
```

### Detailed Gene-Set Results
Extract probe-level details for specific gene-sets or those meeting a significance threshold:
```R
# Get details for gene-sets with p < 0.05
details <- get.gset.result.details(agdex.res, alpha = 0.05)
```

### Exporting Data
Save results to tab-delimited files for external use:
```R
write.agdex.result(agdex.res, file = "agdex_output.txt")
```

## Tips
*   **Adaptive Permutation Testing (APT):** AGDEX uses APT to save time. It continues permutations until `min.perms` significant statistics are found or `max.nperms` is reached. For exact tests, set `min.nperms` equal to `max.nperms`.
*   **Normalization:** Ensure expression data in `ExpressionSet` objects are normalized log-intensity values before creating `dex.set` objects.
*   **GeneSetCollection:** Use the `GSEABase` package to prepare gene-sets if you wish to perform pathway-level agreement analysis.

## Reference documentation
- [An Introduction to AGDEX](./references/AGDEX.md)