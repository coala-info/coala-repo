---
name: bioconductor-garfield
description: GARFIELD evaluates the enrichment of GWAS association signals in functional annotations while correcting for linkage disequilibrium, minor allele frequency, and distance to transcription start sites. Use when user asks to perform functional enrichment analysis of GWAS data, identify regulatory features associated with genetic variants, or account for genomic confounders in enrichment testing.
homepage: https://bioconductor.org/packages/release/bioc/html/garfield.html
---

# bioconductor-garfield

name: bioconductor-garfield
description: GWAS Analysis of Regulatory or Functional Information Enrichment with LD correction. Use this skill when performing functional enrichment analysis of GWAS SNP data to identify relevant regulatory features (ENCODE, Roadmap Epigenomics) while accounting for LD, MAF, and TSS distance.

# bioconductor-garfield

## Overview

GARFIELD (GWAS Analysis of Regulatory or Functional Information Enrichment with LD correction) is a non-parametric framework used to evaluate the enrichment of GWAS association signals in functional annotations. It leverages greedy LD pruning and permutation testing—matching for minor allele frequency (MAF), distance to the nearest transcription start site (TSS), and number of LD proxies—to account for major sources of confounding in enrichment analysis.

The package is particularly effective for analyzing enrichment across 1005 features, including chromatin states, histone modifications, DNaseI hypersensitive sites, and transcription factor binding sites.

## Workflow and Usage

### 1. Data Preparation
GARFIELD requires pre-processed data, typically involving GWAS summary statistics that have been pruned and annotated. The core R functions focus on calculating enrichment and visualizing results from these processed inputs.

```r
library(garfield)

# Typical input includes:
# - P-values for GWAS SNPs
# - Annotation overlap information
# - Confounder data (MAF, TSS distance, LD proxy counts)
```

### 2. Enrichment Analysis
The primary analysis is performed using `garfield.run()`. This function assesses fold enrichment (FE) at various GWAS significance thresholds.

```r
# Example execution pattern
garfield.run(input_file, 
             annotation_file, 
             n_perm = 1000, 
             maf_bins = 5, 
             tss_bins = 5, 
             proxies_bins = 5)
```

### 3. Visualization
GARFIELD provides specialized plotting functions to visualize enrichment across different functional categories and significance thresholds.

*   **Fold Enrichment Plots**: Visualize the magnitude of enrichment.
*   **Significance Plots**: Display p-values from permutation tests across different cell types or tissues.

```r
# Plotting results
garfield.plot(results_data, output_prefix = "my_enrichment_study")
```

## Key Considerations
*   **LD Pruning**: Ensure GWAS SNPs are pruned (typically $r^2 > 0.1$) before the main enrichment analysis to avoid inflation.
*   **Confounder Matching**: The method matches SNPs based on MAF, TSS distance, and LD proxies. Ensure your input data contains these features for accurate permutation testing.
*   **Thresholds**: Analysis is usually performed across multiple p-value cutoffs (e.g., $10^{-5}, 10^{-8}$) to see how enrichment changes with association strength.

## Reference documentation

- [GARFIELD Vignette](./references/vignette.md)