---
name: r-stampp
description: This tool performs statistical analysis of mixed ploidy populations using SNP data to calculate genetic distances and population differentiation. Use when user asks to calculate pairwise Nei's genetic distances, compute pairwise Fixation Indexes with bootstrapping, generate genomic relationship matrices, or perform AMOVA.
homepage: https://cloud.r-project.org/web/packages/StAMPP/index.html
---


# r-stampp

name: r-stampp
description: Statistical analysis of mixed ploidy populations using SNP data. Use this skill to calculate pairwise Nei's genetic distances, pairwise Fixation Indexes (Fst) with bootstrapping, and Genomic Relationship Matrices (GRM). It is specifically designed for populations with varying ploidy levels and integrates with adegenet genlight objects.

## Overview
StAMPP (Statistical Analysis of Mixed Ploidy Populations) provides tools for genomic analysis of SNP data across populations that may contain individuals of different ploidy levels (e.g., diploid and tetraploid). It supports the calculation of genetic distance, population differentiation (Fst), and relationship matrices while accounting for multithreading and missing data.

## Installation
To install the package from CRAN:
```r
install.packages("StAMPP")
```

## Core Workflow

### 1. Data Preparation
StAMPP requires data in a specific format or a `genlight` object from the `adegenet` package. Use `stamppConvert` to transform `genlight` objects or external files into the StAMPP format.

```r
# Convert a genlight object to StAMPP format
data.stampp <- stamppConvert(my_genlight, type = "genlight")
```

### 2. Calculate Genetic Distance
Calculate pairwise Nei's genetic distance (Nei 1972) between individuals or populations.

```r
# Calculate pairwise Nei's distance between populations
neis_dist <- stamppNeisD(data.stampp, pop = TRUE)
```

### 3. Calculate Pairwise Fst
Calculate pairwise Fixation Indexes (Weir & Cockerham 1984). This function includes bootstrapping across loci to generate confidence intervals and p-values.

```r
# Calculate Fst with 100 bootstraps and 95% confidence interval
fst_results <- stamppFst(data.stampp, nboots = 100, percent = 95, ncalc = 1)
```

### 4. Genomic Relationship Matrix (GRM)
Generate a GRM following the method of Yang et al. (2010).

```r
# Calculate GRM
g_matrix <- stamppGmatrix(data.stampp)
```

### 5. AMOVA
Perform Analysis of Molecular Variance (AMOVA).

```r
# Perform AMOVA
amova_results <- stamppAmova(dist_matrix, data.stampp, perm = 100)
```

## Key Functions

- `stamppConvert`: Converts genlight objects or CSV files to the required StAMPP data frame format.
- `stamppNeisD`: Computes Nei's genetic distance between individuals or populations.
- `stamppFst`: Computes pairwise Fst, p-values, and confidence intervals using multithreading.
- `stamppGmatrix`: Computes a genomic relationship matrix.
- `stamppAmova`: Conducts AMOVA based on a distance matrix.
- `stamppPhylip`: Exports a distance matrix in Phylip format for use in external phylogeny software.

## Usage Tips

- **Ploidy**: StAMPP handles mixed ploidy automatically based on the genotype frequencies provided in the input data.
- **Multithreading**: For large datasets, ensure your system supports multithreading to speed up `stamppFst` calculations.
- **Missing Data**: The package is robust to missing SNP genotypes, but high levels of missingness may still impact the accuracy of Fst and distance estimates.
- **Exporting**: Use `stamppPhylip` to save distance matrices for tree-building in software like MEGA or PHYLIP.

## Reference documentation
- [README.md](./references/README.md)