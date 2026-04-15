---
name: bioconductor-metabcombiner
description: metabCombiner aligns LC-MS metabolomics datasets from different chromatographic conditions using non-linear retention time mapping and feature grouping. Use when user asks to align metabolomics datasets, perform non-linear retention time mapping, merge untargeted LC-MS data from different batches, or calculate similarity scores for feature pair alignments.
homepage: https://bioconductor.org/packages/release/bioc/html/metabCombiner.html
---

# bioconductor-metabcombiner

## Overview

`metabCombiner` is a Bioconductor package designed to align LC-MS metabolomics datasets acquired under different chromatographic conditions. It groups features by m/z, performs non-linear retention time mapping to account for chromatographic shifts, and calculates a similarity score (0-1) for feature pair alignments (FPAs). The workflow is particularly useful for merging untargeted metabolomics data from different batches or studies where elution orders are mostly preserved but absolute retention times vary.

## Typical Workflow

### 1. Data Preparation (`metabData`)
Convert raw data frames into `metabData` objects. This step handles column mapping, filtering, and abundance ranking (Q values).

```r
library(metabCombiner)

# Create metabData objects
# samples: keyword for abundance columns; extra: metadata to preserve
p20 <- metabData(table = plasma20, mz = "mz", rt = "rt", 
                 id = "identity", adduct = "adduct", 
                 samples = "CHEAR", extra = c("Red", "POOL"),
                 rtmax = 17.25, duplicate = c(0.0025, 0.05))

p30 <- metabData(table = plasma30, samples = "Red", 
                 extra = c("CHEAR", "POOL", "Blank"))
```

### 2. Initial Grouping (`metabCombiner`)
Group features by m/z across the two datasets. The `binGap` parameter defines the m/z tolerance for grouping.

```r
# xdata is usually the dataset with the longer RT range
p.combined <- metabCombiner(xdata = p30, ydata = p20, binGap = 0.0075)
```

### 3. RT Mapping (Anchors & Splines)
Identify high-confidence "anchor" points (mutually abundant features) to fit a non-linear RT mapping model.

```r
# 1. Select Anchors
p.combined <- selectAnchors(p.combined, windx = 0.03, windy = 0.02, 
                            tolQ = 0.3, tolmz = 0.003)

# 2. Fit Model (GAM or LOESS)
# k: basis dimension (flexibility); iterFilter: outlier removal iterations
set.seed(100)
p.combined <- fit_gam(p.combined, k = seq(12, 20, 2), iterFilter = 2, family = "gaussian")

# 3. Visualize the fit
plot(p.combined, main = "RT Mapping Fit", xlab = "Dataset X RT", ylab = "Dataset Y RT")
```

### 4. Scoring and Labeling
Calculate similarity scores for all potential pairs and label them for conflicts or removal.

```r
# A, B, C: weights for m/z, RT fit, and Q (abundance) deviations
p.combined <- calcScores(p.combined, A = 70, B = 15, C = 0.5)

# Label rows to identify best matches and conflicts
# method "score" compares top-ranked pairs; "mzrt" uses tolerances
results <- combinedTable(p.combined)
results <- labelRows(results, minScore = 0.5, maxRankX = 3, method = "score")
```

### 5. Exporting Results
Use `write2file` to export a formatted report with gaps between m/z groups for easier manual inspection.

```r
write2file(results, file = "Combined_Metabolomics_Table.txt", sep = "\t")
```

## Key Functions and Parameters

- **`metabData()`**: Use `samples` and `extra` regex/keywords to distinguish between abundance data and metadata.
- **`selectAnchors()`**: `windx`/`windy` control the search window for anchors. Smaller windows yield more anchors but potentially more noise.
- **`fit_gam()` / `fit_loess()`**: Essential for RT alignment. Use `family = "scat"` for better outlier robustness at the cost of speed.
- **`calcScores()`**: 
    - **A**: m/z weight (typically 50-120).
    - **B**: RT weight (typically 5-15).
    - **C**: Abundance weight (typically 0-1).
- **`evaluateParams()`**: If you have known identities, use this to find optimal A, B, and C values.

## Tips for Success

1. **Dataset Order**: Assign the dataset with the shorter chromatographic run to `ydata` in the `metabCombiner` constructor.
2. **RT Filtering**: Use `rtmin` and `rtmax` in `metabData` to exclude void volumes or wash-out periods where feature alignment is unreliable.
3. **Conflict Resolution**: The `labelRows` function marks "CONFLICT" when multiple features in one dataset could match a single feature in the other. Inspect these manually in the output table.
4. **Identity Matching**: If you have compound IDs, set `useID = TRUE` in `selectAnchors` and `fit_gam` to prioritize these known matches during model training.

## Reference documentation
- [Combine LC-MS Metabolomics Datasets with metabCombiner](./references/metabCombiner_vignette.md)