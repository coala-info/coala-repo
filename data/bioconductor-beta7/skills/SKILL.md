---
name: bioconductor-beta7
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/beta7.html
---

# bioconductor-beta7

name: bioconductor-beta7
description: Access and utilize the beta7 Bioconductor experiment data package. Use this skill when a user needs to analyze microarray data from the Rodriguez et al. (2004) study regarding differential gene expression in memory/effector T helper cells bearing the gut-homing receptor Integrin alpha4 beta7.

# bioconductor-beta7

## Overview
The `beta7` package is a Bioconductor ExperimentData package containing microarray data from a study of gene expression differences between $\beta7+$ and $\beta7-$ memory T helper cells. The dataset includes an `marrayRaw` object and the original GPR (GenePix Results) files. The experiment involved 6 hybridizations comparing RNA from the same subject labeled with different dyes.

## Data Loading and Inspection
To use the dataset, you must load the package and the data object. The primary object is named `beta7`.

```r
# Load the package
library(beta7)

# Load the dataset
data(beta7)

# Inspect the object
beta7
summary(beta7)
```

## Working with the marrayRaw Object
The `beta7` object is an instance of the `marrayRaw` class from the `marray` package. You can access various slots to inspect the microarray data:

- **Dimensions**: Check the number of probes and arrays.
  ```r
  dim(beta7)
  # Access specific slots like the green foreground intensities
  dim(beta7@maGf)
  ```
- **Layout**: View the grid and spot layout.
  ```r
  maLayout(beta7)
  ```
- **GPR Files**: The package includes 6 GPR files. You can locate them on your system using:
  ```r
  system.file("gpr", package="beta7")
  ```

## Typical Workflow
Since this is an `marrayRaw` object, standard `marray` workflows apply for normalization and differential expression analysis:

1. **Diagnostic Plots**: Use `maPlot(beta7)` to view MA-plots of the raw data.
2. **Normalization**: Apply normalization methods (e.g., loess) using the `marray` package.
   ```r
   library(marray)
   beta7_norm <- maNorm(beta7, norm="loess")
   ```
3. **Analysis**: Identify differentially expressed genes between the $\beta7+$ and $\beta7-$ populations as described in the Rodriguez et al. (2004) reference.

## Reference documentation
- [beta7 Reference Manual](./references/reference_manual.md)