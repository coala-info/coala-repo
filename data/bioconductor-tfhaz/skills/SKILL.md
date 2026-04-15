---
name: bioconductor-tfhaz
description: This package identifies genomic high accumulation zones or hotspots where transcription factor binding sites are densely clustered. Use when user asks to find transcription factor hotspots, calculate genomic accumulation scores, identify dense binding zones, or determine optimal thresholds for transcription factor accumulation.
homepage: https://bioconductor.org/packages/release/bioc/html/TFHAZ.html
---

# bioconductor-tfhaz

## Overview
The `TFHAZ` package identifies genomic regions with high concentrations of transcription factor (TF) binding, often referred to as "hotspots" or high accumulation zones. It processes TF binding data (typically from ChIP-seq) to calculate accumulation scores across the genome using three metrics: TF count, region count, or base count. The package provides tools to determine optimal accumulation thresholds and analyze how neighborhood window sizes affect the identification of these zones.

## Core Workflow

### 1. Data Preparation
Input data must be a `GRanges` object where the ranges represent TF binding sites and a metadata column (typically named `TF`) contains the transcription factor names.

```r
library(TFHAZ)
data("Ishikawa") # Example dataset
# Ishikawa is a GRanges object with TF names in metadata
```

### 2. Calculating Accumulation
Use the `accumulation()` function to generate a score for each chromosome base.

*   **Accumulation Types (`acctype`):**
    *   `"TF"`: Number of different TFs in the window.
    *   `"region"`: Total number of binding regions in the window (allows duplicates of the same TF).
    *   `"base"`: Total number of bases covered by TF regions in the window.
*   **Window Size (`w`):** Half-width of the window. Use `w = 0` for a single-base approach.

```r
# Calculate TF accumulation for chr21 with no neighborhood window
acc_vector <- accumulation(Ishikawa, acctype = "TF", chr = "chr21", w = 0)

# Visualize the accumulation
plot_accumulation(acc_vector)
```

### 3. Finding Dense Zones
The `dense_zones()` function identifies contiguous regions where accumulation meets or exceeds specific thresholds.

```r
# Find zones across multiple thresholds (step = 1)
dense_results <- dense_zones(acc_vector, threshold_step = 1)

# Plot number of zones vs threshold to find the "elbow" (maximum slope change)
plot_n_zones(dense_results, chr = "chr21")
```

### 4. Identifying High Accumulation Zones (TFHAZ)
To find the final set of high accumulation zones using a specific statistical threshold:

*   **Methods:** `"overlaps"` (contiguous bases above threshold) or `"binding_regions"` (requires `w=0`).
*   **Thresholding:** `"std"` (mean + k*sd) or `"top_perc"` (top x percentage).

```r
# Find TFHAZ using the standard deviation method
tfhaz_results <- high_accumulation_zones(acc_vector, 
                                         method = "overlaps", 
                                         threshold = "std", 
                                         k = 2)

# Access the GRanges of hotspots
hotspots <- tfhaz_results$zones
```

## Analysis and Optimization

### Window Size Analysis (`w_analysis`)
To understand how the neighborhood window `w` affects results, compare multiple `dense_zones` outputs.
```r
# Assuming l is a list of dense_zones outputs with different w values
w_analysis(l, chr = "chr21")
```

### Principal Component Analysis (`n_zones_PCA`)
If unsure which `acctype` to use, PCA can determine if TF, region, and base accumulation provide redundant or unique information.
```r
# Compare the three accumulation types
n_zones_PCA(tf_dense, reg_dense, base_dense, chr = "chr21")
```

## Tips for Usage
*   **Performance:** `acctype = "base"` and large `w` values significantly increase computation time. `acctype = "TF"` or `"region"` is generally recommended.
*   **File Output:** Set `writeBed = TRUE` in `dense_zones` or `high_accumulation_zones` to automatically export results for visualization in genome browsers like IGV.
*   **Threshold Selection:** The `plot_n_zones` function is critical for identifying the threshold where the number of zones stabilizes, helping distinguish biological signal from noise.

## Reference documentation
- [TFHAZ](./references/TFHAZ.md)