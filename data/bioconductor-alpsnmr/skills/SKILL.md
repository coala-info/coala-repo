---
name: bioconductor-alpsnmr
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/AlpsNMR.html
---

# bioconductor-alpsnmr

## Overview

AlpsNMR (Automated Spectra Processing System for NMR) is a Bioconductor package designed for the high-throughput analysis of 1D NMR spectra. It provides a complete pipeline from raw data (Bruker or JDX formats) to a final peak table. Most functions are prefixed with `nmr_` to avoid namespace conflicts and facilitate autocompletion.

## Workflow

### 1. Initialization and Parallelization
Enable parallel processing using `BiocParallel` to speed up computationally intensive tasks like peak detection.

```r
library(AlpsNMR)
library(BiocParallel)
register(SnowParam(workers = 2), default = TRUE)
```

### 2. Data Loading and Metadata
Load samples from directories or zip files. Metadata can be merged from external files (Excel/CSV) using a common key like `NMRExperiment`.

```r
# Load samples
dataset <- nmr_read_samples(sample_names = zip_files)

# Add metadata
dataset <- nmr_meta_add(dataset, metadata = annotations, by = "NMRExperiment")

# Retrieve metadata
meta <- nmr_meta_get(dataset, groups = "external")
```

### 3. Preprocessing
Standardize the spectra through interpolation, phasing, and excluding non-informative regions (e.g., water or solvent peaks).

```r
# Interpolate to a common ppm axis
dataset <- nmr_interpolate_1D(dataset, axis = c(min = -0.5, max = 10))

# Exclude specific regions
dataset <- nmr_exclude_region(dataset, exclude = list(water = c(4.6, 5)))

# Optional: Phasing
# dataset <- nmr_autophase(dataset, method = "MPC_DANM")
```

### 4. Quality Control and Outlier Detection
Use robust PCA to identify samples that deviate significantly from the rest of the dataset.

```r
pca_outliers <- nmr_pca_outliers_robust(dataset, ncomp = 3)
nmr_pca_outliers_plot(dataset, pca_outliers)
```

### 5. Baseline and Peak Detection
Estimate the baseline to improve peak detection accuracy. Peak detection uses a continuous wavelet transform (CWT).

```r
# Baseline estimation
dataset <- nmr_baseline_estimation(dataset, lambda = 9, p = 0.01)

# Detect peaks
baselineThresh <- nmr_baseline_threshold(dataset, range_without_peaks = c(9.5, 10))
peak_list <- nmr_detect_peaks(dataset, baselineThresh = baselineThresh, SNR.Th = 3)
```

### 6. Alignment and Normalization
Align spectra to a reference sample to correct for chemical shift variations, then normalize (e.g., PQN) to account for dilution effects.

```r
# Find reference and align
ref_exp <- nmr_align_find_ref(dataset, peak_list)
dataset_align <- nmr_align(dataset, peak_data = peak_list, NMRExp_ref = ref_exp)

# Normalize
dataset_norm <- nmr_normalize(dataset_align, method = "pqn")
```

### 7. Peak Grouping and Table Building
Cluster peaks across samples to create a unified peak table for statistical analysis.

```r
# Re-detect peaks on normalized data if necessary, then cluster
clustering <- nmr_peak_clustering(peak_list_norm)
peak_table <- nmr_build_peak_table(clustering$peak_data, dataset_norm)

# Convert to data frame for analysis
df_peaks <- as.data.frame(peak_table)
```

## Key Functions

- `nmr_read_samples()`: Reads Bruker or JDX files.
- `nmr_interpolate_1D()`: Interpolates spectra to a uniform ppm axis.
- `nmr_meta_add()`: Merges external metadata into the NMR dataset object.
- `nmr_exclude_region()`: Removes specific ppm ranges (e.g., water).
- `nmr_baseline_estimation()`: Estimates and subtracts spectral baseline.
- `nmr_detect_peaks()`: Identifies peaks using CWT.
- `nmr_align()`: Aligns spectra to a reference.
- `nmr_normalize()`: Performs PQN or other normalization methods.
- `nmr_peak_clustering()`: Groups peaks across the dataset.
- `nmr_identify_regions_blood()`: Provides metabolite identification for blood samples.

## Reference documentation

- [Introduction to AlpsNMR](./references/Vig01-introduction-to-alpsnmr.md)
- [Introduction to AlpsNMR (older API)](./references/Vig01b-introduction-to-alpsnmr-old-api.md)
- [Handling metadata and annotations](./references/Vig02-handling-metadata-and-annotations.md)