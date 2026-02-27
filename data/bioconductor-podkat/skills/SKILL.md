---
name: bioconductor-podkat
description: This tool performs position-dependent kernel association testing to detect associations between rare genetic variants and phenotypes. Use when user asks to perform association studies between genotypes and traits, account for genomic positions in variance-component tests, or analyze rare variants from VCF files.
homepage: https://bioconductor.org/packages/release/bioc/html/podkat.html
---


# bioconductor-podkat

name: bioconductor-podkat
description: Position-dependent kernel association testing (PODKAT) for rare and private variants. Use this skill when performing association studies between genotypes (VCF files or matrices) and traits (continuous or binary), especially when accounting for genomic positions and covariates.

# bioconductor-podkat

## Overview

The `podkat` package implements the Position-Dependent Kernel Association Test (PODKAT), a powerful statistical method for detecting associations between rare/private genetic variants and phenotypes. Unlike standard burden tests, PODKAT uses a kernel-based variance-component score test that accounts for the relative positions of variants, which is particularly effective for sequencing data where variants are sparse.

## Typical Workflow

### 1. Prepare the Null Model
Before testing, you must create a null model that describes the relationship between the trait and any covariates (e.g., age, sex, PC components).

```r
library(podkat)

# For a continuous trait
model.c <- nullModel(y ~ covariate1 + covariate2, data=pheno_df)

# For a binary trait (automatically applies small sample correction)
model.b <- nullModel(case_control ~ ., data=pheno_df)
```

### 2. Define Regions of Interest
You can partition the genome into overlapping windows or use specific genomic features (exons, genes).

```r
# Load a pre-defined genome (e.g., hg38)
data(hg38Unmasked)

# Partition into 5kb windows with 50% overlap
windows <- partitionRegions(hg38Unmasked)

# Or use custom regions (GRanges)
custom_regions <- readRegionsFromBedFile("targets.bed")
```

### 3. Perform the Association Test
The `assocTest` function can read directly from a VCF file (memory efficient) or a `GenotypeMatrix`.

```r
# Using a VCF file (requires tabix index)
results <- assocTest("data.vcf.gz", model.b, windows)

# Using a pre-loaded GenotypeMatrix
geno <- readGenotypeMatrix("data.vcf.gz", regions=windows[1:10])
results <- assocTest(geno, model.b)
```

### 4. Analyze and Visualize Results
Apply multiple testing correction and visualize using Manhattan or Q-Q plots.

```r
# Multiple testing correction
results.adj <- p.adjust(results, method="BH")

# Manhattan Plot
plot(results.adj, which="p.value.adj")

# Q-Q Plot
qqplot(results)

# Filter for significant regions
sig_regions <- filterResult(results.adj, cutoff=0.05, filterBy="p.value.adj")
```

### 5. Inspect Variant Contributions
For significant regions, you can determine which specific variants contributed most to the score.

```r
# Compute weights for significant regions
w <- weights(sig_regions, geno, model.b)

# Plot contribution of variants in the first significant region
plot(w[[1]], "weight.contribution", alongGenome=TRUE)
```

## Key Functions

- `nullModel()`: Creates the null model (linear for continuous, logistic for binary).
- `partitionRegions()`: Splits GRanges into windows for sliding-window analysis.
- `readGenotypeMatrix()`: Reads VCF data into a memory-efficient sparse matrix.
- `assocTest()`: The core function for performing the association test.
- `filterResult()`: Subsets results based on p-value thresholds.
- `weights()`: Decomposes the region-based score into individual variant contributions.

## Tips for Large Data
- **VCF Access**: Always use indexed VCF files (`.tbi`). `assocTest` will process the file in chunks to save memory.
- **Parallelization**: `assocTest` supports parallel execution via the `BiocParallel` framework.
- **Small Sample Correction**: For binary traits with few cases, ensure `adj="force"` is used in `nullModel` (though it is the default for N < 2000).

## Reference documentation
- [User Manual / Package Vignette](./references/podkat.md)