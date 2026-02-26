---
name: bioconductor-hapmapsnp6
description: This package provides sample Affymetrix SNP 6.0 HapMap data for testing and demonstrating Bioconductor SNP analysis tools. Use when user asks to access example CEL files, load pre-computed genotyping results, or benchmark SNP 6.0 array workflows.
homepage: https://bioconductor.org/packages/release/data/experiment/html/hapmapsnp6.html
---


# bioconductor-hapmapsnp6

name: bioconductor-hapmapsnp6
description: A data package providing sample Affymetrix SNP 6.0 HapMap data for demonstration and testing of Bioconductor tools. Use this skill when you need to access example CEL files for SNP 6.0 arrays or pre-computed genotyping results (crlmmResult) for workflow validation, benchmarking, or tutorial purposes.

## Overview
The `hapmapsnp6` package is a Bioconductor experiment data package containing sample datasets from the International HapMap Project. It specifically provides data for the Affymetrix Genome-Wide Human SNP Array 6.0 platform. Its primary purpose is to serve as a lightweight, standardized dataset for demonstrating the functionality of SNP analysis packages like `oligo`, `oligoClasses`, and `crlmm`.

## Loading the Data
The package contains two primary resources: raw CEL files (stored in the package installation directory) and a pre-processed `SnpSet` object.

### Accessing Raw CEL Files
To use the raw data for testing file-reading functions:

```r
library(hapmapsnp6)
library(oligo)

# Locate the CEL files within the package
cel_path <- system.file("celFiles", package="hapmapsnp6")

# List the available CEL files
cels <- list.celfiles(path = cel_path, full.names = TRUE)

# Example: Reading the CEL files into a FeatureStack or RawFeatureSuite
# Note: Requires a temporary directory for large data processing
tmp_dir <- tempdir()
raw_data <- read.celfiles(cels, tmpdir = tmp_dir)
```

### Loading Pre-computed Results
The package includes `crlmmResult`, which is a `SnpSet` object containing results for 90 CEU HapMap samples processed via the CRLMM (Corrected Robust Linear Model with Multiple-distance) algorithm.

```r
# Load the dataset
data(crlmmResult)

# Inspect the object
crlmmResult
class(crlmmResult) # SnpSet

# Access genotype calls (1=AA, 2=AB, 3=BB)
calls <- calls(crlmmResult)

# Access confidence scores
conf <- snpCallProbability(crlmmResult)
```

## Typical Workflows
1. **Tool Benchmarking**: Use the `cel_path` to test the performance of new CEL file parsers or normalization algorithms.
2. **Genotyping Demonstration**: Use `crlmmResult` to demonstrate downstream analysis such as copy number estimation, population genetics visualization, or quality control metrics without needing to run the intensive genotyping step.
3. **Integration Testing**: Verify that Bioconductor tools correctly handle the SNP 6.0 platform metadata and probe geometries.

## Tips
- The CEL files provided are a subset intended for demonstration; they do not represent a full study.
- When using `read.celfiles`, always ensure a `tmpdir` is specified if working in memory-constrained environments, as SNP 6.0 data is high-density.
- The `crlmmResult` object is an instance of `SnpSet` from the `Biobase` package; standard accessor functions like `pData()`, `fData()`, and `exprs()` (or `calls()`) apply.

## Reference documentation
- [hapmapsnp6 Reference Manual](./references/reference_manual.md)