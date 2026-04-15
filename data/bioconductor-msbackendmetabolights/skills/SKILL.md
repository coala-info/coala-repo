---
name: bioconductor-msbackendmetabolights
description: This tool retrieves and processes mass spectrometry data from the MetaboLights repository using the Spectra framework in R. Use when user asks to download metabolomics data sets, list files from a MetaboLights study, or load raw spectral data into a Spectra object for analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/MsBackendMetaboLights.html
---

# bioconductor-msbackendmetabolights

name: bioconductor-msbackendmetabolights
description: Retrieve and analyze Mass Spectrometry (MS) data from the MetaboLights repository. Use this skill when you need to download, cache, and process metabolomics data sets (raw or processed MS files like .mzML, .mzXML, or .cdf) directly from MetaboLights into R using the Spectra framework.

# bioconductor-msbackendmetabolights

## Overview

The `MsBackendMetaboLights` package provides a backend for the `Spectra` package, enabling seamless integration with the [MetaboLights](https://www.ebi.ac.uk/metabolights/) repository. It allows users to retrieve MS data files directly from the repository, caches them locally using `BiocFileCache` to avoid redundant downloads, and represents them as `Spectra` objects for downstream analysis in R.

## Installation

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MsBackendMetaboLights")
```

## Typical Workflow

### 1. Explore Study Files
Before loading data, identify the available files and metadata for a specific MetaboLights ID (e.g., "MTBLS39").

```r
library(MsBackendMetaboLights)

# List all files in the study
all_files <- mtbls_list_files("MTBLS39")

# Get the FTP path for manual inspection or metadata reading
ftp_url <- mtbls_ftp_path("MTBLS39")
```

### 2. Read Assay Metadata
MetaboLights uses ISA-tab format. Assay files (starting with `a_`) link samples to spectral data files.

```r
# Identify assay files
assay_file_name <- grep("^a_", all_files, value = TRUE)

# Read the assay table (use retry() due to FTP rate limits)
assay_data <- retry(read.table(paste0(ftp_url, assay_file_name),
                               sep = "\t", header = TRUE, check.names = FALSE),
                    ntimes = 5)

# Check columns for data file locations
# Usually "Derived Spectral Data File" or "Raw Spectral Data File"
colnames(assay_data)
```

### 3. Load MS Data into Spectra
Use the `Spectra` constructor with `MsBackendMetaboLights()`. You can filter files using `filePattern` or `assayName`.

```r
library(Spectra)

# Load specific files matching a pattern
s <- Spectra("MTBLS39", 
             filePattern = "63A.cdf", 
             source = MsBackendMetaboLights())

# The data is now a standard Spectra object
s
```

### 4. Access MetaboLights Metadata
The backend adds specific spectra variables to the object.

```r
# List available variables
spectraVariables(s)

# Access MetaboLights-specific info
spectraData(s, c("mtbls_id", "mtbls_assay_name", "derived_spectral_data_file"))
```

## Cache Management

Data is cached locally to speed up subsequent loads.

*   **Check Cache**: `mtbls_cached_data_files()` lists all locally stored MetaboLights files.
*   **Synchronize**: `mtbls_sync(s@backend)` ensures all files for a backend are downloaded.
*   **Manual Download**: `mtbls_sync_data_files("MTBLS39", fileName = "sample.cdf")` caches a specific file.
*   **Clear Cache**: `mtbls_delete_cache("MTBLS39")` removes local files for a specific study.

## Tips and Best Practices

*   **Rate Limiting**: MetaboLights FTP connections are often rate-limited. Always wrap FTP-based `read.table` calls in the `retry()` function provided by the package.
*   **File Formats**: The backend supports `mzML`, `mzXML`, and `CDF` formats as it extends `MsBackendMzR`.
*   **Memory Efficiency**: Like other `Spectra` backends, `MsBackendMetaboLights` is memory-efficient, only loading peak data into memory when requested.
*   **Data Columns**: If `Spectra()` returns an empty object or error, check the assay file to see if files are listed under "Raw Spectral Data File" instead of the default "Derived Spectral Data File".

## Reference documentation

- [Retrieve and Use Mass Spectrometry Data from MetaboLights](./references/MsBackendMetaboLights.md)
- [MsBackendMetaboLights Vignette Source](./references/MsBackendMetaboLights.Rmd)