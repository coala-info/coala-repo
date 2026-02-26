---
name: bioconductor-funchip
description: This tool performs functional data analysis to cluster ChIP-Seq peaks based on their morphological shapes. Use when user asks to estimate fragment length, compute base-level coverage pileup, smooth peaks with splines, or perform k-means clustering and alignment of genomic regions.
homepage: https://bioconductor.org/packages/3.6/bioc/html/FunChIP.html
---


# bioconductor-funchip

name: bioconductor-funchip
description: Functional Data Analysis (FDA) for ChIP-Seq peaks. Use this skill to cluster ChIP-Seq peaks based on their shapes rather than just magnitude. It supports fragment length estimation, base-level coverage pileup, spline smoothing, peak alignment, and k-means clustering of genomic regions.

## Overview

FunChIP is a Bioconductor package that applies Functional Data Analysis (FDA) to ChIP-Seq data. Unlike traditional peak callers that focus on peak height or area, FunChIP clusters peaks based on their morphology (shape). This is achieved through a pipeline of preprocessing, spline smoothing, and a k-mean alignment algorithm that accounts for horizontal shifts and vertical scaling of peaks.

## Typical Workflow

### 1. Input and Preprocessing
The package requires a `GRanges` object of enriched regions and a BAM file of aligned reads.

```R
library(FunChIP)
library(GenomicRanges)

# Load example data or user data
data(GR100) 
bamf <- "path/to/your/file.bam"

# Estimate fragment length (d) by minimizing distance between strands
d <- compute_fragments_length(GR, bamf, min.d = 0, max.d = 300)

# Compute base-level coverage for each peak
peaks <- pileup_peak(GR, bamf, d = d)
```

### 2. Smoothing and Scaling
Raw count vectors are approximated using cubic B-splines. This step removes background noise and allows for the calculation of derivatives.

```R
# Smooth peaks using Generalized Cross Validation (GCV) to find optimal lambda
# subsample.data is used to speed up the GCV calculation
peaks.smooth <- smooth_peak(peaks, lambda = 10^(-4:12), 
                            subsample.data = 50, 
                            GCV.derivatives = TRUE)

# Optional: Rescale peaks to have the same area and width for shape-only comparison
peaks.scaled <- smooth_peak(peaks, lambda = 10^6, rescale = TRUE)
```

### 3. Summit Identification
Identify the maximum point of the smoothed spline to initialize alignment.

```R
peaks.summit <- summit_peak(peaks.smooth)
```

### 4. Clustering and Alignment
The `cluster_peak` function performs the k-mean alignment. It can cluster peaks based on the original shape or the derivative (to focus on the "steepness" of the peak).

```R
# Cluster into 2 to 4 clusters
# shift.max defines the maximum allowed genomic shift for alignment
# weight: 0 for shape, 1 for derivative, or a value in between
result <- cluster_peak(peaks.summit, K = 2:4, 
                       shift.max = 50, 
                       weight = 0, 
                       rescale = FALSE)
```

### 5. Evaluating Results
Use the Bending Index or Silhouette plots to determine the optimal number of clusters.

```R
# Calculate bending index to choose K
b_index <- bending_index(result)

# Plot specific cluster results
plot_peak(peaks.summit, result, K = 3)
```

## Key Functions

- `compute_fragments_length`: Estimates the distance between positive and negative strand reads to determine fragment size.
- `pileup_peak`: Extracts base-level coverage from a BAM file for specified GRanges.
- `smooth_peak`: Fits splines to coverage data; handles background removal and optional area/width rescaling.
- `summit_peak`: Finds the genomic coordinate of the peak maximum in the smoothed spline.
- `cluster_peak`: The core algorithm for simultaneous alignment and clustering of functional data.
- `plot_peak`: Visualizes the results of the clustering, showing aligned peaks and cluster centers.

## Tips for Success

- **Lambda Selection**: If `smooth_peak` is too slow, provide a single `lambda` value (e.g., `10^6`) instead of a range, or increase the `subsample.data` parameter.
- **Background**: FunChIP estimates background as the minimum coverage value in the region. Ensure your GRanges are wide enough to capture the "shoulders" of the peak for accurate background estimation.
- **Alignment**: The `shift.max` parameter in `cluster_peak` is critical. It should be large enough to account for biological variation in peak positioning but small enough to prevent peaks from shifting into adjacent signals.

## Reference documentation

- [FunChIP: A Functional Data Analysis approach to cluster ChIP-Seq peaks according to their shapes](./references/FunChIP.md)