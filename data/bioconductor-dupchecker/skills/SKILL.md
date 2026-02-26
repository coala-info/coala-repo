---
name: bioconductor-dupchecker
description: Bioconductor-dupchecker identifies and manages duplicated high-throughput genomic samples in meta-analyses by generating and comparing MD5 fingerprints of raw data files. Use when user asks to download raw data from GEO or ArrayExpress, build a file registry for genomic datasets, or identify redundant samples to prevent data contamination.
homepage: https://bioconductor.org/packages/3.6/bioc/html/DupChecker.html
---


# bioconductor-dupchecker

name: bioconductor-dupchecker
description: Identify and manage duplicated high-throughput genomic samples in meta-analyses using MD5 fingerprints. Use this skill when you need to download raw data from GEO or ArrayExpress, extract files, and validate data redundancy to prevent false positives or model over-fitting in biological studies.

# bioconductor-dupchecker

## Overview

DupChecker is a Bioconductor package designed to ensure data integrity in genomic meta-analyses by identifying redundant samples. It works by generating MD5 fingerprints for raw data files (such as Affymetrix CEL files). Since different studies often submit the same raw data to public repositories under different identifiers, DupChecker helps researchers identify these duplicates to avoid data contamination and biased results.

## Standard Workflow

### 1. Data Acquisition
Download raw data directly from GEO or ArrayExpress. The package automatically handles decompression to ensure MD5 fingerprints are calculated on the underlying raw data rather than the compressed containers (which can vary by compression tool).

```r
library(DupChecker)

# Define a directory for data storage
rootDir <- file.path(tempdir(), "DupChecker_Data")
dir.create(rootDir, showWarnings = FALSE)

# Download from GEO
geoDownload(datasets = c("GSE1478"), targetDir = rootDir)

# Download from ArrayExpress
arrayExpressDownload(datasets = c("E-MEXP-3872"), targetDir = rootDir)
```

### 2. Building the File Table
Scan the downloaded directories to create a registry of files to be checked. You can filter for specific file types using regex patterns.

```r
# Focus on Affymetrix CEL files
datafile <- buildFileTable(rootDir = rootDir, filePattern = "cel$")
```

### 3. Validating Redundancy
Calculate MD5 fingerprints and identify duplicates. The `validateFile` function returns a list containing a logical flag `hasdup` and a `duptable` if duplicates are found.

```r
result <- validateFile(datafile)

if(result$hasdup) {
  message("Duplicates detected!")
  duptable <- result$duptable
  # Save results for inspection
  write.csv(duptable, file = file.path(rootDir, "duplicates_found.csv"))
} else {
  message("No duplicates found.")
}
```

## Key Functions

- `geoDownload(datasets, targetDir)`: Downloads and extracts raw data from NCBI GEO.
- `arrayExpressDownload(datasets, targetDir)`: Downloads and extracts raw data from EBI ArrayExpress.
- `buildFileTable(rootDir, filePattern)`: Creates a data frame of files found in the specified directory matching the pattern.
- `validateFile(datafile)`: Performs the MD5 check across the files listed in the file table.

## Tips and Best Practices

- **External Tools**: For very large datasets or unstable connections, consider downloading and decompressing files using external FTP clients or command-line tools, then point `buildFileTable` to the local directory.
- **File Patterns**: Always use specific file patterns (e.g., `"cel$"` or `"fastq$"`) to avoid including metadata or log files in the redundancy check.
- **Meta-Analysis Safety**: Run DupChecker as the very first step of any meta-analysis involving public datasets to ensure the independence of your samples.
- **Broad Application**: While optimized for gene expression (CEL files), the MD5 approach works for any high-throughput data, including NGS (FastQ/BAM) files.

## Reference documentation

- [DupChecker](./references/DupChecker.md)