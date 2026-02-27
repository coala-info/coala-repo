---
name: bioconductor-matter
description: This tool provides memory-efficient data structures and signal processing tools for handling larger-than-memory dense and sparse datasets in R. Use when user asks to create file-based matrices, perform out-of-memory computing, or apply signal processing techniques like smoothing and peak detection to mass spectrometry and image data.
homepage: https://bioconductor.org/packages/release/bioc/html/matter.html
---


# bioconductor-matter

name: bioconductor-matter
description: Expert guidance for using the Bioconductor package 'matter' for out-of-memory computing on dense and sparse arrays, and signal processing of nonuniform data like mass spectra. Use this skill when needing to handle larger-than-memory datasets in R, create file-based matrices/arrays, or perform signal processing (smoothing, baseline correction, peak detection) on spectral or image data.

## Overview
The `matter` package provides memory-efficient data structures for out-of-memory computing. It allows R to interact with large binary files as if they were native R vectors, matrices, or lists. It is particularly optimized for nonuniform signals (e.g., mass spectrometry) and provides a robust suite of signal and image processing tools that work on both in-memory and out-of-memory data.

## Out-of-Memory Data Structures

### Creating Matter Objects
Matter objects point to data on disk rather than loading it all into RAM.
- `matter_vec(data)`: Create an out-of-memory vector.
- `matter_mat(data, nrow, ncol)`: Create an out-of-memory matrix. Supports `rowMaj = TRUE` for row-major storage.
- `matter_arr(data, dim)`: Create an n-dimensional out-of-memory array.
- `matter_list(list)`: Create a file-based list (jagged array).

### Working with Existing Files
To map an existing binary file to a `matter` object, specify the metadata:
```r
# Map a double-precision vector from a file starting at byte 0
x <- matter_vec(type="double", path="data.bin", offset=0, extent=1000)
```

### Deferred Arithmetic
`matter` supports deferred operations. Arithmetic is not applied to the disk; it is calculated on-the-fly when data is accessed.
```r
m2 <- matter_mat(m1)
result <- m2 + 100  # No data is changed on disk
```

## Sparse Data Structures
`matter` provides sparse matrices (CSC/CSR) that support on-the-fly reindexing, which is critical for nonuniform spectral data.
- `sparse_mat(data, index, domain)`: Create a sparse matrix.
- **Nonuniform Signals**: Use the `domain` and `sampler` arguments to align signals with different x-axis values (e.g., m/z) without losing sparsity.
```r
# Aligning spectra with different m/z values to a common domain
spectra <- sparse_mat(intensity_list, index=mz_list, domain=common_mz, sampler="max")
```

## Signal and Image Processing

### Filtering and Smoothing
Functions follow the `filt1_*` (1D), `filt2_*` (2D), and `filtn_*` (N-dimensional/KNN) naming conventions.
- `filt1_gauss(s)`: Gaussian smoothing.
- `filt1_sg(s)`: Savitzky-Golay filtering.
- `filt1_pag(s)`: Peak-aware guided filtering.
- `filt2_bi(img)`: Bilateral filtering for images (preserves edges).

### Baseline and Contrast
- `estbase_snip(s)`: SNIP algorithm for baseline estimation.
- `estbase_hull(s)`: Convex hull baseline estimation.
- `enhance_adapt(img)`: CLAHE for image contrast enhancement.

### Peak Processing Workflow
1. **Detection**: `findpeaks(s, snr=3, noise="diff")` identifies local maxima above a noise threshold.
2. **Noise Estimation**: `estnoise_filt()` or `estnoise_sd()` can be used within `findpeaks`.
3. **Binning**: `binpeaks(peaklist)` aligns peaks from multiple samples into a common domain.
4. **Merging**: `mergepeaks(peaks, tol=1)` combines nearby peak bins.

## Reference documentation
- [User guide for flexible out-of-memory data structures](./references/matter2-guide.md)
- [Signal and image processing](./references/matter2-signal.md)