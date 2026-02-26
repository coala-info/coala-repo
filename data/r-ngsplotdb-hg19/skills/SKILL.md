---
name: r-ngsplotdb-hg19
description: This package provides the genomic database and annotation tables required to visualize NGS data for the hg19 human genome assembly. Use when user asks to generate enrichment plots, create heatmaps, or produce average profiles for genomic regions like TSS, TES, and gene bodies using the ngsplot framework.
homepage: https://cran.r-project.org/web/packages/ngsplotdb-hg19/index.html
---


# r-ngsplotdb-hg19

name: r-ngsplotdb-hg19
description: Specialized R database package for visualizing NGS data (ChIP-seq, RNA-seq) on the hg19 human genome. Use when an AI agent needs to generate enrichment plots, heatmaps, or average profiles for genomic regions like TSS, TES, gene bodies, and enhancers using the ngsplot framework.

# r-ngsplotdb-hg19

## Overview
The `ngsplotdb-hg19` package provides the genomic database and annotation tables required by the `ngsplot` framework to visualize Next-Generation Sequencing (NGS) data specifically for the human genome assembly hg19 (GRCh37). It enables the integration of functional genomic regions (TSS, TES, exons, enhancers) with BAM files to produce high-quality average profiles and heatmaps.

## Installation
To install the database package within R:
```R
install.packages("ngsplotdb-hg19")
# Ensure core dependencies are also present
install.packages(c("doMC", "caTools", "utils"))
```

## Instructions

### Core Parameters for hg19 Analysis
When configuring an ngsplot analysis for hg19, use the following logic for parameterization:

- **Genome Identifier**: Always set `-G hg19`.
- **Genomic Regions (`-R`)**:
    - `tss`: Transcription Start Site (Default flanking: 2000bp).
    - `tes`: Transcription End Site (Default flanking: 2000bp).
    - `genebody`: Entire gene region (Default flanking: 2000bp).
    - `exon`: Individual exons (Default flanking: 500bp).
    - `cgi`: CpG Islands (Default flanking: 500bp).
    - `enhancer`: Enhancer regions (Requires extension package).
    - `dhs`: DNase I Hypersensitive Sites (Requires extension package).
    - `bed`: Custom regions provided via a BED file.

### Refining Annotations with `-F` (Further Information)
Use the `-F` descriptor string to subset the hg19 database. Descriptors are comma-separated and order-independent.

- **Gene Types**: `protein_coding` (default), `pseudogene`, `lincRNA`, `miRNA`.
- **Exon Types**: `canonical` (default), `altAcceptor`, `altDonor`, `promoter`.
- **Cell Lines (for DHS/Enhancers)**: `K562`, `H1hesc`, `Gm12878`, `Hepg2`, `Mcf7`, `Huvec`.
- **Region Classification**: `ProximalPromoter`, `Promoter1k`, `Promoter3k`, `Genebody`.

Example: `-F K562,lincRNA` selects lincRNA genes specifically for the K562 cell line.

### Coverage and Normalization
- **Fragment Length (`-FL`)**: Set to the average fragment length of the library (default 150). For paired-end data, the actual insert size is used automatically.
- **Normalization Algorithm (`-AL`)**: 
    - `spline` (default): Fits a spline then samples equal intervals.
    - `bin`: Splits vectors into fixed numbers of equal-sized bins.
- **Robust Statistics (`-RB`)**: Set to `0.05` to trim the top/bottom 5% of extreme values to reduce noise in average profiles.

### Heatmap and Ranking
- **Ranking Algorithms (`-GO`)**:
    - `total`: Rank by overall enrichment.
    - `km`: K-means clustering (specify clusters with `-KNC`).
    - `hc`: Hierarchical clustering.
    - `none`: Use the order provided in the input gene list.
- **Color Scales (`-SC`)**: Use `global` to ensure all heatmaps in a multi-plot use the same scale, or `min,max` for custom ranges.

### Multi-plot Configuration
For comparing multiple samples or regions, create a tab-delimited configuration file:
```text
# [BAM_OR_BAM_PAIR] [GENE_LIST_OR_-1] [TITLE]
sample1.bam    -1    "Sample 1 All Genes"
sample2.bam    high_exp.txt    "Sample 2 High Exp"
```
Pass this file to the `-C` parameter.

## Reference documentation
- [ProgramArguments101](./references/ProgramArguments101.md)
- [README](./references/README.md)
- [SupportedGenomes](./references/SupportedGenomes.md)
- [UseFurtherInfo](./references/UseFurtherInfo.md)
- [home_page](./references/home_page.md)
- [wiki](./references/wiki.md)