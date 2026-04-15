---
name: bioconductor-breakpointrdata
description: This package provides example BAM files and pre-computed results for the breakpointR Bioconductor package. Use when user asks to access standardized datasets for testing, demonstrate breakpoint detection workflows, or visualize pre-computed strand-state inheritance results.
homepage: https://bioconductor.org/packages/release/data/experiment/html/breakpointRdata.html
---

# bioconductor-breakpointrdata

name: bioconductor-breakpointrdata
description: Provides access to example data for the breakpointR package, including BAM files and pre-computed BreakPoint objects. Use this skill when a user needs to demonstrate, test, or learn the functionalities of the breakpointR package using standardized example datasets.

## Overview

The `breakpointRdata` package is an experiment data package designed to support the `breakpointR` Bioconductor package. It contains two primary types of data:
1. **Example BAM files**: Raw sequencing data used to illustrate breakpoint detection workflows.
2. **Example results**: Pre-computed `BreakPoint` objects (stored as `.RData` files) used to demonstrate plotting and downstream analysis without needing to run the full detection pipeline.

## Loading Example Data

To use this package, first load the library in R:

```R
library(breakpointRdata)
```

### Accessing BAM Files
The BAM files are stored in the `extdata/example_bams` directory. You can retrieve their full system paths using `system.file`:

```R
# Get path to the directory containing BAMs
bam_path <- system.file("extdata", "example_bams", package="breakpointRdata")

# List all BAM files
bam_files <- list.files(bam_path, full.names=TRUE, pattern=".bam$")
```

### Accessing Pre-computed Results
The results are stored in the `extdata/example_results` directory. These are useful for testing plotting functions in `breakpointR`:

```R
# Get path to the directory containing RData results
results_path <- system.file("extdata", "example_results", package="breakpointRdata")

# List all result files
result_files <- list.files(results_path, full.names=TRUE)

# Load a specific result into the R environment
load(result_files[1])
```

## Typical Workflow

This package is almost always used in conjunction with `breakpointR`. A common workflow involves using these files as input for `runBreakpointR()` or for visualizing strand-state inheritance:

```R
library(breakpointR)

# Example: Using a BAM file from breakpointRdata
example_bam <- list.files(system.file("extdata", "example_bams", package="breakpointRdata"), 
                          full.names=TRUE)[1]

# Run breakpoint detection (requires breakpointR)
# results <- runBreakpointR(example_bam, pairedEndReads=FALSE, chromosomes='chr1')
```

## Tips
- Use `?example_bams` and `?example_results` within R to see the help pages for these datasets.
- The BAM files provided are subsets of real data, typically focused on specific genomic regions to keep the package size small and execution times fast for demonstration purposes.

## Reference documentation

- [Example data for breakpointR](./references/breakpointRdata-knitr.md)