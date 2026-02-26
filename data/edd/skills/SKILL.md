---
name: edd
description: EDD identifies megabase-sized enriched domains in ChIP-seq data, specifically targeting broad enrichment patterns rather than narrow peaks. Use when user asks to detect large-scale enriched domains, identify broad ChIP-seq peaks, or account for unalignable genomic regions in domain detection.
homepage: http://github.com/CollasLab/edd
---


# edd

## Overview

EDD (Enriched Domain Detector) is a specialized bioinformatics tool for identifying megabase-sized enriched domains in ChIP-seq data. While most peak callers are optimized for narrow transcription factor binding sites, EDD is designed for broad enrichment patterns. It utilizes a scoring system and Monte Carlo simulations to define domain boundaries while accounting for unalignable genomic regions like centromeres and telomeres.

## Command Line Usage

The basic syntax for running an EDD analysis is:

```bash
edd [options] <chrom_size> <unalignable_regions> <ip_bam> <input_bam> <output_dir>
```

### Required Arguments

- **chrom_size**: A tab-separated file with two columns: chromosome name and size (bp).
- **unalignable_regions**: A BED file defining regions to exclude (e.g., centromeres, telomeres). EDD will not detect domains spanning these regions.
- **ip_bam**: The aligned ChIP-seq BAM file.
- **input_bam**: The aligned Input/Control BAM file.
- **output_dir**: Path to the results directory (must be unique to the analysis).

### Key Parameters and Tuning

- **Gap Penalty (`-g` or `--gap-penalty`)**: This is the primary sensitivity control.
  - **Lower values**: Favor large, broad domains even if they contain heterogeneous (non-enriched) gaps.
  - **Higher values**: Favor smaller, more contiguous enriched domains with fewer internal gaps.
  - *Tip*: If left blank, EDD will attempt to auto-estimate this value.
- **Bin Size (`--bin-size`)**: Specified in Kb. It is generally recommended to let EDD auto-estimate the bin size for optimal results.
- **Monte Carlo Trials (`-n`)**: Default is 10,000. Increase this for higher statistical stringency, though it will increase runtime.
- **Parallelization (`-p`)**: Set this to the number of available CPU cores to speed up the Monte Carlo simulations.

## Expert Best Practices

- **Read Depth Normalization**: EDD performs basic scaling, but it is most effective when IP and Input BAM files have similar depths. If one file is significantly larger, downsample it to match the other before running EDD.
- **Unalignable Regions**: Providing an accurate `unalignable_regions` file is critical. Failure to exclude centromeres and large repeat regions will lead to a high number of false-positive domain detections.
- **Output Verification**: Always compare the resulting `.bed` peaks against the `.bedgraph` bin scores in a genome browser (like IGV) to ensure the gap penalty is appropriate for your specific biological context.
- **Legacy Environment**: EDD is built for Python 2.7 and has strict dependencies on specific versions of `pysam` (0.11) and `numpy`. It is best executed within a dedicated Conda environment or Docker container to avoid library conflicts.

## Reference documentation

- [EDD GitHub Repository](./references/github_com_CollasLab_edd.md)
- [Bioconda EDD Package Overview](./references/anaconda_org_channels_bioconda_packages_edd_overview.md)