---
name: cmsip
description: The cmsip tool is a comprehensive pipeline for analyzing DNA hydroxymethylation data from raw sequencing reads to the identification of differential 5hmC regions. Use when user asks to align reads to a reference, perform genome scanning, normalize data using spike-ins, or detect differential hydroxymethylated regions using statistical tests like t-test or negative binomial models.
homepage: https://github.com/lijinbio/cmsip
metadata:
  docker_image: "quay.io/biocontainers/cmsip:0.0.3.0--py_0"
---

# cmsip

## Overview
The `cmsip` tool (also known as HaMiP) is a comprehensive pipeline designed for the analysis of DNA hydroxymethylation. It automates the transition from raw sequencing data to the identification of statistically significant differential 5hmC regions. The tool is particularly effective because it integrates alignment, quality control, normalization (including spike-in support), and multiple statistical frameworks for region calling.

## Core Workflow and CLI Usage
The tool is typically invoked by passing a configuration file to the main executable. While the internal logic is driven by configuration parameters, the execution follows a standard bioinformatics pipeline:

1.  **Alignment**: Maps raw FASTQ reads to a reference genome (e.g., hg38, mm10).
2.  **Genome Scanning**: Constructs CMS measurements across the genome using fixed-size windows.
3.  **DHMR Detection**: Performs statistical testing to identify regions with significant differences between biological groups (e.g., KO vs. WT).

### Statistical Methods for DHMR Detection
When configuring the detection step, choose the method that best fits the experimental design:
- `ttest`: Uses Student's t-test to compare mean CMS measurements.
- `chisq` / `gtest`: Pearson’s Chi-squared or G-test for goodness-of-fit across replicates.
- `nbtest`: Applies a Negative Binomial generalized linear model (GLM) with a Wald test. This is generally preferred for count-based sequencing data to account for overdispersion.
- `nbtest_sf`: An extension of the NB test using median-ratio normalization (similar to DESeq2).

### Normalization Strategies
- **Spike-in Normalization**: Use this if the experiment included spike-in libraries. It provides the most accurate scaling factors for 5hmC quantification.
- **WIG Sum Normalization**: A fallback method that normalizes based on the total signal sum across the reference genome.

## Expert Tips and Best Practices
- **Read Extension**: For CMS-IP data, always enable `readextension` and set an appropriate `fragsize` (fragment size) to ensure the CMS signal is accurately attributed to the genomic windows.
- **Filtering Low-Depth Windows**: Use the `meandepth` parameter to filter out low-coverage regions before statistical testing. This reduces the multiple-testing burden and increases overall statistical power.
- **Merging Regions**: The `maxdistance` parameter is critical. It defines how close adjacent significant windows must be to be merged into a single Differential Hydroxymethylated Region (DHMR). A common starting point is 100-200bp, depending on the expected size of 5hmC peaks.
- **Parallelization**: Use the `numthreads` and `nsplit` parameters to speed up the DHMR detection phase, which is the most computationally intensive part of the pipeline.

## Reference documentation
- [HaMiP: DNA hydroxymethylation analysis of Cytosine-5-methylenesulfonate ImmunoPrecipitation sequencing](./references/github_com_lijinbio_HaMiP.md)
- [cmsip - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_cmsip_overview.md)