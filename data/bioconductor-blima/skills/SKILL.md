---
name: bioconductor-blima
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/blima.html
---

# bioconductor-blima

name: bioconductor-blima
description: Preprocessing and analysis of Illumina microarray data at the bead (detector) level. Use this skill for background correction (outlier removal or Xie convolution), variance stabilizing transformation (VST), quantile normalization of unequal vectors, and differential expression testing (T-tests) on both bead and probe levels.

## Overview

The `blima` package provides tools for the low-level analysis of Illumina microarrays. Unlike many packages that work on summarized probe-level data, `blima` operates on the detector (bead) level. It integrates with the `beadarray` package's `beadLevelData` objects. Key features include a novel approach to quantile normalization for vectors of unequal lengths and the implementation of variance stabilization and T-tests directly on bead-level observations.

## Core Workflow

A typical `blima` analysis pipeline involves background correction, variance stabilization, normalization, and statistical testing.

### 1. Background Correction and Filtering

`blima` offers multiple methods for background handling:

*   **Outlier Removal:** `bacgroundCorrect` identifies and excludes beads with background intensity significantly different from the mean (e.g., $|I_b - \text{mean}| > k \cdot SD$).
*   **Xie Correction:** `xieBacgroundCorrect` implements a non-parametric estimator (RMA-like convolution) for background correction.
*   **Non-positive Correction:** `nonPositiveCorrect` ensures data is suitable for log transformation by handling values $\le 0$.

```r
# Example: Background outlier removal
# normalizationMod is a logical vector indicating which arrays to process
blimatesting = bacgroundCorrect(blimatesting, normalizationMod=c, channelBackgroundFilter="bgf")

# Ensure values are positive for subsequent log-based steps
blimatesting = nonPositiveCorrect(blimatesting, normalizationMod=c, channelCorrect="GrnF", 
                                 channelBackgroundFilter="bgf", channelAndVector="bgf")
```

### 2. Variance Stabilization (VST)

The `varianceBeadStabilise` function performs VST on the bead level, which is often necessary to stabilize the variance across the intensity range before normalization.

```r
blimatesting = varianceBeadStabilise(blimatesting, normalizationMod = processingMod,
                                     quality="GrnF", channelInclude="bgf", channelOutput="vst")
```

### 3. Quantile Normalization

`quantileNormalize` handles the specific challenge of Illumina data where different arrays or spots may have different numbers of beads.

```r
blimatesting = quantileNormalize(blimatesting, normalizationMod = processingMod,
                                 channelNormalize="vst", channelOutput="qua", channelInclude="bgf")
```

### 4. Differential Expression Testing

You can perform T-tests at two levels:
*   **Bead Level (`doTTests`):** Uses individual bead intensities.
*   **Probe Level (`doProbeTTests`):** Aggregates bead data to the probe level before testing.

```r
# T-test on bead level
beadTest = doTTests(blimatesting, groups1Mod, groups2Mod, "qua", "bgf")

# T-test on probe level
probeTest = doProbeTTests(blimatesting, groups1Mod, groups2Mod, "qua", "bgf")
```

## Quality Control and Summarization

*   **Statistics:** Use `chipArrayStatistics` to get bead counts, mean intensities, and standard deviations for each array spot.
*   **Visualization:** Use `plotBackgroundImageBeforeCorrection` and `plotBackgroundImageAfterCorrection` to inspect the relationship between foreground and background intensities.
*   **Summarization:** `createSummarizedMatrix` produces a standard expression matrix (probes x samples) from the bead-level data.

```r
# Create a summarized matrix for downstream tools
expMatrix = createSummarizedMatrix(blimatesting, quality="qua", channelInclude="bgf", 
                                   annotationTag="Name")
```

## Tips for Effective Usage

*   **Logical Vectors:** Most functions require `normalizationMod`, `c1`, or `c2` arguments. These are typically lists of logical vectors where each list element corresponds to a `beadLevelData` object, and the vector indicates which arrays (chips) within that object to include.
*   **Channel Management:** `blima` works by creating new "channels" (slots) within the `beadLevelData` object. Always keep track of your `channelOutput` names (e.g., "vst", "qua") to ensure you are passing the correct data to the next function.
*   **Transformations:** When performing T-tests, consider using `transformation = log2TransformPositive` within the test function if the data has not been log-transformed during VST.

## Reference documentation

- [blima Reference Manual](./references/reference_manual.md)