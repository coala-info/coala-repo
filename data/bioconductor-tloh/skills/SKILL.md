---
name: bioconductor-tloh
description: The tLOH package assesses evidence for Loss of Heterozygosity in spatial transcriptomics data using Bayesian analysis of allele counts. Use when user asks to assess LOH in 10X Genomics Visium data, calculate Bayes factors for allele counts, or visualize spatial LOH evidence across chromosomes.
homepage: https://bioconductor.org/packages/release/bioc/html/tLOH.html
---

# bioconductor-tloh

## Overview
The `tLOH` package is designed to assess evidence for Loss of Heterozygosity (LOH) in spatial transcriptomics data, specifically from the 10X Genomics Visium platform. It utilizes Bayes factor calculations to compare the probability of a heterozygous state versus an LOH state based on allele counts at known SNP positions.

## Typical Workflow

### 1. Data Import
The package requires a VCF file containing per-cluster allele count information at heterozygous SNP positions.
Note: VCF files must be decompressed (.vcf, not .vcf.gz) before import.

```r
library(tLOH)

# Import VCF data
vcf_path <- "path/to/your/data.vcf"
tloh_data <- tLOHDataImport(vcf_path)
```

### 2. LOH Calculation
The `tLOHCalc` function performs the core Bayesian analysis. It calculates probabilities for both heterozygous and LOH events and generates various Bayes factor metrics (K, LogK, Log10K).

```r
# Perform Bayes factor calculations
results_df <- tLOHCalc(tloh_data)

# View results
head(results_df)
```

**Key Output Columns:**
* `p(D|het)` / `p(D|loh)`: Probability of data given the state.
* `bayesFactors`: The Bayes factor value K.
* `Log10BayesFactors`: Log10 of the Bayes factor (useful for significance thresholds).
* `AF`: Allele fraction.
* `CLUSTER`: The spatial cluster identifier.

### 3. Visualization
`tLOH` provides two primary plotting functions to visualize LOH evidence across the genome.

```r
# Plot allele frequencies across clusters
alleleFrequencyPlot(results_df, "Sample_Name")

# Plot aggregate chromosome evidence
aggregateCHRPlot(results_df, "Sample_Name")
```

## Tips and Interpretation
* **Bayes Factors:** Higher values in `Log10BayesFactors` or `Log10InverseBayes` (depending on the direction of the test) indicate stronger evidence for LOH.
* **Input Requirements:** Ensure your upstream pipeline (e.g., cellranger or custom scripts) has correctly aggregated allele counts by spatial cluster before generating the VCF.
* **Plotting:** The `alleleFrequencyPlot` is particularly useful for identifying specific clusters that deviate from the expected 0.5 allele fraction for heterozygotes.

## Reference documentation
- [tLOH Vignette (Rmd)](./references/tLOH_vignette.Rmd)
- [tLOH Vignette (Markdown)](./references/tLOH_vignette.md)