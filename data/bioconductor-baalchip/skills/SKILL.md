---
name: bioconductor-baalchip
description: The package offers functions to process multiple ChIP-seq BAM files and detect allele-specific events. Computes allele counts at individual variants (SNPs/SNVs), implements extensive QC steps to remove problematic variants, and utilizes a bayesian framework to identify statistically significant allele- specific events. BaalChIP is able to account for copy number differences between the two alleles, a known phenotypical feature of cancer samples.
homepage: https://bioconductor.org/packages/release/bioc/html/BaalChIP.html
---

# bioconductor-baalchip

name: bioconductor-baalchip
description: Bayesian analysis of allele-specific transcription factor binding in cancer genomes. Use this skill to process ChIP-seq BAM files, detect allele-specific binding (ASB) events, and correct for biases including reference mapping (RM) and relative allele frequency (RAF) caused by copy number alterations.

# bioconductor-baalchip

## Overview

BaalChIP (Bayesian Analysis of Allelic imbalances from ChIP-seq data) is an R package designed to identify allele-specific binding (ASB) of transcription factors. It is particularly robust for cancer research because it accounts for copy number variations (CNV) that alter the background frequency of alleles. The workflow involves computing allelic counts at heterozygous SNPs, applying rigorous quality control filters to remove mapping artifacts, and using a beta-binomial Bayesian model to identify statistically significant allelic imbalances.

## Standard Workflow

### 1. Initialization and Data Input
The workflow begins by creating a `BaalChIP` object. You need a sample sheet (TSV), a named vector of heterozygous SNP files, and optionally, gDNA BAM files for RAF calculation.

```r
library(BaalChIP)

# Define paths
samplesheet <- "path/to/samplesheet.tsv"
hets <- c("Group1" = "Group1_hets.txt", "Group2" = "Group2_hets.txt")

# Optional: gDNA for RAF calculation
gDNA <- list("Group1" = c("gDNA_rep1.bam", "gDNA_rep2.bam"))

# Construct object
res <- BaalChIP(samplesheet = samplesheet, hets = hets, CorrectWithgDNA = gDNA)
```

### 2. Allele Counting
Compute the number of reads carrying the reference (REF) and alternative (ALT) alleles at heterozygous sites within peak regions.

```r
res <- alleleCounts(res, min_base_quality = 10, min_mapq = 15)
```

### 3. Quality Control Filtering
Apply filters to remove SNPs in problematic regions (blacklists, high-coverage repeats, or low mappability).

```r
# Load hg19 reference data provided by the package
data(blacklist_hg19)
data(pickrell2011cov1_hg19)
data(UniqueMappability50bp_hg19)

res <- QCfilter(res,
                RegionsToFilter = list("bl" = blacklist_hg19, "hc" = pickrell2011cov1_hg19),
                RegionsToKeep = list("map" = UniqueMappability50bp_hg19))
```

### 4. Post-Filter Processing
Merge counts across replicates and remove sites that appear homozygous in the ChIP-seq data.

```r
res <- mergePerGroup(res)
res <- filter1allele(res)
```

### 5. Identifying ASB Events
Run the Bayesian model. Set `RAFcorrection = TRUE` to account for copy number bias and `RMcorrection = TRUE` for reference mapping bias.

```r
res <- getASB(res, Iter = 5000, conf_level = 0.95, cores = 4, 
              RMcorrection = TRUE, RAFcorrection = TRUE)
```

## Summarizing and Exporting Results

### Reporting
Generate a data frame containing the final ASB calls and corrected allelic ratios.

```r
results <- BaalChIP.report(res)
# Access results for a specific group
mcf7_results <- results[["MCF7"]]
asb_only <- mcf7_results[mcf7_results$isASB == TRUE, ]
```

### Visualization and Statistics
*   **QC Summary:** Use `summaryQC(res)` to see how many variants were removed by each filter.
*   **QC Plots:** `plotQC(res, what = "overall_pie")` or `plotQC(res, what = "barplot_per_group")`.
*   **ASB Summary:** `summaryASB(res)` provides counts of Ref-biased vs Alt-biased SNPs.
*   **Adjustment Plot:** `adjustmentBaalPlot(res)` shows the distribution of allelic ratios before and after bias correction.

## Key Functions
- `BaalChIP()`: Constructor for the BaalChIP object.
- `BaalChIP.run()`: Wrapper function to run the entire pipeline with default settings.
- `alleleCounts()`: Extracts allelic read counts from BAM files.
- `QCfilter()`: Filters SNPs based on genomic regions.
- `filterIntbias()`: Optional simulation-based filter for intrinsic mapping bias.
- `getASB()`: Core Bayesian inference engine for detecting allelic imbalance.
- `BaalChIP.get()`: Utility to retrieve internal slots (e.g., "samples", "assayedVar", "biasTable").

## Reference documentation
- [BaalChIP](./references/BaalChIP.md)