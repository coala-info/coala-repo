---
name: pbsv
description: pbsv identifies structural variants in diploid genomes using PacBio long-read sequencing data. Use when user asks to discover structural variation signatures, call variants from aligned BAM files, or perform joint variant calling across multiple samples.
homepage: https://github.com/PacificBiosciences/pbsv
---


# pbsv

## Overview

pbsv is a specialized suite for identifying structural variants in diploid genomes using PacBio long-read data. It is designed to handle the unique error profiles of SMRT sequencing to call variants ranging from 20 bp to over 100 kb. The tool operates through a two-stage process: first identifying SV signatures from aligned BAM files, and then calling variants from those signatures to produce a VCF. This skill helps users navigate the command-line interface to generate high-quality variant calls from subreads or CCS (HiFi) data.

## Core Workflow

The pbsv workflow requires reads previously aligned to a reference genome (typically using `pbmm2`).

### 1. Discover Signatures
Identify signatures of structural variation from aligned BAM files. This step reduces the full alignment data into a compact `.svsig.gz` format.

```bash
# Basic discovery
pbsv discover input.bam output.svsig.gz

# Recommended: Use tandem repeat annotations to increase sensitivity
pbsv discover --tandem-repeats human_GRCh38_no_alt_analysis_set.trf.bed input.bam output.svsig.gz
```

### 2. Call Variants
Generate the final VCF from one or more signature files.

```bash
# Calling from CCS (HiFi) reads
pbsv call --ccs ref.fa input.svsig.gz output.vcf

# Joint calling (multi-sample)
pbsv call ref.fa sample1.svsig.gz sample2.svsig.gz cohort.vcf
```

## Expert Tips and Best Practices

### Data Type Optimization
*   **HiFi/CCS Data**: Always use the `--ccs` flag during the `pbsv call` stage. This adjusts the algorithm for the higher accuracy of HiFi reads.
*   **Subreads (CLR)**: Ensure the input BAM was aligned with appropriate settings (e.g., `pbmm2 align --sort --median-filter`).

### Performance and Scaling
*   **Parallelization**: For large genomes, process chromosomes separately during the discovery phase using the `--region` flag.
*   **Memory Management**: Predicting very large insertions consumes significant memory. Adjust `--max-ins-length` (default 15k) if necessary.
*   **Indexing**: Index `.svsig.gz` files using `tabix` to allow random access during the calling phase:
    ```bash
    tabix -c '#' -s 3 -b 4 -e 4 sample.svsig.gz
    ```

### Sample Handling
*   **Sample Names**: pbsv uses the `@RG SM` tag from the input BAM headers. Ensure these are unique and correct before discovery, as they are used to identify samples in the final multi-sample VCF.
*   **Tandem Repeats**: Providing a tandem repeat BED file is the single most effective way to improve recall for insertions and deletions in repetitive regions.

### SV Type Specifics
*   **Deletions**: Effectively calls 20 bp to 100 kb. Larger deletions are often reported as translocations.
*   **Insertions**: Effectively calls 20 bp to 10 kb.
*   **Inversions**: Requires a single read split into three alignments (orientation +-+ or -+-).
*   **Duplications**: pbsv labels insertions as duplications if the inserted sequence matches the neighboring reference by 80% or more.

## Reference documentation

- [pbsv README](./references/github_com_PacificBiosciences_pbsv_blob_master_README.md)
- [pbsv Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pbsv_overview.md)