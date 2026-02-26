---
name: bioconductor-derfinderdata
description: This package provides BrainSpan genomic data and phenotype information for testing and examples in differential expression analysis. Use when user asks to access sample BigWig files, load BrainSpan phenotype data, or run example workflows for the derfinder and derfinderPlot packages.
homepage: https://bioconductor.org/packages/release/data/experiment/html/derfinderData.html
---


# bioconductor-derfinderdata

name: bioconductor-derfinderdata
description: Access and use the derfinderData package, which provides BrainSpan genomic data (chromosome 21) for testing and examples in differential expression analysis. Use this skill when you need sample BigWig files or phenotype data for the derfinder or derfinderPlot packages.

## Overview

`derfinderData` is a Bioconductor data experiment package containing processed RNA-seq data from the BrainSpan project. It specifically provides data for 24 samples (12 fetal, 12 adult) restricted to chromosome 21. This package is primarily used as a dependency for running examples and vignettes in the `derfinder` and `derfinderPlot` packages, but it can also be used to test custom differential expression workflows.

## Data Access and Usage

### Loading the Phenotype Data

The package includes a pre-constructed phenotype data frame named `brainspanPheno`. This table contains metadata for the 24 samples, including gender, laboratory ID, age (in years), and brain structure.

```r
library(derfinderData)

# Load and inspect the phenotype data
data("brainspanPheno", package = "derfinderData")
head(brainspanPheno)

# Key columns:
# - gender: F or M
# - lab: Sample identifier (e.g., HSB97.AMY)
# - Age: Age in years (negative values represent fetal samples)
# - group: Factor with levels "fetal" and "adult"
# - structure_acronym: "AMY" (amygdaloid complex) or "A1C" (primary auditory cortex)
```

### Accessing BigWig Files

The package stores BigWig files in its `extdata` directory. These files are organized by brain structure (AMY and A1C).

```r
# Locate the directory containing BigWig files for the Amygdaloid complex
amy_path <- system.file("extdata", "AMY", package = "derfinderData")
amy_files <- list.files(amy_path, pattern = "\\.bw$", full.names = TRUE)

# Locate the directory for the Primary Auditory Cortex
a1c_path <- system.file("extdata", "A1C", package = "derfinderData")
a1c_files <- list.files(a1c_path, pattern = "\\.bw$", full.names = TRUE)
```

### Integration with derfinder

A common workflow involves using these files to test the `fullCoverage` function in the `derfinder` package.

```r
library(derfinder)

# Define files and names based on phenotype data
files <- brainspanPheno$file
names(files) <- gsub(".AMY|.A1C", "", brainspanPheno$lab)

# Example: Load coverage for AMY samples on chr21
# Note: This requires an active internet connection if using the URLs in brainspanPheno$file,
# otherwise use the local paths retrieved via system.file() as shown above.
fullCovAMY <- fullCoverage(files = amy_files, chrs = "chr21")
```

## Workflow Tips

- **Age Calculation**: For fetal samples, age in years is calculated as `(age_in_PCW - 40) / 52`.
- **Sample Selection**: The data is balanced with 6 fetal and 6 adult samples for each of the two brain structures.
- **Testing**: Use this package when you need a small, reproducible dataset to debug `derfinder` pipelines without the overhead of full-genome BigWig files.

## Reference documentation

- [Introduction to derfinderData](./references/derfinderData.md)