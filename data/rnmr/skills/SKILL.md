---
name: rnmr
description: The rnmr tool facilitates the programmatic processing and analysis of 1D NMR spectra using the Rnmr1D package. Use when user asks to process raw NMR data, execute macro-command sequences for baseline correction, generate normalized bucket tables, or visualize spectral matrices.
homepage: https://github.com/INRA/Rnmr1D
metadata:
  docker_image: "biocontainers/rnmr:phenomenal-v1.1.9_cv0.2.1024"
---

# rnmr

## Overview

The rnmr skill facilitates the programmatic processing of 1D NMR spectra through the Rnmr1D R package. This tool acts as the computational engine for the NMRProcFlow web application, allowing users to transition from GUI-based workflow design to automated, scriptable execution. Use this skill to handle raw NMR data directories, execute macro-command sequences for baseline correction and alignment, and generate normalized bucket tables for downstream statistical analysis.

## Core Workflow and CLI Patterns

The primary interface for rnmr is through R commands. The package relies on three main inputs: a directory of raw spectra, a macro-command file defining the processing steps, and a sample metadata file.

### Initializing and Processing

To perform a full processing run, use the `doProcessing` function. It is highly recommended to utilize parallel processing for large datasets.

```r
library(Rnmr1D)

# Define input paths
raw_data_dir <- "path/to/raw_spectra"
macro_cmd_file <- "NP_macro_cmd.txt"
samples_file <- "Samples.txt"

# Execute processing using all available CPU cores
processed_data <- Rnmr1D::doProcessing(
    raw_data_dir, 
    cmdfile = macro_cmd_file, 
    samplefile = samples_file, 
    ncpu = parallel::detectCores()
)
```

### Data Extraction and Normalization

Once processed, you can extract specific datasets for analysis. The `getBucketsDataset` function is the standard way to retrieve the final data matrix.

*   **Extract Buckets**: Use `norm_meth = 'CSN'` for Constant Sum Normalization.
    ```r
    bucket_matrix <- getBucketsDataset(processed_data, norm_meth = 'CSN')
    ```
*   **Signal-to-Noise Ratio (SNR)**: Calculate SNR for a specific ppm range.
    ```r
    snr_matrix <- getSnrDataset(processed_data, c(10.2, 10.5), ratio = TRUE)
    ```
*   **Metadata**: Retrieve the bucket table (ppm ranges and labels).
    ```r
    bucket_info <- getBucketsTable(processed_data)
    ```

### Visualization

Rnmr1D provides specialized plotting functions for spectral matrices.

*   **Stacked Plot**: Creates a perspective effect.
    ```r
    plotSpecMat(processed_data$specMat, ppm_lim = c(0.5, 5.0), K = 0.33)
    ```
*   **Overlaid Plot**: Useful for comparing alignment across samples.
    ```r
    plotSpecMat(processed_data$specMat, ppm_lim = c(0.5, 5.0), K = 0, pY = 0.1)
    ```

## Expert Tips and Best Practices

*   **Macro-Command Generation**: The most efficient way to create the `cmdfile` is to process one representative sample in the NMRProcFlow GUI, save the macro-command sequence, and then use this skill to apply that sequence to hundreds of samples.
*   **Environment Setup**: Ensure a C++ compiler is available on the system, as Rnmr1D relies on C++ for performance-critical spectral operations.
*   **Memory Management**: For very large datasets, monitor R's memory usage. The `specMat` object within the output list contains the full spectral matrix and can be quite large.
*   **PPM Scaling**: If you encounter scaling issues across different NMR machines, verify the reference frequency settings in your raw data headers before processing.

## Reference documentation

- [Rnmr1D Main Module](./references/github_com_INRA_Rnmr1D.md)