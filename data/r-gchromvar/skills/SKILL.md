---
name: r-gchromvar
description: R package gchromvar (documentation from project home).
homepage: https://cran.r-project.org/web/packages/gchromvar/index.html
---

# r-gchromvar

name: r-gchromvar
description: Expert guidance for using the gchromvar R package to perform enrichment analyses of genome-wide chromatin accessibility data with GWAS summary statistics. Use this skill when you need to: (1) Compute cell-type specific GWAS enrichments using weighted deviations, (2) Import GWAS summary statistics (posterior probabilities) into RangedSummarizedExperiment objects, (3) Analyze quantitative chromatin accessibility data (ATAC-seq) in the context of genetic fine-mapping, or (4) Perform lineage-specific enrichment tests for complex traits.

# r-gchromvar

## Overview

The `gchromvar` package is an extension of the `chromVAR` framework designed to handle continuous (weighted) annotations rather than just binary ones. It is primarily used to discriminate between closely related cell types and score them for GWAS enrichment by weighting chromatin features by variant posterior probabilities. It compares these weights against an empirical background matched for GC content and feature intensity.

## Installation

To install the package from GitHub (as it is primarily hosted there):

```R
if (!require("devtools")) install.packages("devtools")
devtools::install_github("caleblareau/gchromVAR")
```

## Core Workflow

### 1. Prepare Chromatin Data
The input should be a `RangedSummarizedExperiment` containing a counts matrix and peak definitions. It is essential to add GC bias information for the background model.

```R
library(gchromVAR)
library(SummarizedExperiment)

# Assuming 'counts' is a matrix and 'peaks' is a GRanges object
SE <- SummarizedExperiment(assays = list(counts = counts),
                           rowData = peaks,
                           colData = DataFrame(names = colnames(counts)))

# Add GC bias (requires a BSgenome object, e.g., BSgenome.Hsapiens.UCSC.hg19)
SE <- addGCBias(SE, genome = BSgenome.Hsapiens.UCSC.hg19)
```

### 2. Import GWAS Summary Statistics
Use `importBedScore` to overlap GWAS posterior probabilities (PP) with your accessibility peaks. This creates a second `RangedSummarizedExperiment` where columns represent different traits.

```R
# files: vector of paths to BED files containing variant coordinates and scores
# colidx: the column index in the BED file containing the score (e.g., 5 for PP)
gwas_data <- importBedScore(rowRanges(SE), files, colidx = 5)
```

### 3. Compute Weighted Deviations
This is the core function of `gchromVAR`. It calculates how much the accessibility of peaks associated with a trait deviates from expected values.

```R
weighted_devs <- computeWeightedDeviations(SE, gwas_data)

# Extract Z-scores for enrichment
z_scores <- assays(weighted_devs)[["z"]]
```

### 4. Lineage-Specific Enrichment Testing
To validate results, you can compare Z-scores of lineage-specific cell types against non-lineage types using a Mann-Whitney Rank-sum test or similar non-parametric approach.

```R
# Example: Calculate p-values from Z-scores
p_values <- pnorm(z_scores, lower.tail = FALSE)

# Apply Bonferroni correction for significance
significant_hits <- z_scores[p_values < (0.05 / length(p_values))]
```

## Tips and Best Practices

- **Parallelization**: `gchromVAR` supports parallel processing via `BiocParallel`. Register a backend (e.g., `register(MulticoreParam(cores))`) before running `computeWeightedDeviations`.
- **Peak Width**: For best results, use consensus, equal-width peaks (e.g., 500bp) across all samples.
- **Input Scores**: While designed for fine-mapped posterior probabilities, any continuous variant-level score can be used with `importBedScore`.
- **Background Model**: Ensure the `BSgenome` version matches the assembly used for peak calling (e.g., hg19 vs hg38).

## Reference documentation

- [gchromVAR User's Guide](./references/gchromVAR_vignette.html.md)
- [gchromVAR Project Home](./references/home_page.md)
- [gchromVAR Mathematical Framework](./references/maths.pdf.md)