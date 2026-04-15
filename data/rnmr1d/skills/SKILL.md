---
name: rnmr1d
description: The rnmr1d tool performs automated high-throughput processing and analysis of 1D NMR datasets. Use when user asks to process raw NMR spectra, apply macro-command sequences, extract bucket data matrices, or calculate signal-to-noise ratios.
homepage: https://github.com/INRA/Rnmr1D
metadata:
  docker_image: "biocontainers/rnmr1d:phenomenal-v1.2.22_cv0.3.49"
---

# rnmr1d

## Overview
The `rnmr1d` skill enables the automated processing of 1D NMR datasets. It acts as the computational engine for the NMRProcFlow web application but can be used independently as an R package. Use this skill when you need to perform high-throughput NMR data processing, apply standardized macro-command sequences to raw spectra, or extract data matrices (buckets) and Signal-to-Noise Ratio (SNR) datasets for downstream metabolomics or chemical analysis.

## Core Workflow
The primary entry point for processing is the `doProcessing` function, which handles both preprocessing and the execution of macro-commands.

### 1. Initialization and Processing
To process a dataset, you require a directory of raw NMR data, a macro-command file (usually `.txt`), and a sample description file.

```r
library(Rnmr1D)

# Define paths to your data and configuration files
raw_dir <- "path/to/raw_spectra"
cmd_file <- "path/to/macro_cmd.txt"
sample_file <- "path/to/Samples.txt"

# Execute processing using multiple cores for efficiency
out <- Rnmr1D::doProcessing(
    raw_dir, 
    cmdfile = cmd_file, 
    samplefile = sample_file, 
    ncpu = parallel::detectCores()
)
```

### 2. Data Extraction
Once processed, use the following functions to extract specific datasets from the output object:

*   **Buckets/Data Matrix**: Extract the normalized intensity matrix.
    ```r
    # Supported normalization: 'CSN' (Constant Sum Normalization), etc.
    outMat <- getBucketsDataset(out, norm_meth = 'CSN')
    ```
*   **SNR Matrix**: Calculate Signal-to-Noise ratios for specific regions.
    ```r
    # Define the noise region (e.g., 10.2 to 10.5 ppm)
    outSNR <- getSnrDataset(out, c(10.2, 10.5), ratio = TRUE)
    ```
*   **Metadata**: Retrieve the bucket table or raw spectra data.
    ```r
    buckets <- getBucketsTable(out)
    spectra <- getSpectraData(out)
    ```

### 3. Visualization
Rnmr1D provides specialized plotting functions for NMR spectra matrices.

*   **Stacked Plot**: Creates a perspective effect.
    ```r
    # K controls the perspective/vertical shift
    plotSpecMat(out$specMat, ppm_lim = c(0.5, 5), K = 0.33)
    ```
*   **Overlaid Plot**: Standard overlay of all spectra.
    ```r
    plotSpecMat(out$specMat, ppm_lim = c(0.5, 5), K = 0, pY = 0.1)
    ```

## Expert Tips
*   **Macro-commands**: If you are not using the NMRProcFlow GUI, you can manually create a macro-command file to define the sequence of operations (e.g., `LINEBROADENING`, `ZEROFILLING`, `PHASECORRECTION`).
*   **Parallel Processing**: Always use `detectCores()` or specify `ncpu` in `doProcessing` to significantly reduce processing time for large cohorts.
*   **PPM Scaling**: Be aware that different NMR machines may require specific scaling adjustments; verify your ppm calibration if peaks appear shifted across different instruments.

## Reference documentation
- [Rnmr1D Main Repository](./references/github_com_INRA_Rnmr1D.md)