---
name: bioconductor-simd
description: This tool performs statistical inference to detect differentially expressed CpG sites by jointly analyzing MeDIP-seq and MRE-seq data using an EM algorithm. Use when user asks to identify differential methylation at the single CpG site level, infer actual methylation levels from fragment counts, or calculate p-values for differential methylation between samples.
homepage: https://bioconductor.org/packages/release/bioc/html/SIMD.html
---

# bioconductor-simd

name: bioconductor-simd
description: Statistical inference for detecting differentially expressed CpG sites in MeDIP-seq and MRE-seq data. Use this skill when analyzing DNA methylation data to identify differential methylation at the single CpG site level using an EM algorithm framework.

# bioconductor-simd

## Overview

The `SIMD` (Statistical Inferences with MeDIP-seq Data) package provides a statistical framework for identifying differentially expressed CpG sites. It is specifically designed to jointly analyze MeDIP-seq (methylated DNA immunoprecipitation) and MRE-seq (methyl-sensitive restriction enzyme) data. By combining these two data types, the package uses an Expectation-Maximization (EM) algorithm to infer actual methylation levels and calculate p-values for differential methylation between control and treatment samples.

## Workflow and Core Functions

### 1. Data Preparation
The package requires MeDIP-seq and MRE-seq read counts, as well as CpG and MRE-specific site information. Input data is typically in `.bed` format.

```r
library(SIMD)
library(methylMnM) # Required for pre-processing

# Load example data provided in the package
data(example_data)
```

### 2. Inferring Actual Reads (EM Algorithm)
Use `EMalgorithm()` to calculate the number of actual short reads in each CpG site by inferring them from observed fragments.

```r
# category: "1" for MeDIP-seq, "2" for MRE-seq
EMalgorithm(cpgsitefile = "path/to/reads.txt", 
            allcpgfile = allcpg_data_frame, 
            category = "1",
            writefile = "output_reads.bed", 
            reportfile = "report.bed")
```

### 3. Calculating P-values for Differential Methylation
The `EMtest()` function is the core inferential tool. It compares two conditions (e.g., H1ESB1 vs H1ESB2) to detect differential methylation.

```r
# Combine processed data from conditions
datafile <- cbind(data_cond1_medip, data_cond2_medip, data_cond1_mre, data_cond2_mre)

EMtest(datafile = datafile, 
       cpgfile = all_cpg_sites, 
       mrecpgfile = mre_cpg_sites,
       writefile = "pvalues_output.bed", 
       reportfile = "test_report.bed",
       mreratio = 3/7, # Ratio of MRE to MeDIP
       psd = 2,        # Pseudo-count
       mkadded = 1,    # Added constant
       f = 1)          # Adjustment weight
```

**Output Columns in `writefile`:**
* `chr`, `chrSt`, `chrEnd`: Genomic coordinates.
* `Medip1`, `Medip2`: MeDIP counts for both samples.
* `MRE1`, `MRE2`: MRE counts for both samples.
* `pvalue`: The calculated p-value for differential methylation.
* `Ts`: The test statistic.

### 4. Selecting Significant Sites
Filter the results based on a p-value threshold (e.g., $10^{-3}$ or $10^{-5}$) to identify significant differentially methylated regions (DMRs).

```r
results <- read.table("pvalues_output.bed", header = TRUE)
significant_sites <- results[results$pvalue < 1e-5, ]
```

## Tips for Success
* **Dependencies**: Ensure `edgeR`, `statmod`, and `methylMnM` are installed and loaded, as `SIMD` relies on their data structures and pre-processing logic.
* **MRE Information**: For MRE-seq data, ensure your mapping process includes strand information ("+" and "-"), typically in the 6th column of the input file.
* **Computational Efficiency**: The core EM algorithm is implemented in C for speed, but genome-wide analysis still benefits from chromosome-specific processing if memory is limited.

## Reference documentation
- [SIMD Tutorial](./references/SIMD.md)