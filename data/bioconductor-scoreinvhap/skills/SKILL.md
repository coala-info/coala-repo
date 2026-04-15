---
name: bioconductor-scoreinvhap
description: This tool genotypes genomic inversions from SNP data using a supervised classifier to determine inversion states. Use when user asks to genotype genomic inversions from VCF or SNPMatrix files, identify inversion genotypes for specific loci, or evaluate classification reliability using similarity scores and call rates.
homepage: https://bioconductor.org/packages/release/bioc/html/scoreInvHap.html
---

# bioconductor-scoreinvhap

name: bioconductor-scoreinvhap
description: Genotype genomic inversions from SNP data using a supervised classifier. Use when analyzing SNP data (VCF or SNPMatrix) to identify inversion genotypes (NN, NI, II) for specific loci like 8p23.1 or 17q21.31.

# bioconductor-scoreinvhap

## Overview

The `scoreInvHap` package genotypes inversions by computing similarity scores between an individual's SNPs and experimental references for three genotypes: non-inverted homozygous (NN), inverted heterozygous (NI), and inverted homozygous (II). Unlike population-based methods, it is a supervised classifier that can handle single samples and is less sensitive to sample size.

## Core Workflow

### 1. Load Data
The package accepts `SNPMatrix` (from `snpStats`) or `VCF` (from `VariantAnnotation`) objects.

```r
library(scoreInvHap)
library(VariantAnnotation)

# Load VCF
vcf_file <- system.file("extdata", "example.vcf", package = "scoreInvHap")
vcf <- readVcf(vcf_file, "hg19")

# Or load PLINK files via snpStats
# library(snpStats)
# snps <- read.plink("example.bed")
```

### 2. Pre-check SNPs
Use `checkSNPs` to ensure input alleles and frequencies match the `scoreInvHap` references (based on hg19 plus strand).

```r
check <- checkSNPs(vcf)
vcf_clean <- check$genos
# Review check$wrongAlleles or check$wrongFreqs if necessary
```

### 3. Genotype Inversions
Run `scoreInvHap` by specifying the inversion label (e.g., "inv7_005"). Use `data(inversionGR)` to see available inversions.

```r
# Basic usage
res <- scoreInvHap(SNPlist = vcf_clean, inv = "inv7_005")

# Parallel execution
res <- scoreInvHap(SNPlist = vcf_clean, inv = "inv7_005", 
                   BPPARAM = BiocParallel::MulticoreParam(8))

# Using posterior probabilities for imputed data
res_imp <- scoreInvHap(SNPlist = vcf_clean, inv = "inv7_005", probs = TRUE)
```

### 4. Extract Results
Retrieve classifications and raw similarity scores.

```r
# Get inversion genotypes (NN, NI, II)
genotypes <- classification(res)

# Get underlying haplotype genotypes (e.g., IaIa, NaIa)
haplotypes <- classification(res, inversion = FALSE)

# Get raw similarity scores
all_scores <- scores(res)
```

## Quality Control

Evaluate the reliability of the classification using score differences and call rates.

### Score Metrics
*   **Max Score**: The highest similarity score for the individual.
*   **Difference Score**: The gap between the highest and second-highest score. High values indicate confident classification.

```r
max_s <- maxscores(res)
diff_s <- diffscores(res)

# Visualize QC
plotScores(res, minDiff = 0.1)
```

### SNP Call Rate
Ensure enough SNPs were present in the inverted region (minimum 15 SNPs recommended).

```r
# Check proportion of SNPs used
rate <- propSNPs(res)

# Visualize call rate
plotCallRate(res, callRate = 0.9)
```

### Filtering Results
Apply QC thresholds directly when retrieving classifications.

```r
# Filter by minimum score difference and call rate
clean_genos <- classification(res, minDiff = 0.1, callRate = 0.9)
```

## Available Inversions
The package includes data for 21 inversions. Access the metadata table via:

```r
data(inversionGR)
as.data.frame(inversionGR)
```

Common labels include:
*   `inv8_001` (8p23.1)
*   `inv17_007` (17q21.31)
*   `inv7_005` (7p11.2)
*   `inv16_009` (16p11.2)

## Reference documentation

- [Inversion genotyping with scoreInvHap](./references/scoreInvHap.md)