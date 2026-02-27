---
name: bioconductor-mugaexampledata
description: This package provides example phenotype and genotype data from Diversity Outbred mice using the Mouse Universal Genotyping Array. Use when user asks to access example datasets for Diversity Outbred mouse studies, analyze founder haplotype probabilities, or demonstrate QTL mapping workflows using MUGA data.
homepage: https://bioconductor.org/packages/release/data/experiment/html/MUGAExampleData.html
---


# bioconductor-mugaexampledata

name: bioconductor-mugaexampledata
description: Provides example phenotype and genotype data from Diversity Outbred (DO) mice using the Mouse Universal Genotyping Array (MUGA). Use when Claude needs to access, analyze, or demonstrate workflows for DO mouse studies, including founder haplotype probabilities, allele intensities, and longitudinal phenotype data (clinical chemistry, body weight, etc.).

## Overview

The MUGAExampleData package provides a subset of data from a study of 150 Diversity Outbred (DO) mice. The data includes genotypes from the Mouse Universal Genotyping Array (MUGA), which contains 7,864 markers, and extensive phenotype data including clinical chemistry, body weights, and physiological measurements. This package is primarily used as a reference dataset for developing and testing QTL mapping algorithms for multi-parent populations.

## Data Access and Loading

Load the package and specific datasets using the `data()` function.

```r
library(MUGAExampleData)

# List available datasets
data(package = "MUGAExampleData")

# Load specific objects
data(pheno)        # Phenotype data
data(geno)         # Allele calls
data(model.probs)  # Founder haplotype probabilities
data(x)            # X allele intensities
data(y)            # Y allele intensities
```

## Key Data Objects

### Phenotype Data (`pheno`)
A data frame with 149 samples (rows) and 142 columns.
- **Metadata**: Columns 1-5 (Sample, Sex, Gen, Diet, Coat.Color).
- **Clinical Chemistry**: WBC, RBC, Hemoglobin, Cholesterol, Triglycerides, etc., measured at 10 and 22 weeks (indicated by suffixes 1 and 2).
- **Physiology**: Heart rate (HR), Bone Mineral Density (BMD), Percent Fat.
- **Longitudinal Weight**: Body weights from week 3 to 30 (columns `BW.3` to `BW.30`).

### Genotype Data (`geno`, `x`, `y`)
- **geno**: A character matrix (141 samples x 7,854 markers) containing allele calls ('A', 'C', 'G', 'T', 'H' for heterozygous, or '-' for missing).
- **x / y**: Numeric matrices containing normalized allele intensities.

### Founder Probabilities (`model.probs`)
A 3D numeric array (141 samples x 8 founders x 7,854 markers).
- Founders are labeled A through H:
  - A: A/J
  - B: C57BL/6J
  - C: 129S1/SvImJ
  - D: NOD/ShiLtJ
  - E: NZO/H1LtJ
  - F: CAST/EiJ
  - G: PWK/PhJ
  - H: WSB/EiJ
- Use `model.probs[sample_index, founder_index, marker_index]` to access specific probabilities.

## Typical Workflows

### Merging Phenotypes and Genotypes
Since the number of samples in `pheno` (149) and `geno` (141) differ due to technical genotyping failures, always align datasets by Sample ID.

```r
data(pheno)
data(geno)

# Identify common samples
common_samples <- intersect(pheno$Sample, rownames(geno))

# Subset both datasets
pheno_sub <- pheno[pheno$Sample %in% common_samples, ]
geno_sub <- geno[common_samples, ]
```

### Analyzing Founder Contributions
To visualize or analyze the genetic makeup of a specific locus:

```r
data(model.probs)

# Extract probabilities for the first 5 markers for the first sample
sample1_probs <- model.probs[1, , 1:5]

# Check the sum of probabilities (should be ~1.0)
colSums(sample1_probs)
```

### Working with Longitudinal Data
To plot growth curves using the body weight data:

```r
data(pheno)
weight_cols <- grep("BW\\.", colnames(pheno))
plot(3:30, pheno[1, weight_cols], type = "b", xlab = "Weeks", ylab = "Weight (g)")
```

## Tips and Troubleshooting
- **Sample Mismatch**: Note that only 141 of the 150 mice were successfully genotyped. Always check `rownames(geno)` against `pheno$Sample`.
- **Raw Data**: If raw GeneSeek output is required for testing parsing scripts, use `FinalReport1`, `FinalReport2`, `Samples1`, and `Samples2`. These are raw text representations.
- **Batch Effects**: Use `data(call.rate.batch)` to check for potential batch effects or sample quality issues based on allele call rates.

## Reference documentation
- [MUGAExampleData](./references/MUGAExampleData.md)