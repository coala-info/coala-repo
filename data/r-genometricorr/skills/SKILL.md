---
name: r-genometricorr
description: This tool performs spatial correlation and independence tests on genome-wide interval datasets to evaluate the spatial relationship between two sets of genomic features. Use when user asks to analyze the spatial relationship between genomic features, test for non-random distribution of intervals, or perform spatial correlation tests like relative distance and Jaccard similarity.
homepage: https://cran.r-project.org/web/packages/genometricorr/index.html
---

# r-genometricorr

name: r-genometricorr
description: Perform spatial correlation and independence tests on genome-wide interval datasets using the GenometriCorr R package. Use this skill when analyzing the spatial relationship between two sets of genomic features (e.g., ChIP-seq peaks vs. promoters, CpG islands vs. repeats) to determine if they are non-randomly distributed relative to each other.

# r-genometricorr

## Overview
The `GenometriCorr` package provides a suite of statistical tests to evaluate the spatial correlation between two sets of genomic intervals (referred to as the Query and the Reference). It moves beyond simple overlap analysis by employing multiple spatial measures—such as relative distance, absolute distance, and Jaccard similarity—to determine if the positioning of one feature set is independent of another across the genome.

## Installation
To install the package from CRAN:
```R
install.packages("GenometriCorr")
```
Note: If the package is not on the primary CRAN mirror, it may be hosted on R-Forge or the project's specific repository.

## Core Workflow
The package typically follows a structured workflow: defining the genomic space, loading intervals, and running the correlation suite.

### 1. Data Preparation
Data should be represented as `GenomicRanges` objects or data frames containing chromosome, start, and end positions.
- **Query (A):** The set of features you are testing.
- **Reference (B):** The set of features you are testing against.
- **Chromosomes:** A description of the chromosome lengths (mapping the "search space").

### 2. Running the Correlation
The primary function is `GenometriCorrConfig` (to set up) and `runGenometriCorr` (to execute).

```R
library(GenometriCorr)

# Basic execution
results <- GenometriCorr(query = query_ranges, 
                        reference = reference_ranges, 
                        chromosomes.length = chrom_lengths)
```

### 3. Key Statistical Tests
The package performs several tests simultaneously:
- **Relative Distance Test:** Evaluates if the Query points are distributed uniformly relative to the Reference intervals. A non-uniform distribution suggests attraction or repulsion.
- **Absolute Distance Test:** Measures the distance from each Query point to the nearest Reference point and compares it to a null model.
- **Jaccard Test:** Measures the ratio of the intersection to the union of the two interval sets.
- **Projection Test:** Tests whether the Query intervals "project" onto the Reference intervals more or less often than expected by chance.

## Visualization and Interpretation
Use the built-in plotting functions to visualize the spatial relationships:

```R
# Visualize the results of the correlation tests
plot(results)
```

### Interpreting Results
- **p-values:** Low p-values across multiple tests (Relative Distance, Projection) provide strong evidence of non-random spatial association.
- **Correlation Coefficient:** Indicates the direction and strength of the association.
- **Scalability:** The package is designed to handle genome-wide datasets efficiently.

## Tips for Success
- **Symmetry:** Note that GenometriCorr is not necessarily symmetric; swapping Query and Reference may yield different results depending on the test.
- **Gap Handling:** Ensure your chromosome lengths correctly account for gaps (like centromeres) if they should be excluded from the "available" genomic space.
- **Large Datasets:** For very large datasets, ensure you are using `GRanges` objects for better memory management.

## Reference documentation
- [GenometriCorr Home Page](./references/home_page.md)