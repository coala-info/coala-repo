---
name: bioconductor-methylmnm
description: The methylMnM package provides a statistical framework for the joint analysis of MeDIP-seq and MRE-seq data to detect differentially methylated regions. Use when user asks to detect differentially methylated regions, integrate MeDIP-seq and MRE-seq data, or perform the M&M statistical test.
homepage: https://bioconductor.org/packages/release/bioc/html/methylMnM.html
---


# bioconductor-methylmnm

## Overview

The `methylMnM` package implements the M&M (Methylation and Mutation) method for the joint analysis of MeDIP-seq (methylated DNA immunoprecipitation) and MRE-seq (methyl-sensitive restriction enzyme) data. It provides a robust statistical framework to detect differentially methylated regions (DMRs) by integrating information from both enrichment-based and restriction-based sequencing technologies.

The workflow typically follows four stages:
1. **Pre-processing**: Binning the genome and counting CpG sites, MRE-specific sites, and sequencing tags.
2. **Statistical Testing**: Calculating p-values using the M&M test.
3. **FDR Control**: Estimating q-values from the p-values.
4. **DMR Selection**: Filtering results based on significance and fold-change thresholds.

## Core Workflow

### 1. Data Pre-processing
The package works with `.bed` format files. You must first calculate the CpG and MRE-CpG density for genomic bins (windows).

```R
library(methylMnM)

# Define bin length (default 500bp)
bin_len <- 500

# 1.1 Count total CpG sites per bin
countcpgbin(file.cpgsite = "all_CpGsite.txt", 
            writefile = "numallcpg.bed", 
            reportfile = "report_cpg.txt", 
            binlength = bin_len)

# 1.2 Count MRE-specific CpG sites per bin
# Note: mrecpg.site should be a data frame of specific sites (e.g., CCGG, GCGC)
countMREcpgbin(mrecpg.site = mre_sites_df, 
               file.allcpgsite = "all_CpGsite.txt", 
               file.bin = "numallcpg.bed", 
               writefile = "three_mre_cpg.bed", 
               binlength = bin_len)

# 1.3 Count MeDIP-seq and MRE-seq tags per bin
countMeDIPbin(file.Medipsite = "sample1_MeDIP.txt", 
              file.bin = "numallcpg.bed", 
              writefile = "s1_MeDIP_bins.bed", 
              binlength = bin_len)

countMREbin(file.MREsite = "sample1_MRE.txt", 
            file.bin = "numallcpg.bed", 
            cutoff = 0.05, # PCR cutoff
            writefile = "s1_MRE_bins.bed", 
            binlength = bin_len)
```

### 2. M&M Statistical Test
Calculate p-values by comparing two conditions. The `file.dataset` argument requires a vector of four file paths: `c(MeDIP_cond1, MeDIP_cond2, MRE_cond1, MRE_cond2)`.

```R
data_files <- c("s1_MeDIP_bins.bed", "s2_MeDIP_bins.bed", 
                "s1_MRE_bins.bed", "s2_MRE_bins.bed")

MnM.test(file.dataset = data_files, 
         file.cpgbin = "numallcpg.bed", 
         file.mrecpgbin = "three_mre_cpg.bed", 
         writefile = "results_pval.bed", 
         mreratio = 3/7, 
         method = "XXYY", 
         psd = 2, mkadded = 1)
```

### 3. FDR Control and Selection
Convert p-values to q-values and filter for significant DMRs.

```R
# Calculate q-values
MnM.qvalue(datafile = "results_pval.bed", 
           writefile = "results_qval.bed")

# Select significant DMRs
results <- read.table("results_qval.bed", header = TRUE)
DMRs <- MnM.selectDMR(frames = results, 
                      up = 1.45, 
                      down = 1/1.45, 
                      q.value = 0.01, 
                      cutoff = "q-value", 
                      quant = 0.6)
```

## Key Parameters and Tips

- **mreratio**: The ratio of total unmethylation level to total methylation level. The default is `3/7`.
- **method**: Use `"XXYY"` to calculate p-values based on the M&M test logic.
- **psd & mkadded**: Pseudo-counts added to sequencing tags and CpG counts respectively to ensure statistical robustness in low-count regions.
- **Memory Management**: Processing the full genome at once during the binning phase can be memory-intensive. Ensure 4GB+ RAM is available for human-sized genomes.
- **Strand Information**: For MRE-seq data, ensure your input BED files contain strand information (usually in the 6th column) as restriction sites are strand-specific.

## Reference documentation
- [methylMnM](./references/methylMnM.md)