---
name: bioconductor-makecdfenv
description: This tool creates and installs CDF environments and packages for Affymetrix GeneChip analysis. Use when user asks to create a CDF package from a file, build an in-memory CDF environment, or clean CDF names for compatibility with the affy package.
homepage: https://bioconductor.org/packages/release/bioc/html/makecdfenv.html
---


# bioconductor-makecdfenv

name: bioconductor-makecdfenv
description: Create and install CDF (Chip Description File) environments and packages for Affymetrix GeneChip analysis. Use this skill when you need to process Affymetrix CEL files using the 'affy' package but lack the corresponding CDF environment, or when you need to build a custom CDF package from a .cdf file.

# bioconductor-makecdfenv

## Overview

The `makecdfenv` package is a utility for Bioconductor users working with Affymetrix microarrays. Its primary purpose is to bridge the gap between raw Affymetrix CDF files and the `affy` package. It allows users to either create an R "environment" (a memory-resident mapping) or a formal R "package" that contains the probe-set-to-location mappings required to process CEL files.

## Typical Workflows

### 1. Creating a CDF Package (Recommended)
Creating a package is the most robust method as it allows for persistent installation and automatic detection by the `affy` package.

```r
library(makecdfenv)

# Create the package source directory
make.cdf.package("mychip.cdf", species = "Homo_sapiens")

# Note: After running the above, you must install the package from the shell:
# R CMD INSTALL mychipcdf
```

### 2. Creating a CDF Environment (In-Memory)
Use this for quick analysis or when you do not have permissions to install new R packages.

```r
library(makecdfenv)

# Create the environment object
mychip_env <- make.cdf.env("mychip.cdf")

# To use with an AffyBatch object 'data':
# data@cdfName <- "mychip_env"
```

## Naming Conventions and Compatibility

The `affy` package automatically looks for CDF resources based on the `cdfName` slot of an `AffyBatch` object.

*   **Packages:** `make.cdf.package` automatically cleans names (lowercase, no special characters). Use `cleancdfname()` to predict the package name `affy` will look for.
*   **Environments:** `affy` looks for an environment named exactly like the CDF file (minus the `.cdf` extension).
*   **Manual Override:** If your CDF filename contains illegal characters (like hyphens or plus signs), you must manually update the `AffyBatch` object:

```r
# Example of handling problematic names
pname <- cleancdfname(whatcdf("sample.cel"))
make.cdf.package("problematic-name.cdf", packagename = pname)

# Or for environments:
my_env <- make.cdf.env("problematic-name.cdf")
raw_data <- ReadAffy()
raw_data@cdfName <- "my_env"
```

## Key Functions

*   `make.cdf.package(filename, species, packagename)`: Generates a directory containing an R package structure.
*   `make.cdf.env(filename)`: Returns an R environment containing the mapping.
*   `cleancdfname(name)`: Converts a standard Affymetrix CDF name into the format used by Bioconductor packages (e.g., "HG-U95Av2" becomes "hgu95av2cdf").
*   `whatcdf(filename)`: Extracts the CDF name directly from a CEL file.

## Reference documentation

- [makecdfenv](./references/makecdfenv.md)