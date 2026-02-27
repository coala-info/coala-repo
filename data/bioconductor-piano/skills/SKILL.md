---
name: bioconductor-piano
description: The piano package provides a unified R framework for performing gene set analysis using multiple algorithms and directionality classes. Use when user asks to run gene set enrichment analysis, load gene set collections, visualize gene set networks, or perform consensus scoring across different GSA methods.
homepage: https://bioconductor.org/packages/release/bioc/html/piano.html
---


# bioconductor-piano

## Overview

The `piano` (Platform for Integrative Analysis of Omics data) package is a comprehensive R framework for gene set analysis. Its primary strength is providing a unified interface to run multiple GSA algorithms (e.g., GSEA, Fisher's, Reporter Metabolites) using the same input format. It introduces "directionality classes" (distinct-directional, mixed-directional, and non-directional) to provide deeper insights into how gene sets are regulated.

## Core Workflow

### 1. Prepare Input Data
GSA requires two main components: gene-level statistics (p-values or t-values) and a Gene Set Collection (GSC).

```r
library(piano)

# Load gene-level statistics (example using a named vector)
# Names must match the IDs in your Gene Set Collection
my_stats <- c(0.01, 0.05, 0.8)
names(my_stats) <- c("geneA", "geneB", "geneC")

# Optional: Load directions (e.g., log fold-changes)
my_dirs <- c(1.5, -2.0, 0.5)
names(my_dirs) <- names(my_stats)
```

### 2. Load Gene Set Collections (GSC)
Use `loadGSC` to import gene sets from data frames, GMT files, or SBML models.

```r
# From a 2-column data frame (Gene <-> Set mapping)
gsc_df <- data.frame(genes = c("g1", "g2"), sets = c("s1", "s1"))
myGsc <- loadGSC(gsc_df)

# From a GMT file
# myGsc <- loadGSC("path/to/file.gmt")
```

### 3. Run Gene Set Analysis
The `runGSA` function is the main engine. You can choose from various methods via the `geneSetStat` argument.

```r
gsaRes <- runGSA(geneLevelStats = my_stats, 
                 directions = my_dirs, 
                 gsc = myGsc, 
                 geneSetStat = "mean", # Options: "fisher", "gsea", "reporter", etc.
                 signifMethod = "geneSampling", 
                 nPerm = 10000)
```

**Method Compatibility:**
- **P-value based:** "fisher", "stouffer", "reporter", "tailStrength".
- **T-value based:** "maxmean", "gsea", "page", "mean", "median", "sum".

### 4. Interpret Directionality Classes
`piano` reports results in several classes:
- **Non-directional:** Enrichment of significant genes regardless of up/down regulation.
- **Distinct-directional:** Significant if genes in the set are coordinately regulated in one direction.
- **Mixed-directional:** Evaluates up-regulated and down-regulated subsets separately.

### 5. Visualize and Export Results
```r
# Summary table of all results
resTab <- GSAsummaryTable(gsaRes)

# Interactive exploration (Shiny app)
exploreGSAres(gsaRes)

# Network plot of overlapping gene sets
networkPlot(gsaRes, class = "non", significance = 0.05)
```

## Consensus Scoring
You can combine results from different GSA methods to find robustly enriched gene sets.

```r
# Run multiple methods
res1 <- runGSA(stats, gsc=myGsc, geneSetStat="mean")
res2 <- runGSA(stats, gsc=myGsc, geneSetStat="median")

# Combine and visualize
resList <- list(MeanMethod = res1, MedianMethod = res2)
ch <- consensusHeatmap(resList, cutoff = 30, method = "mean")
```

## Microarray Pre-processing
`piano` includes wrappers for `limma` and `affy` to move from raw data to GSA:
- `loadMAdata()`: Load CEL files or normalized data.
- `runQC()`: Generate quality control plots (PCA, heatmaps).
- `diffExp()`: Perform differential expression to generate the p-values/fold-changes needed for `runGSA`.

## Reference documentation
- [Running gene-set analysis with piano](./references/Running_gene-set_analysis_with_piano.md)
- [piano-vignette](./references/piano-vignette.md)