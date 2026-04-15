---
name: bioconductor-fishpond
description: The fishpond package performs differential analysis of RNA-seq data using inferential replicates to account for quantification uncertainty. Use when user asks to perform transcript-level differential expression, analyze differential transcript usage, or detect allelic imbalance using the Swish algorithm.
homepage: https://bioconductor.org/packages/release/bioc/html/fishpond.html
---

# bioconductor-fishpond

## Overview

The `fishpond` package provides methods for differential analysis of RNA-seq data, primarily through the **Swish** algorithm. Unlike traditional methods that use point estimates of counts, Swish utilizes inferential replicates (bootstraps or Gibbs samples) to account for uncertainty in transcript-level quantification. It is particularly effective for transcript-level differential expression, differential transcript usage (DTU), and allelic imbalance (SEESAW workflow).

## Core Workflow: Swish for Differential Expression

The standard workflow for bulk RNA-seq involves importing data via `tximeta`, scaling, filtering, and testing.

```r
library(tximeta)
library(fishpond)

# 1. Import data (requires Salmon output with inferential replicates)
se <- tximeta(coldata)

# 2. Scaling and Filtering
y <- scaleInfReps(se)
y <- labelKeep(y)
y <- y[mcols(y)$keep, ]

# 3. Statistical Testing (Swish)
# x: the condition variable in colData
set.seed(1)
y <- swish(y, x="condition")

# 4. Access Results
res <- mcols(y) # Contains log2FC, pvalue, qvalue
```

### Key Parameters for `swish()`
- `x`: The primary condition variable.
- `pair`: Column name for paired/matched samples (e.g., `pair="subject_id"`).
- `cov`: Secondary covariate for batch correction or interaction tests.
- `interaction`: Set to `TRUE` to test if the effect of `x` varies across `cov`.
- `fast`: Set `fast=1` for paired designs to use a faster one-sample z-score statistic.

## Allelic Imbalance (SEESAW)

For allelic expression analysis, `fishpond` compares counts between two alleles (e.g., maternal vs. paternal) within the same sample.

```r
# Import allelic counts (requires specific Salmon diploid transcriptome output)
y <- importAllelicCounts(coldata, a1="alt", a2="ref", format="wide", tx2gene=tx2gene)

# Filter features with no allelic information
n <- ncol(y)/2
rep1a1 <- assay(y, "infRep1")[,y$allele == "a1"]
rep1a2 <- assay(y, "infRep1")[,y$allele == "a2"]
y <- y[rowSums(abs(rep1a1 - rep1a2) < 1) < n, ]

# Run Swish for Global Allelic Imbalance
y <- labelKeep(y)
y <- swish(y, x="allele", pair="sample")
```

## Single-Cell Analysis (Alevin)

For scRNA-seq data from Alevin, `fishpond` can use inferential mean and variance to generate pseudo-replicates, saving memory.

```r
# Import Alevin data without loading full replicates
sce <- tximeta(files, type="alevin", dropInfReps=TRUE)

# Generate pseudo-replicates (e.g., 20)
sce <- makeInfReps(sce, num=20)

# Scale and test
sce <- scaleInfReps(sce, lengthCorrect=FALSE)
sce <- swish(sce, x="cluster_label")
```

## Visualization Functions

- `plotInfReps(y, idx, x)`: Plots the inferential replicates for a specific feature (index or name).
- `plotMASwish(y)`: Generates an MA plot highlighting significant features.
- `plotAllelicHeatmap(y, idx)`: Heatmap of allelic ratios.
- `plotAllelicGene(y, gene, db)`: Genomic context plot of allelic/isoform proportions (requires Gviz).

## Tips for Success
- **Seed Setting**: Always use `set.seed()` before `swish()` as permutations and tie-breaking involve randomness.
- **Factor Levels**: Ensure the reference level of your condition factor is set correctly (the first level is the reference).
- **Gene-level Analysis**: Use `tximeta::summarizeToGene(se)` before running the Swish workflow to perform gene-level inference.
- **DTU**: Use `isoformProportions(y)` after scaling to transform counts into proportions for differential transcript usage testing.

## Reference documentation
- [Allelic expression analysis with Salmon and Swish](./references/allelic.md)
- [Swish: differential expression accounting for inferential uncertainty](./references/swish.md)