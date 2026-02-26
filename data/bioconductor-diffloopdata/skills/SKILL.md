---
name: bioconductor-diffloopdata
description: This package provides example ChIA-PET data from human Chromosome 1 for use with the diffloop analysis tool. Use when user asks to access sample chromatin interaction data, demonstrate differential loop calling, or test diffloop package functions.
homepage: https://bioconductor.org/packages/release/data/experiment/html/diffloopdata.html
---


# bioconductor-diffloopdata

## Overview
The `diffloopdata` package is a specialized data experiment package for Bioconductor. It provides a subset of ChIA-PET (Chromatin Interaction Analysis by Paired-End Tag sequencing) data specifically for Chromosome 1 across six samples. This dataset is designed to be used as a primary example for the `diffloop` package, which facilitates the identification of differential chromatin loops.

## Loading the Data
To use the example data, you must load the library and then use the `data()` function to bring the objects into your R environment.

```r
# Load the package
library(diffloopdata)

# Load the specific loops object
data(loops)

# Inspect the object
loops
```

## Typical Workflow
The data provided in this package is typically used to demonstrate the following `diffloop` operations:

1.  **Data Exploration**: Examining the `loops` object, which is usually a `loops` class object containing interaction counts, genomic coordinates, and sample metadata.
2.  **Filtering**: Using `diffloop` functions to filter out low-count interactions or loops that do not meet specific genomic distance requirements.
3.  **Normalization**: Applying normalization techniques (like those found in `edgeR` or `DESeq2` via `diffloop`) to the ChIA-PET counts.
4.  **Differential Loop Calling**: Comparing the six samples (often representing different biological conditions or replicates) to find statistically significant differences in loop intensity.

## Data Details
- **Source**: The data originates from studies on proto-oncogene activation and the 3D regulatory landscape of human pluripotent cells (Hnisz et al. 2016, Ji et al. 2015).
- **Preprocessing**: Raw FASTQ files were preprocessed using the `dnaloop` pipeline.
- **Scope**: Limited to Chromosome 1 to keep the package size manageable while providing enough complexity for testing.

## Reference documentation
- [diffloopdata: An example ChIA-PET dataset for the diffloop package](./references/diffloopdata.md)