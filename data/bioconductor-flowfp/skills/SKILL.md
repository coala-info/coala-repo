---
name: bioconductor-flowfp
description: This tool generates fingerprints from multivariate flow cytometry data using probability binning to create feature vectors for downstream analysis. Use when user asks to transform flowFrames or flowSets into fingerprints, perform high-throughput quality control, or generate feature vectors for clustering and classification.
homepage: https://bioconductor.org/packages/release/bioc/html/flowFP.html
---

# bioconductor-flowfp

name: bioconductor-flowfp
description: Fingerprinting for Flow Cytometry data analysis. Use this skill to transform multivariate flow cytometry data (flowFrames/flowSets) into "fingerprints" (feature vectors) for quality control, clustering, or classification. It is particularly useful for high-throughput analysis where manual gating is impractical or subjective.

## Overview

The `flowFP` package implements a "fingerprinting" approach to flow cytometry analysis. Instead of manual gating, it uses Probability Binning (PB) to divide multivariate space into hyper-rectangular regions (bins) containing nearly equal numbers of events. This creates a model of the data distribution that can be applied to any sample to generate a feature vector of event counts (a fingerprint).

## Core Workflow

### 1. Create a Model (`flowFPModel`)
The model defines how the multivariate space is partitioned. You typically build this using a representative "training set" (a `flowFrame` or `flowSet`).

```R
library(flowFP)
data(fs1)

# Build a model using SSC (param 2) and CD45 (param 5)
# nRecursions=7 results in 2^7 = 128 bins
mod <- flowFPModel(fs1, parameters=c(2, 5), nRecursions=7)
plot(mod)
```

### 2. Generate Fingerprints (`flowFP`)
Apply the model to your data to get event counts per bin.

```R
# Apply the model to a flowSet
fp <- flowFP(fs1, mod)

# View the fingerprint matrix (instances x bins)
counts_matrix <- counts(fp, transformation="normalize")

# Visualize fingerprints
plot(fp, type="stack")
```

### 3. Aggregate Multiple Models (`flowFPPlex`)
Use a `flowFPPlex` to combine fingerprints from different models or different parameter sets for the same instances.

```R
plex <- flowFPPlex(list(fp1, fp2))
plot(plex, type="grid")
```

## Key Functions and Methods

- `flowFPModel(obj, parameters, nRecursions)`: Constructor for the binning model. `nRecursions` determines resolution ($2^n$ bins).
- `flowFP(obj, model)`: Constructor for fingerprints. If `model` is NULL, a model is generated automatically from `obj`.
- `counts(fp, transformation)`: Extracts the fingerprint data. Transformations include `"raw"`, `"normalize"` (divide by expected count), and `"log2norm"`.
- `nRecursions(fp) <- value`: Allows reducing the resolution of an existing fingerprint without recomputing the model (must be $\le$ original recursions).
- `tags(fp)`: Returns the bin assignment for every event in the original flowFrame.
- `binBoundary(fp)`: Returns the multivariate boundaries for each bin.

## Visualization Types

The `plot` method for `flowFP` objects supports several `type` arguments:
- `stack`: Standard fingerprint plot showing bin counts across instances.
- `grid`: A heatmap-style grid of fingerprints.
- `qc`: A quality control view where colors indicate standard deviation from the norm.
- `plate`: Visualizes fingerprint deviations in a 96-well plate layout.
- `tangle`: Useful for `flowFPPlex` to show how fingerprints change across different recursion levels.

## Best Practices

- **Data Transformation**: Always transform flow data (e.g., logicle or arcsinh) before fingerprinting. PB is sensitive to data distribution; untransformed linear data often results in highly skewed bin sizes.
- **Event Counts**: Ensure you have enough events. If the number of bins approaches the number of events, statistical significance is lost. A rule of thumb is to have at least 10 events per bin.
- **Parameter Selection**: Only include parameters relevant to the biological question or QC task to avoid the "curse of dimensionality."
- **Memory Management**: Large `flowSets` consume significant RAM. For very large datasets, consider sampling (using the `sampleSize` argument in `flowFPModel`) to build the model.

## Reference documentation

- [flowFP: Fingerprinting for Flow Cytometry](./references/flowFP_HowTo.md)