---
name: bioconductor-prebsdata
description: This package provides sample BAM files and experiment data for the prebs package. Use when user asks to access sample data for PREBS examples, test RNA-seq to microarray expression estimation, or locate sample BAM files for the prebsdata experiment package.
homepage: https://bioconductor.org/packages/release/data/experiment/html/prebsdata.html
---

# bioconductor-prebsdata

name: bioconductor-prebsdata
description: Access sample data for the prebs package. Use when running prebs examples, testing RNA-seq to microarray expression estimation, or exploring sample BAM files provided by the prebsdata experiment package.

# bioconductor-prebsdata

## Overview

`prebsdata` is a Bioconductor experiment data package designed to support the `prebs` (Probe Region Expression estimation Based on Sequencing) package. It provides the necessary sample data—specifically BAM files—required to demonstrate the PREBS workflow, which calculates RNA-seq expression estimates that are comparable to Affymetrix microarray data.

## Using prebsdata in R

The primary purpose of this package is to provide file paths to sample data for use in `prebs` functions.

### Loading the Package

```r
library(prebsdata)
```

### Locating Sample Data

The package contains sample BAM files in its `extdata` directory. You can retrieve the full file paths using `system.file`:

```r
# List all files in the extdata directory
data_dir <- system.file("extdata", package = "prebsdata")
list.files(data_dir)

# Get the path to a specific sample BAM file
bam_file <- system.file("extdata", "ex_bam.bam", package = "prebsdata")
```

### Typical Workflow with prebs

Once you have located the data files within `prebsdata`, you typically pass them to the `prebs` package functions:

```r
library(prebs)
library(prebsdata)

# Define path to sample BAM file from this package
bam_file <- system.file("extdata", "ex_bam.bam", package = "prebsdata")

# Define the CDF package (e.g., for Custom CDF or standard Affymetrix)
# Note: The specific CDF depends on your target microarray platform
cdf_name <- "hgu133plus2hsentrezg" 

# Run PREBS (requires prebs package)
# result <- prebs(bam_file, cdf_name)
```

## Tips

- **Data Only**: This package does not contain analysis functions; it is a container for data. Use it in conjunction with the `prebs` software package.
- **File Verification**: Always use `file.exists()` on the path returned by `system.file` to ensure the resource was found correctly before starting long-running expression estimations.

## Reference documentation

- [prebsdata User Guide](./references/prebsdata.md)