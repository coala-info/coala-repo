---
name: r-pairadise
description: r-pairadise performs statistical analysis of allele-specific alternative splicing by aggregating signals across paired replicates from RNA-seq data. Use when user asks to detect allele-specific alternative splicing, identify differential splicing between alleles, or aggregate allelic signals across multiple individuals.
homepage: https://cran.r-project.org/web/packages/pairadise/index.html
---


# r-pairadise

name: r-pairadise
description: Statistical analysis of allele-specific alternative splicing (ASAS) using paired replicates from RNA-seq data. Use this skill when you need to detect differential splicing between alleles by aggregating signals across multiple individuals, treating alleles as paired observations and individuals as replicates.

## Overview

PAIRADISE (Paired Replicate Analysis of Allelic Differential Splicing Events) is a statistical framework for detecting allele-specific alternative splicing (ASAS). Unlike methods that analyze samples individually, PAIRADISE aggregates data across a population. It treats the two alleles within an individual as a paired observation and multiple individuals sharing a heterozygous SNP as replicates. This approach provides higher statistical power to identify ASAS events that are consistent across a group.

## Installation

To install the PAIRADISE R package from CRAN:

```R
install.packages("pairadise")
```

Note: The package depends on `nloptr`, `doParallel`, `foreach`, `binom`, and `ggplot2`.

## Workflow and Main Functions

The R component of PAIRADISE typically handles the statistical modeling of isoform counts (Inclusion and Skipping counts) extracted from mapped RNA-seq data.

### 1. Data Preparation
The input should be a data frame where each row represents an ASAS event (associated with a specific SNP) and columns contain counts for both reference and alternative alleles across multiple replicates.

Required fields typically include:
- `IJC_REF`, `SJC_REF`: Inclusion and Skipping junction counts for the reference allele.
- `IJC_ALT`, `SJC_ALT`: Inclusion and Skipping junction counts for the alternative allele.
- `incLen`, `skpLen`: Effective lengths of the inclusion and skipping isoforms.

### 2. Running the Model
The primary statistical engine is invoked to calculate p-values and effect sizes (Psi values).

```R
# Example structure for running the PAIRADISE model
# result <- pairadise_model(input_data, num_threads = 4)
```

### 3. Interpreting Output
The output table includes:
- **pval / qval**: Raw and FDR-adjusted p-values (Benjamini-Hochberg).
- **IncLevel1 / IncLevel2**: Percent Spliced In (Psi/$\psi$) values for reference and alternative alleles.
- **IncLevelDifference**: The magnitude of the splicing difference between alleles.
- **AvgTotalCount**: Coverage metrics to assess the reliability of the event.

## Usage Tips

- **Replicate Requirement**: PAIRADISE is designed for population-level analysis. Ensure you have multiple individuals (replicates) sharing the same heterozygous SNP for robust detection.
- **Filtering**: Before running the model, filter out events with very low coverage (e.g., total counts < 10) to improve computational efficiency and reduce the multiple testing burden.
- **Parallelization**: Use the `num_threads` or equivalent parameter in the model function to utilize multiple CPU cores, as the optimization process for each exon can be computationally intensive.
- **Visualization**: Significant events (FDR < 0.1) can be visualized by plotting the `IncLevel1` vs `IncLevel2` values to see the consistent shift in splicing across replicates.

## Reference documentation

- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)