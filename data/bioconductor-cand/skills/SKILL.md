---
name: bioconductor-cand
description: This tool detects heterogeneity in population structure across chromosomes or chromosomal regions using local ancestry estimates. Use when user asks to perform the Chromosomal Ancestry Difference test, identify significant differences in ancestral contributions to specific chromosomes, or compare ancestry proportions across the genome.
homepage: https://bioconductor.org/packages/3.5/bioc/html/CAnD.html
---


# bioconductor-cand

name: bioconductor-cand
description: Detects heterogeneity in population structure across chromosomes or chromosomal regions using local ancestry estimates. Use this skill when you need to perform the CAnD (Chromosomal Ancestry Difference) test to identify significant differences in ancestral contributions to specific chromosomes compared to the genome-wide average.

## Overview

The `CAnD` package implements a statistical method to compare proportion ancestry in a sample set across chromosomes. It is particularly useful for analyzing admixed populations where ancestry might vary significantly across the genome (e.g., identifying if the X chromosome has a significantly different ancestral composition than the autosomes). The package calculates p-values for each chromosome and an overall CAnD statistic, properly accounting for multiple testing and correlations between chromosomes.

## Typical Workflow

### 1. Data Preparation
The input must be a `data.frame` where rows are samples and columns represent estimated ancestry proportions for specific chromosomes.

```R
library(CAnD)
data(ancestries)

# The data should have a sample ID column (e.g., "IID") 
# and columns for each chromosome's ancestry proportion.
# Example: "Euro_1", "Euro_2", ..., "Euro_X"
```

### 2. Running the CAnD Test
To run the test, subset your data to include only the columns for the specific ancestry of interest (e.g., all European ancestry columns for chromosomes 1-22 and X).

```R
# Subset to columns for a specific ancestry
euroCols <- seq(from=2, to=24) # Adjust indices based on your data
euroEsts <- ancestries[, euroCols]

# Run the parametric CAnD test
res <- CAnD(euroEsts)

# View summary results
res
```

### 3. Accessing Results
The `CAnD` function returns an object containing both per-chromosome p-values and an overall genome-wide statistic.

```R
# Get p-values for each chromosome
pvals <- pValues(res)

# Get the overall CAnD statistic and p-value
stat <- overallStatistic(res)
overall_p <- overallpValue(res)

# Check if Bonferroni correction was applied
BonfCorr(res)
```

### 4. Visualization
The package provides two primary plotting functions:

```R
# Plot p-values against chromosomes to identify outliers
plotPvals(res, main="CAnD P-values: European Ancestry")

# Visualize ancestry proportions for a specific chromosome across all samples
chr1_data <- ancestries[, c("Euro_1", "Afr_1", "Asian_1")]
barPlotAncest(chr1_data, title="Chromosome 1 Ancestry Proportions")
```

## Tips and Best Practices
- **Input Requirements**: Ensure that for every sample, the proportions for all ancestral populations on a single chromosome sum to 1.
- **Ancestry Estimates**: CAnD is designed to work with output from programs like FRAPPE, ADMIXTURE, or RFMix.
- **Multiple Testing**: By default, the package handles multiple testing. Use `pValues(res)` to see which specific chromosomes are driving a significant overall result.
- **X Chromosome**: It is common to use CAnD to test if the X chromosome differs significantly from the autosomes, which can indicate sex-biased admixture history.

## Reference documentation
- [CAnD](./references/CAnD.md)