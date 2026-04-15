---
name: r-hahmmr
description: r-hahmmr detects copy number variations from bulk RNA-seq data using a haplotype-aware Hidden Markov Model. Use when user asks to identify chromosomal gains or losses, analyze subclonal CNVs, or integrate gene expression and phased allele counts for genomic analysis.
homepage: https://cran.r-project.org/web/packages/hahmmr/index.html
---

# r-hahmmr

name: r-hahmmr
description: Haplotype-aware Hidden Markov Model for RNA (HaHMMR) for detecting copy number variations (CNVs) from bulk RNA-seq data. Use this skill when analyzing bulk RNA-seq datasets to identify large-scale chromosomal gains or losses, especially when low-clonality CNVs are suspected.

# r-hahmmr

## Overview
`hahmmr` implements a Haplotype-aware Hidden Markov Model to detect CNVs in bulk RNA-seq. It leverages both gene expression levels (total counts) and phased allele counts (B-allele frequency) to provide high-sensitivity detection of copy number alterations. It is particularly effective for detecting subclonal events that might be missed by non-haplotype-aware methods.

## Installation
Install the package from CRAN:
```R
install.packages("hahmmr")
```

## Data Preparation
The workflow requires two primary inputs and a reference profile:
1. **Expression Counts (`count_mat`)**: An integer matrix of gene counts. Rownames must be gene symbols; the column name should be the sample ID.
2. **Phased Allele Counts (`df_allele`)**: A dataframe containing SNP-level data. Required columns: `snp_id`, `CHROM`, `POS`, `cM` (genetic distance), `REF`, `ALT`, `AD` (ALT count), `DP` (total depth), `GT` (phased genotype, e.g., "0|1"), and `gene`.
3. **Reference Profile (`lambdas_ref`)**: A named vector or single-column matrix of relative expression levels (normalized to sum to 1) from a diploid/normal control sample.

## Core Workflow
The standard analysis pipeline involves initializing a bulk object and running the joint HMM.

```R
library(hahmmr)
library(dplyr)

# 1. Initialize the bulk object
# gtf_hg38 is provided by the package for human hg38 coordinates
bulk <- get_bulk(
    count_mat = gene_counts[, "sample_id", drop = FALSE],
    df_allele = allele_counts,
    lambdas_ref = ref_profile,
    gtf = gtf_hg38
)

# 2. Run the joint HMM analysis
# This integrates expression and allelic signals
bulk <- bulk %>% analyze_joint()

# 3. Visualize results
# min_depth filters SNPs for the BAF plot
bulk %>% plot_psbulk(min_depth = 15)
```

## Key Functions
- `get_bulk()`: Constructor for the bulk RNA-seq object. Performs internal normalization and mapping of genes to genomic coordinates.
- `analyze_joint()`: The main computational engine. It fits the HMM to the combined expression and haplotype data to call CNV segments.
- `plot_psbulk()`: Generates a visualization showing the log-ratio (expression) and B-allele frequency (allelic) across the genome, with HMM state overlays.

## Tips for Success
- **Phasing**: For best results, allele counts should be phased using a tool like `pileup_and_phase.R` from the `numbat` package or similar pipelines using Eagle2/Beagle.
- **Reference Selection**: The quality of CNV calls depends heavily on the `lambdas_ref`. Use a matched normal sample or a diploid sample from the same tissue type if possible.
- **Gene Symbols**: Ensure that the gene names in your count matrix match the gene names in the `gtf` object and the `df_allele` dataframe.

## Reference documentation
- [HaHMMR README](./references/README.html.md)
- [HaHMMR Home Page](./references/home_page.md)