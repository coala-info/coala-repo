---
name: bioconductor-hapmapsnp5
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/hapmapsnp5.html
---

# bioconductor-hapmapsnp5

name: bioconductor-hapmapsnp5
description: Access and use the hapmapsnp5 Bioconductor experiment data package. Use this skill when you need to load sample Affymetrix SNP 5.0 HapMap data for demonstration, testing, or benchmarking Bioconductor tools like 'oligo'.

# bioconductor-hapmapsnp5

## Overview
The `hapmapsnp5` package is a Bioconductor experiment data package containing sample dataset files from the HapMap Consortium for the Affymetrix SNP 5.0 platform. It is primarily used as a lightweight dataset for demonstrating the functionality of oligonucleotide array analysis packages, specifically the `oligo` package.

## Loading the Data
The package does not contain R objects directly but provides CEL files stored within the package installation directory. To use this data, you must locate the files and read them using a compatible analysis package.

### Locating CEL Files
To find the path to the sample CEL files included in the package:

```r
library(hapmapsnp5)
cel_path <- system.file("celFiles", package="hapmapsnp5")
```

### Typical Workflow with 'oligo'
The standard way to process this data is using the `oligo` package to read the raw intensity files.

```r
library(oligo)
library(hapmapsnp5)

# 1. Get the directory path
the_path <- system.file("celFiles", package="hapmapsnp5")

# 2. List the CEL files
cels <- list.celfiles(path = the_path, full.names = TRUE)

# 3. Read the CEL files into a FeatureSet object
# Note: It is recommended to use a temporary directory for large data processing
temporaryDir <- tempdir()
rawData <- read.celfiles(cels, tmpdir = temporaryDir)

# 4. Inspect the object
show(rawData)
```

## Usage Tips
- **Purpose**: This package is intended for demonstration and software testing. It should not be used for biological inference as the maintainer does not warrant the accuracy of the data.
- **Dependencies**: While `hapmapsnp5` contains the data, you will almost always need the `oligo` package to perform any meaningful operations on it.
- **Platform**: This data is specific to the Affymetrix SNP 5.0 platform. Ensure you have the corresponding annotation packages (e.g., `pd.hapmap.5.0`) if performing normalization or genotyping.

## Reference documentation
- [hapmapsnp5 Reference Manual](./references/reference_manual.md)