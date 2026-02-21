---
name: r-recetox-waveica
description: R package recetox-waveica (documentation from project home).
homepage: https://cran.r-project.org/web/packages/recetox-waveica/index.html
---

# r-recetox-waveica

name: r-recetox-waveica
description: Removal of batch effects for large-scale untargeted metabolomics data using wavelet transform and Independent Component Analysis (ICA). Use this skill when you need to normalize metabolomics data, specifically to remove technical variations (batch effects) while preserving biological signals using the WaveICA or WaveICA 2.0 algorithms.

## Overview

The `recetox-waveica` package provides tools for batch effect removal in untargeted metabolomics. It includes two primary algorithms:
1. **WaveICA (Original)**: Uses wavelet analysis and ICA to remove batch effects, requiring batch information and group information.
2. **WaveICA 2.0**: An updated version that removes batch effects without requiring batch information, relying instead on injection order.

## Installation

Install the package from CRAN:

```R
install.packages("recetox-waveica")
```

Or install the development version from GitHub:

```R
devtools::install_github("RECETOX/WaveICA")
```

## Main Functions

### waveica()
Used for the original WaveICA algorithm. It decomposes the data into different frequency scales and uses ICA to identify and remove components associated with batch effects.

**Key Parameters:**
- `data`: Feature table (samples as rows, features as columns).
- `wf`: Wavelet filter (e.g., "haar", "d4", "la8").
- `batch`: A factor or vector indicating the batch for each sample.
- `group`: A factor or vector indicating the biological group for each sample.
- `K`: Number of components for ICA.
- `t`: Threshold for the association between components and batch.
- `t2`: Threshold for the association between components and group.

### waveica_nonbatchwise()
Used for the WaveICA 2.0 algorithm. This is preferred when batch information is unavailable or when data was measured in a single continuous run.

**Key Parameters:**
- `data`: Feature table (samples as rows, features as columns).
- `wf`: Wavelet filter.
- `injection_order`: Numeric vector representing the sequence of injections.
- `alpha`: Significance level for the association test.
- `cutoff`: Threshold for the proportion of variance explained.
- `K`: Number of components for ICA.

## Workflows

### Batch-aware Normalization (WaveICA 1.0)
Use this when you have clear batch labels and biological group labels.

```R
library(recetox.waveica)

# Assuming features_table, batch_labels, and group_labels are prepared
normalized_data <- waveica(
  data = features_table,
  wf = "haar",
  batch = batch_labels,
  group = group_labels,
  K = 10
)
```

### Batch-agnostic Normalization (WaveICA 2.0)
Use this when batch information is missing or you want to correct for time-dependent drift using injection order.

```R
library(recetox.waveica)

# Assuming features_table and injection_order are prepared
normalized_data <- waveica_nonbatchwise(
  data = features_table,
  wf = "haar",
  injection_order = injection_order,
  K = 10
)
```

## Tips for Success
- **Data Preparation**: Ensure the input feature table contains only numeric intensity values. Metadata (batch, group, order) should be passed as separate vectors.
- **Wavelet Selection**: "haar" is a common starting point, but "d4" or "la8" can be used for smoother transitions.
- **Component Selection (K)**: Choosing K is critical. If K is too small, batch effects remain; if too large, biological signal may be lost. Start with a value around 10-20 and evaluate results via PCA.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)