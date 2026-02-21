---
name: r-mytai
description: R package mytai (documentation from project home).
homepage: https://cran.r-project.org/web/packages/mytai/index.html
---

# r-mytai

name: r-mytai
description: Evolutionary transcriptomics analysis using the myTAI R package. Use this skill to quantify transcriptome conservation, calculate Transcriptome Age Index (TAI) or Transcriptome Divergence Index (TDI), and perform statistical assessments of evolutionary constraints in gene expression datasets (bulk or single-cell).

## Overview

The `myTAI` package integrates gene age information (phylostratigraphy) with transcriptomic data to study the evolution of biological processes. It allows researchers to identify stages of evolutionary conservation (e.g., the "hourglass model") by determining the average evolutionary age of expressed genes across different developmental stages or conditions.

## Installation

```R
install.packages("myTAI")
```

## Core Workflows

### 1. Data Preparation
`myTAI` uses a "PhyloExpressionSet" (for bulk) or "scPhyloExpressionSet" (for single-cell). This is a data frame where:
- Column 1: Phylostratum (PS) or Divergence Stratum (DS) levels (integers).
- Column 2: Gene ID.
- Columns 3+: Expression levels across stages/cells.

```R
library(myTAI)
data("example_phyex_set") # Load example PhyloExpressionSet
```

### 2. Calculating Transcriptome Indices
Quantify the evolutionary signature of a transcriptome stage.
- **TAI (Transcriptome Age Index):** Weighted average of gene age.
- **TDI (Transcriptome Divergence Index):** Weighted average of sequence divergence.

```R
# Calculate TAI for each stage
tai_result <- TAI(example_phyex_set)
```

### 3. Visualization
- **Signature Plot:** Visualize TAI/TDI patterns across stages.
- **Contribution Plot:** See which Phylostrata contribute most to the index.
- **Gene Space:** Dimension reduction of evolutionary signatures.

```R
# Plot TAI signature
plot_signature(example_phyex_set)

# Plot contribution of each phylostratum
plot_contribution(example_phyex_set)
```

### 4. Statistical Testing
Test if the observed pattern (e.g., an hourglass shape) is statistically significant compared to random permutations.
- `FlatLineTest()`: Tests if the TAI profile is significantly non-flat.
- `ReductiveHourglassTest()`: Tests for an hourglass pattern (high-low-high).

```R
# Test for hourglass pattern
ReductiveHourglassTest(example_phyex_set, permutations = 1000)
```

### 5. Single-Cell Analysis
`myTAI` supports Seurat objects directly for single-cell evolutionary transcriptomics.

```R
# Convert Seurat to scPhyloExpressionSet
# sc_set <- SeuratToPhyloExpressionSet(seurat_object, phylostratum_map)
```

## Tips
- **Gene Age Inference:** Use `GenEra` or `orthomap` to generate the phylostratigraphic map (Phylostratum column) before using `myTAI`.
- **Data Transformation:** Use `tf(ExpressionSet, log2)` to log-transform data before index calculation to reduce the impact of outlier highly expressed genes.

## Reference documentation
- [NEWS.md](./references/NEWS.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [cran-comments.md](./references/cran-comments.md)
- [home_page.md](./references/home_page.md)
- [wiki.md](./references/wiki.md)